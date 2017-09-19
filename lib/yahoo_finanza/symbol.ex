defmodule YahooFinanza.Symbol do
  use GenServer

  @moduledoc """
  The Symbol Module implements the GenServer Behavior and
  is a Supervised Worker. This module provides methods to
  get the list of symbols for a given market or index. Also
  allows the easy addition of new lists of symbols.

  ## Methods
      symbols/1

  ## Markets
      NYSE. Referenced as the string "nyse"
      AMEX. Referenced as the string "amex"
      NASDAQ. Referenced as the string "nasdaq"
      SP 500. Referenced as the string "sp_500"
      Dow Jones. Referenced as the string "dow_jones"
  """

  ###
  # Client API
  ###

  @doc """
  The symbols method accepts a string containing the name
  of the market or index and returns the list of symbols
  for that market.

  ## Example
      iex> YahooFinanza.Symbol.symbols "nyse"\n
      {:ok, ["symbol1", "symbol2", ..., "symboln"]}
  """

  def symbols(market) do
    GenServer.call(__MODULE__, {:symbols, market})
  end

  ###
  # GenServer API
  ###

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    table = :ets.new(:symbols_table, [:protected, :named_table])

    read_market_symbols("markets")
    |> Enum.each(fn(market) ->
      :ets.insert(table, {market, read_market_symbols(market)})
    end)

    {:ok, table}
  end

  def handle_call({:symbols, market}, _from, state) do
    {:reply, symbols_for(market), state}
  end

  ###
  # Helpers
  ###

  defp symbols_for(market) do
    case :ets.lookup(:symbols_table, market) do
      [] ->
        {:error, "unable to find market"}
      [results | _] ->
        [_ | symbols] = results |> Tuple.to_list
        {:ok, symbols |> List.flatten}
    end
  end

  defp read_market_symbols(market) do
    ~w(.. .. config markets #{market}.csv)
    |> Path.join
    |> Path.expand(__DIR__)
    |> File.stream!
    |> CSV.decode
    |> Enum.flat_map(fn row -> row end)
  end
end

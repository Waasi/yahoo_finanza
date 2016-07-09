defmodule YahooFinanza.Symbol do
  use GenServer

  ###
  # Client API
  ###

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

    Application.get_env(:yahoo_finanza, :markets)
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
    File.stream!("config/markets/#{market}.csv")
    |> CSV.decode
    |> Enum.flat_map(fn row -> row end)
  end
end

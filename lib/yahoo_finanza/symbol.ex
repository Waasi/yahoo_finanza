defmodule YahooFinanza.Symbol do
  use Agent

  @moduledoc """
  This module provides methods to get the list
  of symbols for a given market or index
  """

  ###
  # Client API
  ###

  def start_link do
    Agent.start_link(&init/0, name: __MODULE__)
  end

  @doc """
  The symbols_for method accepts a string containing the
  name of the market or index and returns the list of
  symbols for that market.

  ## Example
      iex> YahooFinanza.Symbol.symbols_for "nyse"\n
      {:ok, ["symbol1", "symbol2", ..., "symboln"]}
  """

  def symbols_for(market) do
    case Agent.get(__MODULE__, &Map.get(&1, market)) do
      nil ->
        presence_error_for(market)
      symbols ->
        {:ok, symbols}
    end
  end

  ###
  # Private API
  ###

  defp init do
    markets()
    |> Stream.map(&symbols/1)
    |> Enum.reduce(%{}, &build_state/2)
  end

  defp markets do
    ~w(.. .. config markets)
    |> Path.join()
    |> Path.expand(__DIR__)
    |> File.ls!()
    |> Enum.map(&String.split(&1, "."))
  end

  defp symbols([market, ext]) do
    symbols_for_market =
      ~w(.. .. config markets #{market}.#{ext})
      |> Path.join()
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.to_list()

    %{market => symbols_for_market}
  end

  defp build_state(data, state), do: Map.merge(data, state)

  defp presence_error_for(market) do
    {:error, "unable to find symbols for market #{market}"}
  end
end

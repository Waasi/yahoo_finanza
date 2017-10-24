defmodule YahooFinanza.Quote do
  @moduledoc """
  The YahooFinanza Quote Module implements the
  GenServer Behavior and is a Supervised Worker.
  This module provides methods to get the quote
  for a single symbol or multiple symbols.

  ## Methods
      fetch/1
  """

  alias YahooFinanza.QuoteFetcher

  ###
  # Client API
  ###

  @doc """
  The fetch/1 method accepts a list of strings
  containing a symbol and returns the quotes as a list
  of Maps. If an invalid symbol is in the list, it will
  be ignored.

  ## Example
      iex> YahooFinanza.Quote.fetch ["AAPL", "FB", "I don't exist"]\n
      {:ok, [%{"Symbol" => "AAPL", "Ask" => "119.5", ...}, %{"Symbol" => "FB", "Ask" => "130.5", ...} }

  """

  def fetch(symbols) do
    {:ok, quotes_for(symbols)}
  end

  ###
  # Helpers
  ###

  defp quotes_for(symbols) do
    symbols
    |> workloads()
    |> Task.async_stream(QuoteFetcher, :get, [])
    |> Enum.map(&strip/1)
    |> List.flatten()
  end

  defp workloads(symbols) do
    Stream.chunk(symbols, 50, 50, [])
  end

  defp strip({:ok, quotes}), do: quotes
  defp strip(_), do: nil
end

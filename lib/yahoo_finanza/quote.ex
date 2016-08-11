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
    symbols |> workloads
    |> Enum.map(&distribute/1)
    |> Enum.map(&collect/1) |> strip
  end

  defp strip(quotes) do
    quotes |> List.flatten
  end

  defp workloads(symbols) do
    symbols |> Enum.chunk(25, 25, [])
  end

  defp distribute(workload) do
    me = self
    spawn_link(fn -> (send me, {self, QuoteFetcher.get(workload)}) end)
  end

  defp collect(pid) do
    receive do {^pid, quotes} -> quotes end
  end
end

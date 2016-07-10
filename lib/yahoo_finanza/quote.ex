defmodule YahooFinanza.Quote do
  @moduledoc """
  The YahooFinanza Quote Module implements the
  GenServer Behavior and is a Supervised Worker.
  This module provides methods to get the quote
  for a single symbol or multiple symbols.

  ## Methods
      fetch_quote/1
      fetch_quotes/1
  """

  use GenServer
  alias YahooFinanza.QuoteFetcher

  ###
  # Client API
  ###

  @doc """
  The fetch_quote/1 method accepts a string containing
  a symbol and returns a quote as a Map or an error if
  a invalid symbol was given.

  ## Examples
      iex> YahooFinanza.Quote.fetch_quote "AAPL"\n
      {:ok, %{"Symbol" => "AAPL", "Ask" => "119.5", ...}}

      iex> YahooFinanza.Quote.fetch_quote "i don't exist"\n
      {:error, "invalid symbol"}
  """

  def fetch_quote(symbol) do
    GenServer.call(__MODULE__, {:quote, symbol})
  end

  @doc """
  The fetch_quotes/1 method accepts a list of strings
  containing a symbol and returns the quotes as a list
  of Maps. If an invalid symbol is in the list, it will
  be ignored.

  ## Example
      iex> YahooFinanza.Quote.fetch_quote ["AAPL", "FB", "I don't exist"]\n
      {:ok, [%{"Symbol" => "AAPL", "Ask" => "119.5", ...}, %{"Symbol" => "FB", "Ask" => "130.5", ...} }

  """

  def fetch_quotes(symbols) do
    GenServer.call(__MODULE__, {:quotes, symbols})
  end

  ###
  # GenServer API
  ###

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_call({:quote, symbol}, _from, state) do
    {:reply, quote_for(symbol), state}
  end

  def handle_call({:quotes, symbols}, _from, state) do
    {:reply, quotes_for(symbols), state}
  end

  ###
  # Helpers
  ###

  defp quote_for(symbol) do
    QuoteFetcher.get(symbol)
  end

  defp quotes_for(symbols) do
    quotes = (symbols |> Enum.map(&Task.async(fn -> handle_quote(&1) end)) |>
    Enum.map(&Task.await/1)) |> List.delete(nil)

    {:ok, quotes}
  end

  defp handle_quote(symbol) do
    case QuoteFetcher.get(symbol) do
      {:ok, qte} -> qte
      {:error, "invalid symbol"} -> nil
    end
  end
end

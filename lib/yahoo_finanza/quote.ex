defmodule YahooFinanza.Quote do
  use GenServer

  alias YahooFinanza.QuoteFetcher

  ###
  # Client API
  ###

  def fetch_quote(symbol) do
    GenServer.call(__MODULE__, {:quote, symbol})
  end

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

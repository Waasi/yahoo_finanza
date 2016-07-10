defmodule YahooFinanza.QuoteFetcher do
  @moduledoc """
  The YahooFinanza QuoteFetcher Module fetches a single
  quote given a stock symbol from the Yahoo Finance API.

  ## Methods
      get/1
  """

  @doc """
  The get/1 method accepts a string containing the stock
  symbol and returns the quote for the given symbol from
  the Yahoo Finance API or an error if an invalid symbol
  was given.

  ## Examples
      iex> YahooFinanza.QuoteFetcher.get "AAPL"\n
      {:ok, %{"Symbol" => "AAPL", "Ask" => "119.5", ...}}

      iex> YahooFinanza.Quote.fetch_quote "i don't exist"\n
      {:error, "invalid symbol"}
  """

  def get(symbol) do
    symbol |> url_for |> HTTPoison.get |> parse_quote
  end

  defp url_for(symbol) do
    "http://query.yahooapis.com/v1/public/yql?q=" <>
    "select * from yahoo.finance.quotes where symbol in ('#{symbol}')" <>
    "&format=json&diagnostics=true&env=http://datatables.org/alltables.env"
    |> URI.encode
  end

  defp parse_quote({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    json = body |> JSON.decode!
    qte = json["query"]["results"]["quote"]

    case qte["Ask"] do
      nil ->
        {:error, "invalid symbol"}
      _ ->
        {:ok, qte}
    end
  end
end

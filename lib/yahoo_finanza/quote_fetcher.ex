defmodule YahooFinanza.QuoteFetcher do
  @moduledoc """
  The YahooFinanza QuoteFetcher Module fetches a single
  quote given a stock symbol from the Yahoo Finance API.

  ## Methods
      get/1
  """

  @doc """
  The get/1 method accepts a list of strings containing
  stock symbols and returns the quotes for the given symbols
  from the Yahoo Finance API

  ## Example
      iex> YahooFinanza.QuoteFetcher.get ["AAPL"]\n
      {:ok, [%{"Symbol" => "AAPL", "Ask" => "119.5", ...}]}
  """

  def get(symbols) do
    url = symbols |> Enum.join(",") |> url_for
    url |> HTTPoison.get |> parse_quote
  end

  defp url_for(symbols) do
    "http://query.yahooapis.com/v1/public/yql?q=" <>
    "select * from yahoo.finance.quotes where symbol in ('#{symbols}')" <>
    "&format=json&diagnostics=true&env=store://datatables.org/alltableswithkeys"
    |> URI.encode
  end

  defp parse_quote({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    json = body |> Poison.decode!
    json["query"]["results"]["quote"]
  end
  defp parse_quote({_status, _response}), do: %{}
end

defmodule YahooFinanza.QuoteFetcher do
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

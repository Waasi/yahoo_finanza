defmodule YahooFinanza.QuoteFetcherTest do
  use ExUnit.Case

  alias YahooFinanza.QuoteFetcher

  test ".get for valid symbol AAPL" do
    {:ok, qte} = QuoteFetcher.get("AAPL")
    assert qte["Symbol"] == "AAPL"
  end

  test ".get for invalid symbol wassaaah" do
    assert QuoteFetcher.get("wassaaah") == {:error, "invalid symbol"}
  end
end

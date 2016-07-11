defmodule YahooFinanza.QuoteFetcherTest do
  use ExUnit.Case

  alias YahooFinanza.QuoteFetcher

  test ".get for valid symbol AAPL" do
    qte = QuoteFetcher.get(["AAPL"])
    assert qte["Symbol"] == "AAPL"
  end

  test ".get for invalid symbol wassaaah" do
    qte =  QuoteFetcher.get(["wassaaah"])
    assert qte["Ask"] == nil
  end
end

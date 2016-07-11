defmodule YahooFinanza.QuoteTest do
  use ExUnit.Case

  alias YahooFinanza.Quote
  alias YahooFinanza.Symbol

  setup do
    {:ok, symbols} = Symbol.symbols("nyse")
    {:ok, symbols: symbols}
  end

  test ".fetch for one valid symbol", %{symbols: symbols} do
    {:ok, result} = [symbols |> List.first] |> Quote.fetch
    qte = result |> List.first

    assert qte["Symbol"] == List.first(symbols)
  end

  test ".fetch for one invalid symbol" do
    result = ["whatever"] |> Quote.fetch
    assert result == {:ok, []}
  end

  test ".fetch for multiple valid symbols", %{symbols: symbols} do
    {:ok, result} = Enum.take(symbols, 5) |> Quote.fetch
    assert (result |> Enum.count) == 5
  end

  test ".fetch for multiple valid symbols and one invalid symbol", %{symbols: symbols} do
    {:ok, result} = Enum.take(symbols, 4) ++ ["whatever"]  |> Quote.fetch
    assert (result |> Enum.count) == 4
  end
end

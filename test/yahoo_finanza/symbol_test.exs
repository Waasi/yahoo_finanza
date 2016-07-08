defmodule YahooFinanza.SymbolTest do
  use ExUnit.Case

  alias YahooFinanza.Symbol

  test ".symbols for nyse market" do
    {:ok, symbols} = Symbol.symbols("nyse")
    assert symbols |> Enum.count == 3291
  end

  test ".symbols for nasdaq market" do
    {:ok, symbols} = Symbol.symbols("nasdaq")
    assert symbols |> Enum.count == 3083
  end

  test ".symbols for amex market" do
    {:ok, symbols} = Symbol.symbols("amex")
    assert symbols |> Enum.count == 396
  end

  test ".symbols for dow_jones index" do
    {:ok, symbols} = Symbol.symbols("dow_jones")
    assert symbols |> Enum.count == 30
  end

  test ".symbols for sp_500 index" do
    {:ok, symbols} = Symbol.symbols("sp_500")
    assert symbols |> Enum.count == 503
  end

  test ".symbols for invalid market" do
    assert Symbol.symbols("whatever") == {:error, "unable to find market"}
  end
end

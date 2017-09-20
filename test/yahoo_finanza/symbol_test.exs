defmodule YahooFinanza.SymbolTest do
  use ExUnit.Case

  alias YahooFinanza.Symbol

  test ".symbols for nyse market" do
    {:ok, symbols} = Symbol.symbols_for("nyse")
    assert symbols |> Enum.count == 2777
  end

  test ".symbols for nasdaq market" do
    {:ok, symbols} = Symbol.symbols_for("nasdaq")
    assert symbols |> Enum.count == 3083
  end

  test ".symbols for amex market" do
    {:ok, symbols} = Symbol.symbols_for("amex")
    assert symbols |> Enum.count == 355
  end

  test ".symbols for dow_jones index" do
    {:ok, symbols} = Symbol.symbols_for("dow_jones")
    assert symbols |> Enum.count == 30
  end

  test ".symbols for sp_500 index" do
    {:ok, symbols} = Symbol.symbols_for("sp_500")
    assert symbols |> Enum.count == 438
  end

  test ".symbols for invalid market" do
    assert Symbol.symbols_for("whatever") == {:error, "unable to find symbols for market whatever"}
  end
end

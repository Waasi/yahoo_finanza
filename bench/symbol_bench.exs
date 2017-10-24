defmodule YahooFinanza.SymbolBench do
  use Benchfella

  alias YahooFinanza.Symbol

  setup_all do
    Symbol.start_link
  end

  bench ".symbols for nyse" do
    Symbol.symbols_for "nyse"
  end

  bench ".symbols for amex" do
    Symbol.symbols_for "amex"
  end

  bench ".symbols for nasdaq" do
    Symbol.symbols_for "nasdaq"
  end

  bench ".symbols for sp_500" do
    Symbol.symbols_for "sp_500"
  end

  bench ".symbols for dow_jones" do
    Symbol.symbols_for "dow_jones"
  end
end

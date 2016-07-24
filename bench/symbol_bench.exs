defmodule YahooFinanza.SymbolBench do
  use Benchfella

  alias YahooFinanza.Symbol

  setup_all do
    Symbol.start_link
  end

  bench ".symbols for nyse" do
    Symbol.symbols "nyse"
  end

  bench ".symbols for amex" do
    Symbol.symbols "amex"
  end

  bench ".symbols for nasdaq" do
    Symbol.symbols "nasdaq"
  end

  bench ".symbols for sp_500" do
    Symbol.symbols "sp_500"
  end

  bench ".symbols for dow_jones" do
    Symbol.symbols "dow_jones"
  end
end

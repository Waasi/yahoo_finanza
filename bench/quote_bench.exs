defmodule YahooFinanza.QuoteBench do
  use Benchfella

  alias YahooFinanza.Symbol
  alias YahooFinanza.Quote

  setup_all do
    Symbol.start_link
    HTTPoison.start

    {:ok, nyse} = Symbol.symbols_for "nyse"
    {:ok, nasdaq} = Symbol.symbols_for "nasdaq"
    {:ok, amex} = Symbol.symbols_for "amex"
    {:ok, dow_jones} = Symbol.symbols_for "dow_jones"
    {:ok, sp_500} = Symbol.symbols_for "sp_500"

    symbols = nasdaq ++ nyse ++ amex ++ dow_jones ++ sp_500

    {:ok, symbols}
  end

  before_each_bench symbols do
    {:ok, symbols}
  end

  bench ".fetch for max symbols" do
    bench_context |> Quote.fetch
  end
end

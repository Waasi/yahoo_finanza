defmodule YahooFinanza.QuoteBench do
  use Benchfella

  alias YahooFinanza.Symbol
  alias YahooFinanza.Quote

  setup_all do
    Symbol.start_link
    Quote.start_link
    HTTPoison.start

    {:ok, symbols} = Symbol.symbols "nyse"
    {:ok, symbols |> Enum.take(1)}
  end

  before_each_bench symbols do
    {:ok, symbols}
  end

  bench ".fetch for max symbols" do
    bench_context |> Quote.fetch
  end
end

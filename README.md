# YahooFinanza
This is a simple Yahoo Finance module capable of getting current data for several symbols in bulk as well as individually. Additional features include getting stock symbols filtered by stock market.

## Installation

  1. Add yahoo_finanza to your list of dependencies in `mix.exs`:

        def deps do
          [{:yahoo_finanza, "~> 0.1.0"}]
        end

  2. Ensure yahoo_finanza is started before your application:

        def application do
          [applications: [:yahoo_finanza]]
        end

## Usage

Getting symbol list for a market

```elixir
YahooFinanza.Symbol.symbols "market" ## => {:ok, ["symbol1", "symbol2", ..., "symboln"]}
```

Note: The available markets are: "amex", "nyse", "sp_500", "dow_jones", "nasdaq"
To add a new market or listing simply add the csv file to the markets directory
and add the market or listing name to the markets.csv file.

Getting stock quote for a single symbol

```elixir
{:ok, quote} = YahooFinanza.Quote.fetch_quote("AAPL") ## => {:ok, %{"Symbol" => "AAPL", ... }}
```

It's properties can be accessed like so:

```elixir
quote["Ask"] ## => 12.0
```

Getting stock quote for multiple symbols

```elixir
{:ok, quotes} = YahooFinanza.Quote.fetch_quotes(["AAPL", "FB"]) ## => {:ok, quote_map_list}
```

Each quote can be accessed like so:

```elixir
apple = quotes |> List.first ## => %{"Symbol" => "AAPL", ... }
```

Note: The fetch_quotes method only accepts up to 700 symbols. If a larger quantity is given it will fail.

Combining the Symbol and Quote Modules

```elixir
{:ok, nyse_symbols} = YahooFinanza.Symbol.symbols "nyse"
{:ok, nyse_quotes} = nyse_symbols |> Enum.take(100) |> YahooFinanza.Quote.fetch_quotes
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/yahoo_finanza/fork )
2. Create your feature branch (`git checkout -b feature/my_new_feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Special Thanks To:

1. Daniel Berkompas (@danielberkompas)
2. Benjamin Tan Wei Hao
2. Johnny Mejias (@datajohnny)

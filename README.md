# YahooFinanza
This is a simple Yahoo Finance module capable of getting current data for several symbols in bulk as well as individually. It also has an historical data method which fetches historical data about a symbol. Additional features include getting stock symbols filtered by country and stock market.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add yahoo_finanza to your list of dependencies in `mix.exs`:

        def deps do
          [{:yahoo_finanza, "~> 0.0.1"}]
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
To add a new market or listing simply add the yaml file to the markets directory
and add the market or listing name to the config.exs file markets list variable


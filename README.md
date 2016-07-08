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


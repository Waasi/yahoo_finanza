defmodule YahooFinanza.Mixfile do
  use Mix.Project

  def project do
    [app: :yahoo_finanza,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     package: package]
  end

  def application do
    [applications: [:logger, :httpoison],
     mod: {YahooFinanza, []}]
  end

  defp deps do
    [{:csv, "~> 1.4.2"}, {:httpoison, "~> 0.9.0"}, {:json, "~> 0.3.0"}]
  end

  defp description do
    "This is a simple Yahoo Finance module capable
    of getting current data for several symbols in
    bulk as well as individually. Additional features
    include getting stock symbols filtered by stock market."
  end

  defp package do
    [name: :yahoo_finanza,
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Eric Santos"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/Waasi/yahoo_finanza"}]
  end
end

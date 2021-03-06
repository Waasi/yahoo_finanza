defmodule YahooFinanza.Mixfile do
  use Mix.Project

  def project do
    [app: :yahoo_finanza,
     version: "0.3.0",
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     source_url: "https://github.com/Waasi/yahoo_finanza",
     package: package(),
     docs: [extras: ["README.md"]]]
  end

  def application do
    [applications: [:logger, :httpoison],
     mod: {YahooFinanza, []}]
  end

  defp deps do
     [{:httpoison, "~> 0.13"},
     {:poison, "~> 3.1"},
     {:ex_doc, "~> 0.12", only: :dev},
     {:benchfella, "~> 0.3.0", only: :dev}]
  end

  defp description do
    "This is a simple Yahoo Finance module capable
    of getting current data for several symbols in
    bulk as well as individually. Additional features
    include getting stock symbols filtered by stock market."
  end

  defp package do
    [name: :yahoo_finanza,
     files: ["lib", "config", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Eric Santos"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/Waasi/yahoo_finanza"}]
  end
end

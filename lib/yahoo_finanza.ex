defmodule YahooFinanza do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(YahooFinanza.Symbol, [])
    ]

    opts = [strategy: :one_for_one, name: YahooFinanza.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

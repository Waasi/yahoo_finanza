defmodule YahooFinanza do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(YahooFinanza.Quote, []),
      worker(YahooFinanza.Symbol, []),
    ]

    opts = [strategy: :one_for_one, name: YahooFinanza.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

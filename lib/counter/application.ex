defmodule Counter.Application do
  @moduledoc false
  use Application
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [ worker(Counter.Server, [], name: Counter.Server) ]
    opts = [strategy: :one_for_one, name: Counter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

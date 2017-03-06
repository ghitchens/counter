defmodule Counter.Server do

  @moduledoc false
  use GenServer

  @tick_time 1000

  def start_link do
    GenServer.start_link(__MODULE__, 0, name: Counter.Server)
  end

  def init(initial_count) do
    :timer.send_after(@tick_time, :tick)
    {:ok, initial_count}
  end

  def handle_info(:tick, state) do
    :timer.send_after(@tick_time, :tick)
    {:noreply, state + 1}
  end

  def handle_cast(:clear, _state) do
    {:noreply, 0}
  end

  def handle_call(:count, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:request, :count}, from, state) do
    Registry.dispatch(Counter, :count, fn entries ->
      for {pid, _} <- entries do
        send(pid, {Counter, :count, data})
      end
    end
  end

  # BUG - cannot be implemented with Registry because Registry.register/3
  # doesn't allow registering <from> as the subscriber.
  def handle_call(:sync2, from, state) do
    Registry.register(Counter, :count, state, from)  # NEED Register/4
    {:reply, state, state}
  end
end

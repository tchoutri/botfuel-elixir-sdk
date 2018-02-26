defmodule Botfuel.Client do

  use GenServer
  require Logger
  alias Botfuel.{Entity,Spellcheck}

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    if (state.app_id == nil) || (state.app_key == nil) do
      {:stop, "Your Application ID and/or key is lacking from configuration!"}
    end
    Application.put_env(:botfuel, :app_id, state.app_id)
    Application.put_env(:botfuel, :app_key, state.app_key)
    {:ok, state}
  end

  def handle_call({:extract, params}, _from, state) do
    {:ok, result} = Botfuel.Request.extract(params)
    result = Enum.map(result, fn r -> to_struct(Entity.Response, r) end)
    {:reply, result, state}
  end

  def handle_call({:spellcheck, params}, _from, state) do
    {:ok, result} = Botfuel.Request.spellcheck(params)
    Logger.debug(inspect result)
    result = to_struct(Spellcheck, Spellcheck.normalize(result))
    {:reply, result, state}
  end

  defp to_struct(struct, params) do
    struct = struct(struct)
    Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(params, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end
  end
end

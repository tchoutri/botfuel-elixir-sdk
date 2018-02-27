defmodule Botfuel.Client do
  @moduledoc false

  use GenServer
  require Logger
  alias Botfuel.{Entity,Spellcheck,Classify,Request}
  alias Botfuel.Entity.{Response}

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
    {:ok, result} = params
                    |> Entity.purify(:dimensions)
                    |> Entity.purify(:antidimensions)
                    |> Request.extract
    result = Enum.map(result, fn r -> to_struct(Response, r) end)
    {:reply, result, state}
  end

  def handle_call({:spellcheck, params}, _from, state) do
    {:ok, result} = Request.spellcheck(params)
    result = to_struct(Spellcheck, Spellcheck.normalize(result))
    {:reply, result, state}
  end

  def handle_call({:classify, params}, _from, state) do
    {:ok, result} = Request.classify(params)
    Logger.debug(inspect result)
    result = Enum.map(result, fn r -> to_struct(Classify, r) end)
    {:reply, result, state}
  end

  defp to_struct(_, []), do: []
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

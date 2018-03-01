defmodule Botfuel.Request do
  @moduledoc false
  require Logger
  use Tesla, docs: false, only: [:get, :post]

  plug Tesla.Middleware.Headers, %{"App-Id"  => Application.get_env(:botfuel, :app_id),
                                   "App-Key" => Application.get_env(:botfuel, :app_key)
                                  }

  plug Tesla.Middleware.JSON, engine: Jason
  plug Tesla.Middleware.BaseUrl, "https://api.botfuel.io"

  def extract(params) do
    url = "/nlp/entity-extraction"
    params = params_to_list(params)
    Logger.debug(inspect params)
    case get(url, query: params) do
      %Tesla.Env{status: 200, body: body} -> 
        {:ok, body}
      error ->
        Logger.error(inspect error)
        {:error, error}
    end
  end

  def spellcheck(params) do
    url = "/nlp/spellchecking"
    case get(url, query: Map.to_list(params)) do
      %Tesla.Env{status: 200, body: body} ->
        {:ok, body}
      error -> 
        Logger.error(inspect error)
        {:error, error}
    end
  end

  def classify(params) do
    url = "/qna/api/v1/bots/classify"
    case post(url, params) do
      %Tesla.Env{status: 200, body: body} ->
        {:ok, body}
      error ->
        Logger.error(inspect error)
        {:error, error}
    end
  end

  defp params_to_list(params) when is_map(params) do
    params
    |> Map.delete(:__struct__)
    |> Map.to_list
    |> flatten_params([])
  end

  defp flatten_params([_|[]], acc), do: acc
  defp flatten_params([{k,v}|t]=nested_list, acc) when is_list(v) do
    Logger.debug("Blarb => " <> inspect nested_list)
    flat = List.duplicate(k, length(v)) |> Enum.zip(v)
    flatten_params(t, flat ++ acc)
  end

  defp flatten_params([head|tail], acc), do: flatten_params(tail, [head] ++ acc)
end

defmodule Botfuel.Request do
  require Logger
  use Tesla

  plug Tesla.Middleware.Headers, %{"App-Id" => Application.get_env(:botfuel, :app_id),
                                   "App-Key" => Application.get_env(:botfuel, :app_key)
                                  }
  plug Tesla.Middleware.JSON, engine: Jason
  plug Tesla.Middleware.BaseUrl, "https://api.botfuel.io"


  def extract(params) do
    url = "/nlp/entity-extraction"
    case get(url, query: Map.to_list(params)) do
      %Tesla.Env{status: 200, body: body} -> {:ok, body}
      error ->
        Logger.error(inspect error)
        {:error, :error}
    end
  end

  def spellcheck(params) do
    url = "/nlp/spellchecking"
    case get(url, query: Map.to_list(params)) do
      %Tesla.Env{status: 200, body: body} -> {:ok, body}
      error -> 
        Logger.error(inspect error)
        {:error, :error}
    end
  end

  def classify(params) do
    url = "/qna/api/v1/bots/classify"
    case post(url, params) do
      %Tesla.Env{status: 200, body: body} -> {:ok, body}
      error ->
        Logger.error(inspect error)
        {:error, :error}
    end
  end
end

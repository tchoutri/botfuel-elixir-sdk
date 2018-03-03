defmodule Botfuel do
  @moduledoc """
  Documentation for the Botfuel main module.
  """

  alias Botfuel.{Entity,Classify,Spellcheck}

  @doc """
  Creates a new client process with the provided API `app_id` and `app_key` as a map.

  The `Botfuel.Client` module can be started by hand in a supervision tree as well, without much more ceremony.  
  API id and key retrieval are left to the user according to their method of choice (config.ex, environment variables, HashiCorp Vault, etc).
  """
  def new_client(credentials) do
    Botfuel.Client.start_link(credentials)
  end

  @doc """
  Extract the entities of the provided sentence and parameters.

  They must be packed in a `%Botfuel.Entity{}` struct.  
  You can learn more about what dimensions are authoriezd by checking the
  `Botfuel.Entity.dimension` type.
  """
  @spec extract_entity(Entity.t) :: {:ok, [Entity.Response.t]} | {:error, atom()}
  def extract_entity(%Entity{}=params) do
    GenServer.call(Botfuel.Client, {:extract, params})
  end

  @doc """
  Run the provided sentence through the spellchecking platform.

  The accepted parameters are:
  * sentence: the sentence to be checked
  * lang: the language to check. Must be either "FR" or "EN".
  * distance: the maximum authorized distance (1 or 2)
  """
  @spec spellcheck(String.t, String.t, non_neg_integer) :: {:ok, Spellcheck.t} | {:error, atom()}
  def spellcheck(sentence, lang, distance \\ 2) do
    GenServer.call(Botfuel.Client, {:spellcheck, %{"sentence" => sentence, key: "#{lang}_#{distance}"}})
  end

  @doc """
  Send the question to the bot platform and return all answers that match it.
  """
  @spec classify(String.t) :: {:ok, [Classify.t]} | {:error, atom()}
  def classify(sentence) do
    GenServer.call(Botfuel.Client, {:classify, %{sentence: sentence}})
  end
end

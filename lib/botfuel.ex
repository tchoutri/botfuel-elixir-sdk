defmodule Botfuel do
  @moduledoc """
  Documentation for Botfuel.
  """

  alias Botfuel.{Entity,Classify}

  @doc "Creates a new client process with the provided API credentials"
  def new_client(credentials) do
    Botfuel.Client.start_link(credentials)
  end

  @doc """
  Extract the entities of the provided sentence and parameters.
  They must be packed in a `%Botfuel.Entity{}` struct. You can
  learn more about what dimensions are authoriezd by checking the
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
  @spec spellcheck(String.t, String.t, non_neg_integer) :: {:ok, Entity.t} | {:error, atom()}
  def spellcheck(sentence, lang, distance \\ 2) do
    GenServer.call(Botfuel.Client, {:spellcheck, %{"sentence" => sentence, key: "#{lang}_#{distance}"}})
  end

  @spec classify(String.t) :: {:ok, [Classify.t]} | {:error, atom()}
  def classify(sentence) do
    GenServer.call(Botfuel.Client, {:classify, %{sentence: sentence}})
  end
end

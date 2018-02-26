defmodule Botfuel.Spellcheck do
  defstruct [original_sentence: "",
             sentence_template: "",
             correct_words: [],
             original_words: [],
             correct_sentence: "",
             possible_corrections: []
            ]


  @type t :: %__MODULE__{original_sentence: String.t, sentence_template: String.t,
                         correct_words: [String.t], original_words: [String.t],
                         correct_sentence: String.t, possible_corrections: [correction()]
                        }

  @type correction :: map()

  def normalize(map) do
    Enum.map(map, fn {k,v} ->
      v = cond do
        is_map(v) -> normalize(v)
        is_list(v) -> Enum.map(v, fn map -> if is_map(map), do: normalize(map), else: map end)
        true      -> v
      end

      {Recase.to_snake(k), v}
    end)
    |> Enum.into(%{})
  end
end

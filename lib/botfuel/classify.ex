defmodule Botfuel.Classify do
  defstruct [probability: 0.0,
             answer: "",
             questions: []
            ]

  @type t :: %__MODULE__{probability: float(), answer: String.t, questions: [String.t]}
end

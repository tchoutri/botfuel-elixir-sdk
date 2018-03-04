defmodule Botfuel.Botmeter do
@moduledoc """
  The struct that encapsulates the parameters sent to the Botmeter endpoint.

  ### Query Parameters for `%Botfuel.Botmeter{}`

  All Parameters are optional. An empty string or object will be sent instead.

  * `bot_version :: String.t` Bot version ("1.3.0") 

  * `channel :: String.t` Messaging channel (Webchat, Messenger, Telegram…)

  * `user_id  :: String.t` ID of the user you're interacting with

  * `user :: %{}` User properties (%{name: "Jane Doe"})

  * `conversation_id :: String.t` Conversation ID

  * `body :: String.t` Message body

  * `body_type :: :text | :postback` Type of body 

  * `responses :: [String.t]` The bot responses

  * `state_in :: String.t` The input state

  * `state_out :: String.t` The output state

  * `intent :: %{}` Name and score of intent (%{name: "foo", score: 0.9})

  * `tags :: [String.t]` Message tags
  """

  # @derive Jason.Encoder
  defstruct [ bot_version: "",
              channel: "",
              user_id: "",
              user: %{},
              conversation_id: "",
              body: "",
              body_type: "",
              responses: [],
              state_in: "",
              state_out: "",
              intent: %{},
              tags: [], 
            ]

require Protocol
Protocol.derive(Jason.Encoder, Botfuel.Botmeter)

  @type body_type :: :text | :postback
  @type t :: %__MODULE__{bot_version: String.t, channel: String.t, user_id: String.t, user: map(), conversation_id: String.t,
                         body: String.t, body_type: body_type(), responses: [String.t], state_in: String.t, state_out: String.t,
                         intent: map(), tags: [String.t]}
end

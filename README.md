# Botfuel ![Made in Elixir](https://cdn.rawgit.com/tchoutri/botfuel-elixir-sdk/master/elixir.svg) ![Hex.pm](https://img.shields.io/hexpm/v/botfuel.svg) ![Hex.pm](https://img.shields.io/hexpm/l/botfuel.svg)

WARNING: This project is not actively maintained. I'll accept PRs but don't except the library to follow the API changes.

This is an (unofficial) Elixir SDK for the [Botfuel.io](https://app.botfuel.io/docs) NLP bot platform.
Feedback and contributions are of course welcome.

## Installation

You can use `botfuel` directly from [Hex](https://hex.pm). Just add the corresponding line to your `mix.exs`:

```Elixir
def deps do
  [
    {:botfuel, "~> 0.1"}
  ]
end
```

Or (recommended)

```Elixir
def deps do
  [
    {:botfuel, github: "tchoutri/botfuel-elixir-sdk"}
  ]
end
```

## Usage

You can start the `Botfuel.Client` module manually in your Supervision tree, like that:

```Elixir
defmodule Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    {app_id = System.get_env("BTFL_APPID"), app_key = System.get_env("BTFL_APPKEY")}

    children = [
      {Botfuel.Client, %{app_id: app_id, app_key: app_key}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gazoline.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

or use `Botfuel.new_client(%{app_id: <your app ID>, app_key: <your app key>})`.

```Elixir
iex(1)> Botfuel.new_client(%{app_id: app_id, app_key: app_key})
{:ok, #PID<0.189.0>}
```

Moreover, the top-level module exports 3 functions to interact with the platform:

* `extract_entity/1`
* `spellcheck/3`
* `classify/1`

[Read the docs ;)](https://hexdocs.pm/botfuel)

I want to take great care of the documentation, but everyone's different so don't hesitate and reach to me if you feel it could be improved!  
Thanks :heart:

## Licence

This software is licenced under the MIT licence.  
See [LICENSE](LICENSE).  
You can alternatively buy me a drink IRL if you're grateful for my work. :)

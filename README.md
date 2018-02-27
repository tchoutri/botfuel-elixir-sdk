# Botfuel ![Made in Elixir](https://cdn.rawgit.com/tchoutri/botfuel-elixir-sdk/master/elixir.svg) ![Hex.pm](https://img.shields.io/hexpm/v/botfuel.svg) ![Hex.pm](https://img.shields.io/hexpm/l/botfuel.svg)

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

## Usage

You can start the `Botfuel.Client` module manually in your Supervision tree, or use `Botfuel.new_client(%{app_id: <your app ID>, app_key: <your app key>})`.

```Elixir
iex(1)> Botfuel.new_client(%{app_id: app_id, app_key: app_key})
{:ok, #PID<0.189.0>}
```

Moreover, the top-level module exports 3 functions to interact with the platform:

* `extract_entity/1`
* `spellcheck/3`
* `classify/1`

[Read the docs ;)](https://hexdocs.pm/botfuel)

## Licence

This software is licenced under the MIT licence.  
See [LICENSE](LICENSE).  
You can alternatively buy me a drink IRL if you're grateful for my work. :)

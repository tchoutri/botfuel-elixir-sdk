defmodule Botfuel.MixProject do
  use Mix.Project

  def project do
    [
      app: :botfuel,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Botfuel.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, "~> 1.11.0"},
      {:tesla, "~> 0.10.0"}
    ]
  end
end

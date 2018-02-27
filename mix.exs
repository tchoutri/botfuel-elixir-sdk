defmodule Botfuel.MixProject do
  use Mix.Project

  def project do
    [
      app: :botfuel,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Botfuel",
      source_url: "https://github.com/tchoutri/botfuel-elixir-sdk"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Botfuel.Application, []}
    ]
  end

  defp description() do
    "An Elixir SDK for the Botfuel.io chatbot platform."
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ["lib", "mix.exs", "README*","LICENSE*", "CoC.*"],
      maintainers: ["Théophile Choutri"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tchoutri/botfuel-elixir-sdk"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.18.3", only: :dev},
      {:hackney, "~> 1.11"},
      {:jason, "~> 1.0"},
      {:recase, "~> 0.3"},
      {:tesla, "~> 0.10"}
    ]
  end
end

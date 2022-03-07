defmodule Spintria.MixProject do
  use Mix.Project

  def project do
    [
      app: :spintria,
      version: "0.1.0",
      elixir: "~> 1.13",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Spintria.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, "~> 0.16.2"},
      {:mox, "~> 1.0.1", only: :test},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

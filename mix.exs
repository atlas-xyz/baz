defmodule Baz.MixProject do
  use Mix.Project

  def project do
    [
      app: :baz,
      version: "0.0.1",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      aliases: aliases(),
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore.exs"
      ]
    ]
  end

  def application do
    [
      mod: {Baz.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.6"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, "~> 0.15"},
      {:ex_open_sea, "~> 0.0.2"},
      {:table_rex, "~> 3.1"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:ex_unit_notifier, "~> 1.0", only: :test},
    ]
  end

  defp description do
    "A chain native hybrid bazaar engine"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/fremantle-industries/baz"}
    }
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      # "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end

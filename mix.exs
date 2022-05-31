defmodule Baz.MixProject do
  use Mix.Project

  def project do
    [
      app: :baz,
      version: "0.0.2",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      aliases: aliases(),
      dialyzer: [
        plt_add_apps: [:mix, :iex],
        ignore_warnings: ".dialyzer_ignore.exs"
      ]
    ]
  end

  def application do
    [
      mod: {Baz.Application, []},
      start_phases: [venues: []],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.6"},
      {:ecto_term, "~> 0.0.1"},
      {:ecto_sql, "~> 3.6"},
      {:etso, "~> 1.0.1"},
      {:juice, "~> 0.0.3"},
      {:oban, "~> 2.12"},
      {:postgrex, "~> 0.15"},
      {:ex_open_sea, "~> 0.0.3"},
      {:table_rex, "~> 3.1"},
      {:logger_file_backend, "~> 0.0.1", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.1", only: :dev, runtime: false},
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
      links: %{"GitHub" => "https://github.com/Tokenalysis/baz"}
    }
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end

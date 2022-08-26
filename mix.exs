defmodule Baz.MixProject do
  use Mix.Project

  def project do
    [
      app: :baz,
      version: "0.0.13",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: [
        plt_add_apps: [:mix, :iex, :ex_unit],
        ignore_warnings: ".dialyzer_ignore.exs"
      ]
    ]
  end

  def application do
    [
      mod: {Baz.Application, []},
      start_phases: [settings: [], raw_sinks: [], normalized_sinks: [], venues: []],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.8"},
      {:ecto_term, "~> 0.0.1"},
      {:ecto_sql, "~> 3.6"},
      {:etso, "~> 1.1.0"},
      {:juice, "~> 0.0.3"},
      {:oban, "~> 2.12"},
      {:postgrex, "~> 0.15"},
      {:ex_looks_rare, "~> 0.0.2"},
      {:ex_open_sea, "~> 0.0.6"},
      {:ex_magic_eden, "~> 0.0.4"},
      {:ex_x2y2, "~> 0.0.3"},
      {:poolboy, "~> 1.5"},
      {:table_rex, "~> 3.1"},
      {:timex, "~> 3.7"},
      {:logger_file_backend, "~> 0.0.1", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.1", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:ex_unit_notifier, "~> 1.0", only: :test}
    ]
  end

  defp description do
    "A chain native hybrid bazaar engine"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/atlas-xyz/baz"}
    }
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end

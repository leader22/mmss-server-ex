defmodule MMSSServer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :mmss_server_ex,
      version: "0.1.0",
      elixir: "~> 1.6.0-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MMSSServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.1.2"},
      {:plug, "~> 1.3.4"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end
end

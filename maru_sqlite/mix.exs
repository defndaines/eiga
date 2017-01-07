defmodule Eiga.Mixfile do
  use Mix.Project

  def project do
    [app: :eiga,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :sqlitex, :sqlite_ecto, :ecto, :maru],
     mod: {Eiga, []}]
  end

  defp deps do
    [{:maru, "~> 0.11.3"},
     {:sqlite_ecto, "~> 1.1.0"},
     {:distillery, "~> 0.10.1"}]
  end
end

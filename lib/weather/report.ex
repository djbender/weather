defmodule Weather.Report do
  @moduledoc """
  A module for generating weather reports.
  """

  alias Weather.Report.Alerts
  alias Weather.Report.Current
  alias Weather.Report.Hourly
  alias Weather.Report.Rain

  @separator "\n"

  @doc """
  Create a comprehensive weather report composed of subreports.
  """
  @spec generate(Req.Response.t(), Weather.Opts.t()) :: String.t()
  def generate(resp, opts) do
    {[], resp.body, opts}
    |> Alerts.generate()
    |> Current.generate()
    |> Hourly.generate()
    |> Rain.generate()
    |> aggregate_report()
  end

  defp aggregate_report({report, _body, _opts}), do: Enum.join(report, @separator)
end

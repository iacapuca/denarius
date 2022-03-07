defmodule Spintria.Exchange.ClientBehavior do
  @callback new(token :: String.t()) :: Tesla.Client.t()
  @callback get(url :: String.t(), opts :: List.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
end

defmodule Spintria.Exchange.Client do
  @adapter Tesla.Adapter.Hackney
  @behaviour Spintria.Exchange.ClientBehavior

  defp get_token, do: Application.get_env(:spintria, :exchangeratesapi_token)
  # defp base_url, do: Application.get_env(:github_client, :base_url)

  def new(token \\ get_token()) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "http://api.exchangeratesapi.io/v1"},
      {Tesla.Middleware.Timeout, timeout: 1000},
      {Tesla.Middleware.Query, [access_key: token]},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware, @adapter)
  end

  def get(url, opts \\ []) do
    Tesla.get(new(), url, opts)
  end
end

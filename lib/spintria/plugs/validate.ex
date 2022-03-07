defmodule Spintria.Plug.ValidatePlug do
  use Plug.Builder

  import Ecto.Changeset

  def init(options), do: options

  @doc "Function plug to validate a GET /convert request"
  def call(%Plug.Conn{request_path: path} = conn, opts) do
    if path in opts[:paths] do
      conn = Plug.Conn.fetch_query_params(conn)

      case Spintria.Schema.Query.validate_params(conn.query_params) do
        {:ok, attrs} ->
          conn
          |> assign(:attrs, attrs)

        {:error, %Ecto.Changeset{} = changeset} ->
          errors = format_changeset_errors(changeset)

          conn
          |> assign(:error, errors)
          |> send_resp(
            400,
            Jason.encode!(%{
              "error" => true,
              "message" => errors
            })
          )
          |> halt()
      end
    else
      conn
    end
  end

  defp format_changeset_errors(%Ecto.Changeset{} = changeset) do
    errors =
      traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)

    formatted_errors =
      Enum.map(errors, fn {key, value} ->
        formatter_error = "#{key} #{value}"
        formatter_error
      end)

    formatted_errors
  end
end

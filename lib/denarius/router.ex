defmodule Denarius.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias Denarius.Controller.ConvertController
  alias Denarius.Controller.TransactionController
  alias Denarius.Plug.ValidatePlug

  plug(Plug.Logger, log: :debug)
  plug(ValidatePlug, paths: ["/convert"])
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json", "text/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/convert" do
    ConvertController.store(conn)
  end

  get("/transactions") do
    TransactionController.index(conn)
  end

  get("/transactions/:user_id") do
    user_id = user_id |> String.to_integer()
    TransactionController.show(conn, user_id)
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    res = %{
      "message" => conn.assigns[:error]
    }

    send_resp(conn, conn.status, Jason.encode!(res))
  end
end

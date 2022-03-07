defmodule Denarius.Controller.TransactionController do
  import Plug.Conn

  alias Denarius.Schema.Transaction
  alias Denarius.Repo
  import Ecto.Query

  @derive Jason.Encoder
  defimpl Jason.Encoder, for: Transaction do
    def encode(value, opts) do
      Jason.Encode.map(
        Map.take(value, [:transaction_id, :user_id, :amount, :from, :to, :inserted_at, :rate]),
        opts
      )
    end
  end

  def index(conn) do
    transactions = Transaction |> Repo.all()
    send_resp(conn, 200, Jason.encode!(%{:transactions => transactions}))
  end

  def show(conn, user_id) do
    q = from(t in Transaction, where: t.user_id == ^user_id, select: t)
    transactions = Repo.all(q)
    send_resp(conn, 200, Jason.encode!(%{:transactions => transactions}))
  end
end

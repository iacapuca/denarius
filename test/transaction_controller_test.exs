defmodule Denarius.TransactionControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Denarius.Repo
  alias Denarius.Router
  alias Denarius.Schema.Transaction
  alias Ecto.Adapters.SQL.Sandbox

  Sandbox.mode(Repo, :manual)

  setup do
    :ok = Sandbox.checkout(Repo)

    transaction =
      %Transaction{user_id: 1, from: "BRL", to: "USD", amount: 100.0, rate: 0.2}
      |> Repo.insert!()

    {:ok, transaction: transaction}
  end

  test "returns all transactions", %{transaction: transaction} do
    transactions_as_json =
      %{
        :transactions => [
          transaction
        ]
      }
      |> Jason.encode!()

    conn =
      :get
      |> conn("/transactions")
      |> Router.call([])

    assert conn.resp_body == transactions_as_json
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "return all transactions by user_id", %{transaction: transaction} do
    transactions_as_json =
      %{
        :transactions => [
          transaction
        ]
      }
      |> Jason.encode!()

    conn =
      :get
      |> conn("/transactions/1")
      |> Router.call([])

    assert conn.resp_body == transactions_as_json
    assert conn.state == :sent
    assert conn.status == 200
  end
end

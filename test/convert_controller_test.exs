defmodule Spintria.ConvertControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Mox

  alias Ecto.Adapters.SQL.Sandbox
  alias Spintria.Router
  alias Spintria.Repo
  alias Spintria.Utils.Clock

  Sandbox.mode(Repo, :manual)

  setup do
    Clock.freeze()
    :ok = Sandbox.checkout(Repo)
    :verify_on_exit!
    :ok
  end

  test "should convert 100BRL to USD" do
    transaction_as_json = %{
      amount: 100.0,
      converted_amount: 19.74708482887638,
      datetime_utc: Clock.utc_now(),
      from: "BRL",
      to: "USD",
      rate: 0.1974708482887638,
      user_id: 1
    }

    Spintria.Exchange.MockClient
    |> expect(:get, fn _, _ ->
      {:ok,
       %{
         :body => %{
           "base" => "EUR",
           "date" => "2022-03-07",
           "rates" => %{
             "BRL" => 5.492988,
             "USD" => 1.084705
           },
           "success" => true,
           "timestamp" => 1_646_629_026
         }
       }}
    end)

    conn =
      :get
      |> conn("/convert?from=BRL&to=USD&amount=100&user_id=1")
      |> Router.call([])

    assert conn.resp_body == transaction_as_json |> Jason.encode!()
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "should covert 100BRL to EUR" do
    transaction_as_json = %{
      amount: 100.0,
      converted_amount: 18.158951109929568,
      datetime_utc: Clock.utc_now(),
      from: "BRL",
      to: "EUR",
      rate: 0.18158951109929566,
      user_id: 1
    }

    Spintria.Exchange.MockClient
    |> expect(:get, fn _, _ ->
      {:ok,
       %{
         :body => %{
           "base" => "EUR",
           "date" => "2022-03-07",
           "rates" => %{
             "BRL" => 5.506926
           },
           "success" => true,
           "timestamp" => 1_646_629_026
         }
       }}
    end)

    conn =
      :get
      |> conn("/convert?from=BRL&to=EUR&amount=100&user_id=1")
      |> Router.call([])

    assert conn.resp_body == transaction_as_json |> Jason.encode!()
    assert conn.state == :sent
    assert conn.status == 200
  end
end

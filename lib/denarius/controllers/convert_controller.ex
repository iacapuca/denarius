defmodule Denarius.Controller.ConvertController do
  import Plug.Conn

  alias Denarius.Schema.Transaction
  alias Denarius.Utils.Clock

  @exchange_api Application.compile_env!(:denarius, :exchange_api)

  @doc """
  Convert an amount of a certain currency to other currency
  Returns a map which will be parsed to JSON by Jason
  %{
      "user_id" => 1,
      "from" => "BRL",
      "to" => "EUR",
      "amount" => 100,
      "rate" => rate,
      "converted_amount" => 18.03729680083289,
      "datetime_utc" => "2022-03-06T07:00:55.111485Z"
  }
  """
  def store(conn) do
    attrs = conn.assigns[:attrs]

    {:ok, response} = @exchange_api.get("/latest", [])
    rates = response.body["rates"]

    converted_amount = convert_currency(rates, attrs.to, attrs.from, attrs.amount)

    rate = converted_amount / attrs.amount

    data = %{
      "user_id" => attrs.user_id,
      "from" => attrs.from,
      "to" => attrs.to,
      "amount" => attrs.amount,
      "rate" => rate,
      "converted_amount" => converted_amount,
      "datetime_utc" => Clock.utc_now()
    }

    transaction = %Transaction{
      :user_id => attrs.user_id,
      :from => attrs.from,
      :to => attrs.to,
      :amount => attrs.amount,
      :rate => rate
    }

    Denarius.Repo.insert!(transaction)

    send_resp(conn, 200, Jason.encode!(data))
  end

  @doc """
  Convert an amount of a certain currency to EUR
  Returns the converted amount
  """
  defp convert_currency(rates, to, from, amount) when to == "EUR" do
    converted_amount = amount / rates[from]
    converted_amount
  end

  @doc """
  Convert an amount of a certain currency to other currency
  Returns the converted amount
  """
  defp convert_currency(rates, to, from, amount) do
    eur_amount = amount / rates[from]
    converted_amount = eur_amount * rates[to]
    converted_amount
  end
end

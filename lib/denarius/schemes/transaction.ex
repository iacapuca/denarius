defmodule Denarius.Schema.Transaction do
  @moduledoc """
  Provides an Ecto Schema to the Transaction model
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:transaction_id, :binary_id, autogenerate: true}

  schema "transactions" do
    field(:user_id, :integer)
    field(:from, :string)
    field(:to, :string)
    field(:amount, :float)
    field(:rate, :float)

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:user_id, :from, :to, :amount, :rate])
    |> validate_required([:user_id, :from, :to, :amount, :rate])
  end
end

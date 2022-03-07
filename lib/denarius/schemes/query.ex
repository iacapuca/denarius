defmodule Denarius.Schema.Query do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field(:from, :string)
    field(:to, :string)
    field(:amount, :float)
    field(:user_id, :integer)
  end

  def changeset(attrs) do
    %Denarius.Schema.Query{}
    |> cast(attrs, [:from, :to, :amount, :user_id])
    |> validate_required([:user_id, :from, :to, :amount])
  end

  def validate_params(params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true, changes: changes} ->
        {:ok, changes}
    end
  end
end

defmodule Spintria.Repo.Migrations.TransactionHistory do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :transaction_id, :uuid, primary_key: true
      add :user_id, :integer
      add :from, :string
      add :to, :string
      add :amount, :float
      add :rate, :float


      timestamps()
    end
  end
end

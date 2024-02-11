defmodule StringListType.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :integer
      add :nicknames, {:array, :string}

      timestamps(type: :utc_datetime)
    end
  end
end

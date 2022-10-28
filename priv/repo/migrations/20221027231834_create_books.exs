defmodule Tutorial.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :category, :string

      timestamps()
    end
  end
end

defmodule Tutorial.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :category, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :category])
    |> validate_required([:title, :category])
  end
end

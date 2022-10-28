defmodule Tutorial.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tutorial.Library` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        category: "some category",
        title: "some title"
      })
      |> Tutorial.Library.create_book()

    book
  end
end

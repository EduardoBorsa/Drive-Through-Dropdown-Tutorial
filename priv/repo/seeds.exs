# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tutorial.Repo.insert!(%Tutorial.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

[
  %{title: "Some Horror", category: "Horror"},
  %{title: "Some Fantasy", category: "Fantasy"},
  %{title: "Some Literary Fiction", category: "Literary Fiction"}
]
|> List.duplicate(3)
|> List.flatten()
|> Enum.with_index()
|> Enum.each(fn {v, i} ->
  Tutorial.Library.create_book(%{v | title: v.title <> " #{i}"})
end)

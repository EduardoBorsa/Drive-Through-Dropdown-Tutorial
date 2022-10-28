defmodule TutorialWeb.TutorialLive.Index do
  use TutorialWeb, :live_view
  alias Tutorial.MultiSelect
  alias Tutorial.MultiSelect.SelectOption
  alias TutorialWeb.Components.MultiSelectComponent
  alias Tutorial.Library

  @impl true
  def mount(_assigns, _session, socket) do
    options = [
      %SelectOption{id: 1, label: "Fantasy", selected: false},
      %SelectOption{id: 2, label: "Horror", selected: true},
      %SelectOption{id: 3, label: "Literary Fiction", selected: false}
    ]

    {:ok, set_assigns(socket, options)}
  end

  @impl true
  def handle_info({:updated_options, updated_categories}, socket) do
    {:noreply, set_assigns(socket, updated_categories)}
  end

  @impl true
  def handle_event(
        "validate",
        %{"multi_select" => multi_form},
        socket
      ) do
    options = build_options(multi_form["options"])
    {:noreply, set_assigns(socket, options)}
  end

  ############
  # REDUCERS #
  ############

  defp set_assigns(socket, categories) do
    socket
    |> assign(:changeset, build_changeset(categories))
    |> assign(:books, filter_books(categories))
    |> assign(:categories, categories)
  end

  #####################
  # PRIVATE FUNCTIONS #
  #####################

  defp build_options(options) do
    Enum.map(options, fn {_idx, data} ->
      %SelectOption{
        id: data["id"],
        label: data["label"],
        selected: data["selected"]
      }
    end)
  end

  defp build_changeset(options) do
    %MultiSelect{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_embed(:options, options)
  end

  defp filter_books(options) do
    selected_options =
      Enum.flat_map(options, fn option ->
        if option.selected in [true, "true"] do
          [option.label]
        else
          []
        end
      end)

    if selected_options == [] do
      Library.list_books()
    else
      Library.list_books_by_criteria(categories: selected_options)
    end
  end
end

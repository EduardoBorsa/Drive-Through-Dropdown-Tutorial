defmodule TutorialWeb.Components.MultiSelectComponent do
  use TutorialWeb, :live_component
  alias Phoenix.LiveView.JS

  @impl true
  def update(params, socket) do
    %{options: options} = params

    {:ok,
     socket
     |> assign(params)
     |> assign(:selectable_options, options)
     |> assign(:selected_options, filter_selected_options(options))}
  end

  defp filter_selected_options(options) do
    Enum.filter(options, fn opt ->
      opt.selected in [true, "true"]
    end)
  end

  @impl true
  def handle_event(
        "checked",
        %{"multi_select" => %{"options" => values}},
        socket
      ) do
    [{index, %{"selected" => selected?}}] = Map.to_list(values)
    index = String.to_integer(index)
    selectable_options = socket.assigns.selectable_options
    current_option = Enum.at(selectable_options, index)

    updated_options =
      List.replace_at(
        selectable_options,
        index,
        %{current_option | selected: selected?}
      )

    socket.assigns.selected.(updated_options)

    {:noreply, socket}
  end
end

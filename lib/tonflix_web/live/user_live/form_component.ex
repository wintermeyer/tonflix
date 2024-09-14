defmodule TonflixWeb.UserLive.FormComponent do
  use TonflixWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:email]} type="text" label="Email" /><.input
          field={@form[:first_name]}
          type="text"
          label="First name"
        /><.input field={@form[:last_name]} type="text" label="Last name" /><.input
          field={@form[:gender]}
          type="text"
          label="Gender"
        /><.input field={@form[:honorific_title]} type="text" label="Honorific title" /><.input
          field={@form[:street]}
          type="text"
          label="Street"
        /><.input field={@form[:zip_code]} type="text" label="Zip code" /><.input
          field={@form[:country]}
          type="text"
          label="Country"
        /><.input field={@form[:birthdate]} type="date" label="Birthdate" /><.input
          field={@form[:mobile_phone_number]}
          type="text"
          label="Mobile phone number"
        />

        <:actions>
          <.button phx-disable-with="Saving...">Save User</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form()}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    {:noreply, assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, user_params))}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: user_params) do
      {:ok, user} ->
        notify_parent({:saved, user})

        socket =
          socket
          |> put_flash(:info, "User #{socket.assigns.form.source.type}d successfully")
          |> push_patch(to: socket.assigns.patch)

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp assign_form(%{assigns: %{user: user}} = socket) do
    form =
      if user do
        AshPhoenix.Form.for_update(user, :update, as: "user", actor: socket.assigns.current_user)
      else
        AshPhoenix.Form.for_create(Tonflix.Accounts.User, :create,
          as: "user",
          actor: socket.assigns.current_user
        )
      end

    assign(socket, form: to_form(form))
  end
end

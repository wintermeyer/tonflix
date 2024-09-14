defmodule TonflixWeb.UserLive.Show do
  use TonflixWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      User <%= @user.id %>
      <:subtitle>This is a user record from your database.</:subtitle>

      <:actions>
        <.link patch={~p"/users/#{@user}/show/edit"} phx-click={JS.push_focus()}>
          <.button>Edit user</.button>
        </.link>
      </:actions>
    </.header>

    <.list>
      <:item title="Id"><%= @user.id %></:item>

      <:item title="Email"><%= @user.email %></:item>

      <:item title="First name"><%= @user.first_name %></:item>

      <:item title="Last name"><%= @user.last_name %></:item>

      <:item title="Gender"><%= @user.gender %></:item>

      <:item title="Honorific title"><%= @user.honorific_title %></:item>

      <:item title="Street"><%= @user.street %></:item>

      <:item title="Zip code"><%= @user.zip_code %></:item>

      <:item title="Country"><%= @user.country %></:item>

      <:item title="Birthdate"><%= @user.birthdate %></:item>

      <:item title="Mobile phone number"><%= @user.mobile_phone_number %></:item>
    </.list>

    <.back navigate={~p"/users"}>Back to users</.back>

    <.modal :if={@live_action == :edit} id="user-modal" show on_cancel={JS.patch(~p"/users/#{@user}")}>
      <.live_component
        module={TonflixWeb.UserLive.FormComponent}
        id={@user.id}
        title={@page_title}
        action={@live_action}
        current_user={@current_user}
        user={@user}
        patch={~p"/users/#{@user}"}
      />
    </.modal>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, Ash.get!(Tonflix.Accounts.User, id, actor: socket.assigns.current_user))}
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end

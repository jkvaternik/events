defmodule EventsBoardWeb.Helpers do
  def have_current_user?(conn) do
    conn.assigns[:current_user] != nil
  end

  def current_user_id?(conn, user_id) do
    user = conn.assigns[:current_user]
    user && user.id == user_id
  end

  def current_user_id(conn) do
    user = conn.assigns[:current_user]
    user && user.id
  end

  def invited?(conn, invites) do
    user = conn.assigns[:current_user]
    if user do
      Enum.any?(invites, fn inv -> inv.email == user.email end)
    else
      false
    end
  end


  def get_invite(conn, invites) do
    user = conn.assigns[:current_user]
    if user do
      Enum.find(invites, fn inv -> inv.email == user.email end)
    else
      nil
    end
  end
end

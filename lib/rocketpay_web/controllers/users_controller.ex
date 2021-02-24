defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  def create(conn, params) do
    params
      |> Rocketpay.create_user()
      |> handler_response(conn)
  end

  defp handler_response({:ok, %User{} = user}, conn) do
    conn
      |> put_status(:created)
      |> render("create.json", user: user)
  end

  defp handler_response({:error, result}, conn) do
    conn
      |> put_status(:bad_request)
      |> put_view(RocketpayWeb.ErrorView)
      |> render("400.json", result: result)
  end
end

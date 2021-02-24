defmodule RocketpayWeb.WelcomenController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
      |> Numbers.sum_from_file()
      |> handler_response(conn)
  end

  defp handler_response({:ok, %{result: result}}, conn) do
    conn
      |> put_status(:ok)
      |> json(%{message: "He number is #{result}"})
  end

  defp handler_response({:error, %{message: reason}}, conn) do
    conn
      |> put_status(:bad_request)
      |> json(%{message: reason})
  end
end

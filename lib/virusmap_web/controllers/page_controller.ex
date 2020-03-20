defmodule VirusmapWeb.PageController do
  use VirusmapWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def about(conn, _params) do
    render(conn, "about.html")
  end

  def donate(conn, _params) do
    render(conn, "donate.html")
  end
end

defmodule VirusmapWeb.PageControllerTest do
  use VirusmapWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "iframe"
  end

  test "GET /about", %{conn: conn} do
    conn = get(conn, "/about")
    assert html_response(conn, 200) =~ "About Page!"
  end

  test "Get /donate", %{conn: conn} do
    conn = get(conn, "/donate")
    assert html_response(conn, 200) =~ "Donate Page!"
  end
end

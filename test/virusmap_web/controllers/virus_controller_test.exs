defmodule VirusmapWeb.VirusControllerTest do
  use VirusmapWeb.ConnCase

  alias Virusmap.Ailment

  @create_attrs %{
    address: "some address",
    address2: "some address2",
    city: "some city",
    country: "some country",
    cured_at: ~N[2010-04-17 14:00:00],
    diagnosed: true,
    lat: "some lat",
    lng: "some lng",
    location: "some location",
    state: "some state"
  }
  @update_attrs %{
    address: "some updated address",
    address2: "some updated address2",
    city: "some updated city",
    country: "some updated country",
    cured_at: ~N[2011-05-18 15:01:01],
    diagnosed: false,
    lat: "some updated lat",
    lng: "some updated lng",
    location: "some updated location",
    state: "some updated state"
  }
  @invalid_attrs %{
    address: nil,
    address2: nil,
    city: nil,
    country: nil,
    cured_at: nil,
    diagnosed: nil,
    lat: nil,
    lng: nil,
    location: nil,
    state: nil
  }

  def fixture(:virus) do
    {:ok, virus} = Ailment.create_virus(@create_attrs)
    virus
  end

  describe "index" do
    setup [:login_user]

    test "lists all viruses", %{authed_conn: authed_conn} do
      conn = get(authed_conn, Routes.virus_path(authed_conn, :index))
      assert html_response(conn, 200) =~ "Listing Viruses"
    end
  end

  describe "new virus" do
    setup [:login_user]

    test "renders form", %{authed_conn: authed_conn} do
      conn = get(authed_conn, Routes.virus_path(authed_conn, :new))
      assert html_response(conn, 200) =~ "New Virus"
    end
  end

  describe "create virus" do
    setup [:login_user]

    test "redirects to show when data is valid", %{authed_conn: authed_conn} do
      conn = post(authed_conn, Routes.virus_path(authed_conn, :create), virus: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.virus_path(conn, :show, id)

      conn = get(authed_conn, Routes.virus_path(authed_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Virus"
    end

    test "renders errors when data is invalid", %{authed_conn: authed_conn} do
      conn = post(authed_conn, Routes.virus_path(authed_conn, :create), virus: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Virus"
    end
  end

  describe "edit virus" do
    setup [:login_user, :create_virus]

    test "renders form for editing chosen virus", %{authed_conn: authed_conn, virus: virus} do
      conn = get(authed_conn, Routes.virus_path(authed_conn, :edit, virus))
      assert html_response(conn, 200) =~ "Edit Virus"
    end
  end

  describe "update virus" do
    setup [:login_user, :create_virus]

    test "redirects when data is valid", %{authed_conn: authed_conn, virus: virus} do
      conn =
        put(authed_conn, Routes.virus_path(authed_conn, :update, virus), virus: @update_attrs)

      assert redirected_to(conn) == Routes.virus_path(conn, :show, virus)

      conn = get(authed_conn, Routes.virus_path(authed_conn, :show, virus))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{authed_conn: authed_conn, virus: virus} do
      conn =
        put(authed_conn, Routes.virus_path(authed_conn, :update, virus), virus: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Virus"
    end
  end

  describe "delete virus" do
    setup [:login_user, :create_virus]

    test "deletes chosen virus", %{authed_conn: authed_conn, virus: virus} do
      conn = delete(authed_conn, Routes.virus_path(authed_conn, :delete, virus))
      assert redirected_to(conn) == Routes.virus_path(conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.virus_path(authed_conn, :show, virus))
      end
    end
  end

  defp create_virus(_) do
    virus = fixture(:virus)
    {:ok, virus: virus}
  end

  defp login_user(_) do
    user = insert(:user)
    authed_conn = Pow.Plug.assign_current_user(build_conn(), user, otp_app: :virusmap)

    {:ok, authed_conn: authed_conn}
  end
end

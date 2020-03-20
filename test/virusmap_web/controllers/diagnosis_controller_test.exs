defmodule VirusmapWeb.DiagnosisControllerTest do
  use VirusmapWeb.ConnCase

  alias Virusmap.Diagnose

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:diagnosis) do
    {:ok, diagnosis} = Diagnose.create_diagnosis(@create_attrs)
    diagnosis
  end

  describe "index" do
    setup [:login_user]

    test "lists all diagnoses", %{authed_conn: authed_conn} do
      conn = get(authed_conn, Routes.diagnosis_path(authed_conn, :index))
      assert html_response(conn, 200) =~ "Listing Diagnoses"
    end
  end

  describe "new diagnosis" do
    setup [:login_user]

    test "renders form", %{authed_conn: authed_conn} do
      conn = get(authed_conn, Routes.diagnosis_path(authed_conn, :new))
      assert html_response(conn, 200) =~ "New Diagnosis"
    end
  end

  describe "create diagnosis" do
    setup [:login_user]

    test "redirects to show when data is valid", %{authed_conn: authed_conn} do
      conn =
        post(authed_conn, Routes.diagnosis_path(authed_conn, :create), diagnosis: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.diagnosis_path(conn, :show, id)

      conn = get(authed_conn, Routes.diagnosis_path(authed_conn, :show, id))
      assert html_response(conn, 200) =~ "Show Diagnosis"
    end

    test "renders errors when data is invalid", %{authed_conn: authed_conn} do
      conn =
        post(authed_conn, Routes.diagnosis_path(authed_conn, :create), diagnosis: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Diagnosis"
    end
  end

  describe "edit diagnosis" do
    setup [:login_user, :create_diagnosis]

    test "renders form for editing chosen diagnosis", %{
      authed_conn: authed_conn,
      diagnosis: diagnosis
    } do
      conn = get(authed_conn, Routes.diagnosis_path(authed_conn, :edit, diagnosis))
      assert html_response(conn, 200) =~ "Edit Diagnosis"
    end
  end

  describe "update diagnosis" do
    setup [:login_user, :create_diagnosis]

    test "redirects when data is valid", %{authed_conn: authed_conn, diagnosis: diagnosis} do
      conn =
        put(authed_conn, Routes.diagnosis_path(authed_conn, :update, diagnosis),
          diagnosis: @update_attrs
        )

      assert redirected_to(conn) == Routes.diagnosis_path(conn, :show, diagnosis)

      conn = get(authed_conn, Routes.diagnosis_path(authed_conn, :show, diagnosis))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{authed_conn: authed_conn, diagnosis: diagnosis} do
      conn =
        put(authed_conn, Routes.diagnosis_path(authed_conn, :update, diagnosis),
          diagnosis: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Diagnosis"
    end
  end

  describe "delete diagnosis" do
    setup [:login_user, :create_diagnosis]

    test "deletes chosen diagnosis", %{authed_conn: authed_conn, diagnosis: diagnosis} do
      conn = delete(authed_conn, Routes.diagnosis_path(authed_conn, :delete, diagnosis))
      assert redirected_to(conn) == Routes.diagnosis_path(conn, :index)

      assert_error_sent 404, fn ->
        get(authed_conn, Routes.diagnosis_path(authed_conn, :show, diagnosis))
      end
    end
  end

  defp create_diagnosis(_) do
    diagnosis = fixture(:diagnosis)
    {:ok, diagnosis: diagnosis}
  end

  defp login_user(_) do
    user = insert(:user)
    authed_conn = Pow.Plug.assign_current_user(build_conn(), user, otp_app: :virusmap)

    {:ok, authed_conn: authed_conn}
  end
end

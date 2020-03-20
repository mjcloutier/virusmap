defmodule Virusmap.DiagnoseTest do
  use Virusmap.DataCase

  alias Virusmap.Diagnose

  describe "diagnoses" do
    alias Virusmap.Diagnose.Diagnosis

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def diagnosis_fixture(attrs \\ %{}) do
      {:ok, diagnosis} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Diagnose.create_diagnosis()

      diagnosis
    end

    test "list_diagnoses/0 returns all diagnoses" do
      diagnosis = diagnosis_fixture()
      assert Diagnose.list_diagnoses() == [diagnosis]
    end

    test "get_diagnosis!/1 returns the diagnosis with given id" do
      diagnosis = diagnosis_fixture()
      assert Diagnose.get_diagnosis!(diagnosis.id) == diagnosis
    end

    test "create_diagnosis/1 with valid data creates a diagnosis" do
      assert {:ok, %Diagnosis{} = diagnosis} = Diagnose.create_diagnosis(@valid_attrs)
      assert diagnosis.name == "some name"
    end

    test "create_diagnosis/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Diagnose.create_diagnosis(@invalid_attrs)
    end

    test "update_diagnosis/2 with valid data updates the diagnosis" do
      diagnosis = diagnosis_fixture()
      assert {:ok, %Diagnosis{} = diagnosis} = Diagnose.update_diagnosis(diagnosis, @update_attrs)
      assert diagnosis.name == "some updated name"
    end

    test "update_diagnosis/2 with invalid data returns error changeset" do
      diagnosis = diagnosis_fixture()
      assert {:error, %Ecto.Changeset{}} = Diagnose.update_diagnosis(diagnosis, @invalid_attrs)
      assert diagnosis == Diagnose.get_diagnosis!(diagnosis.id)
    end

    test "delete_diagnosis/1 deletes the diagnosis" do
      diagnosis = diagnosis_fixture()
      assert {:ok, %Diagnosis{}} = Diagnose.delete_diagnosis(diagnosis)
      assert_raise Ecto.NoResultsError, fn -> Diagnose.get_diagnosis!(diagnosis.id) end
    end

    test "change_diagnosis/1 returns a diagnosis changeset" do
      diagnosis = diagnosis_fixture()
      assert %Ecto.Changeset{} = Diagnose.change_diagnosis(diagnosis)
    end
  end
end

defmodule Virusmap.AilmentTest do
  use Virusmap.DataCase

  alias Virusmap.Ailment

  describe "viruses" do
    alias Virusmap.Ailment.Virus

    @valid_attrs %{
      address: "some address",
      address2: "some address2",
      city: "some city",
      country: "some country",
      cured_at: ~N[2010-04-17 14:00:00],
      diagnosed: true,
      lat: "some lat",
      lng: "some lng",
      location: "some location",
      state: "some state",
      symptoms: %{}
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
      state: "some updated state",
      symptoms: %{}
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
      state: nil,
      symptoms: nil
    }

    def virus_fixture(attrs \\ %{}) do
      {:ok, virus} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ailment.create_virus()

      virus
    end

    test "list_viruses/0 returns all viruses" do
      virus = virus_fixture()
      assert Ailment.list_viruses() == [virus]
    end

    test "get_virus!/1 returns the virus with given id" do
      virus = virus_fixture()
      assert Ailment.get_virus!(virus.id) == virus
    end

    test "create_virus/1 with valid data creates a virus" do
      assert {:ok, %Virus{} = virus} = Ailment.create_virus(@valid_attrs)
      assert virus.address == "some address"
      assert virus.address2 == "some address2"
      assert virus.city == "some city"
      assert virus.country == "some country"
      assert virus.cured_at == ~N[2010-04-17 14:00:00]
      assert virus.diagnosed == true
      assert virus.lat == "some lat"
      assert virus.lng == "some lng"
      assert virus.location == "some location"
      assert virus.state == "some state"
      assert virus.symptoms == %{}
    end

    test "create_virus/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ailment.create_virus(@invalid_attrs)
    end

    test "update_virus/2 with valid data updates the virus" do
      virus = virus_fixture()
      assert {:ok, %Virus{} = virus} = Ailment.update_virus(virus, @update_attrs)
      assert virus.address == "some updated address"
      assert virus.address2 == "some updated address2"
      assert virus.city == "some updated city"
      assert virus.country == "some updated country"
      assert virus.cured_at == ~N[2011-05-18 15:01:01]
      assert virus.diagnosed == false
      assert virus.lat == "some updated lat"
      assert virus.lng == "some updated lng"
      assert virus.location == "some updated location"
      assert virus.state == "some updated state"
      assert virus.symptoms == %{}
    end

    test "update_virus/2 with invalid data returns error changeset" do
      virus = virus_fixture()
      assert {:error, %Ecto.Changeset{}} = Ailment.update_virus(virus, @invalid_attrs)
      assert virus == Ailment.get_virus!(virus.id)
    end

    test "delete_virus/1 deletes the virus" do
      virus = virus_fixture()
      assert {:ok, %Virus{}} = Ailment.delete_virus(virus)
      assert_raise Ecto.NoResultsError, fn -> Ailment.get_virus!(virus.id) end
    end

    test "change_virus/1 returns a virus changeset" do
      virus = virus_fixture()
      assert %Ecto.Changeset{} = Ailment.change_virus(virus)
    end
  end
end

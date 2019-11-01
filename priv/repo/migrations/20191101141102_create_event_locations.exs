defmodule Promo.Repo.Migrations.CreateEventLocations do
  use Ecto.Migration

  def change do
    create table(:event_locations) do
      add :place, :string
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end
  end
end

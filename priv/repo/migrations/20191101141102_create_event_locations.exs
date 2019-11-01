defmodule Promo.Repo.Migrations.CreateEventLocations do
  use Ecto.Migration

  def change do
    create table(:event_locations) do
      add :place, :string, null: false
      add :latitude, :string, null: false
      add :longitude, :string, null: false

      timestamps()
    end

    create unique_index(:event_locations, [:place])
  end
end

defmodule Promo.Repo.Migrations.CreatePromoCodes do
  use Ecto.Migration

  def change do
    create table(:promo_codes) do
      add :p_code, :string, null: false
      add :amount, :float, null: false
      add :expiry_date, :date, null: false
      add :status, :boolean, default: false, null: false
      add :radius, :float
      add :event_location_id, references(:event_locations, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:promo_codes, [:event_location_id])
  end
end

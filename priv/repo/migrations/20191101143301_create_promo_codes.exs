defmodule Promo.Repo.Migrations.CreatePromoCodes do
  use Ecto.Migration

  def change do
    create table(:promo_codes) do
      add :p_code, :string
      add :amount, :float
      add :expiry_date, :date
      add :status, :boolean, default: false, null: false
      add :radius, :float
      add :event_location_id, references(:event_locations, on_delete: :nothing)

      timestamps()
    end

    create index(:promo_codes, [:event_location_id])
  end
end

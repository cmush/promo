defmodule Promo.Repo.Migrations.CreatePromoCodes do
  use Ecto.Migration

  def change do
    create table(:promo_codes) do
      add :p_code, :string, null: false
      add :ride_amount, :float, null: false
      add :expiry_date, :date, null: false
      add :status, :boolean, default: false, null: false
      add :radius, :float, null: false

      timestamps()
    end

  end
end

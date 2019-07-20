defmodule Promo.Repo.Migrations.CreatePromoCodes do
  use Ecto.Migration

  def change do
    create table(:promo_codes) do
      add :p_code, :string
      add :ride_amount, :float
      add :expiry_date, :date
      add :status, :boolean, default: false, null: false
      add :radius, :float

      timestamps()
    end

  end
end

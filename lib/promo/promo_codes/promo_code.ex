defmodule Promo.PromoCodes.PromoCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promo_codes" do
    field :expiry_date, :date
    field :p_code, :string
    field :radius, :float
    field :ride_amount, :float
    field :status, :boolean, default: false
    field :polyline, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(promo_code, attrs) do
    promo_code
    |> cast(attrs, [:p_code, :ride_amount, :expiry_date, :status, :radius])
    |> validate_required([:p_code, :ride_amount, :expiry_date, :status, :radius])
  end
end

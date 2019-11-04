defmodule Promo.PromoCodes.PromoCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promo_codes" do
    field :amount, :float
    field :expiry_date, :date
    field :p_code, :string
    field :radius, :float
    field :status, :boolean, default: true
    field :event_location_id, :id
    field :polyline, :string, virtual: true
    field :distance_to_destination, :string, virtual: true

    has_one :event_locations, Promo.EventLocations.EventLocation,
      foreign_key: :id,
      references: :event_location_id

    timestamps()
  end

  @doc false
  def changeset(promo_code, attrs) do
    promo_code
    |> cast(attrs, [:p_code, :amount, :expiry_date, :status, :radius, :event_location_id])
    |> validate_required([:p_code, :amount, :expiry_date, :status, :radius, :event_location_id])
    |> unique_constraint(:p_code)
  end
end

defmodule Promo.EventLocations.EventLocation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "event_locations" do
    field :latitude, :string
    field :longitude, :string
    field :place, :string

    timestamps()
  end

  @doc false
  def changeset(event_location, attrs) do
    event_location
    |> cast(attrs, [:place, :latitude, :longitude])
    |> validate_required([:place, :latitude, :longitude])
  end
end

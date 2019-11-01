defmodule Promo.EventLocations do
  @moduledoc """
  The EventLocations context.
  """

  import Ecto.Query, warn: false
  alias Promo.Repo

  alias Promo.EventLocations.EventLocation

  @doc """
  Returns the list of event_locations.

  ## Examples

      iex> list_event_locations()
      [%EventLocation{}, ...]

  """
  def list_event_locations do
    Repo.all(EventLocation)
  end

  @doc """
  Gets a single event_location.

  Raises `Ecto.NoResultsError` if the Event location does not exist.

  ## Examples

      iex> get_event_location!(123)
      %EventLocation{}

      iex> get_event_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_location!(id), do: Repo.get!(EventLocation, id)

  @doc """
  Gets a single event_location by name.

  Raises `Ecto.NoResultsError` if the named Event location does not exist.

  ## Examples

      iex> get_event_location_by_place!("Nairobi, Upperhill")
      %EventLocation{}

      iex> get_event_location_by_place!("Nyairofi")
      ** (Ecto.NoResultsError)

  """
  def get_event_location_by_place!(place) do
    from(event_location in EventLocation, where: event_location.place == ^place)
    |> Repo.all()
  end

  @doc """
  Creates a event_location.

  ## Examples

      iex> create_event_location(%{field: value})
      {:ok, %EventLocation{}}

      iex> create_event_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_location(attrs \\ %{}) do
    %EventLocation{}
    |> EventLocation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event_location.

  ## Examples

      iex> update_event_location(event_location, %{field: new_value})
      {:ok, %EventLocation{}}

      iex> update_event_location(event_location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_location(%EventLocation{} = event_location, attrs) do
    event_location
    |> EventLocation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a EventLocation.

  ## Examples

      iex> delete_event_location(event_location)
      {:ok, %EventLocation{}}

      iex> delete_event_location(event_location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_location(%EventLocation{} = event_location) do
    Repo.delete(event_location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event_location changes.

  ## Examples

      iex> change_event_location(event_location)
      %Ecto.Changeset{source: %EventLocation{}}

  """
  def change_event_location(%EventLocation{} = event_location) do
    EventLocation.changeset(event_location, %{})
  end
end

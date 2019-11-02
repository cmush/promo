defmodule Promo.PromoCodes do
  @moduledoc """
  The PromoCodes context.
  """

  import Ecto.Query, warn: false
  alias Promo.Repo

  alias Promo.PromoCodes.PromoCode

  @doc """
  Returns the list of promo_codes (with preloaded event location).

  ## Examples

      iex> list_promo_codes()
      [%PromoCode{}, ...]

  """
  def list_promo_codes do
    Repo.all(PromoCode)
    |> Repo.preload(:event_locations)
  end

  @doc """
  Returns the list of valid promo_codes.
  - where promo_code.status == true
  - filter where promo_code.expiry_date is today (before 12.59pm) / after today

  ## Examples

      iex> list_valid_promo_codes()
      [%PromoCode{}, ...]

  """
  def list_valid_promo_codes do
    from(promo_code in PromoCode, where: promo_code.status == true)
    |> Repo.all()
    |> Repo.preload(:event_locations)
    |> Enum.filter(fn %PromoCode{} = promo_code ->
      Date.diff(promo_code.expiry_date, Date.utc_today()) >= 0
    end)
  end

  @doc """
  Gets a single promo_code.

  Raises `Ecto.NoResultsError` if the Promo code does not exist.

  ## Examples

      iex> get_promo_code!(123)
      %PromoCode{}

      iex> get_promo_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promo_code!(id), do: Repo.get!(PromoCode, id)

  @doc """
  Gets a single promo_code by its p_code, preload its event_location.

  Raises `Ecto.NoResultsError` if the Promo code does not exist.

  ## Examples

      iex> get_promo_code_by_code!(123)
      %PromoCode{}

      iex> get_promo_code_by_code!(456)
      {:error, :promo_code_not_found}

  """
  def get_promo_code_by_code!(p_code) do
    case Repo.all(from promo_code in PromoCode, where: promo_code.p_code == ^p_code)
         |> Repo.preload(:event_locations) do
      [] -> {:error, :promo_code_not_found}
      [event_location] -> event_location
    end
  end

  @doc """
  Gets a single valid promo_code by its p_code, preload its event_location.
  a promo_code is valid if its status is true and its expiry date has yet to pass.

  Raises `Ecto.NoResultsError` if the Promo code does not exist.

  ## Examples

      iex> get_valid_promo_code_by_code!(123)
      %PromoCode{}

      iex> get_valid_promo_code_by_code!(456)
      {:error, :promo_code_not_found}

  """
  def get_valid_promo_code_by_code!(p_code) do
    case Repo.all(
           from promo_code in PromoCode,
             where: promo_code.p_code == ^p_code,
             where: promo_code.status == true
         )
         |> Repo.preload(:event_locations)
         |> Enum.filter(fn %PromoCode{} = promo_code ->
           Date.diff(promo_code.expiry_date, Date.utc_today()) >= 0
         end) do
      [] -> {:error, :valid_promo_code_not_found}
      [event_location] -> event_location
    end
  end

  @doc """
  Creates a promo_code.

  ## Examples

      iex> create_promo_code(%{field: value})
      {:ok, %PromoCode{}}

      iex> create_promo_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promo_code(attrs \\ %{}) do
    %PromoCode{}
    |> PromoCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promo_code.

  ## Examples

      iex> update_promo_code(promo_code, %{field: new_value})
      {:ok, %PromoCode{}}

      iex> update_promo_code(promo_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promo_code(%PromoCode{} = promo_code, attrs) do
    promo_code
    |> PromoCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PromoCode.

  ## Examples

      iex> delete_promo_code(promo_code)
      {:ok, %PromoCode{}}

      iex> delete_promo_code(promo_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promo_code(%PromoCode{} = promo_code) do
    Repo.delete(promo_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promo_code changes.

  ## Examples

      iex> change_promo_code(promo_code)
      %Ecto.Changeset{source: %PromoCode{}}

  """
  def change_promo_code(%PromoCode{} = promo_code) do
    PromoCode.changeset(promo_code, %{})
  end
end

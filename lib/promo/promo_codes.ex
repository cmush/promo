defmodule Promo.PromoCodes do
  @moduledoc """
  The PromoCodes context.
  """

  import Ecto.Query, warn: false
  alias Promo.Repo

  alias Promo.PromoCodes.PromoCode

  @doc """
  Returns the list of promo_codes.

  ## Examples

      iex> list_promo_codes()
      [%PromoCode{}, ...]

  """
  def list_promo_codes do
    Repo.all(PromoCode)
  end

  @doc """
  Returns the list of promo_codes depending on status supplied
  status can be: true (active) or false (inactive).

  ## Examples

      iex> list_promo_codes(status)
      [%PromoCode{}, ...]

  """
  def list_promo_codes(status) do
    Promo.Repo.all(
      from pc in PromoCode,
        where: pc.status == ^status
    )
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
  Gets a single promo_code using its p_code.

  Raises `Ecto.NoResultsError` if the Promo code does not exist.

  ## Examples

      iex> get_promo_code_by_p_code("SBPC_SEED_1")
      %PromoCode{}

      iex> get_promo_code_by_p_code("UNKOWN_CODE")
      ** (Ecto.NoResultsError)

  """
  def get_promo_code_by_p_code(p_code) do
    Promo.Repo.one(
      from(
        pc in PromoCode,
        where: pc.p_code == ^p_code
      )
    )
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

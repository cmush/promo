# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Promo.Repo.insert!(%Promo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Promo.Repo
alias Promo.PromoCodes.PromoCode

# expiry_date = %Ecto.Date{year: 2014, month: 4, day: 17}
# expiry_date = Date.from_iso8601!("2014-04-17")

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_1",
  ride_amount: 200.00,
  expiry_date: Date.from_iso8601!("2019-07-19"),
  status: true,
  radius: 1.50
})

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_2",
  ride_amount: 300.03,
  expiry_date: Date.from_iso8601!("2019-08-19"),
  status: true,
  radius: 1.00
})

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_3",
  ride_amount: 400.20,
  expiry_date: Date.from_iso8601!("2019-09-19"),
  status: true,
  radius: 2.10
})

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_4",
  ride_amount: 500.45,
  expiry_date: Date.from_iso8601!("2019-10-19"),
  status: true,
  radius: 2.00
})

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_5",
  ride_amount: 600.32,
  expiry_date: Date.from_iso8601!("2019-11-19"),
  status: false,
  radius: 3.00
})

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

alias Promo.{
  Repo,
  EventLocations.EventLocation,
  PromoCodes.PromoCode
}

Repo.insert!(%EventLocation{
  place: "Nairobi, Westlands",
  longitude: "36.808922",
  latitude: "-1.269650"
})

Repo.insert!(%EventLocation{
  place: "Nairobi, Upperhill",
  longitude: "36.820030",
  latitude: "-1.285790"
})

Repo.insert!(%EventLocation{
  place: "Nairobi, Ngong Racecourse",
  longitude: "36.73916371",
  latitude: "-1.30583211"
})

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_1",
  amount: 200.00,
  expiry_date: Date.add(Date.utc_today(), 5),
  status: true,
  radius: 3.00,
  event_location_id: 1
})

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_2",
  amount: 300.03,
  expiry_date: Date.add(Date.utc_today(), -5),
  status: true,
  radius: 2.50,
  event_location_id: 2
})

Repo.insert!(%PromoCode{
  p_code: "SBPC_SEED_3",
  amount: 400.20,
  expiry_date: Date.add(Date.utc_today(), 30),
  status: true,
  radius: 2.10,
  event_location_id: 3
})

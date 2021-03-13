# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EventsBoard.Repo.insert!(%EventsBoard.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EventsBoard.Repo
alias EventsBoard.Users.User
alias EventsBoard.Events.Event

jaime = Repo.insert!(%User{name: "jaime", email: "jk@gmail.com", photo_hash: ""})
ryan = Repo.insert!(%User{name: "ryan", email: "rl@gmail.com", photo_hash: ""})

{:ok, datetime, 0} = DateTime.from_iso8601("2022-01-23T23:50:07Z")

Repo.insert!(%Event{user_id: jaime.id, name: "JK Party", desc: "party!", date: datetime})
Repo.insert!(%Event{user_id: ryan.id, name: "RL Party", desc: "party!", date: datetime})

# Start ExMachina (Factories)
{:ok, _} = Application.ensure_all_started(:ex_machina)

# Start ExUnit
ExUnit.start()

# Use Ecto Sandbox
Ecto.Adapters.SQL.Sandbox.mode(Virusmap.Repo, :manual)

# Start Faker (Random data generator for factories)
Faker.start()

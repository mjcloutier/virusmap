defmodule Virusmap.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Virusmap.Accounts.User{
          name: Faker.StarWars.En.character(),
          email: Faker.Internet.safe_email(),
          password: "password",
          password_hash: "password"
        }
      end
    end
  end
end

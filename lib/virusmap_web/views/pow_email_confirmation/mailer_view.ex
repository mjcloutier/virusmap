defmodule VirusmapWeb.PowEmailConfirmation.MailerView do
  use VirusmapWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end

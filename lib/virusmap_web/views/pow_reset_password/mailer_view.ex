defmodule VirusmapWeb.PowResetPassword.MailerView do
  use VirusmapWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end

class GarageMailer < ActionMailer::Base
  include MailerHelper
  default from: EMAIL_ADMIN

  def notify_demand(garage, demand)
    @user = garage.user.decorate
    @demand = demand
    set_locale(garage)
    mail(to: @user.email, subject: t('new_demand_assigned_to_you'))
  end
end

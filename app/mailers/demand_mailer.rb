class DemandMailer < ActionMailer::Base
  include MailerHelper
  default from: EMAIL_ADMIN

  def no_assignables_alert(demand)
    return if @@seeding
    @demand = demand
    mail(to: EMAIL_ADMIN, subject: t('unassignable_demand'))
  end
end

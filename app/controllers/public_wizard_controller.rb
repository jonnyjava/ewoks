class PublicWizardController < ApplicationController
  skip_before_filter :authenticate_user!

  def public_wizard
    @garage = Garage.new(country: nil)
    render :public_wizard
  end
end

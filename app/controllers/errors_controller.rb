class ErrorsController < ApplicationController
  skip_before_filter :authenticate_user!

  def error_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: 404, layout: false }
      format.json { render json: '404 There are no ewoks here', status: 404 }
    end
  end

  def error_422
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: 404, layout: false }
      format.json { render json: '422 Unprocessable Entity', status: 422 }
    end
  end

  def error_500
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/500.html", status: 500, layout: false }
      format.json { render json: 'Everytime you do a bad request an Ewok dies', status: 500 }
    end
  end
end

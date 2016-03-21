require 'spec_helper'

describe Recruitables::ExportController do
  login_admin
  describe "#index" do
    it "should render an excel" do
      ids = []
      5.times { ids << FactoryGirl.create(:garage_recruitable).to_param }
      get :index, {ids: ids, format: :xls}
      expect(response.content_type).to eq(Mime::XLS)
    end
  end
end

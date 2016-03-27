require 'spec_helper'

describe "demands/index", type: :view do
  before(:each) do
    view.stub(:current_user) { FactoryGirl.create(:owner) }
    demands = FactoryGirl.create_list(:demand, 3)
    paginated_demands = Kaminari.paginate_array(demands).page(1)
    decorated_demands = DemandDecorator.decorate_collection(paginated_demands)
    assign(:demands, decorated_demands)

  end

  it "renders a list of demands" do
    render
  end
end

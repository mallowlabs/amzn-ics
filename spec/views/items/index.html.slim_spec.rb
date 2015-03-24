require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    @release_date = Time.zone.parse("2015-03-23")
    assign(:items, [
      Item.create!(
        :user_id => 1,
        :asin => "Asin1",
        :title => "Title",
        :thumb_url => "Thumb Url",
        :release_date => @release_date
      ),
      Item.create!(
        :user_id => 1,
        :asin => "Asin2",
        :title => "Title",
        :thumb_url => "Thumb Url",
        :release_date => @release_date
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td[1]", :text => @release_date.strftime("%F"), :count => 2
    assert_select "tr>td[2] img", :src => "Thumb Url".to_s, :count => 2
    assert_select "tr>td[3]", :text => "Title".to_s, :count => 2
  end
end

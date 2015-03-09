require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        :user_id => 1,
        :asin => "Asin",
        :title => "Title",
        :thumb_url => "Thumb Url"
      ),
      Item.create!(
        :user_id => 1,
        :asin => "Asin",
        :title => "Title",
        :thumb_url => "Thumb Url"
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Asin".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Thumb Url".to_s, :count => 2
  end
end

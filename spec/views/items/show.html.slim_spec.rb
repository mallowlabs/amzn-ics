require 'rails_helper'

RSpec.describe "items/show", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      :user_id => 1,
      :asin => "Asin",
      :title => "Title",
      :thumb_url => "Thumb Url",
      :release_date => Time.now
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Asin/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Thumb Url/)
  end
end

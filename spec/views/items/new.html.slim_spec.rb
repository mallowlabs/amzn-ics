require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      :user_id => 1,
      :asin => "MyString",
      :title => "MyString",
      :thumb_url => "MyString"
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input#item_url[name=?]", "item[url]"

    end
  end
end

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

      assert_select "input#item_user_id[name=?]", "item[user_id]"

      assert_select "input#item_asin[name=?]", "item[asin]"

      assert_select "input#item_title[name=?]", "item[title]"

      assert_select "input#item_thumb_url[name=?]", "item[thumb_url]"
    end
  end
end

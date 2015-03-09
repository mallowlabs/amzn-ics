require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      :user_id => 1,
      :asin => "MyString",
      :title => "MyString",
      :thumb_url => "MyString"
    ))
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(@item), "post" do

      assert_select "input#item_user_id[name=?]", "item[user_id]"

      assert_select "input#item_asin[name=?]", "item[asin]"

      assert_select "input#item_title[name=?]", "item[title]"

      assert_select "input#item_thumb_url[name=?]", "item[thumb_url]"
    end
  end
end

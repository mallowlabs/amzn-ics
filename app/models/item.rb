require 'open-uri'
class Item < ActiveRecord::Base
  belongs_to :user

  attr_accessor :url

  default_scope { includes(:user).order('release_date DESC') }
  scope :recent, -> { where(arel_table[:release_date].gt 1.months.ago) }

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = Icalendar::Values::Date.new(self.release_date, {'TZID' => ['Asia/Tokyo']})
    event.dtstamp = self.updated_at
    event.summary = self.title
    event.url = self.amazon_url
    event
  end

  def amazon_url
    "http://www.amazon.co.jp/gp/product/#{self.asin}/?tag=mallowlabs-22"
  end

  def self.from_url(url)
    asin = url_to_asin(url.to_s)
    asin_to_item(asin)
  end

  def self.url_to_asin(url)
    doc = Nokogiri::HTML(OpenURI.open_uri(url))
    doc.css("#ASIN").first["value"] rescue nil
  end

  def self.asin_to_item(asin)
    item = Item.new
    res = Amazon::Ecs.item_lookup(asin, {response_group: 'Medium', country: 'jp'}).first_item
    item.asin = res.get('ASIN')
    item.title = res.get('ItemAttributes/Title')
    item.release_date = res.get('ItemAttributes/ReleaseDate')
    item.thumb_url = res.get('ImageSets/ImageSet/SmallImage/URL')
    item
  end
end


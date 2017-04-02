require 'open-uri'
class Item < ActiveRecord::Base
  belongs_to :user

  attr_accessor :url

  validates_uniqueness_of :asin
  validates_presence_of :release_date

  default_scope { includes(:user).order('release_date DESC') }
  scope :recent, -> { where(arel_table[:release_date].gt 1.months.ago) }

  UserAgent = 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)'

  def to_ics(host)
    event = Icalendar::Event.new
    event.dtstart = Icalendar::Values::Date.new(self.release_date, {'TZID' => ['Asia/Tokyo']})
    event.dtstamp = self.updated_at
    event.summary = self.title
    event.url = self.amazon_url
    event.description = self.amazon_url
    event.uid = "#{Digest::MD5.hexdigest(self.amazon_url)}@#{host}"
    event
  end

  def amazon_url
    "http://www.amazon.co.jp/gp/product/#{self.asin}/?tag=mallowlabs-22"
  end

  def self.from_url(url)
    asin = url_to_asin(url.to_s)
    asin_to_item_with_retry(asin)
  end

  def self.url_to_asin(url)
    doc = Nokogiri::HTML(OpenURI.open_uri(url, 'User-Agent' => UserAgent))
    doc.css("#ASIN").first["value"] rescue nil
  end

  def self.asin_to_item(asin)
    item = Item.new
    res = Amazon::Ecs.item_lookup(asin, {response_group: 'Medium', country: 'jp'}).first_item
    item.asin = res.get('ASIN')
    item.title = res.get('ItemAttributes/Title')
    item.release_date = res.get('ItemAttributes/ReleaseDate') || res.get('ItemAttributes/PublicationDate')
    item.thumb_url = res.get('ImageSets/ImageSet/SmallImage/URL')
    item
  end

  def self.asin_to_item_with_retry(asin)
    retry_count = 0
    begin
      return self.asin_to_item(asin)
    rescue => e
      retry_count += 1
      Rails.logger.error e.message
      if retry_count < 5
        sleep(3)
        retry
      end
    end
    return nil
  end
end


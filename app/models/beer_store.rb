class BeerStore

  def self.all
    Hash.new.tap do |all|
      stores_hash['Consumers Beverages'].each do |store, location|
        all[store] = tap_hash(location['twitter'], location['taps_count'])
      end
    end
  end

private
  def self.tap_hash(twitter_name, taps_count)
    Hash.new.tap do |hash|
      most_recent_tweets(twitter_name, taps_count).map do |tweet|
        beer_name = tweet.text.sub(/(.)+Just Tapped\s/, '')
        hash[beer_name] = tweet.created_at
      end
    end
  end
  def self.most_recent_tweets(twitter_name, limit)
    Twitter.user_timeline(twitter_name)[0...limit]
  end
  def self.stores_hash
    @@beer_stores ||= YAML.load_file("#{Rails.root}/config/beer_stores.yml")
  end
end

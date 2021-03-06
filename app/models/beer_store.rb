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
        hash[tweet.created_at] = beer_name
      end
    end
  end
  def self.most_recent_tweets(twitter_name, limit)
    tweets = YAML.load(REDIS.get(twitter_name))
    tweets[0...limit]
  end
  def self.fetch_and_cache_tweets
    twitter_names.map do |twitter_name|
      tweet = Twitter.user_timeline(twitter_name)[0...16]
      REDIS.set twitter_name, YAML.dump(tweet)
      tweet
    end
  end
  def self.twitter_names
    stores_hash['Consumers Beverages'].map do |store, location|
      location['twitter']
    end
  end
  def self.stores_hash
    @@beer_stores ||= YAML.load_file("#{Rails.root}/config/beer_stores.yml")
  end
end

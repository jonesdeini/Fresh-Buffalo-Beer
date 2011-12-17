desc "Grab the latest tweet data from the beer stores"
task :update_tweets => :environment do
  puts "Updatings tweets..."
  tweets = BeerStore.fetch_and_cache_tweets
  puts "Updated #{tweets.count} tweets"
end


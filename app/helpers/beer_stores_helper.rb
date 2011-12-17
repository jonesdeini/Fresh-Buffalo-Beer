module BeerStoresHelper
  def beer_tag(beer_name, tapped_date)
    css_class = beer_class(tapped_date)
    "<li class=#{css_class}>
      <a href='http://beeradvocate.com/search?q=#{beer_name}&qt=beer'>#{beer_name}</a>
      , #{tap_age(tapped_date)}
    </li>".html_safe
  end
  def tap_age(tapped_date)
    # assumes that rails app is in same times zone as the tweeter..
    "tapped #{distance_of_time_in_words(Time.now, tapped_date)} ago"
  end
  def beer_class(tapped_date)
    seconds_ago = Time.now - tapped_date
    days_ago = seconds_ago / (60.0 * 60.0 * 24.0)
    case days_ago
    when 0...1
      'freshest'
    when 1...7
      'fresher'
    when 7...14
      'fresh'
    when 14...21
      'less-fresh'
    else
      'stale'
    end
  end
end


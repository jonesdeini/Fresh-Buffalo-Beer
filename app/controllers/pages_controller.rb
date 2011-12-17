class PagesController < ApplicationController
  def index
    @beer_hash = BeerStore.all
  end
end

class VisitorsController < ApplicationController

def index
	@featured = Piece.where(:featured => true).sample

	 client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "sUedRjJ0a8oHJJfHcnO1x5xBV"
      config.consumer_secret     = "HikKRSrM2gNNDLRakwCGW1tYj3RkGrErISgE0HT8JqRr3pHVmR"
      # config.access_token        = "YOUR_ACCESS_TOKEN"
      # config.access_token_secret = "YOUR_ACCESS_SECRET"
    end

    @tweet = client.search("#art -rt").first.text


    # client.search("#art -rt").limit(10).each do |tweet|
    # 	@tweet << tweet.text
    # end

end



end

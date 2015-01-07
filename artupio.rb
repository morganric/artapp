#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'chatterbot/dsl'

#
# this is the script for the twitter bot artupio
# generated on 2014-12-25 20:06:02 +0000
#

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = 'g50yZMhTs0CVgyy4baSiLPG2g'
  config.consumer_secret     = "mqUnS9BHQ0O6Uh9ccAYEjFM3jQC4R0NUofBQLACtqMleUsQQ5c"
  config.access_token        = "2847301967-SHSbY7MOXs3oy8Em6GkFyGq9xK8jO2KzjRBii5a"
  config.access_token_secret = "FN4Gw0WthvnMLvY0APaezG54Nsnmr4NhbY8x8FAdOekOf"
end

consumer_key 'g50yZMhTs0CVgyy4baSiLPG2g'
consumer_secret 'mqUnS9BHQ0O6Uh9ccAYEjFM3jQC4R0NUofBQLACtqMleUsQQ5c'

secret 'FN4Gw0WthvnMLvY0APaezG54Nsnmr4NhbY8x8FAdOekOf'
token '2847301967-SHSbY7MOXs3oy8Em6GkFyGq9xK8jO2KzjRBii5a'

# remove this to send out tweets
# debug_mode

# remove this to update the db
no_update
# remove this to get less output when running
verbose

# here's a list of users to ignore
blacklist "abc", "def"

# here's a list of things to exclude from searches
exclude "hi", "spammer", "junk"

# search("#140art") do |tweet|
#     retweet(tweet[:id])
#  end

# search "keyword" do |tweet|
#  reply "Hey #USER# nice to meet you!", tweet
# end

# replies do |tweet|
#   reply "Yes #USER#, you are very kind to say that!", tweet
# end

# loop do

# client.search('#art -rt', :result_type => 'recent').take(3).each do |tweet|
# 	puts tweet.text

# 	if tweet.created_at > client.home_timeline.first.created_at
# 		client.retweet(tweet.id)
# 	end
# end

# sleep 60.minutes
# end


# loop do
#   search "#artup" do |tweet|
#     # here you could do something with a tweet
#     # if you want to retweet
#     retweet(tweet[:id])
#   end

#   # replies do |tweet|
#   #   # do stuff
#   # end

#   # explicitly update our config
#   update_config

#   sleep 60
# end
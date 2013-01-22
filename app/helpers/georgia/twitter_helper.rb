module Georgia
  module TwitterHelper

    def tweets_for account
      begin
        @tweets ||= Twitter.user_timeline(account)
      rescue Exception => ex
        logger.error "Twitter retrieval: " << ex.message
      ensure
        @tweets ||= []
      end
      @tweets
    end

    def auto_link_tweet tweet
      if tweet.in_reply_to_screen_name
        auto_link(tweet.text.gsub(/(@\w+)/, link_to("@#{tweet.in_reply_to_screen_name}", "http://twitter.com/#{tweet.in_reply_to_screen_name}"))).html_safe
      else
        auto_link(tweet.text).html_safe
      end
    end

  end
end
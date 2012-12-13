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

end
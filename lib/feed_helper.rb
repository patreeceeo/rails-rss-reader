module FeedHelper
  def self.engine 
    SuperfeedrEngine::Engine
  end

  def self.subscribe(feed)
    body, ok = engine.subscribe(feed, {:retrieve => true})

    feed.notified JSON.parse(body) if ok
    feed.update_attributes :subscribed => !!ok
  end

  def self.unsubscribe(feed)
    engine.unsubscribe(feed)
  end
end

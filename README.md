
# Development

`ngrok` is a command line tool that allows us to use webhooks while running the rails app on a local dev machine.

First, make sure `ngrok` is installed
start ngrok

```
ngrok http 80
```

Now, I'm cheap and I haven't paid for ngrok yet, so that means we have the free version that changes the webhook URL every time you restart it. So, to every time ngrok is started we need to update the forwarding url in the initializer.

Copy one of the forwarding urls into the superfeed initializer. Example:

config/initializers/superfeedr_engine.rb:

```ruby
SuperfeedrEngine::Engine.host = "b2a46eb2.ngrok.io" # Your hostname (no http). Used for webhooks!
```

All set!

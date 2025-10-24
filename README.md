# LLM Rescuer 🤖💰

> ⚠️ **EXPERIMENTAL PROJECT - NOT FOR PRODUCTION USE**
>
> This project is an experimental proof-of-concept developed for educational purposes and pure, unadulterated fun. It uses AI to dynamically handle runtime errors, which introduces unpredictable behavior and potential security risks that would make your security team cry. **Never use this in production environments unless you enjoy explaining to your boss why the AI decided your user's name should be "🐱 Mr. Whiskers".**

## The Mission: Fixing the Billion Dollar Mistake... With a Billion Dollars Worth of LLM Tokens

In 1965, Tony Hoare invented the null reference and later called it his ["billion-dollar mistake"](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/). Well, we're here to fix it by potentially spending a billion dollars in OpenAI API tokens! 💸

Because clearly, the best way to solve a problem caused by the absence of a value is to throw artificial intelligence at it until it hallucinates a reasonable response. What could possibly go wrong?

## What This Abomination Does

LLM Rescuer is a Ruby gem that catches your `NoMethodError`s when you call methods on `nil` and asks GPT to guess what you _probably_ wanted. It's like having a very expensive, overly-confident intern who's read your entire codebase and thinks they know what you meant.

```ruby
user = nil
puts user.name  # Instead of crashing, might return "John Doe" or "undefined" or "🎭"
                # depending on what the AI thinks is funny today
```

## How This Beautiful Disaster Works

1. **The Trap**: We monkey-patch `NilClass` because why not break fundamental assumptions?
2. **The Analysis**: When you call a method on `nil`, we pause everything and ask an LLM to read your mind
3. **The Oracle**: GPT-5 analyzes your code like a digital Sherlock Holmes with ADHD
4. **The Guess**: It returns what it thinks you wanted, which is right about 73.2% of the time\*
5. **The Magic**: Your code continues running, probably doing something completely different than intended

\*Statistics may be made up

## Installation (AKA "How to Spend Your OpenAI Credits")

Add this line to your application's Gemfile (and say goodbye to your API budget):

```ruby
gem 'llm_rescuer'
```

Then execute:

```bash
bundle install
# Also install a second mortgage for your OpenAI bills
```

## Configuration

1. **Feed the AI overlords**:

   ```bash
   export OPENAI_API_KEY="prepare-your-wallet"
   ```

2. **Set your project scope** (so it only ruins _your_ code):

   ```ruby
   LlmRescuer.prefix = "/path/to/your/beautiful/disaster"
   ```

3. **Embrace the chaos**:
   ```ruby
   require 'llm_rescuer'
   LlmRescuer.setup
   # You have chosen... poorly
   ```

## Real-World Usage Examples

```ruby
# Classic nil safety
user = find_user(id: "nonexistent") # returns nil
puts user.email
# AI: "Analyzing context... user seems to need an email...
#      returning 'no-reply@example.com'"

# Shopping cart magic
cart = session[:cart] # nil because session expired
total = cart.total_price
# AI: "This looks like e-commerce. Based on similar patterns,
#      I'll return 0.0 to avoid charging $nil"

# The existential crisis
meaning_of_life = nil
answer = meaning_of_life.to_i
# AI: "Clearly this should be 42. I've read Douglas Adams."
```

## What Could Go Wrong? 🤔

- Your nil users might suddenly become named "ChatGPT's Best Friend"
- Your shopping cart totals might be replaced with haikus about commerce
- Your boolean flags might return philosophical treatises on truth
- Your API might start responding with interpretive dance descriptions
- You might accidentally achieve sentience in your nil objects

## Cost Analysis 💰

- **Traditional nil handling**: Free, but your app crashes
- **LLM Rescuer**: $0.002 per nil rescue (estimated)
- **Your sanity**: Priceless (and rapidly depleting)

For a typical Rails app with healthy nil hygiene, expect to spend approximately:

- **Development**: $50-100/month (because you test things, right?)
- **Production**: $500-5000/month (depending on how nil-happy your code is)
- **Black Friday**: Your firstborn child

## Dependencies (The Usual Suspects)

- `ruby_llm` (~> 1.8.2) - For talking to our AI overlords
- `ruby_llm-schema` (~> 0.2.1) - For making sure AI responses are structured chaos
- `binding_of_caller` (~> 1.0.1) - For context that the AI will probably ignore anyway
- A sense of humor (>= 1.0.0, required)
- A healthy bank account (recommended)

## Development

After checking out the repo and questioning your life choices:

```bash
bin/setup    # Install dependencies
rake spec    # Run tests (spoiler: they're as unpredictable as AI)
bin/console  # Interactive prompt for immediate regret
```

## Contributing

Found a bug? That might be a feature! Found a feature? That might be a bug!

Submit PRs, issues, or interpretive dance videos explaining your problems. We accept contributions in all forms except sensible ones.

## Success Stories

> "LLM Rescuer saved my app from crashing! Sure, all my users are now named 'Anonymous Penguin' and my prices are in Bitcoin, but it didn't crash!" - Definitely Real User

> "I deployed this to production and my nil errors went down 100%! My AWS bill went up 400%, but correlation isn't causation, right?" - Another Real Person

## The Philosophy

Why fix your code when you can train an AI to guess what your code should have done? It's like pair programming, except your pair is a probabilistic text generator that's read the entire internet and has strong opinions about variable naming.

## License

This project is licensed under the MIT License, which gives you the right to use, modify, and distribute this code. It does not give you the right to sue us when your production app starts writing poetry instead of processing payments.

## Final Words

Remember: null references were a billion-dollar mistake, but with today's AI API pricing, we can make it a trillion-dollar mistake! 🚀

---

_"In a world without nil safety, one gem dares to ask: 'What if we just guessed?'"_ 🎬

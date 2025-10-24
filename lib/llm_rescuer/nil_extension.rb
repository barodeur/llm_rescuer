module LlmRescuer
  def self.prefix=(prefix)
    @prefix = prefix
  end

  def self.prefix = @prefix

  module NilExtension
    class ResponseSchema < RubyLLM::Schema
      string :ruby_expression, description: "The heroic ruby expression that will save this program from certain doom"
      string :comment, description: "Your witty commentary on this rescue mission (be entertaining!)"
      string :error_message, description: "A friendly explanation of what went wrong (no boring technical jargon!)"
    end

    def method_missing(method_name, *args, &block)
      chat = RubyLLM
        .chat
        .with_tool(Tools::ReadSourceCodeTool)

      chat.with_instructions <<~SYSTEM_PROMPT
        🚨 EMERGENCY! EMERGENCY! 🚨

        A Ruby program has called `#{method_name}` on `nil` and is about to crash! You are the LLM Rescuer -
        an AI-powered superhero whose job is to save this program from the dreaded NoMethodError.

        Your mission, should you choose to accept it (and you will, because you're an AI):
        1. 🕵️ Use the `read_source_code` tool to investigate the crime scene
        2. 🧠 Channel your inner Sherlock Holmes to deduce what the programmer PROBABLY wanted
        3. 🎭 Return a ruby expression that will keep this show running

        Remember: You're not just fixing code, you're preventing existential crises! Every nil you rescue
        is a developer who doesn't have to question their life choices (today).

        Your response should be a ruby expression that makes sense in context. Some heroic examples:
        - `super` - when you want to let it crash dramatically (sometimes necessary for character development)
        - `nil` - when you want to be the safe choice (like using &.)
        - `""` or `[]` or `{}` - when you sense they wanted an empty container
        - `0` or `false` - when the context screams for these values
        - A sensible default object - when you're feeling particularly creative

        🎯 Your goal: Keep the program running with the most logical, contextually-appropriate value.
        Think like a mind-reader, but with better documentation skills!

        Pro tip: The business logic holds the secrets. Read it like the fascinating novel it definitely isn't.
      SYSTEM_PROMPT

      filtered_caller = caller.filter { |line| line.start_with?(LlmRescuer.prefix) }.join("\n")

      prompt = <<~PROMPT
        🔍 CASE FILE: The Great Nil Mystery of #{Time.now.strftime("%Y")}

        **THE CRIME:**
        Method `#{method_name}` was called on a nil object! The audacity!

        **THE EVIDENCE:**
        - Method name: `#{method_name}`
        - Arguments provided: #{args.inspect}
        - Witnesses (call stack):
        #{filtered_caller}

        **YOUR MISSION:**
        Detective AI, please examine the evidence and determine what this nil object
        SHOULD have been. What would make the most sense in this context?

        Remember: You're not just guessing - you're channeling the collective wisdom
        of a thousand rubber ducks and the programming intuition of developers who
        forgot to check for nil (again).

        Return your best guess as a ruby expression that will save the day! 🦸‍♀️
      PROMPT
      response = chat.with_schema(ResponseSchema).ask(prompt)
      eval(response.content["ruby_expression"]) # standard:disable Security/Eval
    end

    def respond_to_missing?(method_name, include_private = false)
      first_caller = caller(1..1).first
      first_caller&.start_with?(LlmRescuer.prefix) || false
    end
  end
end

module LlmRescuer
  def self.prefix=(prefix)
    @prefix = prefix
  end

  def self.prefix = @prefix

  module NilExtension
    class ResponseSchema < RubyLLM::Schema
      string :ruby_expression, description: "ruby expression to evaluate to recover from the exception"
      string :comment, description: "comment about the response"
      string :error_message, description: "error message from the exception"
    end

    def method_missing(method_name, *args, &block)
      chat =
        RubyLLM
          .chat
          .with_tool(Tools::ReadSourceCodeTool)
          .on_tool_call do |tool_call|
          # Called when the AI decides to use a tool
          puts "Calling tool: #{tool_call.name}"
          puts "Arguments: #{tool_call.arguments}"
        end
          .on_tool_result do |result|
          # Called after the tool returns its result
          puts "Tool returned: #{result}"
        end

      chat.with_instructions <<~SYSTEM_PROMPT
        A ruby program is about to crash or test about to fail because the method `#{method_name}` has been called on `nil`.
        We are trying to determine what the return value of `NilClass.method_missing` should be so the program can resume.
        You can use the `read_source_code` tool to read the source code of a file.
        Generate a response with a ruby expression to evaluate.

        Some examples of expression could be:
        - super if we want to raise the error
        - `nil` if we want to behave like &.
        - a boolean
        - a number
        - a new instance of a class

        The goal is to help the program to resume successfully with the best possible expression.
        You need to look at the business logic of the caller to determine the best expression.
      SYSTEM_PROMPT

      filtered_caller = caller.filter { |line| line.start_with?(LlmRescuer.prefix) }.join("\n")

      prompt = <<~PROMPT
        Here is the failing method call:
        method name: #{method_name}
        arguments: #{args.inspect}
        backtrace:
        #{filtered_caller}
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

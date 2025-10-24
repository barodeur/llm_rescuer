# frozen_string_literal: true

require "ruby_llm"
require "ruby_llm/schema"

require_relative "llm_rescuer/version"
require_relative "llm_rescuer/nil_extension"
require_relative "llm_rescuer/tools/read_source_code_tool"

RubyLLM.configure do |config|
  config.openai_api_key = ENV.fetch("OPENAI_API_KEY")
  config.default_model = "gpt-5"
end

module LlmRescuer
  def self.setup
    NilClass.prepend(LlmRescuer::NilExtension)
  end
end

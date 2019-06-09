require_relative './lib/interface'
require_relative './lib/prompt_input_strategy'

Interface.new(PromptInputStrategy.new).start
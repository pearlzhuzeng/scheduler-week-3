require_relative './lib/interface'
require_relative './lib/prompt_input_strategy'

$input_strategy = PromptInputStrategy.new

Interface.new($input_strategy).start
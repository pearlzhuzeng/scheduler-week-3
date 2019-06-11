require 'tty-prompt'

require_relative './input_strategy'

class PromptInputStrategy < InputStrategy
  def initialize
    @prompt = TTY::Prompt.new
  end

  def ask(value)
    @prompt.ask(value)
  end

  def select(question, choices)
    @prompt.select(question, choices)
  end
end
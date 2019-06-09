require 'tty-prompt'

class PromptInputStrategy
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
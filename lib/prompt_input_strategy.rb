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

  def multi_select(question, choices)
  	@prompt.multi_select(question, choices)
  end

  def yes_or_no(question)
  	loop do
      y_n = @prompt.ask(question + ' (y/n):')
      if y_n == 'y'
        return true
      elsif y_n == 'n'
        return false
      else
        puts "Please enter y or n."
      end
    end
  end
end
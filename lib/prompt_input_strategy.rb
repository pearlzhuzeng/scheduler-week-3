class PromptInputStrategy
  def prompt(value)
    $prompt.ask(value)
  end
end
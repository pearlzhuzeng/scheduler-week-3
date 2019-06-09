class CommandScriptStrategy
  def initialize(command_script_items)
    @command_script_items = command_script_items
    @current_index = 0
  end

  def prompt(key)
    if !@command_script_items[@current_index]
      raise "A prompt was given but all the command script items have already been used. Please put in an exit command."
    end

    @command_script_items[@current_index][key].tap do
      @current_index += 1
    end
  end
end
class CommandScriptStrategy
  def initialize(command_script_items)
    @command_script_items = command_script_items
    @current_index = 0
  end

  def prompt(key)
    @command_script_items[@current_index][key].tap do
      @current_index += 1
    end
  end
end
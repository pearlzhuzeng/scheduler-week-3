require_relative '../../controllers/providers_controller'
require_relative '../../lib/interface'
require_relative '../../lib/command_script_strategy'

RSpec.describe ProvidersController do
  it 'adds a provider to the list' do
    $all_providers = []

    command_script_strategy = CommandScriptStrategy.new([
      { 'Please enter a command:' => 'sp:add' },
      { 'Provider Name:' => 'Jason' },
      { 'Provider Phone Number:' => '555' },
      { 'Please enter a command:' => 'exit' },
   ])

    interface = Interface.new(command_script_strategy)
    interface.start

    expect(ProviderHelper.new.find_provider_by_name('Jason').name).to eq ('Jason')
  end
end
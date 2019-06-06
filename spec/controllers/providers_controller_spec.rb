require_relative '../../models/interface'
require_relative '../../controllers/providers_controller'
require 'pry'

# RSpec.describe ProvidersController do
#   it 'adds a provider to the list' do
#     $all_providers = []
#     ProvidersController.new.add(name: 'Jason', phone: '555')
#     expect(ProviderHelper.new.find_provider_by_name('Jason').name).to eq ('Jason')
#   end
# end

RSpec.describe ProvidersController do
  it 'adds a provider to the list' do
    $all_providers = []

    text_input_strategy = TextInputStrategy.new([
      { 'Please enter a command:' => 'sp:add' },
      { 'Provider Name:' => 'Jason' },
      { 'Provider Phone Number:' => '555' },
      { 'Please enter a command:' => 'exit' },
   ])

    interface = Interface.new(text_input_strategy)
    interface.start

    expect(ProviderHelper.new.find_provider_by_name('Jason').name).to eq ('Jason')
  end
end
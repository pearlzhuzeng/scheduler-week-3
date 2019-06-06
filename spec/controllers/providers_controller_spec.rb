require_relative '../../controllers/providers_controller'

require_relative '../../models/interface'

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

    inputs = {
      'Please enter a command:' => 'sp:add',
      'Provider Name:' => 'jason',
      'Provider Phone Number:' => '555'
    }

    inputs.each do |prompt, input|
      Interface.enter(input)
    end

      expect(ProviderHelper.new.find_provider_by_name('Jason').name).to eq ('Jason')
    end
end
require_relative '../../seed'
require_relative '../../controllers/providers_controller'
require_relative '../../lib/interface'
require_relative '../../lib/command_script_strategy'

RSpec.describe ProvidersController do
  describe '#add' do
    it 'adds a provider to the list' do
      $input_strategy = CommandScriptStrategy.new([
        { 'Provider Name:' => 'Jason' },
        { 'Provider Phone Number:' => '5558889981' },
        {'What services does this provider offer?' => ['Mind Reading']},
        {"Date (MM):" => '10'},
        {"Date (DD):" => '10'},
        {"Date (YYYY):" => '2025'},
        {"Start Time (ex: 13:30):" => '10:00'},
        {"End Time (ex: 14:30):" => '20:00'},
        {"Continue adding?" => 'n'},
      ])

      ProvidersController.add

      expect(Provider.find_provider_by_name('Jason').name).to eq ('Jason')
    end
  end

  describe '#remove' do
    it 'removes a provider from the list' do
      $input_strategy = CommandScriptStrategy.new([
        { 'Provider Name To Remove:' => 'Sue' },
        {'(y/n):' => 'y'},
      ])

      ProvidersController.remove
      
      expect(Provider.find_provider_by_name('Jim').name).to eq ('Jim')
      expect(Provider.find_provider_by_name('Sue')).to be (false)
    end
  end
end
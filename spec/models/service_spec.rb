require '../models/service'

RSpec.describe Service do
  it 'can be initialized' do
    service = Service.new('exorcism', 1000, 60)
    expect(service.name).to eq('exorcism')
  end
end
require_relative './models/service'
require_relative './models/provider'

class Service
  @services = [
    Service.new('Mind Reading', 200, 60),
    Service.new('Demonic Exorcism', 50, 120),
    Service.new('Potion Therapy', 100, 100),
    Service.new('Liver Transplants', 5000, 600),
  ]
end

class Provider
  @providers = [
    Provider.new('Jim', '234-486-9800', Service.all[0..3], [], []),
    Provider.new('Sue', '978-123-5768', Service.all[0..2], [], [])
  ]
end


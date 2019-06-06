# FUNCTION TO INITIALIZE A FAKE DATA SET

def initData
  all_providers = []
  serviceSet1 = [
    Service.new('A', 200, 60),
    Service.new('B', 100, 120),
    Service.new('C', 50, 60)
  ]
  serviceSet2 = [
    Service.new('D', 300, 180),
    Service.new('E', 150, 120)
  ]

  all_providers.push(Provider.new('Jim', '1111111111', serviceSet1, [], []))
  all_providers.push(Provider.new('Sue', '1111111112', serviceSet2, [], []))

  start_datetime = DateTime.new(2019, 12, 12, 12)
  appointment1 = Appointment.new(TimeBlock.new(start_datetime, false, 120), serviceSet1[1], 'Larry', all_providers[0])

  all_providers[0].appointments.push(appointment1)
  return all_providers
end

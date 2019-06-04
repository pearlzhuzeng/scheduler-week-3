def spPrint(all_providers)
  puts "#{BgMagenta}SERVICE PROVIDERS:#{Reset}"
  puts '------------------'
  all_providers.each do |sp|
    puts "#{Magenta}#{sp.name}#{Reset}"
  end
  puts '------------------'
  puts ''
end

def servicePrint(all_providers)
  puts "#{BgCyan}SERVICES:#{Reset}"
  puts '------------------'
  for sp in all_providers do
    sp.printServices()
  end
  puts '------------------'
  puts ''
end
require_relative '../init'

class ProviderHelper
  def find_provider_by_service(service_name)
    providers = []
    for provider in $all_providers do
      for service in provider.services do
        if service.name == service_name
          providers.push(provider)
          break
        end
      end
    end
    return providers
  end

  def find_provider_by_name(name)
    provider = $all_providers.select do |provider| 
      provider.name == name
    end
    if provider.length == 1
      return provider.first
    else
      return false
    end
  end
end
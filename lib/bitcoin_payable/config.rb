require 'singleton'

module BitcoinPayable
  class Config
    include Singleton
    attr_accessor(
      # Core
      :master_public_key, 
      :node_path, 
      :currency, 
      :adapter, 
      :adapter_api_key, 
      :testnet, 
      :confirmations,

      # Pricing
      :open_exchange_key,

      # Webhooks
      :allowwebhooks, 
      :webhook_subdomain, 
      :webhook_domain, 
      :webhook_port
    )

    def initialize
      @currency ||= :cad
      @confirmations ||= 6
    end

    def network
      @testnet == false ? :bitcoin : :bitcoin_testnet
    end
  end
end

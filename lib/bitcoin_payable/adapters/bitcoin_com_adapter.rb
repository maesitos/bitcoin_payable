module BitcoinPayable::Adapters
  class BitcoinComAdapter < Base

    def initialize
      raise 'An error has occured' unless BitcoinPayable.config.crypto == :bch
      prefix = BitcoinPayable.config.testnet ? 't' : ''
      @url = "https://#{prefix}rest.bitcoin.com/v2"
    end

    def fetch_transactions_for_address(address)
      url = "#{@url}/address/utxo/#{address}"
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      message = JSON.parse(response.body)
      message['utxos'].map do |tx|
        {
          txHash: tx['txid'],
          blockHash: nil,  # Not supported
          blockTime: nil,  # Not supported
          estimatedTxTime: nil, #Not supported
          estimatedTxValue: tx['satoshis'],
          confirmations: tx['confirmation'] || 0
        }
      end
    end

  end
end

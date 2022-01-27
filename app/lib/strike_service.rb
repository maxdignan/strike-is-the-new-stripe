class StrikeService
  BASE_URL = "https://api.strike.me/v1"

  # contains amount, currency, name of customer
  def self.generate_invoice(invoice_details)
    invoice_details = invoice_details.merge({
      correlationId: SecureRandom.uuid,
    })

    JSON.parse(HTTParty.post("#{BASE_URL}/invoices",
      body: invoice_details.to_json,
      headers: auth_headers,
    ).body)
  end

  def self.get_invoice_by_uuid(uuid)
    JSON.parse(HTTParty.get(
      "#{BASE_URL}/invoices/#{uuid}",
      { headers: auth_headers },
    ).body)
  end

  def quote_invoice(invoice)
    # /v1/invoices/:invoiceId/quote

    JSON.parse(HTTParty.get(
      "#{BASE_URL}/invoices/#{invoice.uuid}/quote",
      { headers: auth_headers },
    ).body)
  end

  def self.auth_headers()
    {
      "Authorization": "Bearer #{ENV["STRIKE_API_KEY"]}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    }
  end

end
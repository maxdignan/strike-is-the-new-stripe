class StrikeService
  BASE_URL = "https://api.strike.me/v1"

  # contains amount, currency, name of customer
  def self.generate_invoice(strike_user_handle, invoice_details)
    invoice_details = invoice_details.merge({
      correlationId: SecureRandom.uuid,
    })

    JSON.parse(HTTParty.post("#{BASE_URL}/invoices/handle/#{strike_user_handle}",
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

  def self.quote_invoice(invoice)
    # /v1/invoices/:invoiceId/quote

    JSON.parse(HTTParty.post(
      "#{BASE_URL}/invoices/#{invoice.uuid}/quote",
      { headers: auth_headers },
    ).body)
  end

  def self.index_with_filter_for_invoice_id(invoice_ids, only_unpaid = false)
    if invoice_ids.count < 1
      return []
    end

    pp invoice_ids

    output_invoices = []

    while invoice_ids.count > 0
      i_ids = invoice_ids.pop(10)

      pp "post i_ids"
      pp i_ids

      filter_info = i_ids.map do |id|
        "invoiceId eq #{id}"
      end.join(" or ")

      if only_unpaid
        filter_info = "(state eq 'UNPAID' and #{filter_info})"
      else
        filter_info = "(#{filter_info})"
      end

      pp "in index"
      pp filter_info
      req = HTTParty.get(
        "#{BASE_URL}/invoices/?$filter=#{filter_info}",
        { headers: auth_headers },
      )

      pp req

      req_body = req.body

      pp req_body
      json = JSON.parse(req_body)

      pp "json"
      pp json

      output_invoices = output_invoices + json["items"]
    end

    output_invoices
  end

  def self.auth_headers()
    {
      "Authorization": "Bearer #{ENV["STRIKE_API_KEY"]}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    }
  end

end

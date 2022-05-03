class Invoice < ApplicationRecord
  belongs_to :business
  belongs_to :customer

  def self.update_paid_status_from_strike_with_uuid(uuid)
    strike_invoice = StrikeService.get_invoice_by_uuid(@invoice.uuid)

    invoice = self.find_by(uuid: uuid)

    pp 'inside update function'
    pp strike_invoice
    pp invoice

    if strike_invoice['state'] == "PAID"
      invoice.update(paid: true)
    end
  end
end

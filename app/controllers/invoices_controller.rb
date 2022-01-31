class InvoicesController < WhoAmIController
  # GET /invoices
  def index
    @invoices = { error: "please login" }

    if business?
      @invoices = resolve_business.invoices
      pp @invoices
      @invoices = StrikeService.index_with_filter_for_invoice_id(@invoices.map(&:uuid))
    elsif customer?
      @invoices = resolve_customer.invoices
      pp @invoices
      @invoices = StrikeService.index_with_filter_for_invoice_id(@invoices.map(&:uuid))
    end

    render json: @invoices
  end

  # GET /invoices/1
  def show
    if business?
      @invoice = Invoice.find_by(uuid: params[:uuid], business_id: resolve_business.id)
    elsif customer?
      @invoice = Invoice.find_by(uuid: params[:uuid], customer_id: resolve_customer.id)
    end

    if @invoice.nil?
      raise "You need to be the business of customer of that invoice to see it"
    end

    render json: StrikeService.get_invoice_by_uuid(@invoice.uuid)
  end

  def quote
    if business?
      @invoice = Invoice.find_by(uuid: params[:uuid], business_id: resolve_business.id)
    elsif customer?
      @invoice = Invoice.find_by(uuid: params[:uuid], customer_id: resolve_customer.id)
    else
      raise "You need to be logged in"
    end

    if @invoice.nil?
      raise "You need to own this invoice to quote on it"
    end

    render json: StrikeService.quote_invoice(@invoice)
  end

  # POST /invoices
  def create
    if !business?
      raise "Please login as a business"
    end

    # business must own this customer
    if !resolve_business.customers.map(&:id).include?(params[:customer_id].to_i)
      raise "This customer needs to be YOUR customer"
    end

    invoice_from_strike = StrikeService.generate_invoice(resolve_business.strike_user_handle, {
      description: params[:description],
      amount: {
        amount: params[:amount],
        currency: params[:currency],
      }
    })

    puts invoice_from_strike

    if invoice_from_strike.present? && invoice_from_strike["invoiceId"].present?
      @invoice = Invoice.new(
        uuid: invoice_from_strike["invoiceId"],
        business_id: resolve_business.id,
        customer_id: params[:customer_id],
      )

      if @invoice.save
        render json: @invoice, status: :created, location: @invoice
      else
        render json: @invoice.errors, status: :unprocessable_entity
      end
    else
      render json: ["Error from strike"], status: :unprocessable_entity
    end
  end
end

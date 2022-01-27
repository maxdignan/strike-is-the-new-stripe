class InvoicesController < WhoAmIController
  # GET /invoices
  def index
    @invoices = { error: "please login" }

    if business?
      @invoices = resolve_business.invoices
    elsif customer?
      @invoices = resolve_customer.invoices
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

    render json: @invoice
  end

  def quote
    if business?
      @invoice = Invoice.find_by(uuid: params[:uuid], business_id: resolve_business.id)
    elsif customer?
      @invoice = Invoice.find_by(uuid: params[:uuid], customer_id: resolve_customer.id)
    end

    render json: StrikeService.quote_invoice(@invoice)
  end

  # POST /invoices
  def create
    if !business?
      raise "Please login as a business"
    end

    # business must own this customer
    if !resolve_business.customers.map(&:id).include?(params[:customer_id])
      raise "This customer needs to be YOUR customer"
    end

    invoice_from_strike = StrikeService.generate_invoice({
      description: params[:description],
      amount: {
        amount: params[:amount],
        currency: params[:currency],
      }
    })

    puts invoice_from_strike

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
  end
end

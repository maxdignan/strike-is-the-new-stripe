class CustomersController < WhoAmIController
  def show
    @customer = { error: "please login" }

    if customer?
      @customer = resolve_customer
    end

    render json: @customer
  end

  # POST /customers
  def create
    if !business?
      raise "Please login as a business"
    end

    @customer = Customer.new(customer_params.merge({
      secret: SecureRandom.uuid,
      business_id: resolve_business.id,
    }))

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:name)
    end
end

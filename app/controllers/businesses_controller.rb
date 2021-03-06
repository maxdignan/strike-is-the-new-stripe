class BusinessesController < WhoAmIController
  def index
    @business = { error: "please login" }

    if business?
      @business = resolve_business
    end

    render json: @business
  end

  # POST /businesses
  def create
    @business = Business.new(business_params.merge({ secret: SecureRandom.uuid }))

    puts @business
    puts business_params
    puts params

    if @business.save
      render json: @business, status: :created, location: @business
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def business_params
      params.require(:business).permit(:name, :strike_user_handle)
    end
end

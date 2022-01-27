class WhoAmIController < ApplicationController
  def customer?
    params[:customer_secret].present?
  end

  def business?
    params[:business_secret].present?
  end

  def resolve_business
    Business.find_by_secret(params[:business_secret])
  end

  def resolve_customer
    Customer.find_by_secret(params[:customer_secret])
  end
end
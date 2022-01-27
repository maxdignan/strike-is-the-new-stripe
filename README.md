## Strike is the new Stripe

Haven't you heard?

Get basic payment processing features with no long sign up and no fees.

## Basic Usage

### Make your business

<code>
http POST https://desolate-mesa-68729.herokuapp.com/businesses  name='Max Energy' --json
</code>

You'll get back your `business_secret`. **Keep this secret**.

 - Include your own strike handle wip

### Make your first customer

<code>
http POST https://desolate-mesa-68729.herokuapp.com/customers  name='Max Energy' --json
</code>

 - You'll get back your customer's secret. This isn't as secret, but keep it between just you and your customer.
 - You'll also get back the customer's id. Keep this around so you can send them an invoice. These simply auto-increment, but invoice creation only works when it's YOUR customer.

### Make Your First Invoice for that Customer

<code>
http POST https://desolate-mesa-68729.herokuapp.com/invoices business_secret='YOUR_BUSINESS_SECRET_HERE' description='Pay your first invoice pls' amount=9.10 currency='USD' customer_id=THE_ID_RETURNED_FOR_THAT_CUSTOMER --json
</code>

 - You'll get back a uuid. This is the invoiceId from Strike. Keep this handy.

### Make a Quote

<code>
http POST https://desolate-mesa-68729.herokuapp.com/invoice-quote business_secret='YOUR_BUSINESS_SECRET_HERE' uuid='UUID_OR_INVOICE_ID_OF_INVOICE_OF_INTEREST' --json
</code>

 - You'll get back the lnInvoice and onchain address info, if applicable. You'll also get the expiration info for the quote.
 
## Strike is the new Stripe

Haven't you heard?

Get basic payment processing features with no long sign up and no fees.

## Basic Usage

### Make your business
<code>
http POST https://<YOUR DOMAIN>/businesses name='Max Energy' strike_user_handle='maxdignan' --json
</code>

You'll get back your `business_secret`. **Keep this secret**.

### Make your first customer
<code>
http POST https://<YOUR DOMAIN>/customers business_secret='YOUR_BUSINESS_SECRET_HERE' name='Max Energy Buyer' --json
</code>

 - You'll get back your customer's secret. This isn't as secret, but keep it between just you and your customer.
 - You'll also get back the customer's id. Keep this around so you can send them an invoice. These simply auto-increment, but invoice creation only works when it's YOUR customer.

### Make Your First Invoice for that Customer
<code>
http POST https://<YOUR DOMAIN>/invoices business_secret='YOUR_BUSINESS_SECRET_HERE' description='Pay your first invoice pls' amount=9.10 currency='USD' customer_id=THE_ID_RETURNED_FOR_THAT_CUSTOMER --json
</code>

 - You'll get back a uuid. This is the invoiceId from Strike. Keep this handy.

### Make a Quote
<code>
http POST https://<YOUR DOMAIN>/invoice-quote business_secret='YOUR_BUSINESS_SECRET_HERE' uuid='UUID_OR_INVOICE_ID_OF_INVOICE_OF_INTEREST' --json
</code>

 - You'll get back the lnInvoice and onchain address info, if applicable. You'll also get the expiration info for the quote.
 

## Advanced Features

### List invoices
(as a business)

<code>
http GET https://<YOUR DOMAIN>/invoices business_secret='YOUR_BUSINESS_SECRET_HERE'
</code>

(as a customer)

<code>
http GET https://<YOUR DOMAIN>/invoices customer_secret='YOUR_CUSTOMER_SECRET_HERE'
</code>

### Get Invoice Details by UUID
Use the uuid of an invoice to get more info about it. Works the same as above. Send the business or the customer secret.

<code>
http GET https://<YOUR DOMAIN>/invoices/i uuid='dc186f4e-0958-431e-aea0-e3b3cf2b714e' business_secret='c920ed94-014b-406e-a498-d67ca80d5e34'
</code>

### And some more...
Checkout the source code to find more goodies!

json.extract! transaction, :id, :title, :value, :payment_date, :until_date, :recurring, :recurrence, :status, :comment, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

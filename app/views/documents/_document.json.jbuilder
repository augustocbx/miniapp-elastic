json.extract! document, :id, :title, :description, :document, :created_at, :updated_at
json.url document_url(document, format: :json)

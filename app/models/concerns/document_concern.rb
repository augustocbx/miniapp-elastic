module DocumentConcern
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    after_touch() {__elasticsearch__.index_document}

    analyzers = {
        "analysis": {
            "analyzer": {
                "folding": {
                    "tokenizer": "standard",
                    "filter": ["lowercase", "asciifolding"]
                }
            }
        }
    }
    settings index: analyzers do
      mapping do
        indexes :document_file_name, type: 'text', boost: 2
        indexes :document_file_name, type: 'text', index_options: 'offsets', analyzer: 'brazilian_stop_words_analyzer'
      end
    end

  end

  def as_indexed_json(options = {})
    as_json(only: [:id, :document_file_name, :document_text_plain])
  end
end
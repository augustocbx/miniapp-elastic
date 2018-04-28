module DocumentConcern
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    after_touch() {__elasticsearch__.index_document}

    analyzers = {
        analysis: {
            analyzer: {
                stop_words_analyzer: {
                    tokenizer: "standard",
                    filter: ["lowercase", "asciifolding", "stop", "trim", "snowball"]
                }
            }
        }
    }
    settings index: analyzers do
      mapping dynamic: 'false' do
        indexes :id, type: 'long'
        indexes :document_file_name, type: 'text', boost: 2, analyzer: 'stop_words_analyzer'
        indexes :content, type: 'text', analyzer: 'stop_words_analyzer', index_options: 'offsets'
      end
    end


    def self.search(query)

      search = Jbuilder.encode do |json|
        json.query do
          json.match do
            json.content "#{query}"
          end
        end

        json.highlight do
          json.pre_tags ['<em>']
          json.post_tags ['</em>']
          json.fields do
            json.set! 'document_file_name', {}
            json.set! 'content', {}
          end
        end
      end

      puts search
      return __elasticsearch__.search(search)
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:id, :document_file_name, :content])
  end
end
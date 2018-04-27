namespace :files do
  task :import => :environment do
    begin
      Document.destroy_all
    rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
      p e
      Document.__elasticsearch__.create_index! force: true
      Document.all.each do |document|
        document.document.destroy
      end
      Document.delete_all
    end
    dir = Rails.root.join('files_sample')
    Dir.foreach(dir) do |filename|
      next if filename == '.' || filename == '..'
      document = Document.new
      file = File.open(dir.join(filename))
      document.document = file
      file.close
      begin
        document.save
      rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
        p e
        puts filename
        puts document.content
      end
    end
  end
end
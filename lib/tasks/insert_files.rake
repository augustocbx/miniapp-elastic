namespace :files do
  task :import => :environment do
    Document.destroy_all
    dir = Rails.root.join('files_sample')
    Dir.foreach(dir) do |filename|
      next if filename == '.' || filename == '..'
      document = Document.new
      file = File.open(dir.join(filename))
      document.document = file
      file.close
      document.save
    end
  end
end
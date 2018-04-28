# == Schema Information
#
# Table name: documents
#
#  id                    :bigint(8)        not null, primary key
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  content               :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Document < ApplicationRecord
  include DocumentConcern

  has_attached_file :document, { preserve_files: false }
  validates_attachment_file_name :document, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /pdf\Z/, /doc\Z/, /odt\Z/, /docx\Z/]

  before_save :extract_text


  def extract_text
    jars_path = Rails.root.join('lib', 'jars')
    # puts `ls -lah #{self.document.queued_for_write[:original].path}`
    # p self.document.methods
    # puts "java -cp #{jars_path}/jai_core-1.1.3.jar:#{jars_path}/jai_imageio.jar:#{jars_path}/jbig2_1.4.jar:#{jars_path}/levigo-jbig2-imageio-1.6.1.jar:#{jars_path}/tika-parsers-1.13.jar -jar bin/tika-app-1.12.jar --text-main #{self.document.queued_for_write[:original].path}"
    self.content = `java -cp #{jars_path}/jai_core-1.1.3.jar:#{jars_path}/jai_imageio.jar:#{jars_path}/jbig2_1.4.jar:#{jars_path}/levigo-jbig2-imageio-1.6.1.jar:#{jars_path}/tika-parsers-1.13.jar -jar bin/tika-app-1.12.jar --text-main #{self.document.queued_for_write[:original].path}`[0..33000]
    if self.content.empty?
      self.content = `tesseract ~/Downloads/Southern_Life_in_Southern_Literature_text_page_322.jpg stdout`
    end
    puts "#{self.document.original_filename} indexed!"
  end
end

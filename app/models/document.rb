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
  has_attached_file :document, { preserve_files: false }
  validates_attachment_file_name :document, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /pdf\Z/, /doc\Z/, /odt\Z/, /docx\Z/]
end

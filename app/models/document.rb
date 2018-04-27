class Document < ApplicationRecord
  has_attached_file :document, { preserve_files: false }
  validates_attachment_file_name :document, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /pdf\Z/, /doc\Z/, /odt\Z/, /docx\Z/]
end

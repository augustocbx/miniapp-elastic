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

module DocumentsHelper
end

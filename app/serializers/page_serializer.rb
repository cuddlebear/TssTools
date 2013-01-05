class PageSerializer < ActiveModel::Serializer
  attributes :id, :title, :file_name, :status
  #has_many :contents
end

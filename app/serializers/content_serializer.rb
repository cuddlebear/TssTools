class ContentSerializer < ActiveModel::Serializer
  attributes :id
  has_many :links
end
class hPathSerializer < ActiveModel::Serializer
  attributes :name, :size
  has_many :children, :class_name => "paths"

  def name
    object.value.rpartition("/")[2]
  end

  def size
    1000
  end

end

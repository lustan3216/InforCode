class ContainerImageSerializer < ActiveModel::Serializer
  attributes :src

  def src
    object.image.url
  end

end
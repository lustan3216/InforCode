class UnitAdsSerializer < ActiveModel::Serializer
  attributes :id, :client, :impression_price, :face_price, :click_price, :material, :is_default

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def material
    object.materials.as_json(only: [:trigger_file ,:display_file, :buffering_file, :arrive_url])
  end

  def impression_price
    object.is_default ? 0 : object.impression_price
  end

  def face_price
    object.is_default ? 0 : object.face_price
  end

  def click_price
    object.is_default ? 0 : object.click_price
  end

  end
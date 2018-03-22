module ViewMethod

  def id_with_title
    "[#{id}]  #{title.to_s}"
  end

  def id_with_name
    "[#{id}]  #{name.to_s}"
  end
end
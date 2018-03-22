class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ransacker :id do |parent|
    Arel.sql("CONVERT(#{parent.base_klass.table_name}.id, CHAR(8))")
  end
end

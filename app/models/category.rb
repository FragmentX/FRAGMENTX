class Category < ApplicationRecord
  has_many :categories_restored_objects
  has_many :restored_objects, through: :categories_restored_objects

  def i18n_name
    if I18n.locale == :es
      return nombre
    else
      return name
    end
  end
end

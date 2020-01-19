class Material < ApplicationRecord
  has_many :compositions
  has_many :restored_objects, through: :compositions

  def i18n_name
    if I18n.locale == :es
      return nombre
    else
      return name
    end
  end
end

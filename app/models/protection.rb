class Protection < ApplicationRecord
  has_many :restored_objects

  def i18n_name
    if I18n.locale == :es
      return nombre
    else
      return name
    end
  end
end

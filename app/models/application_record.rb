class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(pagination_params)
    page, per = pagination_params.values_at(:page, :per)

    return all if per.to_s == '0'

    page(page).per(per)
  end
end

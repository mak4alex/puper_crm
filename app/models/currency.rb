# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  name       :string
#  abbr       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Currency < ApplicationRecord
  has_many :deals
end

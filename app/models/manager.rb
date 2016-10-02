# == Schema Information
#
# Table name: workers
#
#  id         :integer          not null, primary key
#  full_name  :string
#  position   :string
#  phone      :string
#  email      :string
#  skype      :string
#  fax        :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Manager < Worker
end

# == Schema Information
#
# Table name: agents
#
#  id            :integer          not null, primary key
#  type          :string
#  name          :string
#  delivery_time :datetime
#  company_name  :string
#  contact_id    :integer
#  manager_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Client < Agent
end

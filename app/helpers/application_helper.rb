module ApplicationHelper
  def period_cospan(plan)
    if plan == Plan::NAMES[:strategic]
      '12'
    elsif plan == Plan::NAMES[:perspective]
      '3'
    else
      '1'
    end
  end

  def editable(plan)
    plan == Plan::NAMES[:strategic] || plan == Plan::NAMES[:perspective]
  end
end

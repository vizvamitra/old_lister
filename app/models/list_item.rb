class ListItem < ActiveRecord::Base
  validates_presence_of :text

  default_scope{ order(created_at: :desc) }

  def switch_done
    self.done = !self.done
  end
end

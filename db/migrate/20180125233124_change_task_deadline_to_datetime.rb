class ChangeTaskDeadlineToDatetime < ActiveRecord::Migration[5.0]
  def change
    change_column(:tasks, :deadline, :datetime)
  end
end

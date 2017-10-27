class AddActiveToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :active, :boolean
  end
end

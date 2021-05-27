class AddColumnsToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :category_id, :string
  end
end

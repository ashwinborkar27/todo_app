class AddSelectorToNotes < ActiveRecord::Migration[6.1]
  def change
  	add_column :notes, :selector, :string
  end
end



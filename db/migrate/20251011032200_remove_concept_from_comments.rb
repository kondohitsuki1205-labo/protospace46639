class RemoveConceptFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :concept, :text
  end
end

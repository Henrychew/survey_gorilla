class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :question_id
      t.timestamps null: false
    end
  end
end

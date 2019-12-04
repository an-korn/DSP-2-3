class CreateDsps < ActiveRecord::Migration[5.2]
  def change
    create_table :dsps do |t|
      t.string :N
      t.string :K
      t.string :Phi

      t.timestamps
    end
  end
end

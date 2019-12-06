class CreateFourierTransforms < ActiveRecord::Migration[5.2]
  def change
    create_table :fourier_transforms do |t|
      t.string :N
      t.string :j

      t.timestamps
    end
  end
end

class CreateFornecedors < ActiveRecord::Migration[7.0]
  def change
    create_table :fornecedors do |t|
      t.string :nome
      t.string :email

      t.timestamps
    end
  end
end

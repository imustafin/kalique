class CreateSourceTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :source_texts do |t|
      t.string :text
      t.string :post_id
      t.string :domain
      t.datetime :parse_time

      t.timestamps
    end
  end
end

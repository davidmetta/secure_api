class SecureApiMigration < ActiveRecord::Migration[6.0]
  def change
    return if table_exists?(:secure_api_tokens)

    create_table :secure_api_tokens do |t|
      t.string :token
      t.datetime :exp_date

      t.references :resource, polymorphic: true, index: { name: 'index_secure_api_tokens_on_resource' }
      t.timestamps
    end
  end
end

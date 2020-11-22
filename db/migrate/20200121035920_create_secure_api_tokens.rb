class CreateSecureApiTokens < ActiveRecord::Migration[6.0]
  def change
    return if Rails.env.test?

    create_table :secure_api_tokens do |t|
      t.string :token
      t.datetime :exp_date

      t.references :resource, polymorphic: true, index: { name: 'index_secure_api_tokens_on_resource' }
      t.timestamps
    end
  end
end

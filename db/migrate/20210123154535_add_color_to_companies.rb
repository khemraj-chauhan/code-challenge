class AddColorToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :color, :string, default: '#00FF00'
  end
end

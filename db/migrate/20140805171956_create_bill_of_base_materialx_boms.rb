class CreateBillOfBaseMaterialxBoms < ActiveRecord::Migration
  def change
    create_table :bill_of_base_materialx_boms do |t|
      t.integer :part_id
      t.integer :project_id
      t.integer :qty
      t.text :preferred_mfr
      t.text :preferred_supplier
      t.integer :last_updated_by_id
      t.string :wf_state
      t.integer :estimated_total
      t.text :brief_note
      t.text :about_cost
      t.float :est_unit_price

      t.timestamps
    end
    
    add_index :bill_of_base_materialx_boms, :part_id
    add_index :bill_of_base_materialx_boms, :project_id
    add_index :bill_of_base_materialx_boms, :wf_state
  end
end

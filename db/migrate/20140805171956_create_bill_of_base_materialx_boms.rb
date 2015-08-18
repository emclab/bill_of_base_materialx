class CreateBillOfBaseMaterialxBoms < ActiveRecord::Migration
  def change
    create_table :bill_of_base_materialx_boms do |t|
      t.integer :part_id
      t.string :name
      t.string :part_num
      t.text :spec
      t.string :unit
      t.integer :project_id
      t.integer :qty
      t.text :preferred_mfr
      t.text :preferred_supplier
      t.integer :last_updated_by_id
      t.string :wf_state
      t.float :total_reference
      t.text :brief_note
      t.text :about_cost
      t.float :unit_price_reference
      t.integer :bom_level_id
      t.integer :bom_level_parent_id
      t.string :aux_resource

      t.timestamps
    end
    
    add_index :bill_of_base_materialx_boms, :part_id
    add_index :bill_of_base_materialx_boms, :project_id
    add_index :bill_of_base_materialx_boms, :bom_level_id
    add_index :bill_of_base_materialx_boms, :bom_level_parent_id
    add_index :bill_of_base_materialx_boms, :wf_state
    add_index :bill_of_base_materialx_boms, :name
    add_index :bill_of_base_materialx_boms, :part_num
    add_index :bill_of_base_materialx_boms, :spec
    add_index :bill_of_base_materialx_boms, :aux_resource
  end
end

# This migration comes from purchase_orderx (originally 20131115022208)
class CreatePurchaseOrderxOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orderx_orders do |t|
      
      t.string :po_num
      t.integer :last_updated_by_id
      t.string :wf_state
      t.integer :supplier_id
      t.date :delivery_date
      t.text :brief_note
      t.date :po_date
      t.text :po_requirement
      t.decimal :po_total, :precision => 10, :scale => 2
      t.decimal :shipping_cost, :precision => 10, :scale => 2
      t.decimal :tax, :precision => 10, :scale => 2
      t.decimal :other_cost, :precision => 10, :scale => 2
      t.integer :requested_by_id
      t.integer :po_category_id
      t.boolean :delivered, :default => false
      t.date :actual_delivery_date
      t.boolean :approved, :default => false
      t.date :approved_date
      t.integer :approved_by_id
      t.boolean :order_placed, :default => false
      t.date :order_placed_date
      t.boolean :void, :default => false
      t.integer :project_id
      t.timestamps
      t.decimal :executed_po_total, :precision => 10, :scale => 2
      t.integer :po_sub_category_id
      
    end
    
    add_index :purchase_orderx_orders, :po_category_id
    add_index :purchase_orderx_orders, :po_sub_category_id
    add_index :purchase_orderx_orders, :supplier_id
    add_index :purchase_orderx_orders, :po_num
    add_index :purchase_orderx_orders, :requested_by_id
    add_index :purchase_orderx_orders, :wf_state
    add_index :purchase_orderx_orders, :approved
    add_index :purchase_orderx_orders, :void
  end
end

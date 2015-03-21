# This migration comes from purchase_orderx (originally 20140704041655)
class CreatePurchaseOrderxOrderItems < ActiveRecord::Migration
  def change
    create_table :purchase_orderx_order_items do |t|
      t.integer :order_id
      t.integer :last_updated_by_id
      t.integer :qty
      t.string :unit
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.decimal :item_total, :precision => 10, :scale => 2
      t.string :name
      t.text :spec
      t.integer :item_category_id
      t.string :item_note
      t.timestamps
      t.integer :mfg_id
      t.string :brand
      t.integer :item_sub_category_id
    end
    
    add_index :purchase_orderx_order_items, :order_id
    add_index :purchase_orderx_order_items, :name
    add_index :purchase_orderx_order_items, :item_category_id
    add_index :purchase_orderx_order_items, :brand
    add_index :purchase_orderx_order_items, :mfg_id
  end
end

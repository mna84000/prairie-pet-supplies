ActiveAdmin.register Order do
  permit_params :customer_id,
                :subtotal,
                :gst,
                :pst,
                :hst,
                :total,
                :status

  index do
    selectable_column
    id_column
    column :customer
    column :subtotal
    column :gst
    column :pst
    column :hst
    column :total
    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :customer
      row :subtotal
      row :gst
      row :pst
      row :hst
      row :total
      row :status
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :unit_price
        column :line_total
      end
    end
  end
end

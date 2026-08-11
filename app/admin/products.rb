ActiveAdmin.register Product do
  permit_params :name,
                :description,
                :price,
                :stock_quantity,
                :active,
                :category_id,
                :image,
                tag_ids: []

  index do
    selectable_column
    id_column

    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), width: 60, height: 60
      else
        "No image"
      end
    end

    column :name
    column :category
    column :price
    column :stock_quantity
    column :active
    column :tags do |product|
      product.tags.map(&:name).join(", ")
    end
    actions
  end

  filter :name
  filter :category
  filter :price
  filter :active


  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :active
      f.input :category
      f.input :tags, as: :check_boxes
      f.input :image, as: :file
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :price
      row :stock_quantity
      row :active
      row :category

      row :tags do |product|
        product.tags.map(&:name).join(", ")
      end

      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), width: 250
        else
          "No image uploaded"
        end
      end

      row :created_at
      row :updated_at
    end
  end
end

ActiveAdmin.register Customer do
  permit_params :first_name,
                :last_name,
                :email,
                :address,
                :city,
                :postal_code,
                :province_id

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :address
    column :city
    column :postal_code
    column :province
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :address
      row :city
      row :postal_code
      row :province
      row :created_at
      row :updated_at
    end
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :city
  filter :province
  filter :created_at
end

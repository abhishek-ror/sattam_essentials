ActiveAdmin.register Account do
  permit_params :email, :password, :role, :activated

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :activated
    column :remember_created_at
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :role, as: :select, collection: Account.roles.keys
  filter :activated
  filter :remember_created_at
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :email
      row :role
      row :activated
      row :remember_created_at
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password, input_html: { autocomplete: "new-password" }
      f.input :role, as: :select, collection: Account.roles.keys
      f.input :activated
    end
    f.actions
  end
end

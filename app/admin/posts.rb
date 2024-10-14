ActiveAdmin.register Post do
  permit_params :title, :content, :user_id

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :user
    column :created_at
    actions
  end

  filter :title
  filter :content
  filter :user
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :user
    end
    f.actions
  end
end
Sequel.migration do
  change do
    create_table(:circles) do
      primary_key :id
      String :name
      Integer :round
      DateTime :created_at
      DateTime :updated_at
    end
  end
end

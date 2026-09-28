Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name
      Integer :round
      foreign_key :circle_id, :circles, index: true
      Integer :level
      Integer :balance, default: -5000
      TrueClass :insider, default: false
      DateTime :created_at
      DateTime :updated_at
    end
  end
end

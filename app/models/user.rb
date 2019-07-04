class User < ApplicationRecord
  enum sex: [:Male, :Female, :Trans]

  validates :first_name, :last_name, :age, :sex, presence: true

  def self.import_by_file_type(file)
    @messages = []
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      create_users_from_import(row)
    end
    @messages
  end

  def self.create_users_from_import(row)
    u = User.new
    u.first_name = row[0]
    u.last_name = row[1]
    u.age = row[2]
    u.sex = row[3]

    @messages << u.errors.full_messages unless u.save
    @messages
  end
end

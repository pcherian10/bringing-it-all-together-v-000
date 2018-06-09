class Dog

  attr_accessor :id, :name, :breed

  def initialize (id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      );
      SQL
      DB[:conn].execute(sql)
  end

  def self.drop_table
      sql = <<-SQL
        DROP TABLE dogs
      SQL
      DB[:conn].execute(sql)
  end

  def self.new_from_db
    id = row[0]
    name = row[1]
    grade = row[2]
    new_dog = self.new(id, name, grade)
  end

  def save
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?,?)
      SQL
      DB[:conn].execute(sql, self.name, self.breed)
      #@id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
  end

  def update
      sql = <<-SQL
        UPDATE dogs
        SET name = ?, breed = ? WHERE id = ?
      SQL
      DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  def self.create (name:, breed:)
    new_dog = self.new(name, breed)
    new_dog.save
    new_dog
  end

end

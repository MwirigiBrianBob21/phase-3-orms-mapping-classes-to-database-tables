class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id:nil)
    @id = id
    @name = name
    @album = album
  end

  def self.create_table
    # writing several strings of code
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

    # #save method as instance method that saves a given instance of
    # the Song class into the songs table of our db.

    def save
      sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
      SQL

      # insert the song
      DB[:conn].execute(sql, self.name, self.album)

      # get the song ID from the database and save it to the Ruby
    # instance
      self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

      # return the Ruby instance
      self
    end

    # keyword arguments
    def self.create(name:, album:)
      song = Song.new(name: name, album: album)
      song.save
    end
  

end

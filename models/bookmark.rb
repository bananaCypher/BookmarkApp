class Bookmark
  # Database settings
  TABLENAME = 'bookmarks'
  DATABASE = 'bookmark'
  HOSTNAME = 'localhost'

  # Class methods
  def self.all
    sql = "SELECT id, name, url, genre FROM #{TABLENAME}"
    run_sql(sql).map { |values| self.new(values) }
  end

  def self.find(id)
    sql = "SELECT id, name, url, genre FROM #{TABLENAME} WHERE id = #{id.to_i}"
    run_sql(sql).map { |values| self.new(values) }.first
  end

  def self.search(term)
    term = sql_string("%#{term}%")
    sql = "SELECT id, name, url, genre FROM #{TABLENAME} WHERE name ILIKE #{term} OR genre ILIKE #{term}"
    run_sql(sql).map { |values| self.new(values) }
  end

  # Object methods
  attr_accessor :name, :url, :genre
  attr_reader :id
  def initialize(values={})
    @id = values['id']
    @name = values['name']
    @url = values['url']
    @genre = values['genre']
  end

  def save
    id = @id.to_i
    name = sql_string(@name)
    url = sql_string(@url)
    genre = sql_string(@genre)

    if @id && self.class.find(id)
      sql = "UPDATE #{TABLENAME} SET (name, url, genre) = (#{name}, #{url}, #{genre}) WHERE id = #{id}"
    else
      sql = "INSERT INTO #{TABLENAME} (name, url, genre) VALUES (#{name}, #{url}, #{genre})"
    end
    run_sql(sql)
  end

  def delete
    if @id && self.class.find(id)
      sql = "DELETE FROM #{TABLENAME} WHERE id = #{@id.to_i}"
      run_sql(sql)
    end
  end

  private
  def self.run_sql(sql)
    db = PG.connect(dbname: DATABASE, host: HOSTNAME)
    result = db.exec(sql)
    db.close
    result
  end

  def run_sql(sql)
    self.class.run_sql(sql)
  end

  def self.sql_string(value)
    "'#{value.to_s.gsub("'", "''")}'"
  end
end
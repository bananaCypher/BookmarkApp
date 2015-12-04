class Genre
  # Database settings
  TABLENAME = 'genres'
  DATABASE = 'bookmark'
  HOSTNAME = 'localhost'

  def self.all
    sql = "SELECT id, name, url, genre FROM #{TABLENAME}"
    run_sql(sql).map { |values| self.new(values) }
  end

  def self.find(id)
    sql = "SELECT id, name, url, genre FROM #{TABLENAME} WHERE id = #{id.to_i}"
    run_sql(sql).map { |values| self.new(values) }.first
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

  def sql_string(value)
    "'#{value.to_s.gsub("'", "''")}'"
  end
end
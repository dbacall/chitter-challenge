require 'pg'

class Message

  attr_reader :id, :message, :time, :username

  def initialize(id, username, message, time)
    @id = id
    @message = message
    @time = time
    @username = username
  end

  def self.add(username, message)
    database_selector

    @connection.exec("INSERT INTO messages(username, message, time) 
    VALUES('#{username}','#{message}', '#{Time.now.strftime("%k:%M:%S on %d/%m/%Y")}')")
  end

  def self.all
    database_selector

    result = @connection.exec("SELECT * FROM messages ORDER BY time DESC;")
    
    result.map { |peep|
      Message.new(peep['id'], peep['username'], peep['message'], peep['time'])
    }
  end

  def self.delete(id)
    database_selector

    @connection.exec("DELETE FROM messages WHERE id='#{id}'")
  end

  def self.get_message(id)
    database_selector

    result = @connection.exec("SELECT * FROM messages WHERE id='#{id}'")

    result[0]['message']
  end

  def self.edit(id, message)
    database_selector

    @connection.exec("UPDATE messages SET message='#{message}' WHERE id='#{id}'")
  end

  def self.database_selector
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'message_database_test')
    else
      @connection = PG.connect(dbname: 'message_database')
    end
  end
  
  private_class_method :database_selector

end

require 'sqlite3'
require 'CSV'


# Parse your CSV file into an acceptable format
# You can also use #read to get immediately into array of arrays

class CSV

	def self.parse(file)
		array_holder = []
		CSV.foreach(file, headers: true) do |year_stats|
			empty_array = []
			empty_array << year_stats['Season'] << year_stats['W_L'] << year_stats['Playoffs']
			array_holder << empty_array
		end
		return array_holder #simple three column setup
	end

end

celtics_array = CSV.parse('celtics.csv')
celtics_array.each do |row|
	row.each_with_index { |element, index|  row[index] = "" if row[index] == nil }
end

# p celtics_array
	


schema = "CREATE TABLE IF NOT EXISTS celtics (
  id INTEGER PRIMARY KEY ASC,
  season CHAR(30),
  w_p CHAR(30),
  playoffs CHAR(30) 
);"

insert = "INSERT INTO celtics (season, w_p, playoffs) VALUES (?,?,?)"
$db = SQLite3::Database.new "celtics.db", results_as_hash: true
$db.execute("#{schema}")

#Populate data via prepared statements
# celtics_array.each do |row|
#   $db.execute("#{insert}", row)
# end











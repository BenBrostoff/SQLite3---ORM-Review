
require 'sqlite3'

module CelticsDB

  def self.db
    db = SQLite3::Database.new "celtics.db", results_as_hash: true
  end

end

class CelticSeason

  include CelticsDB

  attr_accessor :id, :season, :w_p

	def initialize(props = {})
		@id = props['id']
		@season = props['season']
		@w_p = props['w_p']
	end

  def self.where(category, value)
    season = CelticsDB.db.execute("SELECT * from celtics WHERE #{category}", value)
    season_holder = []
    season.each do |unique|
      season_holder << CelticSeason.new(unique)
    end
    season_holder
  end

end


CelticSeason.where("season > ?", "1985-86").each do |season|
  puts season.season + " " + season.w_p
end

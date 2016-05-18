require "yaml"
require_relative 'hangman.rb'

def run
	puts "Type _load_ to load saved game"
	puts "Type any letter to start new game"
	input = gets.chomp.downcase
	if input == "_load_"
		game = loadGame
		runGame(game)
	else
		game = Hangman.new()
		game.loadDictionary()
		game.chooseWordToGuess
		runGame(game)
	end
end

def runGame(game)
	endOfGame = false
	while !endOfGame do
		puts "Guess next letter or guess the password"
		puts "Type _save_ to save the game"
		game.showHistory
		input = gets.chomp.downcase
		if input == "_save_"
			endOfGame = saveGame(game)
		else
			endOfGame = game.play(input)
		end
	end
end

def saveGame(game)
	saveFile = File.new("savegame.txt","w+")
	serialized_object = YAML::dump(game)
	saveFile.puts(serialized_object)
	saveFile.close
	puts " Game was save successfuly! "
	return true
end

def loadGame
	saveFile = File.open("savegame.txt")
	serialized_object = saveFile.read
	game_object = YAML::load(serialized_object)
	puts " Game was loaded successfuly! "
	#puts game_object
	return game_object
end

run()		


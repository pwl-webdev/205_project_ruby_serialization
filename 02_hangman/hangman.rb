require "yaml"

class Hangman
	def initialize
		@dictionary = nil
		@wordToGuess = nil
		@guessHistory = []
		@guessMissed = []
		@noOfRounds = 10
	end

	def loadDictionary
		@dictionary = File.readlines("5desk.txt")
		puts "Dictionary of #{@dictionary.length} entries was loaded successfully !"
	end

	def chooseWordToGuess
		wordChoosen = false
		while !wordChoosen do
			word = @dictionary[Random.rand(@dictionary.length())]
			word = word.chomp.downcase
			if (5...12) === word.length
				wordChoosen = true
				@wordToGuess = word
				(1..@wordToGuess.length).each do
					@guessHistory << "_"
				end
			end
		end
		# puts "Word to Guess selected: #{@wordToGuess}"
	end

	def play(input)
		endOfGame = false
		victory = false
		#while !endOfGame do
		#	showHistory
			if input.length == 1
				checkLetter(input)
				if @guessHistory.join() == @wordToGuess
					endOfGame = true
					victory = true
					puts " You won! The password was: #{@wordToGuess}"
				end
			elsif input == @wordToGuess
				endOfGame = true
				victory = true
				puts " You won! The password was: #{@wordToGuess}"
			end
			if @noOfRounds == 0
				endOfGame = true
				victory = false
				puts " You Lost! The password was: #{@wordToGuess}"
			end
			# puts "Your gess: #{input}  #{input.length} #{@wordToGuess.length}"
			@noOfRounds -= 1
			return endOfGame
		#end
	end

	def checkLetter(input)
		if @wordToGuess.include? input
			@wordToGuess.split("").each_with_index  do |value, key|
				# puts "loop #{key} #{value}"
				if value == input
					# puts "inside _#{@guessHistory[key]}_ _#{input}_"
					@guessHistory[key] = input
				end
			end
		else
			@guessMissed << input
		end
	end

	def showHistory
		@guessHistory.each do |iter|
			print "#{iter} "
		end
		print " | Missed Letters: #{@guessMissed}"
		puts ""
		puts "Rounds to go: #{@noOfRounds}"
	end

	def saveGame
	end

    def serialize
  		YAML::dump(self)
  	end

  	def self.deserialize(yaml_string)
    	YAML::load(yaml_string)
  	end
end

x = Hangman.new
x.loadDictionary
x.chooseWordToGuess
x.play
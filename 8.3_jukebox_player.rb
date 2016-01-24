# ### Problem:
# Design a musical jukebox using object-oriented principles.

# ### Clarification:
# what is this music jukebox and how is it used?
# does it take CD? MP3?
# is it a simulation on a computer? or a physical jukebox player you often see at a billiards?
# does it take cash? credit card? credit? free?
# if it takes cash is it a specific currency or currencies? and does it give back change?

# ### Solution:
# ## Core Objects:
# • Jukebox
# • CD
# • Song
# • Artist
# • Playlist
# • Display (displays details on the screen)

# ## Analyze Relationships:
# • Playlist creation (includes add, delete, and shuffle)
# • CD selector
# • Song selector
# • Queuing up a song
# • Get next song from playlist
# A user also can be introduced:
# • Adding
# • Deleting
# • Credit information
# Each of the main system components translates roughly to an object, and each action translates to a method. Let's walk through one potential design. 

# ## Investigate Actions:
# The Play list manages the current and next songs to play. It is essentially a wrapper class for a queue and offers some additional methods for convenience.

class Jukebox
  attr_reader :play_list, :available_songs, :song_playing

  Songs = [["ACDC", "3:32", "Born to be Wild"],["Red Hot Chili Peppers", "3:37", "By the Way"], ["Adele", "3:30", "Chasing Pavements"]]

  def initialize
    @available_songs = {}
    @play_list = []
    @song_playing = nil
    @credit = 0
    Songs.each.with_index do |song, index|
      artist, time, title = song
      @available_songs[index + 1] = Song.new(artist, time, title)
    end

    player_dashboard
  end

  def menu(option)
    case option
    when "d"
      puts "\n"
      puts "========================== Jukebox Player ============================"
      puts "(a) add credit | (b) browse songs | (p) player | (x) exit".center(70)
      puts "======================================================================"
      puts "available credit: #{@credit}".rjust(70)
      puts "\n"
    when "b"
      puts "\n"
      puts "========================== Jukebox Player ============================"
      puts "(a) add credit | (m) return to menu | (p) player | (x) exit".center(70)
      puts "======================================================================"
      puts "available credit: #{@credit}".rjust(70)
      puts "\n"
    when "p"
      puts "\n"
      puts "========================== Jukebox Player ============================"
      puts "(a) add credit | (m) return to menu | (p) player | (x) exit".center(70)
      puts "------------------------- player control -----------------------------"
      puts "(p) play song | (n) next song | (l) show play list | (d) delete song"
      puts "======================================================================"
      puts "available credit: #{@credit}".rjust(70)
      puts "\n"
      puts "currently playing: #{@song_playing.artist} - #{@song_playing.title}".ljust(70) if @song_playing != nil
      puts "\n"
    end
  end

  def player_dashboard
    menu("d")
    puts "what would you like to do?".center(70)
    puts "\n"

    option = gets.chomp
    case option
    when "a"
      purchase_credit
    when "b"
      browse_songs
    when "p"
      music_player
    when "x"
      puts "\n"
      puts "========== Good bye! ===========".center(70)
      return
    else
      puts "\n"
      puts "please select a valid option".center(70)
      player_dashboard
    end
  end
  
  def purchase_credit
    puts "Enter credits you would like to add - 1 credit for 1 song".center(70)
    puts "\n"
    num = gets.chomp.to_i
    if num == 0
      puts "\n"
      puts "*** Please enter a valid number greater than 1 ***" if num == 0
      purchase_credit
    else
      @credit += num
      puts "*** credit added! ***".center(70)
      player_dashboard
    end
  end

  def browse_songs
    menu("b")
    display_songs
    puts "\n"
    puts "*** Select song number to add to play list ***".center(70)
    option = gets.chomp
    add_song(option.to_i) if option.to_i > 0 

    case option
    when "a"
      purchase_credit
    when "m"
      player_dashboard
    when "p"
      music_player
    when "x"
      puts "\n"
      puts "========== Good bye! ===========".center(70)
      return
    else
      puts "\n"
      puts "please select a valid option".center(70)
      browse_songs
    end
  end

  def display_songs
    @available_songs.each do |number, song|
      puts "(#{number}) #{song.artist} - #{song.title} - #{song.time}"
    end
  end

  def display_play_list
    if @play_list.empty?
      puts "*** There are no songs in the play list ***".center(70)
      music_player
    else
      puts "*********** Play List ************".center(70)
      puts "\n"
      @play_list.each.with_index do |song, index|
        puts "(#{index + 1}) #{song.artist}, #{song.time}, #{song.title}"
      end
      puts "\n"
      puts "*********** End List ************".center(70)
      music_player
    end
  end

  def add_song(key)
    if @available_songs[key]
      song =  @available_songs[key]
    else
      puts "*** please enter a valid song number ***".center(70)
      browse_songs
    end

    if check_credit
      puts "*** song added: #{song.artist} - #{song.title} - #{song.time} ***".center(70)
      @credit -= 1
      @play_list << song
      browse_songs
    else
      puts "*** You have no credit. Please add more ***".center(70)
      browse_songs
    end
  end

  def music_player
    menu("p")

    option = gets.chomp
    add_song(option.to_i) if option.to_i > 0 

    case option
    when "a"
      purchase_credit
    when "m"
      player_dashboard
    when "l"
      display_play_list
    when "p"
      play_song
    when "n"
      play_next
    when "d"
      delete_song
    when "x"
      puts "\n"
      puts "========== Good bye! ===========".center(70)
      return
    else
      puts "\n"
      puts "please select a valid option".center(70)
      music_player
    end
  end

  def check_credit
    @credit > 0 ? true : false
  end

  def delete_song
    puts "=== DELETE SONG ===".center(70)
    puts "pick song number to delete".center(70)
    num = gets.chomp
    index = num.to_i - 1
    @play_list.delete_at(index)
    puts "*** song deleted and refunded credit! ***".center(70)
    @credit += 1  
    music_player
  end

  def play_song
    if @play_list.empty?
      puts "no songs in your play list!"
      music_player
    else
      @song_playing = @play_list.pop
      puts "now playing - #{@song_playing.artist}, #{@song_playing.time}, #{@song_playing.title}"
      music_player
    end
  end

  def play_next
    play_song
  end
end


class Song
  attr_reader :artist, :time, :title

  def initialize(artist, time, title)
    @artist = artist
    @time = time
    @title = title
  end  
end


# ### Sample Output:
player = Jukebox.new

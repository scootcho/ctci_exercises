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
  attr_accessor :play_list, :available_songs, :song_playing

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

  def player_dashboard
    puts "\n"
    puts "(a) add credit | (b) browse songs | (p) player | (x) exit"
    puts "======================================================================"
    puts "what would you like to do?             | available credit: #{@credit}"
    puts "\n\n"

    option = gets.chomp
    case option
    when "a"
      purchase_credit
    when "b"
      browse_songs
    when "p"
      music_player
    when "x"
      puts "Good bye!"
      return
    else
      puts "please select a valid option"
      player_dashboard
    end
  end
  
  def purchase_credit
    puts "Enter credits you would like to add - 1 credit for 1 song"
    num = gets.chomp.to_i
    puts "Please enter a valid number greater than 1" if num == 0
    @credit += num
    puts "** credit added! **"
    player_dashboard
  end

  def browse_songs
    puts "\n"
    puts "(a) add credit | (m) return to menu | (p) player | (x) exit"
    puts "======================================================================"
    puts "Enter song number or other options       | available credit: #{@credit}"
    puts "\n\n"

    display_songs

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
      puts "Good bye!"
      return
    else
      puts "please select a valid option"
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
      puts "There are no songs in the play list"
    else
      puts "========= Play List =========="
      puts "\n"
      @play_list.each.with_index do |song, index|
        puts "(#{index + 1}) #{song.artist}, #{song.time}, #{song.title}"
      end
      puts "\n"
    end
  end

  def add_song(key)
    if @available_songs[key]
      song =  @available_songs[key]
    else
      puts "please enter a valid song number"
      browse_songs
    end

    if check_credit
      puts "*** song added: #{song.artist} - #{song.title} - #{song.time} ***"
      @credit -= 1
      @play_list << song
      browse_songs
    else
      puts "You have no credit left. Please add more"
      browse_songs
    end
  end

  def music_player
    puts "================ JukeBox Player ====================="
    puts "\n"
    puts "(a) add credit | (m) return to menu | (x) exit"
    puts "======================================================================"
    puts "(p) play song | (n) next song | (l) show play list | (d) delete song"
    puts "currently playing: #{@song_playing.artist} - #{@song_playing.title}" if @song_playing != nil
    puts "\n\n"
    display_play_list

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
      puts "Good bye!"
      return
    else
      puts "please select a valid option"
    end

  end

  def check_credit
    @credit > 0 ? true : false
  end

  def delete_song
    puts "pick song number to delete"
    num = gets.chomp
    index = num.to_i - 1
    @play_list.delete_at(index)
    puts "song deleted and refunded credit!"
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

# ...
# (a) add credit | (m) return to menu | (p) player | (x) exit
# ======================================================================
# Enter song number or other options       | available credit: 5
# 
# 
# (1) ACDC - Born to be Wild - 3:32
# (2) Red Hot Chili Peppers - By the Way - 3:37
# (3) Adele - Chasing Pavements - 3:30
# 1
# *** song added: ACDC - Born to be Wild - 3:32 ***
# 
# ...
# ================ JukeBox Player =====================
# 
# (a) add credit | (m) return to menu | (x) exit
# ======================================================================
# (p) play song | (n) next song | (l) show play list | (d) delete song

# currently playing: ACDC - Born to be Wild
# 
# 
# ========= Play List ==========
# 
# (1) ACDC, 3:32, Born to be Wild
# (2) Red Hot Chili Peppers, 3:37, By the Way


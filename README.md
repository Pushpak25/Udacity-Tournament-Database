# Udacity-Tournament-Database

# Getting Started

Vagrant virtual machine is required for this project which you can find here: https://github.com/udacity/fullstack-nanodegree-vm 
First, fork the fullstack-nanodegree-vm repository so that you have a version of your own within your Github account.
Next clone your fullstack-nanodegree-vm repo to your local machine.
<br/>
To use the Vagrant virtual machine, navigate to the full-stack-nanodegree-vm/tournament directory in the terminal, then use the command vagrant up (powers on the virtual machine) followed by vagrant ssh (logs into the virtual machine).  
<br/>
In the command line, first run tournament.sql file to connect to the database and create tables using command
```
$ psql -f tournament.sql
```
<br/>

To run the series of tests defined in this test suite, run the program from the command line 
```
$ python tournament_test.py
```
<br/>
You should be able to see the following output once all your tests have passed:
<br/>
vagrant@vagrant-ubuntu-trusty-32:/vagrant/tournament$ python tournament_test.py
<ol>
<li>Old matches can be deleted.</li>
<li>Player records can be deleted.</li>
<li>After deleting, countPlayers() returns zero.</li>
<li>After registering a player, countPlayers() returns 1.</li>
<li>Players can be registered and deleted.</li>
<li>Newly registered players appear in the standings with no matches.</li>
<li>After a match, players have updated standings.</li>
<li>After one match, players with one win are paired.</li>
</ol>
Success!  All tests pass!
<br/>

# Understanding the purpose of each file

<b>tournament.sql</b>  - this file is used to set up your database schema (the table representation of your data structure).
<br/>
<b>tournament.py</b> - this file is used to provide access to your database via a library of functions which can add, delete or query data in your database to another python program (a client program). Remember that when you define a function, it does not execute, it simply means the function is defined to run a specific set of instructions when called.
<br/>
<b>tournament_test.py</b> - this is a client program which will use your functions written in the tournament.py module. We've written this client program to test your implementation of functions in tournament.py
<br/>
# Functions Used

The various functions in tournament.py and their corresponding test functions in tournament_test.py are:
<html>
<table class="c44"><tbody><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c0 c48 c46">tournament.py </span><span class="c6 c32 c12">function</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c20"><span class="c0 c46 c48">tournament_test.py </span><span class="c6 c12 c32">test function</span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c11">connec</span><span class="c8">t</span></p><p class="c2"><span class="c46 c12">Meant to connect to the database. Already set up for you.</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c20 c27"><span class="c7"></span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c8">deleteMatches </span></p><p class="c2"><span class="c5">Remove all the matches records from the database.</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c20 c27"><span class="c8"></span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c8">deletePlayers</span></p><p class="c2"><span class="c5">Remove all the player records from the database.</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c20 c27"><span class="c8"></span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c8">countPlayers </span></p><p class="c2"><span class="c5">Returns the number of players currently registered</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c2"><span class="c8">testCount</span></p><p class="c20 c27"><span class="c7 c28"></span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c11">registerPlayer -- </span><span class="c5">Adds a player to the tournament database.</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c1"><span class="c8"></span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c8">playerStandings -- </span></p><p class="c2"><span class="c5">Returns a list of the players and their win records, sorted by wins. You can use the player standings table created in your .sql file for reference.</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c20"><span class="c11">testStandingsBeforeMatches</span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c8">reportMatch</span></p><p class="c2"><span class="c5">This is to simply populate the matches table and record the winner and loser as (winner,loser) in the insert statement.</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c20"><span class="c11">testReportMatches</span></p></td></tr><tr class="c21"><td class="c3" colspan="1" rowspan="1"><p class="c2"><span class="c8">swissPairings</span></p><p class="c2"><span class="c4">Returns a list of pairs of players for the next round of a match. Here all we are doing is the pairing of alternate players from the player standings table, zipping them up and appending them to a list with values:</span></p><p class="c2"><span class="c5">(id1, name1, id2, name2)</span></p></td><td class="c37" colspan="1" rowspan="1"><p class="c2"><span class="c8">testPairings</span></p><p class="c20 c27"><span class="c7 c28"></span></p></td></tr></tbody></table>
</html>

# Example of a 16 Player Swiss Tournament:
First round pairing is by random draw. For example, with 16 players they would be matched into 8 random pairs for the first round. For now, assume all games have a winner, and there are no draws.
<br/>
<br/>
<b>After the first round</b>, there will be a group of 8 players with a score of 1 (win), and a group of 8 players with a score of 0 (loss). For the 2nd round, players in each scoring group will be paired against each other – 1’s versus 1’s and 0’s versus 0’s.
<br/>
<br/>
<b>After round 2</b>, there will be three scoring groups:
<br/>
4 players who have won both games and have 2 points
<br/>
8 players who have won a game and lost a game and have 1 point
<br/>
4 players who have lost both games and have no points.
<br/>
<br/>
<b>Again, for round 3</b>, players are paired with players in their scoring group. After the third round, the typical scoring groups will be:
<br/>
2 players who have won 3 games (3 points)
<br/>
6 players with 2 wins (2 points)
<br/>
6 players with 1 win (1 point)
<br/>
2 players with no wins (0 points)
<br/>
<br/>
For the fourth (and in this case final) round, the process repeats, and players are matched with others in their scoring group. Note that there are only 2 players who have won all of their games so far – they will be matched against each other for the "championship" game. After the final round, we’ll have something that looks like this:
<br/>
1 player with 4 points – the winner!
<br/>
4 players with 3 points – tied for second place
<br/>
6 players with 2 points
<br/>
4 players with 1 point
<br/>
1 player with 0 points
<br/>
The Swiss system produces a clear winner in just a few rounds, no-one is eliminated and almost everyone wins at least one game, but there are many ties to deal with.

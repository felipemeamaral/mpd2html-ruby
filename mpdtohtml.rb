###############################################################################
# Copyright (c) <2012> Simon Woker
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# </copyright>
###############################################################################

require 'rubygems'
require 'librmpd'

mpd = MPD.new 'localhost', 6600
mpd.connect

# print HTML header etc.
# print jQuery and jQuery-Tablesorter
# print some CSS
#puts '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
puts '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">'
puts '<head>'
puts '  <meta http-equiv="content-type" content="text/html; charset=utf-8" />'
puts '  <meta name="robots" content="noindex" />'
puts '  <title>My Music</title>'
puts '  <style type="text/css"><!--body {font-family:arial;font-size: 8pt;color: #3D3D3D;}table.tablesorter {background-color: #CDCDCD;margin:10px 0pt 15px;text-align: left;width: 100%;}table.tablesorter thead tr th, table.tablesorter tfoot tr th {background-color: #e6EEEE;border: 1px solid #FFF;font-size: 8pt;padding: 4px;}table.tablesorter thead tr .header {background-image:url(data:image/gif;base64,R0lGODlhFQAJAIAAACMtMP///yH5BAEAAAEALAAAAAAVAAkAAAIXjI+AywnaYnhUMoqt3gZXPmVg94yJVQAAOw%3D%3D);background-repeat: no-repeat;background-position: center right;cursor: pointer;}table.tablesorter tbody td {color: #3D3D3D;padding: 4px;background-color: #FFF;vertical-align: top;}table.tablesorter tbody tr.odd td { background-color:#F0F0F6; }table.tablesorter thead tr .headerSortUp { background-image:url(data:image/gif;base64,R0lGODlhFQAEAIAAACMtMP///yH5BAEAAAEALAAAAAAVAAQAAAINjB+gC+jP2ptn0WskLQA7); }table.tablesorter thead tr .headerSortDown { background-image:url(data:image/gif;base64,R0lGODlhFQAEAIAAACMtMP///yH5BAEAAAEALAAAAAAVAAQAAAINjI8Bya2wnINUMopZAQA7); }table.tablesorter thead tr .headerSortDown, table.tablesorter thead tr .headerSortUp {background-color: #8dbdd8; }--></style>'
puts "</head>"
puts "<body>"
puts '  <script type="text/javascript" src="jquery.min.js"></script>'
puts '  <script type="text/javascript" src="jquery.tablesorter.js"></script>'
puts '  <script type="text/javascript"><!--'
puts '    $(document).ready(function() { $("#music").tablesorter({widgets: ["zebra"] }); } );'
puts '  --></script>'

# print all songs to a table
puts "<h1>My Music</h1>"
puts '<table id="music" class="tablesorter">'
puts "  <thead>"
puts "  <tr>"
puts "     <th>Artist</th>"
puts "     <th>Title</th>"
puts "     <th>Album</th>"
puts "  </tr>"
puts "  </thead>"
puts "  <tbody>"

mpd.songs.each do |song|
  if song.artist and song.title
    puts "  <tr>"
    puts "    <td>#{song.artist}</td>"
    puts "    <td>#{song.title}</td>"
    puts "    <td>#{song.album}</td>"
    puts "  </tr>"
  end
end
puts "</tbody>"
puts "</table>"

# print stats
stats = mpd.stats
puts "<h2>Statistics</h2>"
puts "<ul>"
puts "  <li>Artists: #{stats['artists']}</li>"
puts "  <li>Albums: #{stats['albums']}</li>"
puts "  <li>Songs: #{stats['songs']}</li>"
time = stats['db_playtime'].to_i
puts "  <li>Playtime: #{time/60/60}h #{(time/60)%60}m #{time%60}s</li>"
puts "</ul>"
puts "Generated: #{Time.now.strftime('%H:%M %d.%m.%Y')}";

puts "</body>"
puts "</html>"

mpd.disconnect


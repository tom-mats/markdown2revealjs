require 'optparse'
require 'erb'

erb_slides = <<reveal_slide
<html lang="ja">
<head>
  <meta charset="utf-8">

  <title><%= title %></title>
  <meta name="description" content="<%= description %>">
  <meta name="author" content="<%= author %>">
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui">

  <link rel="stylesheet" href="css/reveal.css">
  <link rel="stylesheet" href="css/theme/<%= theme %>.css" id="theme">

  <!-- Code syntax highlighting -->
  <link rel="stylesheet" href="lib/css/zenburn.css">

  <!-- Printing and PDF exports -->
  <script>
    var link = document.createElement('link');
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.href = window.location.search.match(/print-pdf/gi) ? 'css/print/pdf.css' : 'css/print/paper.css';
    document.getElementsByTagName('head')[0].appendChild(link);
  </script>
</head>
<body>
  <div class = "reveal">
    <div class = "slides">
       <section data-markdown data-separator="^\\n===$" data-separator-vertical="^\\n---$"><script type="text/template">
<%= slide_contents %>
      </script></section>
    </div>
  </div>
	<script src="lib/js/head.min.js"></script>
	<script src="js/reveal.js"></script>
	<script>
		// Full list of configuration options available at:
		// https://github.com/hakimel/reveal.js#configuration
		Reveal.initialize({
			controls: true,
			progress: true,
			history: true,
			center: true,
			transition: '<%= transition %>', // none/fade/slide/convex/concave/zoom
			// Optional reveal.js plugins
  		dependencies: [
  			{ src: 'lib/js/classList.js', condition: function() { return !document.body.classList; } },
  			{ src: 'plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
  			{ src: 'plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
  			{ src: 'plugin/highlight/highlight.js', async: true, condition: function() { return !!document.querySelector( 'pre code' ); }, callback: function() { hljs.initHighlightingOnLoad(); } },
  			{ src: 'plugin/zoom-js/zoom.js', async: true },
  			{ src: 'plugin/notes/notes.js', async: true }
  		]
  	});
  </script>
</body>
</html>
reveal_slide
def parse_attribute(line)
  line
end

title = "test"
author = "hoge"
description = "huga"
opts = ARGV.getopts("i:o:", "width:960", "height:700", "theme:black", "transition:slide")
opts["o"] = "index.html" unless opts["o"]
opts["i"] = "index.md" unless opts["i"]
width = opts["width"]
height = opts["height"]
theme = opts["theme"]
transition = opts["transition"]

markdown_fp  = File.open(opts["i"])
html_fp = File.open(opts["o"], "w")
slide_data = Array.new()
current_slide_depth = 0
next_slide_depth = 0
is_first_page = true
while line = markdown_fp.gets
  if slide_data.size > 0
    case line
    when /^===+$/ then
      slide_data.insert(-2, "\n===\n\n") if is_first_page == false
      is_first_page = false
    when /^---+$/ then
      slide_data.insert(-2, "\n---\n\n") if is_first_page == false
      is_first_page = false
    end
  end
  slide_data.push(parse_attribute(line))
end

slide_contents = slide_data.join("")
erb_data  = ERB.new(erb_slides)
html_fp << erb_data.result(binding)
markdown_fp.close
html_fp.close
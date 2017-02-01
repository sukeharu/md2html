require "kramdown"

# parameters
source = ARGV[0]
output = ARGV[1]

#template
template = <<EOS
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Compiled from #{source}</title>
</head>
<body>
<!-- Document starts here -->

<%= @body %>

<!-- Document ends here -->
</body>
</html>
EOS

begin
	File.open("tmpl.tpl", "w"){|ff| ff.write template}
	File.open(ARGV[0]) do |file|
		doc = file.read
		html_str = Kramdown::Document.new(doc, :template=>"tmpl.tpl").to_html
		File.open(ARGV[1], "w") {|ff| ff.write html_str}
		File.unlink("tmpl.tpl")
	end

    # exception
    rescue SystemCallError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
    rescue IOError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
end

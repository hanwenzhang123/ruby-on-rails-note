Layouts

#in view
name: admin.html.erb
<%= yield %/>

#in controller
layout "admin"

Partials
name: _form.html.erb
# <%= render(:partial => "form", :locals => {:f => f}) %/>  #local variable


Text helps
word_wrap() - process or breaking a section of text into lines
simple_format() - using \n for break line
turncate() - continue with ...
turncate_words()
highlight()
excerpt()
pluralize()
# <%= [0, 1, 2].each do |n| %/>
#   <%= pluralize(n, "product") %> found. <br />
# <%= end %/>


Number Helpers
number_to_currency
number_to_percentage

:delimiter - delimits thousands; default is ","
:seperator - decimal separator; default "."
:precision - decimal place to show 
  
  
Date and Time Helpers
Time.now + 30.days - 30.minutes
Time.now - 30.days => 30.days.ago
Time.now + 30.days => 30.days.from_now
  
beginning_of_month
last_week
end_of_day
tomorrow
next_year
Time.now.last_year.end_of_month.beginning_of_day
  
DateTime Formatting
datetime.strftime(format_string)
Time.now.strftime("%B %d, %Y %H:%M")
datetime.to_s(format_symbol)
Time.now.to_s(:long)

  
Custom Helpers
- ruby modules
- created when generating a controller
  must have corresponding file name and module name
  available helper methods in view templates
Custom Helpers
- useful for frequently used code
  strong complex code simplify view templates
  writing large section of ruby code
  
  
Sanitization Helpers
- for the sake of XSS, undesirable HTML, escape all user-entered data
html_escape()
h()
raw()
string.html_safe
strip_links(html)
strip_tags(html)
sanitize(html, options)
  
  
#Quiz
The _____ method escapes all of the HTML tags in a string. h()
In formatting, %A is the full weekday name.
Which of the following are correct about number helpers? :delimiter defaults to comma, number_to_human is a helper, precision is about decimal places to show
For word_wrap, what is the line_width by default? 80
Partials are named with an _____ at the start. _
You should use _____ to allow the template content to be dropped into a specific spot in the layout. yield
  
  
  

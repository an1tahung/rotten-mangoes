module MoviesHelper
  def formatted_date(date)
    date.strftime("%b %d, %Y")
  end

  def duration_options
    @options = 
    [
      ["---",0],
      ["Under 90 minutes",1],
      ["Between 90 and 120 minutes",2],
      ["Over 120 minutes",3]
    ]  
  end
end

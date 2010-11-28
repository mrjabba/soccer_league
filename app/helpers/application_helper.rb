module ApplicationHelper

  def logo
#	base_logo = image_tag("logo.png", :alt => "Soccer_League", :class => "round") 
	base_logo = image_tag("soccer_icon.png", :alt => "Soccer_League", :class => "top_logo") 
	#if @logo.nil?
	#	base_logo
	#end


  end

#  def setup_league(league)
    #deprecated, look up tap
#    returning(league) do |lg|
 #     lg.teamstats.build if lg.teamstats.empty?
 #   end
 # end

  # Return a title on a per-page basis.
  def title
    base_title = "Soccer_League Manager"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end

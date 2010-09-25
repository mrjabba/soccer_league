module ApplicationHelper

  def logo
	base_logo = image_tag("logo.png", :alt => "Soccer_League", :class => "round") 
	if @logo.nil?
		base_logo
	end

  end

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

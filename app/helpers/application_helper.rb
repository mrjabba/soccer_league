module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), :class => css_class
  end

  def full_path_no_locale
    return "" if request.fullpath == root_path
    request.fullpath.to_s[3..-1] if locale.size == 2
    request.fullpath.to_s[6..-1] if locale.size == 5
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

  def header_title(content)
    content_tag(:header, content_tag(:h1, content))
  end

  def zone_cell_at_position(zones, position)
    zone = Leaguezone.find_zone_by_position(zones, position)
    zone.nil? ? content_tag(:td, position) : content_tag(:td, position, {:class => zone.style, :title => zone.name})
  end
end

class ReverseLinkRenderer < WillPaginate::ActionView::LinkRenderer

  # Reverses pagination links
  def to_html
    html = pagination.reverse.map do |item|
      item.is_a?(Fixnum) ?
        page_number(item) :
        send(item)
    end.join(@options[:link_separator])

    @options[:container] ? html_container(html) : html
  end

end

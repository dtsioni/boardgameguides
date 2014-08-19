module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Boardgame Guides"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  #markdown
  def markdown(text)
    def markdown(blogtext)
      renderOptions = {hard_wrap: true, filter_html: true}
      markdownOptions = {autolink: true, no_intra_emphasis: true, strikethrough: true }
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(renderOptions), markdownOptions)
      markdown.render(blogtext).html_safe
   end
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end

end
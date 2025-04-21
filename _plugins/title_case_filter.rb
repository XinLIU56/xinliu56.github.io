# _plugins/title_case_filter.rb
module Jekyll
  module TitleCaseFilter
    def title_case(input)
      input.split(" ").map(&:capitalize).join(" ")
    end
  end
end

Liquid::Template.register_filter(Jekyll::TitleCaseFilter)

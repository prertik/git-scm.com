# frozen_string_literal: true

module DocHelper
  def man(name, text = nil)
    if @language && @language != "en"
      link_to text || name.gsub(/^git-/, ""), doc_file_path(file: name) + "/#{@language}",
              class: ("active" if @name == name)
    else
      link_to text || name.gsub(/^git-/, ""), doc_file_path(file: name), class: ("active" if @name == name)
    end
  end
end

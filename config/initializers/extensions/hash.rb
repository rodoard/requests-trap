class Hash
  def to_pretty_raw_json
    JSON.pretty_generate(self).gsub(/\s*{/, '{').gsub(" ","&nbsp;").to_s.html_safe
  end
end
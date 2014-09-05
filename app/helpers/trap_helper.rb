module TrapHelper
  def to_pretty_json(hash)
    raw JSON.pretty_generate(hash).gsub(/\s*{/, '{').gsub(" ","&nbsp;")
  end
end

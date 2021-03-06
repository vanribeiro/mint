class String
  def uncolorize
    gsub(/[ \t]+$/m, "")
      .gsub(/\e\[(\d+;?)*m/, "")
      .rstrip
  end

  def last
    return "" if size == 0
    self[size - 1].to_s
  end

  def indent(spaces : Int32 = 2)
    lines.map do |line|
      line.empty? ? line : (" " * spaces) + line
    end.join("\n")
  end

  def remove_all_leading_whitespace
    lines
      .map(&.lstrip(" \t"))
      .join("\n")
  end

  def remove_leading_whitespace
    # Count the leading whitespace in each line
    count =
      lines
        .reject(&.strip.empty?)
        .map(&.leading_whitespace_count)
        .compact
        .min? || 0

    # Remove the minimum count of lines
    lines
      .map { |line| line.lchop(line[0, count]) }
      .join("\n")
      .strip("\n\r")
  end

  def leading_whitespace_count
    i = 0
    begin
      while self[i].in_set?(" \n\r\t")
        i += 1
      end
    rescue IndexError
    end
    i
  end

  def remove_trailing_whitespace
    lines
      .map(&.rstrip)
      .join("\n")
  end
end

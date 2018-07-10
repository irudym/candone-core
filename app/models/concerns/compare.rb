module Compare
  def compare(a, b)
    a.size == b.size && a & b == a
  end
end
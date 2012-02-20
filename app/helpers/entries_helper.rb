module EntriesHelper
  
  def mask_number(number)
    number.to_s.size < 5 ? number.to_s : (('*' * number.to_s[0..-5].length) + number.to_s[-4..-1])
  end
end

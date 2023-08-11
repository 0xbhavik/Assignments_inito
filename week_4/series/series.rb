

def calc_string_from_num(num)
    str = ""
    ('A'..'Z').reverse_each do |letter|
        
        break if num == 0
        letter_val = calc_num_from_letter(letter)
       
        if num >= letter_val 
            times = (num/letter_val)
            str += (letter*times)
            num = (num%letter_val)
        end  
    end
    str
end

def calc_num_from_letter(letter)

  i = 2
  val = 1

  ('B'..letter).each do |char|
      val = (val*2) + i
      i+=1
  end

  val
end


def calc_num_from_string(text)

   ans = 0
   text.each_char do |letter|
    ans += calc_num_from_letter(letter)
   end
   ans
end



class TitleBracketsValidator < ActiveModel::Validator
  def self.say_hello
    puts "Hello it's the brackets validator"
  end

  def validate(record)
    unless parentheses_balanced?(record.title)
      record.errors[:base] << "Parentheses are not balanced"
    end
  end

  def parentheses_balanced?(text)
    brackets_stack = []
    text.split('').each do |char|
      # if is_closing?(brackets_stack.last, char)
      #   brackets_stack.pop
      # else
      #   brackets_stack.push if is_a_bracket?(char)
      # end
      if is_an_opener?(char)
        brackets_stack.push(char)
      elsif is_a_closer?(char)
        if is_closing?(brackets_stack.last, char)
          brackets_stack.pop
        else
          brackets_stack.push(char)
        end
      end
    end
    brackets_stack.empty?
  end

  @@pairs = {'(' => ')', '[' => ']', '{' => '}'}

  def is_a_bracket?(symbol)
    @@pairs.keys.include?(symbol) || @@pairs.values.include?(symbol)
  end

  def is_an_opener?(symbol)
    @@pairs.keys.include?(symbol)
  end

  def is_a_closer?(symbol)
    @@pairs.values.include?(symbol)
  end

  def is_closing?(opening, closing)
    @@pairs[opening] == closing
  end
end

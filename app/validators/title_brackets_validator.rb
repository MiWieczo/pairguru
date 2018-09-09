class TitleBracketsValidator < ActiveModel::Validator
  def self.say_hello
    puts "Hello, it's the brackets validator!"
  end

  def validate(record)
    record.errors[:base] << "Brackets are not balanced!" unless brackets_balanced?(record.title)
    record.errors[:base] << "There is an empty bracket!" unless brackets_not_empty?(record.title)
  end

  def brackets_balanced?(text)
    pairs = {'(' => ')', '[' => ']', '{' => '}'}
    left = pairs.keys
    right = pairs.values
    stack = []
    text.split('').each do |char|
      if left.include?(char)
        stack << char
      elsif right.include?(char)
        return false if stack.empty? || (pairs[stack.pop] != char)
      end
    end
    stack.empty?
  end

  def brackets_not_empty?(text)
    brackets = %w[ () [] {} ]
    brackets.none? { |b| text.include?(b) }
  end
end

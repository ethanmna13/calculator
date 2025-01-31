# frozen_string_literal: true

# this lets user calculate with basic operations
class BasicCalculator
  def initialize(number1, number2)
    raise ArgumentError, 'Arguments should be numbers.' unless number1.is_a?(Integer) && number2.is_a?(Integer)

    @number1 = number1
    @number2 = number2
  end

  def add
    @number1 + @number2
  end

  def subtract
    @number1 - @number2
  end

  def multiply
    @number1 * @number2
  end

  def divide
    return 'Division by zero is not allowed' if @number2.zero?

    @number1.to_f / @number2
  end
end

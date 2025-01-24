class Calculator
  def main_menu
    puts 'Welcome to the Calculator App!'
    puts 'What would you like to do?'
    puts '1. Addition | 2. Subtraction | 3. Multiplication'
    puts '4. Division | 5. Custom Equation | 6. Exit'
    response = gets.chomp.to_i
    choose_operation(response)
  end

  def choose_operation(response)
    case response
    when 1 then addition
    when 2 then subtraction
    when 3 then multiplication
    when 4 then division
    when 5 then custom_eq
    when 6 then goodbye
    else puts 'Please input a valid option from the menu.'
         main_menu
    end
  end

  def addition
    calculate('Enter two numbers to add:', :+)
  end

  def subtraction
    calculate('Enter two numbers to subtract:', :-)
  end

  def multiplication
    calculate('Enter two numbers to multiply:', :*)
  end

  def division
    calculate('Enter two numbers to divide:', :/)
  end

  def calculate(message, operator)
    puts message
    number1, number2 = input_numbers
    if number2.to_f.zero? && operator == :/
      puts 'Undefined'
      try_again { calculate(message, operator) }
    end
    puts "#{number1} #{operator} #{number2} = #{number1.to_f.send(operator, number2.to_f)}"
    try_again { calculate(message, operator) }
  end

  def custom_eq
    puts 'Enter a numerical equation: '
    equation = gets.chomp
    puts "Result = #{calculate_custom(equation)}"
    try_again { custom_eq }
  end

  def calculate_custom(expression)
    tokens = expression.scan(%r{\d+|[+\-*/]})
    numbers = []
    operators = []
    tokens.each { |t| process_token(t, numbers, operators) }
    compute(numbers, operators) while operators.any?
    numbers.last
  end

  def process_token(token, numbers, operators)
    priority = { '+' => 1, '-' => 1, '*' => 2, '/' => 2 }
    if token =~ /\d+/
      numbers << token.to_f
    else
      while operators.any? && priority[operators.last] >= priority[token]
        compute(numbers, operators)
      end
      operators << token
    end
  end

  def compute(numbers, operators)
    a = numbers.pop
    b = numbers.pop
    numbers << b.send(operators.pop, a)
  end

  def input_numbers
    number1 = gets.chomp
    number2 = gets.chomp
    unless valid_numbers?(number1, number2)
      puts 'Please enter valid numbers only.'
      return input_numbers
    end
    [number1, number2]
  end

  def valid_numbers?(number1, number2)
    number1.match?(/^-?\d+(\.\d+)?$/) && number2.match?(/^-?\d+(\.\d+)?$/)
  end

  def try_again
    loop do
      puts 'Would you like to use this function again? (Y/N): '
      response = gets.chomp.upcase
      case response
      when 'Y' then yield
      when 'N' then main_menu
      else puts 'Please enter Y or N only.'
      end
    end
  end

  def goodbye
    puts 'Goodbye!'
    exit
  end
end

calc = Calculator.new
calc.main_menu

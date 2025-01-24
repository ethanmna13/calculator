# this is a calculator
class Calculator
  def main_menu
    puts 'Welcome to the Calculator App!'
    puts '1. Addition'
    puts '2. Subtraction'
    puts '3. Multiplication'
    puts '4. Division'
    puts '5. Custom Equation'
    puts '6. Exit'
    puts 'Enter number: '
    response = gets.chomp.to_i
    choose_operation(response)
  end

  def choose_operation(response)
    case response
    when 1
      addition
    when 2
      subtraction
    when 3
      multiplication
    when 4
      division
    when 5
      custom_eq
    when 6
      puts 'Goodbye!'
      exit
    else
      puts 'Please input a valid option.'
      main_menu
    end
  end

  def addition
    puts 'Enter two numbers to be added:'
    @n1 = gets.chomp
    @n2 = gets.chomp
    if @n1 =~ /^-?[0-9]+$/ && @n2 =~ /^-?[0-9]+$/
      answer = @n1.to_i + @n2.to_i
      puts "#{@n1} + #{@n2} = #{answer}"
    else
      puts 'Please enter numbers only.'
      addition
    end
    puts 'Would you like to use this function again again? (Y/N): '
    response = gets.chomp
    while response
      case response.upcase
      when 'Y'
        addition
      when 'N'
        main_menu
      else puts 'Please enter Y or N only:'
      end
    end
  end

  def subtraction
    puts 'Enter two numbers to be subtracted:'
    @n1 = gets.chomp
    @n2 = gets.chomp
    if @n1 =~ /^-?[0-9]+$/ && @n2 =~ /^-?[0-9]+$/
      answer = @n1.to_i - @n2.to_i
      puts "#{@n1} - #{@n2} = #{answer}"
    else 
      puts 'Please enter numbers only.'
      subtraction
    end
    puts 'Would you like to use this function again again? (Y/N): '
    response = gets.chomp
    while response
      case response.upcase
      when 'Y'
        subtraction
      when 'N'
        main_menu
      else puts 'Please enter Y or N only:'
      end
    end
  end

  def multiplication
    puts 'Enter two numbers to be multiplied:'
    @n1 = gets.chomp
    @n2 = gets.chomp
    if @n1 =~ /^-?[0-9]+$/ && @n2 =~ /^-?[0-9]+$/
      answer = @n1.to_i * @n2.to_i
      puts "#{@n1} * #{@n2} = #{answer}"
    else
      puts 'Please enter numbers only.'
      multiplication
    end
    puts 'Would you like to use this function again again? (Y/N): '
    response = gets.chomp
    while response
      case response.upcase
      when 'Y'
        multiplication
      when 'N'
        main_menu
      else puts 'Please enter Y or N only:'
      end
    end
  end

  def division
    puts 'Enter two numbers to be added:'
    @n1 = gets.chomp
    @n2 = gets.chomp
    if @n1 =~ /^-?[0-9]+$/ && @n2 =~ /^-?[0-9]+$/
      answer = @n1.to_f / @n2
      puts "#{@n1} / #{@n2} = #{answer.round(2)}"
    else
      puts 'Please enter numbers only.'
      division
    end
    puts 'Would you like to use this function again again? (Y/N): '
    response = gets.chomp
    while response
      case response.upcase
      when 'Y'
        division
      when 'N'
        main_menu
      else puts 'Please enter Y or N only:'
      end
    end
  end

  def calculate(expression)
    tokens = expression.scan(%r/\d+|\+\-\*\//)
    numbers = []
    operators = []
    priority = { '+' => 1, '-' => 1, '*' => 2, '/' => 2 }

    tokens.each do |token|
      if token =~ /\d+/
        numbers << token.to_f
      elsif token =~ %r/{\+\-\*\/}/
        while operators.any? && priority[operators.last] >= priority[token]
          compute(numbers, operators)
        end
        operators << token
      end
    end
    compute(numbers, operators) while operators.any?
    numbers.last
  end

  def compute(numbers, operators)
    b = numbers.pop
    a = numbers.pop
    operator = operators.pop
    numbers << a.send(operator, b)
  end

  def custom_eq
    puts 'Enter a numerical equation: '
    equation = gets.chomp
    puts " = #{calculate(equation)}"
    puts 'Would you like to use this function again again? (Y/N): '
    response = gets.chomp
    while response
      case response.upcase
      when 'Y'
        custom_eq
      when 'N'
        main_menu
      else puts 'Please enter Y or N only:'
      end
    end
  end
  main_menu
end

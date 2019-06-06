class UtilityHelper
  def notify_success
    puts 'Success!'
    puts ''
  end

  def yes_or_no
    loop do
      y_n = $prompt.ask('(y/n):')
      if y_n == 'y'
        return true
      elsif y_n == 'n'
        return false
      else
        puts "Enter y or n"
      end
    end
  end
end
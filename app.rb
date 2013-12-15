$: << Dir.pwd
require 'processor'

@hash0 = { [2,1] => 1, [3,2] => 1, [1,3] => 1, [2,3] => 1, [3,3] => 1,
           [20, 20] => 1, [20, 21] => 1, [21, 20] => 1, [21, 21] => 1,
           [22, 22] => 1, [23, 22] => 1, [22, 23] => 1, [23, 23] => 1}
processor = Processor.new(@hash0)

loop do
  system('clear')
  processor.next_gen!
  processor.vizualize(40, 40)
  sleep(0.1)
end
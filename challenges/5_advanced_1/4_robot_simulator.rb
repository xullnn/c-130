# - only right, left, advance, no backwards
# - placed on coordinates increasing towards north-east(up and right)
# - the state of it contain:
#   - position
#   - facing direction
#   - its initial state didin't tell
#
# Algorithm
#   keep a pointer towards the 4 directions
#   directions {12 => :north, 3 => :east, 6 => :south, 9 => :west}
#   every robot keep a orien_num like: 12, 3
#     - turn left (orien_num - 3) % 12
#     - turn right opposite
#   if given direct orientation
#     - hash.key(given_orien)
#   use orien_num to retrieve the state
#
#   moving at x or y
#     - first need to check orientation
#       - if 12 no x, positive y
#       - if 3 pos x, pos y
#       ...
#
#

class Robot
  VALID_DIR = { 12 => :north, 6 => :south, 9 => :west, 3 => :east }

  def orient(dir)
    raise ArgumentError if !VALID_DIR.values.include?(dir)
    @orien_num = VALID_DIR.key(dir)
  end

  def bearing
    VALID_DIR[@orien_num]
  end

  def turn_right
    @orien_num + 3 == 15 ? @orien_num = 3 : @orien_num += 3
  end

  def turn_left
    @orien_num - 3 == 0 ? @orien_num = 12 : @orien_num -= 3
  end

  def at(x, y)
    @x, @y = x, y
  end

  def coordinates
    [@x, @y]
  end

  def advance
    case @orien_num
    when 12 then @y += 1
    when 3 then @x += 1
    when 6 then @y -= 1
    when 9 then @x -= 1
    end
  end
end

# Simulator
#   - instruction: turn stirng to an array of commands(orient or advance)
#   - place: accepts 4 arguments, set the state of the given robot
#     - a robot obj
#     - x and y
#     - dir
#   - evaluate: accepts
#     - a robot(has state already)
#     - a string of commands
#     - execute all the commands

class Simulator
  VALID_INS = { 'L' => :turn_left, 'R' => :turn_right, 'A' => :advance }

  def instructions(ins)
    raise ArgumentError if ins.match(/[^ALR]/)
    ins.chars.map do |abbrev|
      VALID_INS[abbrev]
    end
  end

  def place(robot, states)
    robot.at(states[:x], states[:y])
    robot.orient(states[:direction])
  end

  def evaluate(robot, ins)
    commands = instructions(ins)
    commands.each { |command| robot.send(command) }
  end
end

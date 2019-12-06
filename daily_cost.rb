require 'date'

# daily, weekly, monthly
PERIOD_COUNT = 3.freeze
ALL_TIME_PERIODS = %w(daily weekly monthly)

# Calculate number of days in the month including specific date
def days_in_month(year, month)
  (Date.new(year, 12, 31) << (12 - month)).day
end

# Calculate daily cost from start_date to end_date
def daily_cost(start_date, end_date, time_period_costs)
  # Calculate sum of costs based on daily, weekly, and monthly
  period_costs = time_period_costs.reduce(Array.new(PERIOD_COUNT, 0)) do |res, time_period_cost|
    (0..PERIOD_COUNT - 1).each do |i|
      res[i] = (ALL_TIME_PERIODS[i] == time_period_cost[:time_period]) ? res[i] + time_period_cost[:cost] : res[i]
    end
    res
  end

  # Calculate sum of daily costs regarding daily and weekly.
  daily_weekly_sum = period_costs[0] + period_costs[1] / 7

  results = Array.new

  (start_date..end_date).map do |cur|
    days = days_in_month cur.year, cur.month
    results.push({
      date: cur.strftime("%a, %d %b %Y"),
      cost: daily_weekly_sum + period_costs[2] / days
    })
  end
  results
end

# input date range
start_date = Date.new(2019, 9, 29)
end_date = Date.new(2019, 10, 3)

# input costs in time_period
time_period_costs = [
  {
    time_period: "daily", # daily
    cost: 10.0
  },
  {
    time_period: "weekly", # weekly
    cost: 70.0
  },
  {
    time_period: "monthly",
    cost: 31*30
  },
  {
    time_period: "daily",
    cost: 5.0
  }
]

puts daily_cost(start_date, end_date, time_period_costs).inspect
describe "days_in_month" do
  it "should return number of days in month" do
    expect(days_in_month 2019, 4).to eq 30
  end
end

describe "daily_cost" do
  before(:each) do
    @start_date = Date.new(2019, 9, 29)
    @end_date = Date.new(2019, 10, 3)
    @time_period_costs = [
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
    @result = [{date: "Sun, 29 Sep 2019", cost: 56.0}, {date: "Mon, 30 Sep 2019", cost: 56.0},
      {date: "Tue, 01 Oct 2019", cost: 55.0}, {date: "Wed, 02 Oct 2019", cost: 55.0}, {date: "Thu, 03 Oct 2019", cost: 55.0}]
  end

  it "should return correct result" do
    expect(daily_cost(@start_date, @end_date, @time_period_costs)).to match_array(@result)
  end
end
########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.

# Q: Which layers are nested in each other?
# The file contains data about 11 different rides;
# each ride has the following information:
# driver_id, date, cost, rider_id, and rating (presumably 1-5)
# Each individual ride has the ride info (driver, date, etc) nested in it

# Q: Which layers of data "have" within it a different layer?
# Rides includes layers of individual rides

# Q: Which layers are "next" to each other?
# Individual ride data are next to each other
# (ex. driver_id, date, cost, rider_id, rating are all on the same level)

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have
#
# 1. Outermost layer --> Hash with key called ":rides"
# 2. Rides key has array value
# 3. Rides array value contains hash for each individual ride,
#    including driver_id, date, cost, rider_id, rating as keys

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

ride_share_data = {
    rides: [
        {
            driver_id: 'DR0004',
            date: '3rd Feb 2016',
            cost: 5,
            rider_id: 'RD0022',
            rating: 5
        },
        {
            driver_id: 'DR0001',
            date: '3rd Feb 2016',
            cost: 10,
            rider_id: 'RD0003',
            rating: 3
        },
        {
            driver_id: 'DR0002',
            date: '3rd Feb 2016',
            cost: 25,
            rider_id: 'RD0073',
            rating: 5
        },
        {
            driver_id: 'DR0001',
            date: '3rd Feb 2016',
            cost: 30,
            rider_id: 'RD0015',
            rating: 4
        },
        {
            driver_id: 'DR0003',
            date: '4th Feb 2016',
            cost: 5,
            rider_id: 'RD0066',
            rating: 5
        },
        {
            driver_id: 'DR0004',
            date: '4th Feb 2016',
            cost: 10,
            rider_id: 'RD0022',
            rating: 4
        },
        {
            driver_id: 'DR0002',
            date: '4th Feb 2016',
            cost: 15,
            rider_id: 'RD0013',
            rating: 1
        },
        {
            driver_id: 'DR0003',
            date: '5th Feb 2016',
            cost: 50,
            rider_id: 'RD0003',
            rating: 2
        },
        {
            driver_id: 'DR0002',
            date: '5th Feb 2016',
            cost: 35,
            rider_id: 'RD0066',
            rating: 3
        },
        {
            driver_id: 'DR0004',
            date: '5th Feb 2016',
            cost: 20,
            rider_id: 'RD0073',
            rating: 5
        },
        {
            driver_id: 'DR0001',
            date: '5th Feb 2016',
            cost: 45,
            rider_id: 'RD0003',
            rating: 2
        }
    ]
}

########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# - the number of rides each driver has given
def num_rides(structured_data)
  driver_ride_count = {}
  structured_data[:rides].each do |ride|
    if driver_ride_count.include?(ride[:driver_id])
      driver_ride_count[ride[:driver_id]] += 1
    else
      driver_ride_count[ride[:driver_id]] = 1
    end
  end
  return driver_ride_count
end

p "Number of rides completed per driver:"
p num_rides(ride_share_data)


# - the total amount of money each driver has made
def driver_earnings(structured_data)
  earnings = {}
  structured_data[:rides].each do |ride|
    if earnings.include?(ride[:driver_id])
      earnings[ride[:driver_id]] += ride[:cost]
    else
      earnings[ride[:driver_id]] = ride[:cost]
    end
  end
  return earnings
end

p "Total cost per driver:"
p driver_earnings(ride_share_data)


# - the average rating for each driver
def average_rating(structured_data)
  avg_driver_ratings = {}

  structured_data[:rides].each do |ride|
    if avg_driver_ratings.include?(ride[:driver_id])
      avg_driver_ratings[ride[:driver_id]] << ride[:rating].to_f
    else
      avg_driver_ratings[ride[:driver_id]] = [ride[:rating].to_f]
    end
  end

  avg_driver_ratings.each do |driver_id, ratings|
    avg_driver_ratings[driver_id] = (ratings.sum / ratings.size).round(1)
  end

  return avg_driver_ratings
end

p "Average rating per driver:"
p average_rating(ride_share_data)


# - Which driver made the most money?
def max_earner(structured_data)
  earnings = driver_earnings(structured_data)
  max_earnings = earnings.values.max

  if earnings.values.count(max_earnings) > 1
    max_earner = (earnings.map { |driver, earnings| driver if earnings == max_earnings }).compact
  else
    max_earner = earnings.key(max_earnings)
  end

  return max_earner
end

p "Max earning driver(s):"
p max_earner(ride_share_data)


# - Which driver has the highest average rating?
def highest_rated(structured_data)
  ratings = average_rating(structured_data)
  highest_rating = ratings.values.max

  if ratings.values.count(highest_rating) > 1
    highest_rated_driver = (ratings.map { |driver, avg_rating| driver if avg_rating == highest_rating }).compact
  else
    highest_rated_driver = ratings.key(highest_rating)
  end

  return highest_rated_driver
end

p "Highest rated driver(s):"
p highest_rated(ride_share_data)


# - For each driver, on which day did they make the most money?
def highest_earning_day(structured_data)
  driver_earnings_per_day = {}
  structured_data[:rides].each do |ride|
    if driver_earnings_per_day.include?(ride[:driver_id])
      if driver_earnings_per_day[ride[:driver_id]].include?(ride[:date])
        driver_earnings_per_day[ride[:driver_id]][ride[:date]] += ride[:cost]
      else
        driver_earnings_per_day[ride[:driver_id]][ride[:date]] = ride[:cost]
      end
    else
      driver_earnings_per_day[ride[:driver_id]] = { ride[:date] => ride[:cost] }
    end
  end

  highest_earning_days = {}
  driver_earnings_per_day.each do |driver, earnings|
    max_earnings = earnings.values.max
    highest_earning_days[driver] = (earnings.select { |day, earned| earned == max_earnings }).keys
  end

  return highest_earning_days
end


p "Highest earning day(s) per driver:"
p highest_earning_day(ride_share_data)

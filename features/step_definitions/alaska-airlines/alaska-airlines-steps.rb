require 'selenium-cucumber'
require 'selenium-webdriver'
require 'rubygems'
require 'rspec'

Given(/^User opens the airlines page$/) do
  # @search_page = SearchPage.new($browser)
  # @search_page.visit_airline_site
  $driver.navigate.to 'https://www.alaskaair.com/'
end

When(/^User enters these search parameters$/) do |table|
  @data = table.raw
  from = @data[0][1]
  to = @data[1][1]
  departure_date = @data[2][1]
  return_date = @data[3][1]
  adults = @data[4][1]
  children = @data[5][1]

  # @search_page.from_field.wait_until(&:present?)
  # @search_page.enter_from_field(from)
  # @search_page.enter_to_field(to)
  # @search_page.enter_departure_date(departure_date)
  # @search_page.enter_return_date(return_date)
  # @search_page.click_find_flights_button

  $driver.find_element(:id, 'fromCity1').send_keys from
  $driver.find_element(:id, 'fromCity1').click

  $driver.find_element(:id, 'toCity1').send_keys to
  $driver.find_element(:id, 'toCity1').click

  $driver.find_element(:id, 'departureDate1').clear
  $driver.find_element(:id, 'departureDate1').send_keys departure_date

  if departure_date == 'NO'
    $driver.find_element(:id, 'oneWay').click
  else
    $driver.find_element(:id, 'returnDate').clear
    $driver.find_element(:id, 'returnDate').send_keys return_date
  end

  if adults > 1
    $driver.find_element(:id, 'adultCount').find_element(:css, "option[value='#{adults}']").click
  end

  if children != 0
    i = 0
    while i < children
      $driver.find_element(:id, 'childrenCountDropDown').find_element(:id, 'infantPlus').click
      i += 1
    end
  end

  $driver.find_element(:id, 'findFlights').click
end

Then(/^User sees (.*) search results$/) do |results|
  array = $driver.find_elements(:css, '#ContinueButton')
  case results
  when 'several'
    expect(array.size).to be > 0
  when 'no_results'
    expect(array).to be_empty
  else
    puts 'unexpected condition ' + results
  end
end

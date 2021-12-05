require 'selenium-cucumber'

Given(/^ATM is (.*)$/) do |condition|
  @url_get = 'https://www.atm.healthcheck.com'
  @response = Generic::Helper.get_call(@url_get)
  @response_body = JSON.parse(@response)

  case condition
  when 'present and working'
    expect(@response.code).to eq(200)
    expect(@response_body).to eq('OK')
  when 'NOT present or NOT working'
    expect(@response.code).to eq(404)
  else
    raise 'Unknown condition: ' + condition
  end
end

And(/^ATM has (.*) bills available$/) do |bills|
  @bills = bills.split(/\s*,\s*/)
end

Given('ATM has ${int} total') do |int|
  pending
end

And(/^ATM language is correct$/) do
  language = @browser.find_element(:name, "language")
  language.text.should eq "English"
end
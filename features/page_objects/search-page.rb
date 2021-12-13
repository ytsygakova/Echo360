class SearchPage
  include PageObject

  checkbox(:one_way_checkbox, :id => 'oneWay')

  text_field(:from_field, :id => 'fromCity1')
  text_field(:to_field, :id => 'toCity1')
  text_field(:departure_date_field, :id => 'departureDate1')
  text_field(:return_date_field, :id => 'returnDate')

  select_list(:adults, :id => 'AdultCount')
  select_list(:children, :id => 'childrenCountDropDown')
  list_item(:infant_plus_button, :id => 'infantPlus')

  button(:find_flights_button, :id => 'findFlights')

  def visit_airline_site
    $browser.goto 'https://www.alaskaair.com/'
  end

  def enter_from_field(from_field)
    self.from_field = from_field
  end

  def enter_to_field(to_field)
    self.to_field = to_field
  end

  def enter_departure_date(departure_date)
    self.departure_date_field = departure_date
  end

  def enter_return_date(return_date)
    self.return_date_field = return_date
  end

  def click_find_flights_button
    find_flights_button
  end

  def search_results_present?(search_key)
    search_results.include?(search_key)
  end

  def close
    @browser.close
  end
end

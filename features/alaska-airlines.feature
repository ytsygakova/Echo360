Feature: Tests for flights booking

  This feature tests only flights booking.
  It is assumed that all other aspects of the process are tested in different feature files and working correctly.

  Scenario Outline: Tests for Round and One Way flights
    Given User opens the airlines page
    When User enters these search parameters
      | FROM               | <FROM>           |
      | TO                 | <TO>             |
      | DEPARTURE_DATE     | <DEPARTURE_DATE> |
      | RETURN_DATE        | <RETURN_DATE>    |
      | NUMBER_OF_ADULTS   | <ADULTS>         |
      | NUMBER_OF_CHILDREN | <CHILDREN>       |
      | USE_MILES          | NO               |

    Then User sees <RESULTS> search results
    Examples:
      | FROM | TO  | DEPARTURE_DATE | RETURN_DATE | ADULTS | CHILDREN | RESULTS                                       |
      | JNU  | BOS | 12/24/21       | 12/26/21    | 1      | 0        | several                                       |
      | BOS  | JNU | 12/24/21       | NO          | 2      | 1        | several                                       |
      | KTN  | IMT | 12/24/21       | 12/26/21    | 1      | 0        | no_results                                    |

#      | JNU  | BOS | 12/24/21       | 12/26/21    | 0      | 0        | error_passengers                              |
#      | JNU  | BOS | 12/26/21       | 12/24/21    | 1      | 0        | error_return_before_departure                 |
#      | JNU  | BOS | february       | 12/26/21    | 1      | 0        | error_invalid_departure                       |
#      | JNU  | BOS | 12/24/21       | february    | 1      | 0        | error_invalid_return                          |
#      | JNU  | BOS | 2/30/22        | 12/26/21    | 1      | 0        | error_invalid_departure                       |
#      | JNU  | BOS | 12/24/21       | 2/30/22     | 1      | 0        | error_invalid_return                          |
#      | JNU  | BOS | 12/26/23       | 12/24/23    | 1      | 0        | error_departure_too_far, error_return_too_far |

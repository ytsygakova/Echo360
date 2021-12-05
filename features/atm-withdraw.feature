Feature: Tests for cash withdrawals from an ATM

  This feature tests only cash withdrawal.
  It is assumed that all other aspects of the process are tested in different feature files and working correctly.
  It is assumed that a user can enter only whole numbers from 1 to 1000 and can't choose bills.

  Background:
    Given ATM is present and working
    And ATM has $1, $5, $10, $20, $50, $100 bills available
    And ATM has $1500 total
    And ATM language is correct
    And Card is inserted correctly
    And Card is valid
    And User enters a correct PIN
    And Withdrawal option is present

  Scenario Outline: Tests for user limits and bottom boundary value
    When User has $100 on the account
    And User enters <AMOUNT> to withdraw
    Then User gets <ATM RESPONSE>
    Examples:
      | AMOUNT | ATM RESPONSE                                  |
      | $0     | "Please, enter a valid amount"                |
      | $1     | $1                                            |
      | $2     | "Please, enter different amount"              |
      | $5     | $5                                            |
      | $10    | $10                                           |
      | $20    | $20                                           |
      | $50    | $50                                           |
      | $80    | $10, $20 and $50                              |
      | $100   | $100                                          |
      | $200   | "You don't have enough money on your account" |

  Scenario Outline: Tests for top boundary value
    When User has $10000 on the account
    And User enters <AMOUNT> to withdraw
    Then User gets <ATM RESPONSE>
    Examples:
      | AMOUNT | ATM RESPONSE                               |
      | $999   | 9 x $100, $50, 2 x $20 and 9 x $1          |
      | $1000  | 10 x $100                                  |
      | $1001  | "Please, enter amount less or equal $1000" |

  Scenario: Test for ATM limits
    When User has $10000 on the account
    And User enters $1000 to withdraw
    And User gets $1000
    And User enters $1000 to withdraw
    Then User gets "Please, enter amount less or equal $500"

    # This test case covers 2 things. It's easier to combine them in this way as steps are consecutive
    When User enters $500 to withdraw
    And User gets $500
    And User enters $1 to withdraw
    Then User gets "ATM is out of money"





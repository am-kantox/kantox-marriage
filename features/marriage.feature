# encoding: utf-8

Feature: Matches sums from given 2 datasets properly

@simple
Scenario Outline: Matches exact sum(s) from given datasets
 Given the arrays to match are parsed from "<fst>" and "<snd>"
  When the match is called
  Then result is "<result>"
  Examples:
    | fst                            | snd                            | result              |
    | [1, 2, 4]                      | [3]                            | [[1, 2], [3]]       |
    | [1, 4]                         | [3, 8]                         | []                  |
    | [1, 4, 5, 7]                   | [3, 8, 1]                      | [[1, 7], [8]]       |
    | [1, 4, 5, 7]                   | [2, 3, 8, 5]                   | [[1, 4], [2, 3]]    |
    | [802, 421, 143, 137, 316, 150] | [302, 611, 466, 42, 195, 295 ] | [[316, 150], [466]] |

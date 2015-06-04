# encoding: utf-8

Feature: Matches sums from given 2 datasets properly

@simple @matrix
Scenario Outline: Matches exact sum(s) from given datasets (dynamic)
 Given the arrays to match are parsed from "<fst>" and "<snd>"
  When the match "matrix" is called
  Then result is "<result>"
  Examples:
    | fst                            | snd                            | result              |
    | [1, 2, 4]                      | [3]                            | [[1, 2], [3]]       |
    | [1, 4]                         | [3, 8]                         | []                  |
    | [1, 4, 5, 7]                   | [3, 8, 1]                      | [[1, 7], [8]]       |
    | [1, 4, 5, 7]                   | [2, 3, 8, 5]                   | [[1, 4], [2, 3]]    |
    | [802, 421, 143, 137, 316, 150] | [302, 611, 466, 42, 195, 295 ] | [[316, 150], [466]] |

@simple @approx
Scenario Outline: Matches exact sum(s) from given datasets (approx)
 Given the arrays to match are parsed from "<fst>" and "<snd>"
  When the match "approx" is called
  Then result is "<result>"
  Examples:
    | fst                            | snd                            | result              |
    | [1, 2, 4]                      | [3]                            | [[1, 2], [3]]       |
    | [1, 4]                         | [3, 8]                         | []                  |
    | [1, 4, 5, 7]                   | [3, 8, 2]                      | [[4, 7], [3, 8]]    |
    | [11, 11, 7]                    | [33, 22]                       | [[11, 11], [22]]    |
    | [1, 4, 5, 7]                   | [2, 3, 9, 14]                  | [[1, 4], [2, 3]]    |
    | [802, 421, 143, 137, 316, 150] | [302, 611, 466, 42, 195, 295 ] | [[316, 150], [466]] |

@rounded @matrix
Scenario Outline: Matches sum(s) from given datasets with units digit position (dynamic)
 Given the arrays to match are parsed from "<fst>" and "<snd>"
  When the match "matrix" is called with units digit position "<udp>"
  Then result is "<result>"
  Examples:
    | fst                            | snd                            | udp | result                 |
    | [11, 12, 34]                   | [21]                           | 1   | [[10, 10], [20]]       |
    | [10, 21, 54]                   | [65, 48]                       | 1   | [[20, 50], [70]]       |
    | [120, 240, 1321]               | [30, 1501]                     | 2   | [[200, 1300], [1500]]  |
    | [120, 240, 1321]               | [1005, 1208]                   | 2   | []                     |
    | [1800, 2105, 3505, 20, 30, 40] | [302, 611, 466, 5123, 295 ]    | 3   | [[2000, 4000], [1000, 5000]] |

@rounded @approx
Scenario Outline: Matches sum(s) from given datasets with units digit position (approx)
 Given the arrays to match are parsed from "<fst>" and "<snd>"
  When the match "approx" is called with units digit position "<udp>"
  Then result is "<result>"
  Examples:
    | fst                            | snd                            | udp | result                 |
    | [11, 12, 34]                   | [21]                           | 1   | [[10, 10], [20]]       |
    | [10, 21, 54]                   | [65, 48]                       | 1   | [[20, 50], [70]]       |
    | [120, 240, 1321]               | [30, 1501]                     | 2   | [[200, 1300], [1500]]  |
    | [120, 240, 1321]               | [1005, 1208]                   | 2   | []                     |
    | [1800, 2105, 3505, 20, 30, 40] | [302, 611, 466, 5123, 295 ]    | 3   | [[2000, 4000], [1000, 5000]] |

@rounded @lookup @matrix
Scenario Outline: Matches sum(s) from given datasets with units digit position (dynamic)
 Given the arrays to match are parsed from "<fst>" and "<snd>"
  When the match "matrix" is called with units digit position "<udp>"
   And result is reverted back to exacts
  Then result is "<result>"
  Examples:
    | fst                            | snd                            | udp | result                 |
    | [11, 12, 34]                   | [21]                           | 1   | [[11, 12], [21]]       |
    | [10, 21, 54]                   | [65, 48]                       | 1   | [[21, 54], [65]]       |
    | [120, 240, 1321]               | [30, 1501]                     | 2   | [[240, 1321], [1501]]  |
    | [120, 240, 1321]               | [1005, 1208]                   | 2   | []                     |
    | [1800, 2105, 3505, 20, 30, 40] | [302, 611, 466, 5123, 295 ]    | 3   | [[1800, 3505], [611, 5123]] |

@rounded @lookup @matrix
Scenario Outline: Matches sum(s) from given datasets with units digit position (approx)
 Given the arrays to match are parsed from "<fst>" and "<snd>"
  When the match "approx" is called with units digit position "<udp>"
   And result is reverted back to exacts
  Then result is "<result>"
  Examples:
    | fst                            | snd                            | udp | result                 |
    | [11, 12, 34]                   | [21]                           | 1   | [[11, 12], [21]]       |
    | [10, 21, 54]                   | [65, 48]                       | 1   | [[21, 54], [65]]       |
    | [120, 240, 1321]               | [30, 1501]                     | 2   | [[240, 1321], [1501]]  |
    | [120, 240, 1321]               | [1005, 1208]                   | 2   | []                     |
    | [1800, 2105, 3505, 20, 30, 40] | [302, 611, 466, 5123, 295 ]    | 3   | [[1800, 3505], [611, 5123]] |

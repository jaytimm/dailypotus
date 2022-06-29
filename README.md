# dailypotus

A simple set of functions for scraping Wikipedia-based timelines/daily
happenings for the Trump & Biden Presidencies. For 46, function call
returns an up-to-date timeline. Daily event data have been structured
for a uniform output.

``` r
devtools::install_github("jaytimm/dailypotus")
```

## Trump timeline

``` r
djt <- dailypotus::daily_wiki_trump()
```

### Last day of the Trump Presidency

``` r
djt |>
  dplyr::select(-weekof, -daypres, -dow) |>
  dplyr::filter(date == max(date)) |>
  knitr::kable() 
```

| pres  | quarter              | date       | bullet | Events                                                                                                                                                                                                                                              |
|:--|:-----|:---|--:|:--------------------------------------------------------|
| Trump | 2020_Q4–January_2021 | 2021-01-20 |      1 | President Trump grants pardons to 73 individuals and commutes the sentence for 70 others prior to finishing his full term.                                                                                                                          |
| Trump | 2020_Q4–January_2021 | 2021-01-20 |      2 | President Trump completes his full term in office and leaves the White House for the final time as Commander-in-chief. A farewell ceremony is held at Joint Base Andrews after which he and his wife depart aboard Air Force One.                   |
| Trump | 2020_Q4–January_2021 | 2021-01-20 |      3 | President Trump did not attend the inauguration ceremony and returns to Mar-a-Lago to begin his post-presidency. However, Vice President Pence did attend the inauguration ceremony and later returns to Indiana to begin his post-vice presidency. |
| Trump | 2020_Q4–January_2021 | 2021-01-20 |      4 | Joe Biden is inaugurated as the 46th president of the United States, at noon EST.                                                                                                                                                                   |

## Biden timeline

``` r
jrb <- dailypotus::daily_wiki_biden()
```

### First day of the Biden Presidency

``` r
jrb |>
  dplyr::select(-weekof, -daypres, -dow) |>
  dplyr::filter(date == min(date)) |>
  knitr::kable() 
```

| pres  | quarter | date       | bullet | Events                                                                                                                                                                                                                                                        |
|:--|:--|:---|--:|:-----------------------------------------------------------|
| Biden | 2021_Q1 | 2021-01-20 |      1 | Joe Biden takes the oath of office as the 46th president of the United States and Kamala Harris takes the oath of office as the 49th vice president. Outgoing President Trump does not attend the ceremony, though outgoing Vice President Pence does attend. |
| Biden | 2021_Q1 | 2021-01-20 |      2 | President Biden proclaims a National Day of Unity.                                                                                                                                                                                                            |
| Biden | 2021_Q1 | 2021-01-20 |      3 | President Biden rejoins the Paris Climate Agreement, from which the United States formally withdrew on November 4, 2020. The action took effect in 30 days.                                                                                                   |
| Biden | 2021_Q1 | 2021-01-20 |      4 | In a letter to UN Secretary-General António Guterres, President Biden rescinds the United States’ July 2020 intended withdrawal from the World Health Organization. Biden also names Anthony Fauci as the head of the United States’ WHO delegation.          |
| Biden | 2021_Q1 | 2021-01-20 |      5 | President Biden issues an executive order to revoke the Keystone XL Pipeline permit and overturn various other Trump administration environmental policies.                                                                                                   |
| Biden | 2021_Q1 | 2021-01-20 |      6 | President Biden issues an executive order to halt funding for the border wall along the Mexican border.                                                                                                                                                       |
| Biden | 2021_Q1 | 2021-01-20 |      7 | President Biden issues a proclamation to repeal the travel ban from Muslim-majority countries.                                                                                                                                                                |
| Biden | 2021_Q1 | 2021-01-20 |      8 | The Senate confirms Avril Haines as Director of National Intelligence in a vote of 84–10.                                                                                                                                                                     |
| Biden | 2021_Q1 | 2021-01-20 |      9 | President Biden directs the Department of Education to extend the pause on federal student loans through September 30, 2021.                                                                                                                                  |
| Biden | 2021_Q1 | 2021-01-20 |     10 | Press Secretary Jen Psaki holds the first press briefing of the Biden administration, during which she mentions that the administration will hold briefings daily.                                                                                            |

## 

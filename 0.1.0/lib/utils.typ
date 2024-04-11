/// get the current academic year, assuming that the academic year starts in September
///
/// this function will return somthing like `[2023-2024]`
#let current-academic-year() = {
  let today = datetime.today()

  let year = today.year()
  let month = today.month()

  if month < 9 {
    let first-year = year - 1
    let second-year = year
    [#first-year\-#second-year]
  } else {
    let first-year = year
    let second-year = year + 1
    [#first-year\-#second-year]
  }
}

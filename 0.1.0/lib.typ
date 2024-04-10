#import "lib/utils.typ": current-academic-year

// store in states such that these need to be passed
// only once, in the `thesis` function
#let _authors = state("authors", none)
#let _title = state("title", none)
#let _supervisors = state("supervisors", none)
#let _year = state("year", [#current-academic-year()])

#let thesis(
  // The title of this thesis [content]
  title: none,
  // the authors of this thesis
  authors: none,
  // The supervisors for this thesis
  supervisors: none,
  // the academic year
  year: none,
  // the actual content of the thesis
  body
) = {
  // title, authors are required (return clear error message if not given)
  assert.ne(title, none, message: "`title` is a required argument")
  assert.ne(authors, none, message: "`authors` is a required argument")

  set document(
    title: title, 
    author: authors,
  )

  // set states to the given parameters
  _authors.update(authors)
  _title.update(title)
  _supervisors.update(supervisors)
  if year != none {
    _year.update(year)
  }

  set page(
    paper: "a4",
    margin: 2cm,
    numbering: "I"
  )
  
  set heading(numbering: none)
  
  show heading.where(
    level: 1
  ): it => {
    text(size: 30pt, it)
    v(1.5em)
  }
  
  show heading.where(
    level: 2
  ): it => {
    text(size: 26pt, it)
    v(1em)
  }
  
  show heading.where(
    level: 3
  ): it => {
    text(size: 20pt, it)
    v(.75em)
  }
  
  set text(font: "UGent Panno Text", size: 12pt)
  
  // make new sections appear on the right-hand side
  set pagebreak(weak: true, to: "odd")

  // add a new page before each level one heading
  show heading.where(
    level: 1
  ): it => {
    pagebreak()
    it
  }

  body
}

#let page-content(body) = {
  // Reset header counts and add numbering
  counter(heading).update(0)
  set heading(numbering: "1.", supplement: [Chapter])

  // Reset page counts, set to '1' numbering, and add
  // chapter title to header where no chapter is displayed
  counter(page).update(1)
  set page(
    numbering: "1",
    header: context {
      let elems = query(
        selector(heading).before(here()))

      let headings_at_this_page = query(
        heading.where(level: 1)
      ).find(h => h.location().page() == here().page())

      let page_has_no_heading = headings_at_this_page == none 

      if elems.len() != 0 and page_has_no_heading {
        let body = elems.last().body
        align(right, emph(body))
      }
    },
  )

  body
}

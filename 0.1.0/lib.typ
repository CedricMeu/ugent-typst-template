#import "@preview/acrostiche:0.3.1": init-acronyms, print-index
#import "lib/research-questions.typ": init-rqs
#import "lib/utils.typ": current-academic-year

// workaround for lack of std scope
#let std-biblio = bibliography

// store in states such that these need to be passed
// only once, in the `thesis` function
#let _authors = state("authors", ())
#let _title = state("title", [])
#let _supervisors = state("supervisors", ())
#let _year = state("year", [#current-academic-year()])

#let thesis(
  // The title of this thesis
  title: [The title of the thesis],
  // the authors of this thesis
  authors: ("John Doe",),
  // The supervisors for this thesis
  supervisors: ("Prof. Dr. Jane Doe",),
  // the academic year
  year: [2023-2024],
  // a `#bibliography(...)` or `none`
  bibliography: none,
  // the actual content of the thesis
  body
) = {
  set document(
    title: title, 
    author: authors,
  )
  // set states to the given parameters
  _authors.update(authors)
  _title.update(title)
  _supervisors.update(supervisors)
  _year.update(year)


  set page(
    paper: "a4",
    margin: 2cm,
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
    numbering: "I"
  )
  
  set heading(numbering: "1.", supplement: [Chapter])
  
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
  
  // make new sections appear on the right hand side
  set pagebreak(weak: true, to: "odd")

  body

  if bibliography != none {
    pagebreak()
    set std-biblio(style: "ieee", title: [References])
    bibliography
  }
}

#let page-content(body) = {
  // from here, add a new page before each level one heading
  show heading.where(
    level: 1
  ): it => {
    pagebreak()
    it
  }

  body
}

#let acronyms(
  acros: (
    "ML": "Machine Learning",
    "AI": "Artificial Intelligence",
  )
) = {
  init-acronyms(acros)
}

#let show-acronyms() = {
  print-index()
}

#let rqs(
  questions: ("RQ1": "What is the impact of X on Y?",)
) = {
  init-rqs(questions)
}

#let front-page(
  faculty-img: none,
  ugent-logo: none,
) = {
  if faculty-img != none and type(faculty-img) == content {
    faculty-img
  }
  
  // contextually get title and author etc.
  context {
    align(center + horizon)[
     #text(size: 24pt)[#_title.get()]
    ]
  
    align(bottom + center)[
     #table(
      columns: (auto, auto),
      stroke: none,
      [_Author_], [#_authors.get().join(", ")],
      [_Supervisors_], [#_supervisors.get().join(", ")],
     )
    
     Academic year #_year.get()
    ]
  }
  
  if ugent-logo != none and type(ugent-logo) == content {
    pad(top: 8em, ugent-logo)
  }
  
  pagebreak()
}

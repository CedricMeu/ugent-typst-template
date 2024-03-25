#import "lib/research-questions.typ": *
#import "@preview/acrostiche:0.3.1": *

#set document(
  title: "Thesis template", // Change title!
  author: "Cédric Meukens", // Change author!
)

#set page(
  paper: "a4",
  margin: 2cm,
  header: locate(loc => {
    let elems = query(
      selector(heading).before(loc), loc)

    let page_has_no_heading = query(
      heading.where(level: 1),
      loc
    ).find(h => h.location().page() == loc.page()) == none

    if elems != () and page_has_no_heading {
      let body = elems.last().body
      align(right, emph(body))
    }
  }),
  numbering: "I"
)

#set heading(numbering: none, supplement: [Chapter])

#show heading.where(
  level: 1
): it => {
  set text(size: 30pt)
  it
  v(1.5em)
}

#show heading.where(
  level: 2
): it => {
  set text(size: 26pt)
  it
  v(1em)
}

#show heading.where(
  level: 3
): it => {
  set text(size: 20pt)
  it
  v(.75em)
}

#set text(font: "UGent Panno Text", size: 12pt)

#set pagebreak(weak: true, to: "odd")

#include "acronyms.typ"
#include "rqs.typ"

#include "front-page.typ"

#include "chapters/preface.typ"

#show heading.where(
  level: 1
): it => {
  pagebreak()
  it
}

#include "chapters/remark.typ"
#include "chapters/abstract.typ"
#include "chapters/extended-abstract.typ"

/* Outlines */
#include "chapters/outlines.typ"

/* Start normal numbering */
#set page(numbering: "1")
#counter(page).update(1)

/* Start numbering headings */
#set heading(numbering: "1.1")

#include "chapters/introduction.typ"
#include "chapters/method.typ"
#set heading(numbering: none)
#include "chapters/conclusion.typ"

#bibliography("dissertation.bib")

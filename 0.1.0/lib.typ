#import "@preview/acrostiche:0.3.1": init-acronyms, print-index
#import "lib/research-questions.typ": init-rqs
#import "lib/utils.typ": current-academic-year

#let _todo-col = rgb("#ff5a08")
#let _idea-col = rgb("#2b8a70")

#let thesis(
  // The title of this thesis [content]
  title: none,
  // the authors of this thesis [array of strings]
  authors: none,
  // the font that's used for the thesis [string]
  font: "UGent Panno Text",
  // optionally align pagebreaks to odd pages [bool]
  odd_pagebreaks: false,
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

  show par: set block(spacing: 20pt)
  set par(leading: 12pt, justify: true)
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),  
    paper: "a4",
    numbering: "I",
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
  
  show heading.where(
    level: 1
  ): it => {
    pagebreak(weak: true)
    text(size: 20pt, it)
    v(1.25em)
  }

  show heading.where(
    level: 2
  ): it => {
    text(size: 17pt, it)
    v(1em)
  }
  
  show heading.where(
    level: 3
  ): it => {
    text(size: 14pt, it)
    v(.75em)
  }
  
  set text(font: font)
  // don't break up words in justified text
  set text(hyphenate: false)
  
  // make new sections appear on the right hand side
  if odd_pagebreaks {
    set pagebreak(weak: true, to: "odd")
  }

  body
}

#let main-content(body) = {
  set heading(numbering: "1.1", supplement: "Chapter")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    context {
      let number = [#counter(heading).get().at(0)]

      let nb = [#text(size: 60pt, weight: 300, number)]
      let title = [
        #text(size: 30pt, weight: 400, it.body)
        #v(8pt)
      ]

      v(100pt)
      grid(
        rows: (50pt,),
        columns: (1fr, 5fr),
        grid.cell(
          align: left + bottom,
          [#nb],
        ),
        grid.cell(
          align: right + bottom,
          stroke: (bottom: 1pt),
          [#title]
        )
      )
      v(40pt)
    }
  }

  set page(numbering: "1")
  counter(page).update(1)

  body
}

// whether to show text black or white based on background colour
#let bw-text(colour) = {
  if oklab(colour).components().at(0) > 70% {
    black
  } else {
    white
  }
}

#let coloured-block(colour: rgb("#2b8a70"), title: [title], body) = {
  block(
    width: 100%,
    radius: 4pt,
    fill: colour,
    inset: 6pt,
    stroke: 2pt + colour.lighten(50%),
    {
      [#h(1fr) #text(size: 20pt, weight: 500, fill: white, title)]
      v(-14pt)
      set align(center)
      set text(fill: bw-text(colour), weight: 500)
      set par(leading: 9pt)
      body
    }
  )
}

#let todo(body) = {
  coloured-block(colour: _todo-col, title: [TODO], body)
}

#let idea(body) = {
  coloured-block(colour: _idea-col, title: [IDEA], body)
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

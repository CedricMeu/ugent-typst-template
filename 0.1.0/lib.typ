#import "@preview/acrostiche:0.3.1": init-acronyms, print-index

#let _todo-col = rgb("#ff5a08")
#let _idea-col = rgb("#2b8a70")
#let _note-col = rgb("#6faede")

#let _title = state("title", none)
#let _author = state("title", none)

#let nb-eq(body, l: "") = {
    [
        #if l != "" [
          #set math.equation(numbering: "(1)")
          #math.equation(block: true)[#body] #label(l)
        ] else [
          #math.equation(block: true)[#body]
        ]
    ]
}

#let _style-quote(body) = {
  set quote(block: true)
  show quote: it => {
    set pad(x: 50pt)
    text(fill: luma(50), it)
    v(1em)
  }

  body
}

#let main-content(body) = {
  set heading(numbering: "1.1", supplement: "Section")
  counter(heading).update(1)

  show heading.where(level: 1): set heading(supplement: "Chapter")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    context {
      let number = int(counter(heading).display())

      let nb_width = if number < 10 {
        1fr
      } else {
        1.5fr
      } 

      let nb = [#text(size: 65pt, weight: 300, [#number])]

      let title = [
        #block[
        // #set align(right)
        #set par(justify: false)
        #text(size: 28pt, weight: 400, it.body)
        #v(9pt)]
      ]

      v(100pt)
      grid(
        rows: (50pt,),
        columns: (nb_width, 5fr),
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

  show figure: it => place(auto, float: true, box(width:100%)[
	  #align(center)[#it.body]

	  #v(5mm, weak: true)

	  #set align(center)
    #pad(x: 5mm, grid(
      columns: (20mm, auto),
      grid.cell(align: left)[
        #it.supplement
        #it.counter.display(it.numbering):
      ],
      // [#it.fields()],
      grid.cell(align: left)[#it.caption.body]
    ))

    #v(5mm)
  ])
  

  set list(indent: 10pt)

  show terms.item: it => {
    grid(
      columns: (1fr, 5fr),
      rows: (auto,),
      [ 
        #set text(weight: 600)
        #it.term 
      ],
      it.description
    )
    v(5pt)
    // it.fields()
  }

  set enum(indent: 10pt)

  set page(numbering: "1")
  counter(page).update(1)

  body
}

// whether to show text black or white based on background colour
#let bw-text(colour) = {
  if oklab(colour).components().at(0) > 80% {
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
      [#h(1fr) #text(size: 20pt, weight: 500, fill: bw-text(colour), title)]
      v(-14pt)
      // set align(center)
      set text(fill: bw-text(colour), weight: 500)
      set par(leading: 9pt)
      pad(x: 10pt, y: 5pt, body)
    }
  )
}

#let coloured-box(colour: rgb("#2b8a70"), title: [title], body) = {
  box(
    radius: 4pt,
    fill: colour.transparentize(25%),
    height: 0.5em,
    outset: (top: 7pt, bottom: 3pt),
    inset: (x: 2pt),
    {
      set text(fill: bw-text(colour), weight: 500)
      move(dy: -2pt)[#title: #body]
    }
  )
}

#let todo(inline: false, body) = {
  if inline {
    coloured-box(colour: _todo-col, title: [TODO], body)
  } else {
    coloured-block(colour: _todo-col, title: [TODO], body)
  }
}

#let idea(inline: false, body) = {
  if inline {
    coloured-box(colour: _idea-col, title: [IDEA], body)
  } else {
    coloured-block(colour: _idea-col, title: [IDEA], body)
  }
}

#let note(inline: false, body) = {
  if inline {
    coloured-box(colour: _note-col, title: [NOTE], body)
  } else {
    coloured-block(colour: _note-col, title: [NOTE], body)
  }
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

#let list-of-figures() = {

  show outline.entry: it => {
    // level, element: figure (supplement, counter, caption: caption (body))
    
    context {
      let res = query(figure.where(counter: it.element.counter)).find(
        f => {
          f == it.element
        }
      )

      let loc = res.location()

      let count = it.element.counter.at(loc)
      let caption = it.element.caption.body

      let entry = block(breakable: false, width: 100%)[
        #stack(
          dir: ltr,
          spacing: 0pt,
          [
            #set text(weight: 500)
            #box(width: 3em)[#count.at(0)]
          ],
          [
            #show text: set text(fill: luma(0), weight: 400)
            #box(width: 100% - 3em, caption)
          ],
        )
      ]

      link(loc,entry)
      v(-30pt)
    }
  }

  outline(title: none, target: figure)
}

#let thesis(
  // The title of this thesis [content]
  title: none,
  // the authors of this thesis [array of strings]
  authors: none,
  // the font that's used for the thesis [string]
  font: "UGent Panno Text",
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

  state("title").update(title)
  state("author").update(authors)

  set page(
    paper: "a4",
    numbering: "I",
  )

  // FIGURES
  // set figure(gap: 20pt)

  set text(font: font)
  // don't break up words in justified text
  set text(hyphenate: false)
  
  show: _style-quote

  show outline.entry.where(level: 1): it => {
    v(24pt, weak: true)

    context {
      let loc = it.element.location()
      link(loc, strong[#it.body #h(1fr) #it.page])
    }
  }

  set outline(indent: 1.5em, fill: box(width: 1fr, repeat(pad(x: 0.15em, "."))))

  body
}

#let at-outline(body) = {
  show heading.where(
    level: 1
  ): it => {
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

  show par: set block(spacing: 20pt)
  set par(leading: 12pt, justify: true)

  set page(
    margin: (x: 2.5cm, y: 2.5cm),  
    header: context {
      let elems = query(
        selector(heading).before(here()))

      let headings_at_this_page = query(
        heading.where(level: 1)
      ).find(h => h.location().page() == here().page())

      // dont show if there's a heading on the current page's top
      let heading_at_top = false
      let heading_after = query(
        selector(heading).after(here())).find(h => h.location().page() == here().page())

      if heading_after != none {
        if heading_after.location().position().at("y") < 80pt {
          heading_at_top = true 
        }
      }

      let page_has_no_heading = headings_at_this_page == none

      if elems.len() != 0 and page_has_no_heading and not heading_at_top {
        let body = elems.last().body
        align(right, emph(body))
      }
    },
  )
  
  body
}

#let extended(
  title: [],
  authors: (),
  abstract: [],
  index-terms: (),
  body
) = {
  set heading(outlined: false)

  // do not show numbering
  // set page margins
  show: page.with(numbering: none, margin: (x: 1.5cm))

  {
    set align(center)
    context text(size: 22pt, state("title").at(<sec:intro>))
    linebreak()
    v(2mm)
    context text(size: 10pt, state("author").at(<sec:intro>).join(", "))
    // TODO: add supervisors and councelors
    v(2mm)
  }


  set par(justify: true)
  set text(size: 9pt)

  set heading(numbering: "I.A.1")

  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 11pt, weight: 500)
    let smcp = upper(it.body.text) 
    let smcp-words = smcp.split(" ")
    let smcp = for smcp-word in smcp-words [#smcp-word.at(0)#text(size: 9pt, smcp-word.slice(1, none)) ]
    context {
      let l1 = counter(heading).get().at(0)
      [#numbering("I. ", l1) #smcp]
    }
    v(1mm)
  }
  show heading.where(level: 2): it => {
    set align(left)
    set text(size: 10pt, weight: 400, style: "italic")
    // it.fields()
    context {
      let l2 = counter(heading).get().at(1)
      [#numbering("A. ", l2) #it.body]
    }
    v(1mm)
  }

  show: columns.with(2)
  
  {
    set text(weight: 500)
    [#box[_Abstract_ --] #abstract]
    linebreak()
    [#box[_Index Terms_ --] #index-terms.join(", ")]
  }

  body
}

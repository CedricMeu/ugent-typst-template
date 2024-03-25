#import "@preview/acrostiche:0.3.1": *

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

#outline()

#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)

#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)

#print-index(title: "List of Acronyms")

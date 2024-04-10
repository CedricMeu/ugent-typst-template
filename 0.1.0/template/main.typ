#import "@local/ugent-thesis:0.1.0": thesis, page-content
#import "@preview/acrostiche:0.3.1": *

#show: thesis.with(
  title: [A UGent Master's Dissertation Created Using Typst],
  authors: ("John Doe",),
  supervisors: ("Prof. Dr. Jane Doe",),
  year: "2023-2024",
)

#outline()
#init-acronyms((
  "ML": "Machine Learning",
  "AI": "Artificial Intelligence",
))

#print-index()

#show: page-content
// start the actual thesis contents here!

= Introduction
#lorem(200) 

= Next Sections... 
#lorem(2000)

#import "@local/ugent-thesis:0.1.0": thesis, acronyms, front-page, page-content

#show: thesis.with(
  title: [A UGent Master's Dissertation Created Using Typst],
  authors: ("John Doe",),
  supervisors: ("Prof. Dr. Jane Doe",),
  year: "2023-2024",
  bibliography: bibliography("bib.bib")
)

#front-page(
  faculty-img: image("images/ea.png"),
  ugent-logo: image("images/ugent.png"),
)

#acronyms(
  acros: (
    "ML": "Machine Learning",
    "AI": "Artificial Intelligence",
  )
)

#show: page-content
// start the actual thesis contents here!

= Introduction
#lorem(200) 

= Next Sections... 

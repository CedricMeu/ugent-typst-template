#import "lib.typ": thesis, acronyms, front-page, page-content, show-acronyms

#show: thesis.with(
  title: [A UGent Master's Dissertation Created Using Typst],
  authors: ("John Doe",),
  supervisors: ("Prof. Dr. Jane Doe",),
  year: "2023-2024",
  bibliography: bibliography("template/bib.bib")
)

#front-page(
  faculty-img: "template/images/ea.png",
  ugent-logo: "template/images/ugent.png",
)

#acronyms(
  acros: (
    "ML": "Machine Learning",
    "AI": "Artificial Intelligence",
  )
)

#show-acronyms()

#show: page-content
// start the actual thesis contents here!

= Introduction
#lorem(200) 

= Next Sections... 
#lorem(2000)

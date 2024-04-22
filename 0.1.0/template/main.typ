#import "@local/ugent-thesis:0.1.0": thesis, acronyms, main-content, todo

#show: thesis.with(
  title: [A UGent Master's Dissertation Created Using Typst],
  authors: ("John Doe",),
)

#acronyms(
  acros: (
    // define your acronyms here
    "ML": "Machine Learning",
    "AI": "Artificial Intelligence",
  )
)

= List of figures etc.
#lorem(200)

#show: main-content.with()

// start your actual thesis contents here!

= Introduction
#todo[Write your introduction]
#lorem(2000) 

= Continue
#lorem(200)

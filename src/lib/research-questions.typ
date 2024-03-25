#let rqs_state = state("rqs", none)

#let init_rqs(rqs) = {
  rqs_state.update(rqs)
}

#let outline_rqs() = {
  set enum(numbering: (..nums) => "RQ" + nums.pos().map(str).join(".") + ":", full: true)
  rqs_state.display(rqs => {
    for key in rqs.keys() {
      [+ #rqs.at(key)]
    }
  })
}

#let ref_rq(key) = {
  rqs_state.display(rqs => {
    let pos = rqs.keys().position(v => v == key) + 1
    [RQ#pos]
  })
}

#let cite_rq(key) = {
  rqs_state.display(rqs => {
    rqs.at(key)
  })
}

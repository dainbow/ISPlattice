#import "@preview/theorion:0.3.3": *
#import cosmos.fancy: *
#show: show-theorion

#import "@preview/polytonoi:0.1.0": *
#import "@preview/ouset:0.2.0": *

#let gk = ptgk

#let seq(idx: "n", start: "1", end: $oo$, name) = ${name_idx}_(idx = start)^end$

#let eq(cont) = align(center)[
  #cont
]

#let weak = $overset(->, w)$

#let res = $op("res")$

#let epigraph(phrase, author) = align(right)[
  #text(font: "DejaVu Sans Mono")[
    #phrase
  ]
  #line()
  #text(style: "italic")[
    #author
  ]
]

#let conf(title, doc) = {
  set page(paper: "a4", numbering: "1", header: align(right + horizon, title))
  set par(leading: 0.55em, first-line-indent: 1.8em, justify: true)
  set text(font: "New Computer Modern", size: 12pt, lang: "ru")
  set heading(numbering: "1.")

  show raw: set text(font: "New Computer Modern")
  show par: set block(spacing: 0.55em)
  show heading: set block(above: 1.4em, below: 1em)

  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }

  page()[#outline(indent: auto)]

  doc
}

#set page(margin: (
  top: 1cm,
  bottom: 1cm,
  x: 0.9cm,
))
#import "@preview/cetz:0.3.1"
#import "@preview/cades:0.3.0": qr-code

#import "flex.typ"

// Change your personal info here
#let name = [
  Neven Villani
]
#let city = [
  St-M. d'Hères
]

// Optional parameterization
#let date-format = [
  ..../..../20.....
]

#let font = (
  header: it => text(size: 21pt)[#it],
  body: it => text(size: 15pt)[#it],
  footer: it => text(size: 10pt)[#it],
)

#let writing = (
  header: (font.header)[
    *Kéfir*
  ],
  footer: (font.footer)[
    _#{name}_ \
    _#{city}_
  ],
  body: (font.body)[
    #(font.footer)[Parfum:] ........... \
    #(font.footer)[Mis en bouteille:] \
    #v(-4mm) #{date-format} \
    #(font.footer)[Fin de maturation:] \
    #v(-4mm) #{date-format} \
    #(font.footer)[
      Sous pression. \
      #v(-4mm) Ne pas agiter.
    ]
  ],
)

#let verso-writing = (
  header: [],
  footer: [],
  body: rotate(90deg)[
    #table(columns: 2, stroke: none, align: horizon,
      [Neven Villani \ `github:vanille-n/kefir`],
      qr-code("https://github.com/vanille-n/kefir", width: 2.3cm),
    )
  ],
)

#let my-outline = {
  (
    head: "circular",
    incision: "rounded",
    neck: "rounded",
    body: "blocky",
  )
}

#flex.examples(writing, 
  (default: "blocky"),
  (default: "sharp"),
  (default: "rounded"),
  (default: "circular"),
  my-outline,
)

#let packed(obj, parity: false) = {
  let imax = 2
  let jmax = 4
  let dx = 2.25cm
  let deltay = 14.5cm

  let default_rot = if parity { 180deg } else { 0deg }

  for i in range(imax) {
    for j in range(jmax) {
      place(center + horizon, dy: ((imax - 1)/2 - i)*deltay, dx: (jmax - 0.5 - (2*j))*dx)[#rotate(default_rot)[
        #obj
      ]]
      place(center + horizon, dy: ((imax - 1)/2 - i)*deltay, dx: (jmax - 0.5 - (2*j+1))*dx)[#rotate(default_rot + 180deg)[
        #obj
      ]]
    }
  }
}

#packed(
  cetz.canvas({ flex.object(writing, my-outline) })
)
#if not flex.preview.verso {
  pagebreak()
}
#packed(
  cetz.canvas({ flex.object(verso-writing, (:)) }),
  parity: not flex.preview.verso,
)

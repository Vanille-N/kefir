#set page(margin: (
  top: 1cm,
  bottom: 1cm,
  x: 1cm,
))
#import "@preview/cetz:0.3.1"

// Change your personal info here
#let name = [Neven Villani]
#let city = [St-M. d'Hères]

// Optional parameterization
#let date-format = [..../..../20.....]

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

// Main shape drawing

#let shape = (
  body: area => {
    import cetz.draw: *
    let loc = area.locate
    merge-path(fill: white, {
      line(loc(0.75, 1), loc(1, 0.9))
      line((), loc(1, 0.1))
      line((), loc(0.75, 0))
      line((), loc(0.25, 0))
      line((), loc(0, 0.1))
      line((), loc(0, 0.9))
      line((), loc(0.25, 1))
    })
    line(loc(0, 0.2), loc(1, 0.2))
    anchor("text-header", loc(0.5, 0.9))
    anchor("text-body", loc(0.5, 0.5))
    anchor("text-footer", loc(0.5, 0.12))

  },
  hanger: area => {
    import cetz.draw: *
    let loc = area.locate
    rect(loc(0, -0.1), loc(1, 1)) 

    line(loc(0, 0.1), loc(0.5, 0.1))
    line((), loc(0.5, 0.2))

    line(loc(1, 0.8), loc(0.5, 0.8))
    line((), loc(0.5, 0.85))
  }
)

#let make-area(x: 0, y: 0, dx: 1, dy: 1) = {
  import "draw.typ" as cz
  (
    locate: (xfrac, yfrac) => {
      cz.dp((x, y), x: xfrac * dx, y: yfrac * dy)
    },
  )
}

#let object() = {
  import "draw.typ" as cz
  let body = (height: 7cm, width: 3cm)
  let band = (height: 5.6cm, width: 1.5cm, overlap: 2cm)
  (shape.hanger)(make-area(x: -band.width/2, y: body.height/2, dx: band.width, dy: band.height))
  (shape.body)(make-area(x: -body.width/2, y: -body.height/2, dx: body.width, dy: body.height))
  cz.content("text-header")[#align(center)[#writing.header]]
  cz.content("text-footer")[#align(center)[#writing.footer]]
  cz.content("text-body")[#align(center)[#writing.body]]
}

// Page layout

#{
  for i in range(2) {
    for j in range(4) {
      place(dy: i*14.5cm, dx: j*4.56cm)[
        #cetz.canvas({
          object()
        })
      ]
      place(dy: i*14.5cm - 7mm, dx: j*4.56cm+2.28cm)[
        #rotate(180deg)[#cetz.canvas({
          object()
        })]
      ]
    }
  }
}

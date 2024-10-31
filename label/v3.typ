#set page(margin: (
  top: 1cm,
  bottom: 1cm,
  x: 0.5cm,
))
#import "@preview/cetz:0.3.1"

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

// Main shape drawing

#let preview = false

#let preview-color = rgb("FF553377")
#let preview-anchor(level) = (name, pos) => {
  import cetz.draw: *
  anchor(name, pos)
  if preview {
    circle((), stroke: none, fill: preview-color, radius: level * 1mm)
  }
}
#let xanchor = preview-anchor(2)
#let xxanchor = preview-anchor(1.5)
#let xxxanchor = preview-anchor(1)

#set page(background: {
  if preview {
    place(center + horizon)[
      #rotate(24deg)[
        #text(70pt, fill: preview-color)[
          *PREVIEW*
        ]
      ]
    ]
  }
})

#let shape = {
  import cetz.draw: *
  (
    body: (
      anchors: area => {
        let loc = area.locate
        xanchor("bd:|bot", loc(0, 0))
        xanchor("bd:|top", loc(0, 1))
        xanchor("bd:top|", loc(1, 1))
        xanchor("bd:bot|", loc(1, 0))
        xxanchor("bd:|lo", loc(0, 0.2))
        xxanchor("bd:lo|", loc(1, 0.2))
        xxanchor("bd:|hi", loc(0, 0.8))
        xxanchor("bd:hi|", loc(1, 0.8))
        xxxanchor("bd:|lo-", loc(0, 0.1))
        xxxanchor("bd:lo-|", loc(1, 0.1))
        xxxanchor("bd:|hi-", loc(0, 0.9))
        xxxanchor("bd:hi-|", loc(1, 0.9))
        xxxanchor("bd:<bot", loc(0.25, 0))
        xxxanchor("bd:bot>", loc(0.75, 0))

        xanchor("tx:header", loc(0.5, 0.9))
        xanchor("tx:body", loc(0.5, 0.5))
        xanchor("tx:footer", loc(0.5, 0.12))
      },
      draw: area => {
        merge-path({
          line(
            "hg:bot|",
            "bd:hi-|", "bd:lo-|",
            "bd:bot>", "bd:<bot",
            "bd:|lo-", "bd:|hi-",
            "hg:|bot",
          )
        })
        line("bd:|lo", "bd:lo|")
      },
    ),
    hanger: (
      anchors: area => {
        let loc = area.locate
        xanchor("hg:|bot", loc(0, 0))
        xanchor("hg:|top", loc(0, 1))
        xanchor("hg:top|", loc(1, 1))
        xanchor("hg:bot|", loc(1, 0))
        xxanchor("hg:|lo", loc(0, 0.1))
        xxanchor("hg:lo|", loc(1, 0.1))
        xxanchor("hg:|hi", loc(0, 0.8))
        xxanchor("hg:hi|", loc(1, 0.8))
      },
      draw: area => {
        let rel = area.relative
        line("hg:|bot", "hg:|top", "hg:top|", "hg:bot|")
        line("hg:|lo", rel((), 0.5, 0), rel((), 0, 0.1))
        line("hg:hi|", rel((), -0.5, 0), rel((), 0, 0.05))
      }
    )
  )
}

#let make-area(x: 0, y: 0, dx: 1, dy: 1) = {
  import "draw.typ" as cz
  (
    locate: (xfrac, yfrac) => {
      cz.dp((x, y), x: xfrac * dx, y: yfrac * dy)
    },
    relative: (abs, xfrac, yfrac) => {
      cz.dp(abs, x: xfrac * dx, y: yfrac * dy)
    }
  )
}

#let object() = {
  import "draw.typ" as cz
  let body = (height: 7cm, width: 3cm)
  let band = (height: 5.6cm, width: 1.5cm, overlap: 2cm)
  cz.rect((-body.width/2 - 5mm, -body.height/2 - 5mm), (body.width/2 + 5mm, body.height / 2 + band.height + 5mm), stroke: none)

  let hanger-area = make-area(x: -band.width/2, y: body.height/2, dx: band.width, dy: band.height)
  let body-area = make-area(x: -body.width/2, y: -body.height/2, dx: body.width, dy: body.height)
  (shape.hanger.anchors)(hanger-area)
  (shape.body.anchors)(body-area)
  (shape.hanger.draw)(hanger-area)
  (shape.body.draw)(body-area)
  cz.content("tx:header")[#align(center)[#writing.header]]
  cz.content("tx:footer")[#align(center)[#writing.footer]]
  cz.content("tx:body")[#align(center)[#writing.body]]
}

// Page layout

#{
  if preview {
    cetz.canvas({
      object()
    })
    pagebreak()
  }
}

#{
  let imax = 2
  let jmax = 4
  let dx = 2.28cm
  let deltay = 14.5cm
  let packing-dy = -7mm

  for i in range(imax) {
    for j in range(jmax) {
      place(dy: i*deltay, dx: (2*j)*dx)[
        #cetz.canvas({ object() })
      ]
      place(dy: i*deltay + packing-dy, dx: (2*j+1)*dx)[#rotate(180deg)[
        #cetz.canvas({ object() })
      ]]
    }
  }
}

#set page(margin: (
  top: 1cm,
  bottom: 1cm,
  x: 0.9cm,
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

#let centered-area(x: 0, y: 0, dx: 1, dy: 1) = {
  import "draw.typ" as cz
  let relative(abs, xfrac, yfrac) = {
    cz.dp(abs, x: xfrac * dx, y: yfrac * dy)
  }
  let locate(xfrac, yfrac) = {
    relative((x, y), xfrac, yfrac)
  }
  let box() = {
    cz.rect(locate(-1, -1), locate(1, 1), stroke: (paint: red, thickness: 2pt))
  }
  (
    locate: locate,
    relative: relative,
    box: box,
  )
}

#let shape = {
  import cetz.draw: *
  (
    body: (
      anchors: area => {
        let loc = area.locate
        xanchor("bd:|bot", loc(-1, -1))
        xanchor("bd:|top", loc(-1, 1))
        xanchor("bd:top|", loc(1, 1))
        xanchor("bd:bot|", loc(1, -1))

        xxanchor("bd:|lo", loc(-1, -0.5))
        xxanchor("bd:lo|", loc(1, -0.5))

        xanchor("tx:body", loc(0, 0.2))
        xanchor("tx:footer", loc(0, -0.7))
      },
      draw: area => {
        let rel = area.relative
        line("bd:|top", rel("bd:|bot", 0, 0.25))
        line((), rel("bd:|bot", 0.5, 0))
        line((), rel("bd:bot|", -0.5, 0))
        line((), rel("bd:bot|", 0, 0.25))
        line((), "bd:top|")

        line("bd:|lo", "bd:lo|")
      },
    ),
    neck: (
      anchors: area => {
        let loc = area.locate
        let rel = area.relative
        xanchor("nk:|top", loc(-0.5, 1))
        xanchor("nk:top|", loc(0.5, 1))
        xanchor("nk:|bot", loc(-1, -1))
        xanchor("nk:bot|", loc(1, -1))

        xanchor("tx:header", loc(0, -0.3))
      },
      draw: area => {
        let rel = area.relative
        line("nk:|bot", rel((), 0, 2/3))
        line((), rel((), 1/2, 2/3))
        line((), rel((), 0, 2/3))

        line("nk:bot|", rel((), 0, 2/3))
        line((), rel((), -1/2, 2/3))
        line((), rel((), 0, 2/3))
      },
    ),
    head: (
      anchors: area => {
        let loc = area.locate
        xanchor("hd:|bot", loc(-1, -1))
        xanchor("hd:|top", loc(-1, 1))
        xanchor("hd:top|", loc(1, 1))
        xanchor("hd:bot|", loc(1, -1))
        xxanchor("hd:|hi", loc(-1, 0.6))
        xxanchor("hd:hi|", loc(1, 0.6))
      },
      draw: area => {
        let rel = area.relative
        line("hd:|bot", "hd:|top", "hd:top|", "hd:bot|")
        line("hd:|bot", rel((), 1, 0), rel((), 0, 0.2))
        line("hd:hi|", rel((), -1, 0), rel((), 0, 0.1))
      }
    )
  )
}

#let object() = {
  import "draw.typ" as cz
  let body = (height: 5.6cm, width: 3cm)
  let neck = (height: 2cm)
  let head = (height: 4.9cm, width: 1.5cm)

  cz.crect(name: "box", (0, 0), dx: (body.width + 5mm) / 2, dy: (neck.height + body.height * 2 + 5mm) / 2, stroke: if preview { red } else { none })
  let neck-area = centered-area(x: 0, y: 0, dx: body.width / 2, dy: neck.height / 2)
  let body-area = centered-area(x: 0, y: -(body.height + neck.height) / 2, dx: body.width / 2, dy: body.height / 2)
  let head-area = centered-area(x: 0, y: (head.height + neck.height) / 2, dx: head.width / 2, dy: head.height / 2)
  if preview {
  //  (neck-area.box)()
  //  (body-area.box)()
  //  (head-area.box)()
  }
  (shape.neck.anchors)(neck-area)
  (shape.head.anchors)(head-area)
  (shape.body.anchors)(body-area)
  (shape.head.draw)(head-area)
  (shape.neck.draw)(neck-area)
  (shape.body.draw)(body-area)
  cz.content("tx:header")[#align(center)[#writing.header]]
  cz.content("tx:footer")[#align(center)[#writing.footer]]
  cz.content("tx:body")[#align(center)[#writing.body]]
}


// Page layout

#{
  if preview {
    box[#cetz.canvas({
      object()
    })]
    pagebreak()
  }
}

#{
  let imax = 2
  let jmax = 4
  let dx = 2.25cm
  let deltay = 14.5cm

  for i in range(imax) {
    for j in range(jmax) {
      place(dy: i*deltay, dx: (2*j)*dx)[
        #cetz.canvas({ object() })
      ]
      place(dy: i*deltay, dx: (2*j+1)*dx)[#rotate(180deg)[
        #cetz.canvas({ object() })
      ]]
    }
  }
}

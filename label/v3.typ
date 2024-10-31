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

#let object(orig) = {
  import "draw.typ" as cz
  let body = (height: 7cm, width: 3cm)
  let band = (height: 6cm, width: 1.5cm, overlap: 2cm)
  let inset = (depth: band.width / 3)
  let cut = (width: band.width / 2, height: body.width + 1cm, top: 0.9)
  // Attachment band
  cz.crect(cz.dp(orig, 0, body.height / 2 + band.height / 2 - band.overlap/2),
    dx: band.width/2, dy: band.height/2 + band.overlap / 2)
  cz.line(cz.dp(orig, 0, body.height/2 + band.height * 0.8),
    cz.dp(orig, band.width/2, body.height/2 + band.height * 0.8))
  cz.line(cz.dp(orig, 0, body.height/2 + band.height * 0.8),
    cz.dp(orig, 0, body.height/2 + band.height * 0.85))
  cz.line(cz.dp(orig, 0, body.height/2 + band.height * 0.1),
    cz.dp(orig, -band.width/2, body.height/2 + band.height * 0.1))
  cz.line(cz.dp(orig, 0, body.height/2 + band.height * 0.1),
    cz.dp(orig, 0, body.height/2 + band.height * 0.2))
  // Main body and text
  cz.crect(orig, dx: body.width / 2, dy: body.height / 2, radius: body.width / 2, fill: white)
  cz.content(cz.dp(orig, 0, body.height/2 - body.width/3))[#writing.header]
  cz.content(cz.dp(orig, 0, -body.height/2 + body.width/3.5))[#writing.footer]
  cz.line(cz.dp(orig, -body.width/2, -body.height*0.3),
    cz.dp(orig, body.width/2, -body.height*0.3))
  cz.content(cz.dp(orig, 0, 0))[#align(center)[#writing.body]]
}

// Page layout

#{
  for i in range(2) {
    for j in range(4) {
      place(dy: i*14cm, dx: j*4.56cm)[
        #cetz.canvas({
          object((0, 0))
        })
      ]
      place(dy: i*14cm, dx: j*4.56cm+2.28cm)[
        #rotate(180deg)[#cetz.canvas({
          object((0, 0))
        })]
      ]
    }
  }
}

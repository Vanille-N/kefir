#set page(margin: (
  top: 1cm,
  bottom: 1cm,
  x: 1cm,
))
#import "@preview/cetz:0.2.2"

#let object(orig) = {
  import "draw.typ" as cz
  let body = (height: 7cm, width: 3cm)
  let band = (height: 6cm, width: 1.5cm, overlap: 2cm)
  let inset = (depth: band.width / 3)
  let cut = (width: band.width / 2, height: body.width + 1cm, top: 0.9)
  let font = (title: 21pt, body: 15pt, footnote: 10pt)
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
  cz.content(cz.dp(orig, 0, body.height/2 - body.width/3))[#text(size: font.title)[
    *Kéfir*
  ]]
  cz.content(cz.dp(orig, 0, -body.height/2 + body.width/3.5))[
    #align(center)[#text(size: font.footnote)[
      _Neven Villani_ \ _St-M. d'Hères_
    ]]
  ]
  cz.line(cz.dp(orig, -body.width/2, -body.height*0.3),
    cz.dp(orig, body.width/2, -body.height*0.3))

  cz.content(cz.dp(orig, 0, 0))[#text(size: font.body)[#align(center)[
    #text(size: font.footnote)[Parfum:] ........... \
    #text(size: font.footnote)[Mis en bouteille:] \
    #v(-1em)
    ..../..../20..... \
    #text(size: font.footnote)[Fin de maturation:] \
    #v(-1em)
    ..../..../20..... \
    #text(size: font.footnote)[
      Sous pression. \
      #v(-1.5em)
      Ne pas agiter.
    ]
  ]]]
}

#cetz.canvas({
  for i in range(2) {
    for j in range(6) {
      object((j*3.04cm, 14cm*i))
    }
  }
})

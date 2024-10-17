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
  let font = (title: 21pt, body: 15pt, footnote: 11pt)
  // Attachment band
  cz.crect(cz.dp(orig, 0, body.height / 2 + band.height / 2 - band.overlap/2), dx: band.width/2, dy: band.height/2 + band.overlap / 2)
  cz.circle(cz.dp(orig, band.width/2, body.height/2 + 0.3*inset.depth), radius: inset.depth)
  cz.circle(cz.dp(orig, -band.width/2, body.height/2 + 0.3*inset.depth), radius: inset.depth)
  cz.line(cz.dp(orig, -cut.width/2, body.height/2 + band.height*cut.top),
    cz.dp(orig, cut.width/2, body.height/2 + band.height*cut.top))
  cz.line(cz.dp(orig, 0, body.height/2 + band.height*cut.top),
    cz.dp(orig, 0, body.height/2 + band.height*cut.top - cut.height))
  // Main body and text
  cz.crect(orig, dx: body.width / 2, dy: body.height / 2, radius: body.width / 2, fill: white)
  cz.content(cz.dp(orig, 0, body.height/2 - body.width/3))[#text(size: font.title)[
    *Kéfir*
  ]]
  cz.content(cz.dp(orig, 0, -body.height/2 + body.width/3))[
    #align(center)[#text(size: font.footnote)[
      _Neven Villani_ \ _Grenoble_
    ]]
  ]
  cz.content(cz.dp(orig, 0, 0))[#text(size: font.body)[#align(center)[
    ..../..../........ \
    \
    .................. \
    ..................
  ]]]
}

#cetz.canvas({
  for i in range(2) {
    for j in range(6) {
      object((j*3cm, 14cm*i))
    }
  }
})

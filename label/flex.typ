#import "@preview/cetz:0.3.1"

#let make-preview(anchors: false, singleton: false, box: false, verso: false) = {
  (
    anchors: anchors,
    singleton: singleton,
    box: box,
    verso: verso,
    any: anchors or singleton or box or verso,
  )
}

#let preview = make-preview(
  anchors: false,
  singleton: false,
  verso: false,
  box: false,
)

#let preview-color = rgb("FF553377")

#let preview-anchor(level) = (name, pos) => {
  import cetz.draw: *
  anchor(name, pos)
  if preview.anchors {
    circle((), stroke: none, fill: preview-color, radius: level * 1mm)
  }
}
#let xanchor = preview-anchor(2)
#let xxanchor = preview-anchor(1.5)
#let xxxanchor = preview-anchor(1)

#set page(background: {
  if preview.any {
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
  let xscale(len) = len * dx
  let yscale(len) = len * dy
  let relative(abs, xfrac, yfrac) = {
    cz.dp(abs, x: xscale(xfrac), y: yscale(yfrac))
  }
  let xrelative(abs, xfrac, yfrac) = {
    cz.dp(abs, x: xscale(xfrac), y: xscale(yfrac))
  }
  let yrelative(abs, xfrac, yfrac) = {
    cz.dp(abs, x: yscale(xfrac), y: yscale(yfrac))
  }
  let locate(xfrac, yfrac) = {
    relative((x, y), xfrac, yfrac)
  }
  let box() = {
    cz.rect(locate(-1, -1), locate(1, 1), stroke: (paint: red, thickness: 2pt))
  }
  (
    loc: locate,
    rel: relative,
    xmul: xscale,
    ymul: yscale,
    xrel: xrelative,
    yrel: yrelative,
    box: box,
  )
}

#let anchors = {
  import cetz.draw: *
  (
    body: area => {
      let (loc,xrel) = area
      xanchor("<bot", loc(-1, -1))
      xanchor("<top", loc(-1, 1))
      xanchor("top>", loc(1, 1))
      xanchor("bot>", loc(1, -1))

      xxanchor("<mid", xrel(loc(-1, -1), 0, 0.7))
      xxanchor("mid>", xrel(loc(1, -1), 0, 0.7))

      xanchor("tx:body", loc(0, 0.15))
      xanchor("tx:footer", loc(0, -0.8))
    },
    neck: area => {
      let (loc, rel) = area
      xanchor("<top", loc(-0.5, 1))
      xanchor("top>", loc(0.5, 1))
      xanchor("<bot", loc(-1, -1))
      xanchor("bot>", loc(1, -1))

      xxanchor("<mid", loc(-0.75, 0))
      xxanchor("mid>", loc(0.75, 0))

      xanchor("tx:header", loc(0, -0.5))
    },
    head: area => {
      let (loc,) = area
      xanchor("<bot", loc(-1, -1))
      xanchor("<top", loc(-1, 1))
      xanchor("top>", loc(1, 1))
      xanchor("bot>", loc(1, -1))
    },
    incision: area => {
      let (loc, xrel) = area
      xanchor("<bot", loc(-1, -1))
      xanchor("bot>", loc(1, -1))
      xxanchor("<mid", xrel(loc(-1, 1), 0, -2))
      xxanchor("mid>", xrel(loc(1, 1), 0, -2))
    },
  )
}

#let outline = {
  import cetz.draw: *
  (

    sharp: (
      body: area => {
        let (rel, xrel) = area
        line("<top", xrel("<bot", 0, 0.5))
        line((), xrel("<bot", 0.5, 0))
        line((), xrel("bot>", -0.5, 0))
        line((), xrel("bot>", 0, 0.5))
        line((), "top>")

        line("<mid", "mid>")
      },
      neck: area => {
        let (rel,) = area
        line("<bot", rel((), 0, 2/3), rel("<top", 0, -2/3), "<top")
        line("bot>", rel((), 0, 2/3), rel("top>", 0, -2/3), "top>")
      },
      head: area => {
        let (xrel,) = area
        line(
          "<bot",
          xrel("<top", 0, -0.5), xrel("<top", 0.5, 0),
          xrel("top>", -0.5, 0), xrel("top>", 0, -0.5),
          "bot>",
        )
      },
      incision: area => {
        let (xrel,) = area
        line("<bot", xrel((), 1, 1))
        line("mid>", xrel((), -1, 1))
      },
    ),
    rounded: (
      body: area => {
        let (rel, xrel, xmul) = area
        line("<top", xrel("<bot", 0, 0.5))
        arc((), start: 180deg, delta: 90deg, radius: xmul(0.5))
        line((), xrel("bot>", -0.5, 0))
        arc((), start: -90deg, delta: 90deg, radius: xmul(0.5))
        line((), "top>")

        line("<mid", "mid>")
      },
      neck: area => {
        let (xrel,) = area
        bezier("<bot", "<top", xrel("<mid", -0.25, 0), xrel("<mid", 0.25, 0))
        bezier("bot>", "top>", xrel("mid>", 0.25, 0), xrel("mid>", -0.25, 0))
      },
      head: area => {
        let (xrel, xmul) = area
        line("<bot", xrel("<top", 0, -0.5))
        arc((), start: 180deg, delta: -90deg, radius: xmul(0.5))
        line((), xrel("top>", -0.5, 0))
        arc((), start: 90deg, delta: -90deg, radius: xmul(0.5))
        line((), "bot>")
      },
      incision: area => {
        let (xrel, xmul) = area
        line("<bot", xrel((), 0.5, 0))
        arc((), start: -90deg, delta: 90deg, radius: xmul(0.5))
        line((), xrel((), 0, 0.5))

        line("mid>", xrel((), -0.5, 0))
        arc((), start: -90deg, delta: -90deg, radius: xmul(0.5))
        line((), xrel((), 0, 0.5))
      },
    ),
    blocky: (
      body: area => {
        let (rel,) = area
        line("<top", "<bot", "bot>", "top>")
        line("<mid", "mid>")
      },
      neck: area => {
        let (rel,) = area
        line("<bot", rel((), 0, 1), rel("<top", 0, -1), "<top")
        line("bot>", rel((), 0, 1), rel("top>", 0, -1), "top>")
      },
      head: area => {
        let (rel,) = area
        line("<bot", "<top", "top>", "bot>")
      },
      incision: area => {
        let (rel, xrel) = area
        line("<bot", rel((), 1, 0), xrel((), 0, 1))
        line("mid>", rel((), -1, 0), xrel((), 0, 1))
      },
    ),
    circular: (
      body: area => {
        let (rel, xrel, xmul) = area
        line("<top", "<mid")
        arc((), start: 180deg, delta: 180deg, radius: xmul(1), mode: "CLOSE")
        line((), "top>")
      },
      neck: area => {
        let (rel, xrel, xmul) = area
        arc("<mid", start: 90deg, delta: 90deg, radius: xmul(0.25))
        line((), "<bot")

        arc("<mid", start: -90deg, delta: 90deg, radius: xmul(0.25))
        line((), "<top")

        arc("mid>", start: 90deg, delta: -90deg, radius: xmul(0.25))
        line((), "bot>")

        arc("mid>", start: -90deg, delta: -90deg, radius: xmul(0.25))
        line((), "top>")
      },
      head: area => {
        let (rel, xrel, xmul) = area
        line("<bot", xrel("<top", 0, -1))
        arc((), start: 180deg, delta: -180deg, radius: xmul(1))
        line((), "bot>")
      },
      incision: area => {
        let (rel, xrel, xmul) = area
        arc("<bot", start: -120deg, delta: 160deg, radius: xmul(0.7))
        arc("mid>", start: -60deg, delta: -160deg, radius: xmul(0.7))
      },
    ),
  )
}

#let object(writing, outline_kind) = {
  import "draw.typ" as cz
  let body = (height: 5.6cm, width: 3cm)
  let neck = (height: 2cm)
  let head = (height: 5.6cm, width: 1.5cm)

  cz.crect(name: "box", (0, 0), dx: (body.width + 5mm) / 2, dy: (neck.height + body.height * 2 + 5mm) / 2, stroke: if preview.box { red } else { none })
  let neck-area = centered-area(x: 0, y: 0, dx: body.width / 2, dy: neck.height / 2)
  let body-area = centered-area(x: 0, y: -(body.height + neck.height) / 2, dx: body.width / 2, dy: body.height / 2)
  let head-area = centered-area(x: 0, y: (head.height + neck.height) / 2, dx: head.width / 2, dy: head.height / 2)
  if preview.box {
    (neck-area.box)()
    (body-area.box)()
    (head-area.box)()
  }

  let fetch(label) = {
    let default = outline_kind.at("default", default: none)
    let kind = outline_kind.at(label, default: default)
    if kind != none {
      outline.at(kind).at(label)
    } else {
      (_) => {}
    }
  }

  (anchors.head)(head-area)
  fetch("head")(head-area)

  (anchors.neck)(neck-area)
  fetch("neck")(neck-area)

  (anchors.body)(body-area)
  fetch("body")(body-area)

  (anchors.incision)(head-area)
  fetch("incision")(head-area)

  cz.content("tx:header")[#align(center)[#writing.header]]
  cz.content("tx:footer")[#align(center)[#writing.footer]]
  cz.content("tx:body")[#align(center)[#writing.body]]
}


// Page layout

#let examples(writing, ..outlines) = {
  if preview.singleton {
    [= Samples]
    for outline in outlines.pos() {
      box[
        #cetz.canvas({
          object(writing, outline)
        })
        #text(size: 9pt)[#outline]
      ]
    }
    pagebreak()
  }
}


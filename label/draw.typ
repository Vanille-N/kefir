#import "@preview/cetz:0.2.2": *

#import draw: *

#let stroke = 0.5pt

#let dp(to, ..attrs) = {
  let as_arr = attrs.pos()
  let as_dic = attrs.named()
  let chosen = {
    if as_arr.len() > 0 {
      if as_dic.len() > 0 {
        panic("Can't handle poth positional and named arguments")
      } else {
        as_arr
      }
    } else {
      if as_dic.len() > 0 {
        as_dic
      } else {
        panic("Arguments must be provided")
      }
    }
  }
  (to: to, rel: chosen)
}

#let arrow(uid1, dir, uid2, ..args) = {
  let style = (length: 0.3cm, width: 0.2cm)
  let mark = if dir == ">" {
    (end: ">", ..style)
  } else if dir == "<" {
    (start: ">", ..style)
  } else {
    (end: ">", start: ">", ..style)
  }
  let name = args.named().at("name", default: "_line")
  line(uid1, uid2, stroke: stroke, mark: mark, angle: angle, name: name)
  let text = args.named().at("text", default: none)
  if text != none {
    content(name+".mid")[#text]
  }
}

#let crect(center, ..args) = {
  let dx = args.named().dx
  let dy = args.named().dy
  rect(
    (rel: (-dx, -dy), to: center),
    (rel: ( dx,  dy), to: center),
    ..args,
  )
}

#let point(center, ..args) = {
  circle(center, radius: 0, stroke: none, ..args)
}

#let csquare(pos, halfside, ..args) = {
  crect(pos, dx: halfside, dy: halfside, ..args)
}

#let carc(center, ..args) = {
  let a = args.named()
  arc(
    dp(center, radius: a.radius, angle: a.start),
    start: a.start,
    radius: a.radius,
    ..args
  )
}

#let orig = (0, 0)

#let cone(center, invert: false, ..args) = {
  let start = args.named().start
  let stop = if "stop" in args.named() {
    args.named().stop
  } else {
    start + args.named().delta
  }
  let stroke = args.named().at("stroke", default: (:))

  let inner = args.named().inner
  let outer = if "outer" in args.named() {
    args.named().outer
  } else {
    inner + args.named().width
  }

  group({
    merge-path(stroke: stroke, close: true, {
      if invert {
        let stop = if stop > start {
          stop - 360deg
        } else {
          stop + 360deg
        }
        carc(center, radius: inner, start: start, stop: stop)
      } else {
        carc(center, radius: inner, start: start, stop: stop)
      }
      carc(center, radius: outer, start: stop, stop: start)
    })
  })
}

#let lozenge(center, ..args) = {
  let dx = args.named().dx
  let dy = args.named().dy
  let name = args.named().name

  group(name: name, {
    let north = dp(center, 0, dy)
    let south = dp(center, 0, -dy)
    let east = dp(center, dx, 0)
    let west = dp(center, -dx, 0)
    merge-path(close: true, {
      line(east, south)
      line(west, north)
    })
    anchor("north", north)
    anchor("south", south)
    anchor("east", east)
    anchor("west", west)
  })
}

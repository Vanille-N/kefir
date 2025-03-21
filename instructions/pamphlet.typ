#import "@preview/cetz:0.3.0"
#import "@preview/cades:0.3.0": qr-code

#let preview = false

#set page(background: {
  if preview [
    #let color = rgb("FFCBC4")
    #place(center + horizon)[
    #rotate(24deg,
      text(70pt, fill: color)[
        *PREVIEW*
      ]
    )
    ]
    #place(center + horizon)[
      #rect(height: 96%, width: 96%, stroke: (paint: color, thickness: 3pt))
    ]
    #let hstrike(frac) = {
      place[#line(
        start: (-5%, frac), end: (105%, frac),
        stroke: (paint: color, thickness: 3pt)
      )]
    }
    #let top-third = 32%
    #let bot-third = 69.5%
    #hstrike(top-third)
    #hstrike(bot-third)
    #assert(bot-third - top-third > top-third)
    #assert(bot-third - top-third > 100% - bot-third)
  ]
})

#set page(margin: (x: 5mm, y: 5mm))
#set par(justify: true)
#set text(size: 12.1pt)

#let color = (
  highlight: black,
  dim: gray.darken(20%),
)

#let symbol(name) = {
  box(baseline: 20%)[#image("images/"+name+".svg", height: 13pt)]
}

#let step(title, ingredients, comments, ..params) = {
  let width = params.named().at("width", default: 100%)
  let split = params.named().at("split", default: 60%)

  box(
    stroke: (paint: gray, thickness: 0.5pt),
    radius: 5pt, inset: 5pt,
    width: width,
  )[
    #{
      if repr(comments) != repr([]) {
        table(
          columns: (split, 100% - split),
          stroke: (x,y) => (
            if x == 1 {
              (left: (paint: gray, thickness: 0.5pt))
            } else {
              none
            }
          )
        )[
          #text(size: 14pt, fill: color.highlight)[#title] \
          #ingredients
        ][
          #text(fill: color.dim)[
            #comments
          ]
        ]
      } else [
          #{ if repr(title) != repr([]) [
            #text(size: 14pt, fill: color.highlight)[#title] \
          ] }
          #ingredients
      ]
    }
  ]
}

#step[
  *0. Conservation* $(#symbol("jam") <- #symbol("water") + #symbol("sugar")"1cas" : #symbol("fridge") ; #symbol("timer") <"1-2sem")$
][
  Durée: quelques semaines au plus \
  Au frigo, dans un bocal hermétique (e.g. pot de confiture).
][
  Mettre juste assez d'eau pour submerger les grains,
  dissoudre 1 cuillère de sucre par semaine. \
]
#step[
  *1. Préparation* $(#symbol("jug") <- #symbol("water")"2L" + #symbol("sugar")"100g" + #symbol("lemon") + #symbol("fig"))$
][
  Matériel:
  - bocal de plus de 2L à large goulot
  - serviette propre (tissu ou papier), élastique

  Ingrédients:
  - 2L d'eau
  - 100g de grains de kéfir (égouttés mais pas secs)
  - 100g de sucre
  - 1 citron
  - (optionnel) quelques figues sèches
][
  Dissoudre le sucre dans l'eau. Ajouter le citron coupé en tranches de 1cm et les grains.
  Le citron doit être neuf et rinçé: ne pas utiliser de jus de citron (trop transformé),
  ne pas réutiliser un citron entamé (risque de contamination).
  Couvrir avec la serviette fixée par un élastique.
  L'obectif est que les poussières ne puissent pas entrer mais que le mélange
  puisse librement s'équilibrer en pression.
]

#step[
  *2. Fermentation 1* $(#symbol("jug"): #symbol("timer")"48h")$
][
  Durée: *48h* (optionnellement un peu plus si il fait froid) \
  Température ambiante, non hermétique, à l'abri du soleil.
][
  Des petites bulles se forment, mais la pression n'augmente pas.
  Si on a mis des figues elles remontent à la surface.
]
#step[
  *3. Filtrage* $(#symbol("bottles") <- #symbol("leaf") + [#symbol("jug") ~> #symbol("filter")])$
][
  Matériel:
  - filtre à grosses mailles (1mm)
  - 2 à 3 bouteilles qui supportent la pression (e.g. limonade)
  - conseillé: entonnoir

  Ingrédients, choisir un parmi:
  - sirop (le plus facile) (25g pour 1L)
  - arômes séchés (menthe / hibiscus)
  - fruits frais (fraise / framboise)
][
  Retirer les tranches de citron et les figues.
  Filtrer les grains.
  Il ne faut pas que le filtre soit trop fin:
  on veut retirer les grains mais garder un résidu pour continuer la fermentation.
  Une passoire marche bien, un filtre à café non.
  Les grains peuvent refaire un nouveau cycle (voir Fermentation 1),
  ou bien partir en hibernation (voir Conservation).
  Ajouter les arômes et fermer les bouteilles.
]
#step[
  *4. Fermentation 2* $(#symbol("bottles"): #symbol("timer")"48h")$
][
  Durée: *48h* (optionnellement un peu plus si il fait froid) \
  Température ambiante, bouteille hermétique, à l'abri du soleil.
][
  Attention, dorénavant les bouteilles sont sous pression.
  Ne pas ouvrir brusquement sous peine que ça gicle.
]

#step[
  *5. Maturation* $(#symbol("bottles"): #symbol("fridge") ; #symbol("timer")>"48h")$
][
  Durée: *48h* (flexible, plus long = bulles mieux dissoutes) \
  Au frigo, toujours en bouteille.
][
  La fermentation est terminée.
  Peut se conserver au frigo jusqu'à 1 mois.
  Pétillant au plus quelques jours après ouverture.
]
#step[
  *Remarques*
][
  #text(fill: color.dim)[
  - À l'issue d'un cycle de fermentation, on obtient environ 130-140g de grains pour 100g au départ.
  - Il n'est ni nécessaire ni contre-indiqué de rincer occasionellement les grains.
  - Utiliser des ingrédients BIO, et du sucre aussi peu transformé que possible.
  - Si votre eau est chlorée, laissez-la reposer 1h avant de commencer la préparation.
  - Ne pas mettre plus que 100g de sucre, la fermentation deviendrait alcoolique.
  - Ne pas laisser fermenter plus longtemps que nécessaire (étapes 2 et 4 ne doivent pas dépasser 72h chacune).
  - Il est envisageable de mettre 2-3 grains dans la bouteille pour la Fermentation 2 si le résidu seul ne suffit pas.
  ]
][]
#text(size: 11pt, fill: color.dim)[
  Fait avec Typst: #link("https://github.com/vanille-n/kefir")[`github:vanille-n/kefir`]
  #h(3.3cm)
  v0.2
  #h(3.3cm)
  Neven Villani, à Saint Martin d'Hères
]

// Page 2

#pagebreak()

#v(2mm)
#align(center)[
  #text(size: 20pt)[
    *Résumé du matériel nécessaire*
  ]
  (voir au dos pour les instructions détaillées)
]
#v(2mm)
#table(columns: (60%, 40%), inset: 0pt, stroke: none)[
  #step[
    *En 1 exemplaire*
  ][
  *Nécessaire*
  - balance
  *Recommandé*
  - passoire / filtre à grosses mailles
  - entonnoir
  ][]
  #step[
    *Réutilisable*
  ][
  *Nécessaire*
  - pot de confiture (occupé pendant les temps morts)
  - bocal d'au moins 2 à 2,5 litres (occupé pour 2 jours)
  - tissu / serviette en papier (occupé pour 2 jours)
  - 2L de bouteilles (occupées pour au moins 5 jours)
  ][]
][
  #align(center + horizon)[
    #qr-code("https://test.com", width: 4cm)
  ]
]

#step[
  *Consommable*
][
*Nécessaire*
- sucre (100g/lot)
- citron (1/lot)
*Recommandé*
- figues sèches (2/lot)
- sirop (25g/lot)
][
  Sirops testés personellement: anis, fraise, citron, fruits rouges, vanille.

  J'utilise du sucre de canne BIO pur.
]
#step[
  *Note: délai et débit*
][
  #text(fill: color.dim)[
    Si on produit en continu, avec un seul lot à la fois en première phase de fermentation,
    on a un rythme de jusqu'à 1L/jour.
    Avec 2j+2j de fermentation, et $>=2$j de maturation,
    le délai de préparation à consommation est de 6 jours,
    dont 4 jours en bouteille.
    Pour maintenir un tel rythme sans interruption il faut donc posséder
    au moins 5 à 6 bouteilles de 1L, ou 9 bouteilles de 75cL.

    Il est déconseillé de s'engager à ce rythme dès le début.
    Commencez par vous familiariser avec le processus, et n'hésitez pas à expérimenter.
  ]

  #v(3.8cm)

  #cetz.canvas({
    import cetz.draw: *
    scale(x: 90%)
    let stroke = (stroke: 0.4pt)

    line(name: "time", (0, 0), (21, 0), mark: (end: ">"), ..stroke)
    content("time.end", anchor: "north", padding: 5pt)[jours]
    for i in range(21) {
      let hgt = if calc.rem(i, 7) == 0 {
        0.1
      } else {
        0.05
      }
      line((i, -hgt), (i, hgt), ..stroke)
    }

    let batch(start, line) = {
      let lower = line + 0.2
      let upper = lower + 1 - 0.1
      let begin = start
      let mid1 = start + 2
      let mid2 = mid1 + 2
      let finish = mid2 + 3
      rect(name: "p1", (begin, lower), (mid1, upper), radius: (north-west: 10pt), ..stroke)
      rect(name: "p2", (mid1, lower), (mid2, upper), ..stroke)
      rect(name: "p3", (mid2, lower), (finish, upper), radius: (south-east: 10pt), ..stroke)
      content("p1.center")[#symbol("jug")]
      content("p2.center")[#symbol("bottles")]
      content("p3.center")[#symbol("bottles")#symbol("fridge")]
    }
    for i in range(4) {
      batch(2*i, i)
      batch(2*i + 8, i)
    }

    line(name: "sect", (6.5, 4.5), (6.5, -1), stroke: (paint: gray, dash: "dashed"))
    content("sect.end", anchor: "west", padding: 5pt)[Au max: 1 bocal, 5-6L en bouteille dont 3-4L au frigo]
  })
][]


#set page(margin: (x: 5mm, y: 5mm))
#set par(justify: true)
#set text(size: 12.1pt)

#let symbol(name) = {
  box(baseline: 20%)[#image("images/"+name+"-svgrepo-com.svg", height: 13pt)]
}

#let step(title, ingredients, comments, ..params) = {
  let width = params.named().at("width", default: 100%)
  let split = params.named().at("split", default: 60%)

  box(
    stroke: (paint: gray, thickness: 0.1pt),
    radius: 5pt, inset: 5pt,
    width: width,
  )[
    #{
      if repr(comments) != repr([]) {
        table(
          columns: (split, 100% - split),
          stroke: (x,y) => (
            if x == 1 {
              (left: (paint: gray, thickness: 0.1pt))
            } else {
              none
            }
          )
        )[
          #text(size: 14pt, fill: blue.darken(60%))[#title] \
          #ingredients
        ][
          #text(fill: gray.darken(30%))[
            #comments
          ]
        ]
      } else [
          #{ if repr(title) != repr([]) [
            #text(size: 14pt, fill: blue.darken(60%))[#title] \
          ] }
          #ingredients
      ]
    }
  ]
}

#let hstrike(frac) = {
  place[#line(
    start: (-5%, frac), end: (105%, frac),
    stroke: (paint: gray.darken(-50%), thickness: 0.1pt)
  )]
}
#let top-third = 31.4%
#let bot-third = 70.1%
#hstrike(top-third)
#hstrike(bot-third)
#assert(bot-third - top-third > top-third)
#assert(bot-third - top-third > 100% - bot-third)

#step[
  *Conservation* $(#symbol("jam-jar") <- #symbol("water-outline") + #symbol("sugar")"1cas" : #symbol("fridge") + #symbol("timer") <"7j")$
][
  Durée: 1 semaine au plus \
  Au frigo, dans un bocal hermétique (e.g. pot de confiture).
][
  Mettre juste assez d'eau pour submerger les grains,
  dissoudre 1 cuillère à soupe de sucre. \
]
#step[
  *Préparation* $(#symbol("jar-water") <- #symbol("water-outline")"2L" + #symbol("sugar")"100g" + #symbol("lemon") + #symbol("fig"))$
][
  Matériel:
  - bocal de plus de 2L à large goulot
  - serviette propre (tissu ou papier), élastique

  Ingrédients:
  - 2L d'eau
  - 100g de grains
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
  *Fermentation 1* $(#symbol("jar-water"): #symbol("timer")"48h")$
][
  Durée: 48h \
  Température ambiante, non hermétique, à l'abri du soleil.
][
  Des petites bulles se forment, mais la pression n'augmente pas.
  Si on a mis des figues elles remontent à la surface.
]
#step[
  *Filtrage* $(#symbol("pair-of-bottles") <- #symbol("leaf") + #symbol("strainer") <- #symbol("jar-water"))$
][
  Matériel:
  - filtre à grosses mailles (1mm)
  - 2 à 3 bouteilles qui supportent la pression
  - conseillé: entonnoir

  Ingrédients, choisir un parmi:
  - sirop (25g pour 1L)
  - arômes séchés (menthe, hibiscus)
  - fruits frais ()
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
  *Fermentation 2* $(#symbol("pair-of-bottles"): #symbol("timer")"48h")$
][
  Durée: 48h \
  Température ambiante, bouteille hermétique, à l'abri du soleil.
][
  Attention, dorénavant les bouteilles sont sous pression.
  Ne pas ouvrir brusquement sous peine que ça gicle.
]

#step[
  *Stabilisation* $(#symbol("pair-of-bottles"): #symbol("fridge") + #symbol("timer")>"3j")$
][
  Durée: au moins 3 jours \
  Au frigo, toujours en bouteille.
][
  La fermentation est terminée.
  Peut se conserver au frigo jusqu'à 1 mois, ou 1 semaine après ouverture.
]
#step(width: 71%)[
  *Remarques*
][
  - Un cycle produit eviron 120g de grains pour 100g au départ.
    Cela veut dire que tous les 5 cycles on peut faire don d'un lot.
    Cela signifie également qu'il faut repeser les grains au début de chaque
    cycle de fermentation pour en avoir bien 100g.
  - Il n'est ni nécessaire ni contre-indiqué de rincer occasionellement les grains.
  - Utiliser du sucre aussi peu transformé que possible.
    Préferer un citron BIO puisqu'on fait tremper y compris la peau.
][]
#h(3mm)
#step(width: 27%)[][
  Neven Villani, \
  le 16 Octobre 2024, \
  à Saint Martin d'Hères

  #v(14.5mm)

  Fait avec Typst. \
  #link("https://github.com/vanille-n/kefir")[`github:vanille-n/kefir`]
][]

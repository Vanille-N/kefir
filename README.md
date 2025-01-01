# Kefir

Recette de limonade maison.

## Dépendances

Il vous faut acquérir des [grains de kéfir de fruits](https://fr.wikipedia.org/wiki/K%C3%A9fir_de_fruits).
Si vous avez trouvé ce dépot parce que je vous ai personellement donné le lien, il est probable que je vous ai aussi
donné par la même occasion un lot de 100g de grains pour démarrer.
Sinon renseignez-vous pour en obtenir.

À titre anecdotique le matériel que j'utilise personellement est composé de
- [un grand bocal](https://www.centrakor.com/bocal-cotele-verre-et-inox-2-35l-294255.html)
- [des bouteilles de limonade 1L](https://www.naturalia.fr/produit/limonade-33-offert-1l)
- [une petite passoire](https://www.centrakor.com/passoire-bi-matiere-inox-verte-d-7-5cm-318714.html)
- et divers: couteau, écumoir, balance, entonnoir, louche, ...

## Structure du projet

- `instructions/`: la recette. Tient sur une feuille recto-verso et explique tout en détail.
  De légères variantes existent (voir ci-dessous par exemple), et vous pouvez expérimenter vous-mêmes.
- `label/`: des étiquettes. Je veux pouvoir étiquetter mes bouteilles avec la date de fermeture,
  le parfum, etc. Ces étiquettes imprimables à usage unique, très faciles à installer
  (accrochez-lez à un élastique autour du goulot) marchent bien pour mon utilisation personelle.
  
## Compiler la documentation

Ce dépôt utilise [Typst](https://typst.app/), dont vous aurez besoin d'une version récente.
Si vous avez [`just`](https://github.com/casey/just?tab=readme-ov-file) vous pouvez compiler
via `$ just` dans n'importe lequel des deux sous-dossiers.
La sortie sera un fichier PDF 2 pages fait pour être imprimé en recto-verso.

## Recette

La recette est adaptée de celle qui m'a été donnée avec mon propre lot de départ de grains.
Il existe des variantes:
- [celle-ci](https://www.symbiose-kefir.fr/recette-kefir-de-fruits/) est fonctionellement identique,
  avec de mineures différences de proportions.
- [celle-ci](https://revolutionfermentation.com/blogs/kefir-deau/comment-faire-son-kefir-de-fruits-maison/)
  omet la phase de maturation
- etc., tapez "kéfir de fruits" et vous trouverez des recettes à la pelle.
  Celle-ci est testée personellement, mais vous pouvez sans problème expérimenter.

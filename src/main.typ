#import "template.typ": project

// voir fichier `template.typ` pour modifier le template
#show: project.with(
  title: "Incorporer des outils d'intégration continue dans les processus métiers",
  subtitle: "Mémoire de fin d'année de M1 à l'EFREI",
  authors: (
    (name: "Maxime Daniel", email: "maxime.daniel@efrei.net", company: "Adagp", company_email: "maxime.daniel@adagp.fr"),
  ),
  abstract: lorem(300),
  abstract_en: lorem(300),
  // abstract: [
  //   blabla
  // ],
  date: "Version du 31 Juillet 2023",
  schoolLogo: "./assets/efrei.png",
  companyLogo: "./assets/adagp.svg",
)

= Introduction
L'évolution des projets informatiques modernes
accompagne celle de l'industrie dans son ensemble :
les projets ont hautement gagné en taille et en âge.

Pour accompagner cette nouvelle complexité,
des outils aidant au développement
et à la gestion des infrastructures
permettant de la faire fonctionner sont apparus.

Parmi ces outils, les outils d'intégration continue
sont une partie essentielle du processus de déploiement.
Il s'agit d'un ensemble de pratiques visant
à assurer la qualité du code écrit au fur du développement
de nouvelles fonctionnalités.

Ce mémoire aura donc pour but de répondre à la question suivante :
comment intégrer les pratiques d'intégration continue dans des processus métiers existants ?

Outre la réponse à cette question, ce mémoire vise également
à produire quelque éclairage sur les voies menant à un projet d'intégrations
des méthodologies d'intégration continue au sein des processus métiers
d'une entreprise.

En tout cas, pour répondre à notre problématique,
nous baserons nos conclusions sur une revue de travaux antérieurs sur ce sujet
et sur une étude de cas autour des projets réalisés pendant la rédaction du mémoire.

Nous commencerons donc par une analyse de l'état de l'art
au travers d'une revue de la littérature existante sur le sujet.
Nous continuerons en analysant le contexte de notre étude de cas,
avant de proposer une solution à notre problématique
au travers d'approches aussi bien théoriques que pratiques.
Nous mettrons en œuvre cette solution, et en critiquerons les résultats puis
finirons en déterminant le positionnement de notre étude dans l'état de l'art,
avant de tirer nos conclusions sur notre problématique.

= État de l'art
#lorem(50)
== Définition
#lorem(200)
== Présentation d'outils et technologies d'intégration continue
#lorem(700)
== Revue de littérature contextualisée
#lorem(400)

#pagebreak()

= Contextualisation de la mission en entreprise
#lorem(300)
== Contexte de l'entreprise et processus métiers existants
#lorem(400)
== Défis et lacunes
#lorem(500)
== Gains potentiels et avantages

#pagebreak()

= Proposition d'une solution
== Approche théorique
#lorem(750)
== Étapes clés et bonnes pratiques de mise en place
#lorem(350)
== Pertinence
#lorem(350)

#pagebreak()

= Mise en œuvre et responsabilités liées à la mission
== Actions entreprises
#lorem(500)
== Responsabilités assumées
#lorem(500)
== Défis rencontrés et leurs solutions
#lorem(500)

#pagebreak()

= Étude des résultats et limites du travail réalisé
== Résultats obtenus
#lorem(500)
== Analyse critique
#lorem(400)
=== Avantages
#lorem(500)
=== Limitations
#lorem(500)
== Facteurs d'influence sur les résultats
#lorem(400)
== Améliorations possibles
#lorem(400)

#pagebreak()

= Positionnement dans l'état de l'art
#lorem(150)
== Comparaison avec autres résultats prééxistants
#lorem(500)
== Contributions originales
// qu'ai-je apporté ?
#lorem(400)
== Implications et perspectives futures
#lorem(500)

#pagebreak()

= Conclusion

// - Résumé des principales conclusions du mémoire
// - Récapitulation des contributions et des recommandations
// - Possibilités d'extension et de recherche future

#lorem(500)

#pagebreak()

#bibliography("./bibliography.yml", title: "Bibliographie")

#pagebreak()

= Annexes
#lorem(50)

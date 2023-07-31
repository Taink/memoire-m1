#import "template.typ": project

// voir fichier `template.typ` pour modifier le template
#show: project.with(
  title: "Incorporer des outils d'intégration continue dans les processus métiers",
  subtitle: "Mémoire de fin d'année de M1 à l'EFREI",
  authors: (
    (name: "Maxime Daniel", email: "maxime.daniel@efrei.net", company: "Adagp", company_email: "maxime.daniel@adagp.fr"),
  ),
  // abstract: lorem(300),
  // abstract_en: lorem(300),
  abstract: [
    La création d'un logiciel de qualité est un processus complexe,
    nécessitant une grande discipline de la part de ses développeurs.
    Pour encourager cette discipline, divers outils ont été créés
    pour aider à maintenir la qualité du logiciel :
    les outils d'intégration continue.
    Ce mémoire s'intéresse au cas de l'Adagp,
    une entreprise qui souhaite incorporer
    ces outils dans ses processus métiers.
    Nous y abordons les bonnes pratiques, telles que les changements
    précédant la mise en place de ces produits
    et les raisons qui motivent les choix réalisés.
    Le mémoire décrit ensuite la mise en place de l'intégration continue par
    l'intermédiaire des Github Actions sur un projet précédent,
    mais aussi la rédaction même de ce mémoire,
    et conclut en établissant une analyse critique des résultats du projet
    puis en se positionnant par rapport à l'état de l'art.
  ],
  abstract_en: [
    The creation of quality software is a complex process,
    requiring a great deal of discipline from its developers.
    To encourage this discipline, various tools have been created
    to help maintain software quality:
    continuous integration tools.
    This thesis focuses on the case of Adagp,
    a company which wishes to incorporate
    these tools into its business processes.
    We address good practices, such as the changes
    preceding the implementation of these products
    and the motivations behind the decisions that were made.
    The thesis then describes the implementation of continuous integration by
    means of Github Actions both on a previous project,
    and the writing of this thesis itself,
    and concludes by establishing a critical analysis of the project's results
    and then positioning itself in relation to the state of the art.
  ],
  date: "Version du 31 Juillet 2023",
  schoolLogo: "./assets/efrei.png",
  companyLogo: "./assets/adagp.svg",
)

#heading(numbering: none)[Introduction]
L'informatique est un domaine qui bénéficie
du fait que son produit n'est pas constitué d'atomes.
Il est possible de créer un produit logiciel à partir de rien,
car il n'y a pas de contraintes physiques à la création d'un logiciel.
Il n'est pas nécessaire de rassembler des matières premières,
de les transformer, de les assembler, etc.
Il suffit de créer un fichier texte, et d'y inscrire du code --
ce code sera ensuite exécuté par une machine, et le logiciel sera créé.

Ce benéfice est accompagné d'un piège :
il est très facile de créer un logiciel,
mais il est difficile de créer un logiciel _de qualité_.

D'une certaine manière, le produit logiciel est l'opposé du produit physique :
plus il est utilisé, plus il est difficile à échelonner.
Plus un produit physique est âgé, plus il se déteriore.
Un produit logiciel, lui, ne se déteriore pas de la même manière :
il gagne en complexité, et devient plus difficile à maintenir.
Il doit accomoder de plus en plus de cas d'utilisation,
et couvrir de plus en plus de fonctionnalités.
Pour gérer cette complexité grandissante,
il est nécessaire de mettre en place des processus de développement
qui permettent de maintenir la qualité du logiciel.
C'est là que la discipline des collaborateurs intervient :
il est difficile de maintenir la complexité
à des niveaux raisonnables sans discipline.
L'obstacle principal à la création d'un logiciel de qualité est
la discipline nécessaire à sa création.

Pour pallier cet obstacle, divers outils ont été créés pour aider
à maintenir la discipline nécessaire à la création d'un logiciel de qualité.
Ce sont les outils qui facilitent l'intégration continue.
Ces outils permettent de s'assurer que le code écrit par les développeurs
maintient toujours le même standard de qualité,
de façon automatique et systématisée.

Ce mémoire aura donc pour but de répondre à la question suivante :
comment intégrer les outils d'intégration continue dans des processus métiers existants ?

Pour y répondre, nous nous intéresserons au cas de l'Adagp,
qui souhaite incorporer à ses processus métiers
des outils d'intégration continue.
Nous aborderons notre problématique dans un projet qui consistera
à mettre en place ces outils d'intégration continue,
et à les intégrer dans les processus métiers de l'Adagp.

De plus, ce mémoire sera l'occasion de mettre en pratique
les connaissances acquises durant l'exécution de ce projet :
nous mettrons en place les outils d'intégration continue
sur le projet de rédaction de ce mémoire.
Il utilisera un langage de balisage, les fichiers Typst.
Nous reviendrons sur son utilisation dans la @meta-memoire-markup.

Ce mémoire commencera par une analyse de l'état de l'art
au travers d'une revue de la littérature existante sur les pratiques
d'intégration continue.
Nous continuerons en analysant le contexte de notre étude de cas,
avant de proposer une solution à notre problématique
au travers d'approches aussi bien théoriques que pratiques.
Nous mettrons en œuvre cette solution, et en critiquerons les résultats puis
finirons en positionnant notre projet dans l'état de l'art,
pour conclure par une réponse à notre problématique.

#pagebreak()

= État de l'art
// Intro de cette partie ?
// idées ci-dessous

// Parmi ces outils, les outils d'intégration continue
// sont une partie essentielle du processus de déploiement.
// Il s'agit d'un ensemble de pratiques visant
// à assurer la qualité du code écrit au fur du développement
// de nouvelles fonctionnalités.

// Comme nous l'avons dit plus tôt, les outils d'intégration continue
// sont une composante essentielle de des processus de déploiement modernes.
// Commençons donc par en établir une définition.

== Définitions
=== Intégration
Avant de parler d'intégration continue, définir la notion d'intégration
dans notre contexte devrait permettre de faire comprendre exactement
ce que l'intégration _continue_ vise à faire.

Dans notre contexte, l'intégration désigne l'étape durant laquelle
on rassemble les modifications réalisées par les équipes de développement.
Cette étape précède généralement l'envoi d'un livrable au client,
et comprend donc la mise en commun des modifications,
la compilation (ou une étape équivalente), qu'on appelle généralement _build_,
et enfin les tests de conformité fonctionnelle
(souvent réalisés par un service QA dédié).

C'est une étape longue et compliquée, car elle peut révèler des bugs
qui nécessiteront un travail conséquent pour être corrigés.
C'est également souvent une source de conflits entre les équipes de
développement, l'une introduisant des changements qui impactent les autres,
sans qu'aucune équipe ne soit au courant avant l'intégration.
De plus, sur les projets à plus long terme,
c'est une étape qui peut révèler des bugs de _régression_#footnote[La
régression correspond à une diminution de la qualité ou de la complétude
du logiciel développé. Autrement dit, un changement introduit dans
une nouvelle version qui vient perturber un mécanisme d'une version
plus ancienne.], qui sont autrement plus difficile à déceler pendant
le développement.
#cite(
  "fowler-ci",
  "packt-hands-on-ci-cd",
)

=== Intégration continue <définition-ci>
Introduite dans les pratiques d'_Extreme Programming_#footnote[Il s'agit
d'une méthodologie similaire à la méthode Agile. Nous n'entrerons pas
dans les détails de son fonctionnement ici puisque la CI est devenue
indépendante de sa création et s'est standardisée dans l'industrie.]
la définition exacte de l'intégration continue
(ou "CI" pour "_Continuous Integration_"
et "IC" pour "_Intégration Continue_" dans certains ouvrages en français
-- nous utiliserons "IC" ou "intégration continue"
dans le reste de ce mémoire),
bien qu'elle soit souvent similaire,
diffère parmi les experts du domaine
#cite(
  "fowler-ci",
  "booch-ood",
  "aws-ci-def",
  "ibm-ci-def",
  "atlassian-ci-def",
  "ieee-ci-review",
).

Le socle commun est bien retranscrit par la définition de Wikipedia
@wikipedia-ci :
"L'intégration continue est un ensemble de pratiques utilisées
en génie logiciel consistant à
vérifier à chaque modification de code source que
le résultat des modifications ne produit pas de régression
dans l'application développée."

Il est en effet important de comprendre que l'intégration continue
désigne les pratiques à intégrer dans ses processus métiers,
et non les outils qui permettent d'en faciliter la mise en place.
Martin Fowler @fowler-ci explique d'ailleurs, dans son article sur le sujet,
que la différence entre un projet qui pratique de la CI
et un projet qui n'en pratique pas ne réside pas dans l'utilisation
d'un outil cher et/ou complexe,
mais dans la pratique quotidienne d'une intégration par les développeurs
sur un répertoire contrôlé du code source#footnote[Un répertoire contrôlé
du code source est un répertoire de code source utilisant un système de
contrôle de version, comme Git, CVS ou Subversion par exemple.]<vcs>.

Par ailleurs, les experts s'accordent aussi sur les objectifs de
l'intégration continue :
- Accélérer la correction de bugs, au travers de tests systématiques
  sur les modifications réalisées
  #cite(
    "fowler-ci",
    "aws-ci-def",
    "ibm-ci-def",
    "atlassian-ci-def",
    "meyer-ci-tools",
  )
- Améliorer la communication des problèmes potentiels,
  au travers de notifications lorsque les tests échouent par exemple
  #cite(
    "aws-ci-def",
    "atlassian-ci-def",
    "meyer-ci-tools",
  )
- Visualiser rapidement l'évolution du développement du logiciel
  #cite(
    "aws-ci-def",
    "ibm-ci-def",
    "atlassian-ci-def"
  )

En somme, l'intégration continue vise à réduire les problèmes
introduits par la collaboration sur les projets informatiques,
en particulier en ciblant le moment du partage des modifications
du code source.
#cite(
  "fowler-ci",
  "packt-hands-on-ci-cd",
  "aws-ci-def",
  "ieee-ci-review",
  "meyer-ci-tools",
)

L'IC s'appuie généralement sur une automatisation de ses pratiques,
et sur un système de notification en cas d'échec.
#cite("aws-ci-def", "atlassian-ci-def")

L'automatisation ne devient possible que lorsque le code source est
géré sur le répertoire d'un système de contrôle de version,
comme Git, CVS ou Subversion.
L'intégration continue peut donc nécessiter une redéfinition
en profondeur des processus de développement de logiciels,
comme nous le verrons dans notre approche théorique
de la mise en place de ce projet (voir @approche-théorie).

// === DevOps
// Le DevOps est un ensemble de méthodologies qui consistent à accélerer
// les cycles de vie des projets de développement d'applications.


== Présentation d'outils et technologies
Nous nous proposons maintenant de lister
les outils d'intégration continue les plus utilisés.

=== Jenkins <jenkins>
Jenkins est un outil d'intégration continue open-source écrit en Java.
Il est très flexible, et permet de mettre en place des pipelines
d'intégration continue très complexes.
Il est relativement facile à prendre en main,
mais la complexité des pipelines qu'il permet de mettre en œuvre
impacte sa facilité d'utilisation par rapport à des solutions plus modernes.
C'est en effet un des premiers outils répandu de son genre et
il a défini de nombreux standards dans son marché.
Il occupe encore aujourd'hui une large part
du marché des outils d'intégration continue, même si
des solutions plus récentes l'ont fait peu à peu tomber en désuétude,
notamment en créant des alternatives plus faciles d'utilisation.
#cite("ieee-ci-review", "packt-hands-on-ci-cd")

#figure(
  ```groovy
  node {
    stage('SCM') {
      git 'https://github.com/user/repo.git'
    }
    
    stage('Build') {
      sh 'mvn clean install'
    }
    
    stage('Test') {
      sh 'mvn test'
      junit 'target/surefire-reports/*.xml'
    }
  }
  ```,
  caption: [
    Une pipeline Jenkins qui permet de tester une application
    Java Maven en générant un rapport (écrite en
    #link("https://www.groovy-lang.org/", "Groovy"))
  ],
  kind: "code",
  supplement: "Fichier"
) <jenkins-example>

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [*Principaux atouts*], [*Compatible avec*],
    align(left)[
      - Écosystème robuste,
      - Communauté active,
      - Exécution sur site gratuite
        #footnote[
          L'exécution sur site est souvent
          nécessaire dans des contextes où les données utilisées
          sont sensibles@ieee-ci-review,
          ou du moins si le réseau d'entreprise
          est derrière un pare-feu peu laxiste.
        ]
    ],
    [
      N'importe quel système : Jenkins est un serveur d'automatisation.
      À partir du moment où une étape est automatisable, Jenkins peut
      l'automatiser.
    ]
  ),
  caption: [Récapitulatif Jenkins],
) <jenkins-recap>

=== Travis CI <travis>
Travis CI est un service hébergé d'intégration continue.
Il est distribué sous une licence libre#footnote[Le code est certes libre,
mais l'intégration de son offre "entreprise", qui permet d'héberger sur 
site sur une infrastructure n'est pas facile,
de l'aveu de Travis eux-même@travis-blog-install],
et s'est surtout fait connaître pour son offre gratuite pour les
répertoires publics open-source.
Il est plutôt flexible, et permet de faire à peu près la même chose
que #link(label("jenkins"))[Jenkins].
La seule différence avec ce dernier c'est qu'il doit suivre les changements
réalisés sur une plateforme en ligne, ce qui limite logiquement
sa compatibilité à une poignée de sites.
Il est cependant très facile d'utilisation, et utilise un fichier de
configuration écrit en YAML (son format est donc répandu).
C'est une idée qui est reprise dans beaucoup d'autres systèmes
similaires (et le reste des outils présentés dans cette section sont
configurés en YAML également).

#figure(
  ```yaml
  language: java
  jdk:
    - openjdk8
  script:
    - mvn clean install
    - mvn test
    - cat target/surefire-reports/*.txt
  ```,
  caption: [
    Une pipeline Travis qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "code",
  supplement: "Fichier"
) <travis-example>

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [*Principaux atouts*], [*Compatible avec*@travis-ci-compat],
    align(left)[
      - Facile d'utilisation,
      - Communauté active,
      - Mise en place très rapide,
      - Gratuit sur les projets open-source
    ],
    align(left)[
      - Github
      - Atlassian Bitbucket
      - GitLab
      - Assembla
    ]
  ),
  caption: [Récapitulatif TravisCI],
) <travis-recap>

=== CircleCI <circle>
CircleCI est un autre service alternatif à #link(label("travis"))[Travis].
Il est fonctionnellement très similaire, mais s'en distingue
par une attention plus importante à la performance et l'efficacité.
Il est un peu moins facile d'utilisation (mais toujours plus que Jenkins),
mais a mis en place beaucoup de fonctionnalités permettant d'améliorer
la rapidité des étapes de build et de test, ce qui accélère encore
davantage l'intégration continue.
@travis-vs-circleci

#figure(
  ```yaml
  version: 2.1
  jobs:
    build:
      docker:
        - image: circleci/openjdk:8-jdk
      steps:
        - checkout
        - run: mvn clean install
        - run: mvn test
        - store_test_results:
            path: target/surefire-reports
  ```,
  caption: [
    Une pipeline CircleCI qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "code",
  supplement: "Fichier"
) <circle-example>

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [*Principaux atouts*], [*Compatible avec*@travis-vs-circleci],
    align(left)[
      - Assez facile d'utilisation,
      - Mise en place et exécution très rapides,
      - Gratuit sur les projets open-source
    ],
    align(left)[
      - Github
      - Atlassian Bitbucket
      - Github Enterprise
    ]
  ),
  caption: [Récapitulatif CircleCI],
) <circle-recap>

=== GitLab CI <gitlab-ci>
GitLab CI est un outil d'intégration continue open-source
intégré à la plateforme GitLab.
Il est moins flexible que #link(label("travis"))[TravisCI] ou
#link(label("circle"))[CircleCI] mais compense son exclusivité avec
Gitlab par une intégration inatteignable pour un service externe.
Il s'appuie sur l'utilisation de conteneurs Docker,
qui lui permettent d'exécuter ses tâches dans un environnement
reproductible, souvent très proche de celui de production.
Son principal atout réside dans son intégration à la plateforme GitLab ;
il est possible depuis une pipeline Gitlab d'interagir en profondeur
avec le reste de plateforme, qui peut alors réagir directement aux
changements introduits dans les dernières versions.
@gitlab-about-ci

Il faut par ailleurs noter que l'exécuteur des tâches est un
"runner" qu'il est possible d'héberger sur site gratuitement. Des runners
hébergés par l'instance du site sont cependant mis à disposition des
utilisateurs, qui disposent de crédits d'utilisation à la minute
-- ce fonctionnement est alors le même que #link(label("travis"))[TravisCI]
et #link(label("circle"))[CircleCI].
Héberger le runner permet de l'utiliser dans un réseau d'entreprise sans
permettre à Gitlab d'y accéder, mais l'orchestration des pipelines entre
les runners est laissée à l'instance Gitlab#footnote[L'instance peut aussi
être hébergée sur site, mais c'est un projet à part entière.]

Le service CI fonctionne main dans la main avec le reste de l'offre de 
GitLab, qui se vend d'ailleurs comme une "plateforme DevOps", et qui offre
ainsi la possibilité d'unifier toutes les informations nécessaires à la
gestion du projet, fournissant des services de gestion de projet approchant
à certains égards des plateformes dédiées (comme Jira par exemple).

#figure(
  ```yaml
  image: maven:3.6.1-jdk-8
  stages:
    - build
    - test
  build:
    stage: build
    script: mvn clean install
  test:
    stage: test
    script: mvn test
    artifacts:
      when: always
      paths:
        - target/surefire-reports
  ```,
  caption: [
    Une pipeline Gitlab qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "code",
  supplement: "Fichier"
) <gitlab-example>

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [*Principaux atouts*], [*Compatible avec*],
    align(left)[
      - Intégration privilégiée avec Gitlab
      - Gratuit si runner auto-hébergé +
        crédits gratuits sur runners partagés
    ],
    [
      Gitlab seulement, possibilité d'importer des projets depuis
      Bitbucket et Github cependant.
    ]
  ),
  caption: [Récapitulatif Gitlab CI],
) <gitlab-recap>

=== Github Actions <github-actions>
Github Actions est un service très similaire à
#link(label("gitlab-ci"))[Gitlab CI],
mais pour Github au lieu de Gitlab.

Il en diffère cependant sur certains points @github-about-ci :
- Il se base non seulement sur Docker, mais aussi sur des étapes
  partagées par la communauté
- Il peut interagir avec des évènements plus variés que des modifications
  de code ; des pull requests, des issues, des commentaires, des reviews...
  C'est un outil donc beaucoup plus flexible sur la communication que
  son concurrent, qui lui est davantage pensé pour fonctionner
  avec des systèmes de déploiement complexes.
- Son runner n'est pas lui-même dans un conteneur Docker : c'est simplement
  un script shell. Cela signifie que l'environnement d'exécution du runner
  n'est pas isolé du serveur sur lequel il est exécuté.

#figure(
  ```yaml
  name: Java CI
  on: [push, pull_request]
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
      - uses: actions/checkout@v2
      - name: Set up JDK 1.8
        uses: actions/setup-java@v1
        with:
          java-version: 1.8
      - name: Build with Maven
        run: mvn clean install
      - name: Test with Maven
        run: mvn test
      - name: Archive test results
        uses: actions/upload-artifact@v2
        with:
          name: surefire-reports
          path: target/surefire-reports
  ```,
  caption: [
    Une pipeline Github Actions qui permet de tester une application
    Java Maven en générant un rapport
  ],
  kind: "code",
  supplement: "Fichier"
) <github-actions-example>

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [*Principaux atouts*], [*Compatible avec*],
    align(left)[
      - Intégration privilégiée avec Github,
      - Gratuit si runner auto-hébergé +
        crédits gratuits sur runners partagés
    ],
    [
      Github seulement.
    ]
  ),
  caption: [Récapitulatif Github Actions]
) <github-actions-recap>

== Revue de la littérature
La littérature sur l'intégration continue est souvent produite par
des acteurs du métier, mais sa croissance suit l'intérêt qui est porté
pour cette approche qui facilite grandement la collaboration sur
les projets informatiques.

#cite("fowler-ci", style: "chicago-author-title"),
présente le concept au plus grand nombre.
C'est un article fondateur, écrit en 2000 puis édité en 2006,
qui fournit plusieurs informations importantes
sur le concept d'intégration continue,
son utilité, et son applicabilité.
Il appuie sa présentation par des exemples pratiques tirés de
son expérience professionnelle, et y établit les critères nécessaires à
la bonne conduite de l'intégration continue :
- Maintenir une source de vérité unique pour le code source
- Automatiser le build
- Ajouter des tests à l'étape de build
- Tous les développeurs devraient pousser leurs modifications (ou _commits_
  dans le contexte de Git et Subversion) quotidiennement
- Toutes les commits devraient déclencher un build
- Un build raté devrait être corrigé aussitôt
- Garder un build rapide
- Réaliser les tests dans un clone de l'environnement de production
- Rendre l'accès à un exécutable récent très facile
- Tout le monde doit voir ce qui se passe
- Automatiser le déploiement

#cite("ieee-ci-review", style: "chicago-author-title")
est un travail remarquable ; dans leur propre revue de la littérature
sur le sujet, ils produisent
une synthèse très instructive sur les tenants et aboutissants de l'IC mais
aussi d'autres étapes du cycle DevOps : la livraison et le déploiement
continus.
Dans leur sélection (qui inclut 69 ouvrages, de 2004 à juin 2016), ils
notent que la majorité sont récents, et qu'ils sont pour la plupart produit
par l'industrie du développement logiciel.
Ils constatent en outre une majorité de projets web et utilitaires,
avec comme outils principaux Git/Github et Subversion pour le contrôle de
version et Jenkins comme serveur d'intégration.
Ils établissent enfin une liste de 7 facteurs qui impactent le succès des
projets d'incorporation des outils d'intégration continue,
par ordre d'importance :
1. L'effort et le temps alloués pour tester les approches
2. La transparence et la communication au sein de l'équipe
3. De bons principes de conceptions
4. Le client
5. La présence d'éléments motivés et compétents au sein de l'équipe
6. Le domaine d'application
7. Une infrastructure appropriée

Une lacune présente dans la littérature existante est cependant qu'elle peut
être sujette, du fait de sa production par des acteurs de l'industrie,
à des conflits d'intérêts ou du moins des manques d'objectivité.
Il est donc difficile de se baser sur l'avis d'une ou deux revues.

Une autre lacune, celle-là beaucoup plus importante, est que la plupart
des ouvrages récents publiés présupposent une grande familiarité avec le
reste des pratiques DevOps, et oublient un peu comment simplement intégrer
les idées de l'intégration continue dans un contexte moins compatible.
Très peu de publications expliquent leur choix de technologie, et les défis
qui ont pu les réorienter.

Ce mémoire se place donc comme un témoignage de l'applicabilité des pratiques
d'intégration continue, à travers l'incorporation de leurs outils au sein de
processus métiers orthogonaux aux pratiques DevOps.

#pagebreak()

= Contextualisation de la mission en entreprise
// #lorem(300)
Notre allons réaliser une étude de cas, celui de l'Adagp.
Cette entreprise, créée en 1953, est une société à but non lucratif.

"ADAGP" est un acronyme qui signie
"Association pour la Diffusion des Arts Graphiques et Plastiques"
#footnote[
  Elle a été rebaptisée depuis la loi 3 juillet 1986 en "Société des artistes
  dans les arts graphiques et visuels"
] ;
c'est un _Organisme de Gestion Collective_,
qui représente des artistes d'horizons très différents :
plus de 40 disciplines artistiques sont représentées
parmi les arts graphiques et plastiques
(allant de la peinture à l'architecture,
la photographie à la sculpture,
en passant par la ferronerie et la bande dessinée ou le manga).

D'après le CNC @cnc-sprd,
"[l'ADAGP] intervient dans les domaines suivants :
droit de reproduction
(livres, posters, presse, merchandising...),
droit de représentation
(audiovisuel, présentation publique...),
droit de suite,
multimédia,
copie privée,
photocopie,
droit de prêt".

Elle joue en somme un rôle d'intermédiaire juridique entre les artistes
et les personnes qui, d'une façon ou d'une autre,
veulent utiliser leurs œuvres.

C'est une entreprise de taille moyenne, dont le nombre d'employés (aussi
appelés _gestionnaires_ dans ce contexte) est d'environ 70 personnes.

Son statut juridique de SPRD
#footnote[
  Pour Société de Perception et de Répartition des Droits
]
la soumet à un contrôle annuel de la Cour des
Comptes (à l'instar d'autres sociétés d'auteur comme la SACEM ou la SACD par
exemple) et son statut de société d'auteur (et de société à but non lucratif)
l'oblige à redistribuer ses perceptions dans diverses actions,
dont l'Action Culturelle par exemple.

== Contexte de l'entreprise et processus métiers existants
// #lorem(400)
Je suis alternant au sein du service informatique de l'Adagp.
Ce service est composé de 4 personnes (3 si on omet ma présence),
et intervient dans tous les autres services de l'Adagp,
notamment à travers l'ERP développé en interne, SIGEDAV.
Ce dernier est l'outil utilisé par l'ensemble de l'entreprise
pour gérer les droits de ses adhérents.

C'est un service important, essentiel au bon fonctionnement de l'Adagp,
et qui a à ce titre une multitude de responsabilités, parmi lesquelles :
- Le développement et le support de SIGEDAV, l'ERP interne (écrit en Java),
- Le développement et le support de l'extranet,
- La gestion du parc informatique de l'Adagp,
- La gestion du réseau interne,
- Le support technique

Contrairement à la plupart des autres services de l'Adagp,
ses effectifs n'ont pas changé depuis le début de mon alternance.
Sa petite taille est à la racine de ses choix de processus métiers.

Le développement sur les applications à l'ADAGP
suit un processus d'amélioration continue.
1. En premier lieu, une demande est formulée par un utilisateur du SI
2. Ensuite, la demande est évaluée par le *précopil* ;
  il s'agit d'un comité décisionnel composé
  du service informatique
  et du comité utilisateur --
  ce dernier est de 2 représentants des utilisateurs,
  qui pourront poser des questions aux utilisateurs
  à l'origine de la demande.
3. Une seconde évaluation est réalisée par le *copil* ;
  ce comité est composé
  du service informatique,
  de la direction administrative et financière,
  et du service études et prospectives.

  Ce comité va en particulier établir l'importance de la demande.
  Pour ce faire, il va en évaluer les gains, et risques potentiels.
  Ce score détermine la priorité et les échéances d'implémentation
  de la demande si cette dernière est acceptée.
  En effet, les demandes, une fois acceptées,
  sont ajoutées au planning du service informatique,
  et le score d'importance va déterminer l'échéance de la tâche,
  qui ira d'une échéance immédiate
  pour les demandes hautement prioritaires,
  à une échéance indéfinie
  pour les demandes jugées peu importantes.
  Parfois, la demande constitue une obligation réglementaire :
  dans ce cas, il est nécessaire de se mettre en conformité
  avec la nouvelle législation --
  la demande a alors une priorité absolue
  et doit être traitée dans les plus brefs délais.
4. Un cahier des charges est rédigé,
  ainsi que des spécifications techniques,
  et une étude d'impact
  (pour déterminer quels services seront impactés par la demande).
  Cette rédaction est réalisée en collaboration
  avec les personnes à l'origine de la demande.
5. Vient enfin le temps du développement de la fonctionnalité.
  C'est aussi pendant cette étape que les tests sont écrits.
6. C'est généralement à ce stade qu'une intégration est réalisée.
  Dans certains cas,
  cette étape peut constituer la mise en place
  d'un environnement de pré-production
7. Après le développement,
  une série de tests est réalisée avec les équipes des services
  à l'origine de la demande.
8. Si tout s'est bien passé,
  la demande a bien été réalisée.
  Les modifications sont mises en production
  Une rétrospective sera faite en précopil et en copil.

#figure(
  image("assets/cycle-développement-adagp.excalidraw.svg", width: 80%),
  caption: [Cycle de l'amélioration continue des applications à l'Adagp.]
) <cycle-dev-adagp>

On peut voir en @cycle-dev-adagp que certaines étapes
mènent à revenir en arrière dans le processus d'amélioration continue.
Une autre façon de schématiser le cycle de développement de l'Adagp
est comme une série de cycles en V
(dont le cas général est produit en @cycle-en-v),
pour chaque nouvelle demande d'amélioration d'une application.

Enfin, chacun des membres du service a une spécialité qui lui incombe
(Web, Applications Java, ...),
et les application tombent dans l'une de ces spécialités.
L'application tombe sous la responsabilité de la personne
qui est spécialisé dans le domaine de l'application.
Ça n'exclut évidemment pas la responsabilité de support,
et si le membre responsable d'une application particulière est absent,
il faut que les autres membres puissent au moins diagnostiquer les erreurs
qui pourraient survenir pour y remédier.
Par conséquent, chaque membre fournit aux autres une documentation relative
à la gestion des applications dont il a la responsabilité
(installation, exploitation, mise à jour...).
La rédaction de cette documentation est un processus interne au service,
qui s'ajoute au cycle d'amélioration continue.

== Défis et obstacles <défis-et-obstacles>
// #lorem(500)
L'incorporation d'outils et méthodologies d'intégration continue
peut constituer un défi à de multiples égards.

Premièrement, l'intégration continue bénéficie grandement
de l'automatisation de certaines tâches,
travail qui n'est généralement pas déjà fait à l'Adagp.
Les tâches de test et de déploiement sont réalisées manuellement,
ce qui peut entraîner des oublis et des erreurs.
Le code d'automatisation devra donc être intégralement écrit
pendant la mise en place des outils.

De plus, l'équipe du service informatique n'utilise pas les dernières
technologies d'intégration,
et n'a pas nécessairement le temps de se former en profondeur sur le sujet.
Il faut donc trouver un compromis entre la mise en place d'une solution
efficace et la facilité d'utilisation de cette dernière.
L'expérience du service avec un outil d'intégration continue
se limite à la solution Bamboo d'Atlassian,
qui était utilisée pour l'intégration continue de l'ERP interne
avant son abandon par manque d'intérêt.
Depuis lors, l'Adagp n'a pas réutilisé d'outils d'intégration continue.
De plus, Bamboo est un outil qui est aujourd'hui délaissé par Atlassian,
en faveur de la solution Bitbucket Pipelines,
et qui est payant.

Enfin, l'Adagp est une entreprise à but non lucratif de taille moyenne,
qui n'a pas nécessairement les moyens de mettre en place une solution
d'intégration continue complexe et coûteuse.
Il faut donc trouver une solution qui soit à la fois efficace et si
possible gratuite, sinon très peu coûteuse.
Le plus difficile sera de trouver une solution
qui soit à la fois efficace et facile d'utilisation,
car les solutions gratuites sont souvent plus complexes
à installer et maintenir.

En effet,
#cite("ieee-ci-review", style: "chicago-author-date")
note que l'effort et le temps alloués
à l'expérimentation des approches d'intégration continue
sont les facteurs les plus importants pour le succès
des projets d'incorporation des pratiques d'intégration continue,
or les effectifs du service informatique de l'Adagp étant limités,
il est difficile de trouver du temps pour expérimenter
les différentes solutions disponibles
en plus des améliorations à apporter aux applications existantes.

Le plus gros défi sera cependant à long terme.
L'absence d'outils d'intégration continue n'a pas encouragé
le service à écrire beaucoup de tests unitaires
(en pratique, seuls des tests unitaires basiques sont écrits) ;
ils constituent une charge de développement supplémentaire,
charge qui peut être difficile à assumer en plus du support.
#cite("fowler-ci", style: "chicago-author-date")
encourage d'ailleurs le test du code pendant l'intégration.
Il faudra donc aussi commencer à réintégrer l'écriture
de tests de façon plus systématique
pendant le développement.

== Gains potentiels et avantages <gains-et-avantages>
// #lorem(200)
Le gain potentiel principal de l'ajout de processus d'intégration continue
est le gain en facilité de collaboration entre les membres du service.

Au-delà des simples améliorations de qualité de vie
(l'intégration continue diminue l'impact des conflits
de fusion de branches sur les système de contrôle de version comme Git,
car l'intégration comprend la compilation des projets :
on est assurés que le projet fonctionne car il _build_ malgré la fusion),
l'ajout d'outils d'IC à un projet permet surtout d'augmenter
la confiance dans le code écrit par les autres collaborateurs.
Les outils d'IC permettant d'intégrer à chaque modification,
ils augmentent mécaniquement la transparence et la communication
(au travers des logs et des notifications d'échec ou de rétablissement)
pendant le développement.

À plus long terme, l'intégration continue est surtout un bon moyen
d'éviter les régressions issues des modifications.
Le service informatique n'y a été que très peu confronté
car les projets sont généralement très cloisonnés,
de sorte que chacun connaît très bien les projets qui lui incombent
et les problèmes de régression sont généralement facilement identifiés
et rapidement corrigés.

Un autre avantage à l'incorporation de ces outils,
c'est que beaucoup de processus internes seront automatisés.
C'est une charge supplémentaire mais un gain conséquent.

Enfin, l'intégration continue est un des chemins
que le service informatique souhaite emprunter
pour mettre en place des méthodologies agiles.
L'intégration continue est en effet une étape clé
de certaines méthodologies d'inspiration agile ;
ce projet pourra constituer un retour d'expérience supplémentaire.

#pagebreak()

= Proposition d'une solution
== Approche théorique <approche-théorie>
// #lorem(750)

Avant de détailler la solution proposée,
il est important de noter que ce projet
ne se limite pas à l'installation d'un outil.
Il s'agit d'un projet de changement de processus métier,
qui nécessitera donc une communication importante
avec les développeurs et les chefs de projets.
Il faudra donc prévoir un temps de formation
pour les développeurs et les chefs de projets,
et un temps de communication pour les autres collaborateurs,
si cela est jugé nécessaire.

Il faut aussi prendre en considération que ce projet
constitue surtout un retour d'expérience
sur la mise en place de l'intégration continue
dans un processus de développement de bout en bout.

Nous avons vu précédemment, dans la @défis-et-obstacles, // Section II.2
que le service informatique a négligé jusqu'ici l'intégration continue,
principalement à cause de la charge de travail que représente
la maintenance d'un outil de ce genre,
sans compter la charge monétaire des outils les plus faciles à maintenir.

Une solution idéale, d'après nos conclusions précédentes,
aurait les caractéristiques suivantes :
- Elle serait facile (voire agréable) d'utilisation
- Elle serait gratuite
- Elle serait compatible avec les technologies utilisées à l'Adagp
  (Java, Maven, Git, Github)
- Elle serait facile à mettre en place
- Elle ne nécessiterait pas (ou très peu) de maintenance

L'outil qui s'approche le plus de ces critères,
ce sont les Github Actions (voir @github-actions-recap).

Le choix des Github Actions n'est pas anodin ;
l'Adagp confie déjà l'hébergement de ses répertoires de code à Github,
donc il n'y aura pas de migration de code à réaliser.
De plus, Github Actions est un outil
très facile à mettre en place et à maintenir,
car son orchestration est gérée par Github
-- seul le runner est hébergé sur site.

En outre, la solution Github Actions bénéficie
d'une documentation extensive,
est officiellement supportée par Github,
est gratuite pourvu qu'on héberge simplement le runner
(ce qui ne devrait pas nécessiter de grosse maintenance),
et est très facile d'utilisation car sa communauté a développé
beaucoup d'outils adaptés à des configurations potentiellement très exotiques.

Au-delà du choix de l'outil,
l'ajout de l'intégration continue dans le processus de développement
nécessitera aussi une réflexion sur le processus de développement lui-même.

Puisque le choix s'est porté sur les Github Actions,
il va être possible de tirer pleinement parti
de l'ensemble des fonctionnalités de Github :
- Les Issues, qui permettent de noter des tâches à réaliser sur le projet
- Les Pull requests, qui permettent de gérer la fusion des branches,
  de faire des revues de code, et de déclencher des actions
- Une interface de gestion de projet, qui permet de manipuler
  des Issues et de les organiser sur différentes vues
  (tableau Kanban, Roadmap, Liste)
- Une interface permettant de lister les environnements d'exécution
  du projet
- Un gestionnaire de versions avec changelog
  #footnote[
    Un changelog contient une liste des modifications apportées
    à un projet, avec des informations sur les versions
    et les dates de publication.
  ]
  et hébergement d'exécutables.

Toutes ces fonctionnalités sont très utiles mais
nous préfèrerons limiter la portée du projet dans un premier temps.
Nous nous limiterons donc à l'utilisation des Pull requests,
et nous verrons par la suite
si l'utilisation des autres fonctionnalités
est pertinente pour le service informatique.
Il est préférable d'opérer des modifications
sur les processus métiers
de manière incrémentale
-- cette première expérience avec les outils de Github
permettra de déterminer si la solution est assez robuste.

Puisque le code est géré par Git, nous allons aussi pouvoir tirer parti
de sa capacité de gestion de branches pour mettre en place
un processus de développement en tronc commun.
Le développement en tronc commun
-- _trunk-based development_ en anglais --
#cite(
  "fowler-ci",
  "trunk-based-development-website",
  style: "chicago-author-title"
),
est un modèle de gestion de branches
qui consiste à fusionner les branches de développement
dans une branche principale, commune à tous les développeurs,
dès que leurs modifications sont validées.
Tout développement supplémentaire doit être basé
sur cette branche principale.
Un diagramme résumant le processus est disponible en
@trunk-based-development-branch-diagram.

Ce modèle de gestion de branches permet de réduire
le nombre de branches à maintenir,
et de réduire le nombre de conflits lors des fusions de ces branches.
L'étape de validation des modifications peut être automatisée
par l'intermédiaire de l'intégration continue,
notamment, dans le cas de Github, par l'intermédiaire des Pull requests.
@trunk-based-development-website
Certains projets de l'Adagp utilisent déjà ce modèle de gestion de branches,
mais il n'est pas encore utilisé de manière systématique.

== Étapes clés et bonnes pratiques de mise en place <liste-étapes-clés>
La première étape du projet consistera donc principalement
à adapter les processus de développement existants.
L'élément principal à intégrer au développement est,
comme dit précédemment, le développement sur tronc commun.
C'est le meilleur moyen d'éviter des incohérences de version
et de faciliter la collaboration entre les développeurs.

La deuxième étape consistera à mettre en place les Github Actions
en compilant le code et en automatisant le déclenchement
des tests unitaires et d'intégration,
afin d'assurer la qualité du code.
Ces tests pourront être reportés dans les Pull requests,
ce qui permettra d'intégrer les tests dans le processus de revue de code,
et encouragera leur écriture.

Enfin, la troisième et dernière étape
consistera à traduire l'étape de déploiement
vers un environnement de pré-production après la revue de code.
Cette étape permettra de s'assurer que le code est fonctionnel
une fois confronté à des données réelles
avant de le déployer en production.
Il a été jugé non pertinent à l'heure actuelle de mettre en place
une étape de déploiement en continu, aussi cette dernière étape
sera déclenchée manuellement.

Enfin, il faut aussi garder à l'esprit que l'intégration continue
est un processus qui doit être maintenu et amélioré,
et qu'il requiert une certaine discipline de la part des développeurs.
Il est donc important de mettre en place des bonnes pratiques
pour assurer la pérennité de l'intégration continue.

Parmi ces bonnes pratiques,
on peut citer la correction instantanée des erreurs d'intégration,
la réduction au minimum du temps de build,
l'augmentation de la couverture de tests,
et la réduction au minimum du nombre de branches.
@fowler-ci
Ce dernier point est particulièrement important,
et devra être pris en compte tout au long des futurs
développements sur les projets concernés.

== Pertinence
// #lorem(350)

Nous avons vu dans la @gains-et-avantages // Section II.3
que la mise en place des outils d'IC est devenue suffisamment intéressante
puisqu'elle facilitera la collaboration sur un même projet
de deux colloborateurs,
sans parler des avantages classiques de l'IC.

Notre approche, basée sur l'utilisation des Github Actions,
est pertinente puisqu'elle permet de tirer parti
des fonctionnalités de Github,
qui sont déjà utilisées par le service informatique
pour gérer le code source.

Là où d'autres projets pourraient se contenter de simplement
implémenter l'IC avec un outil dédié,
nous avons choisi d'aller plus loin en redéfinissant
les processus de développement,
par exemple à travers la décision de développer sur tronc commun.

Ce que le service informatique attend de ce projet,
c'est un retour d'expérience sur l'implémentation de l'IC
avec les Github Actions,
et sur l'implémentation de processus liés à Github.
Ce projet devrait en effet permettre de déterminer
si l'utilisation de Github est pertinente pour le service informatique,
et si oui, dans quelle mesure.
Le projet, une fois abouti et diffusé à d'autres processus,
permettra de réduire le nombre d'outils à maintenir
et de faciliter la prise en main de l'IC par les développeurs.

#pagebreak()

= Mise en œuvre et responsabilités liées à la mission
== Responsabilités assumées
// #lorem(500)
Ma mission pendant mon alternance au sein de l'Adagp
consiste à épauler les autres membres du service informatique
sur ses nouveaux projets,
soit en collaboration avec le reste du service,
soit en réalisant ces projets en autonomie.

Dans le cadre de mon alternance, j'ai déjà eu l'occasion
de travailler sur plusieurs projets en collaboration avec le reste du service.
Parmi ces projets, on peut citer le projet du formulaire en ligne,
qui consistait à mettre en place un formulaire en ligne
à l'aide de l'outil Drupal Webforms
pour permettre aux futurs adhérents de l'Adagp de s'inscrire en ligne,
sans avoir à se déplacer à l'Adagp.
Ce projet permet aussi d'informatiser le processus d'adhésion,
ce qui facilite le travail du pôle adhésion
et permet d'y augmenter la capacité de traitement des dossiers.

Le projet qui concerne ce mémoire est un projet en autonomie
et interne au service informatique.
C'est un projet de recherche et développement,
qui s'appuiera le développement d'un outil informatique interne,
qui a lui aussi été développé en autonomie.
Cet ancien projet, dont j'avais aussi la charge,
est un processus serveur écrit en Typescript pour pour Node.js,
et utilisait une base de données Redis.
Il incluait aussi deux processus clients d'exemple,
dont un écrit en Javascript avec Node.js,
et un autre en Java avec Spring Boot.

Mon rôle dans ce projet de recherche et développement
consiste à déterminer le moyen d'utiliser les Github Actions
pour mettre en place de l'intégration continue l'ancien projet.

Une autre de mes responsabilités est de documenter
les choix et technologies utilisées dans ce projet,
ce qui a mené à la rédaction de ce mémoire.
Ce dernier est un outil de communication interne
qui permettra de diffuser les connaissances acquises
à d'autres projets du service informatique.

Détaillons maintenant les différentes étapes de ce projet.
== Actions entreprises
// #lorem(500)

Nous l'avons déjà vu dans la @liste-étapes-clés, // Section II.2
la première étape sur ces projets est d'adapter les processus
de développement pour permettre l'intégration continue.
Le projet précédent avait déjà été développé
en suivant le développement sur tronc commun,
et quelques tests avaient déjà été écrits,
donc le gros du travail était dejà fait.
Avant de passer à l'étape suivante cependant,
j'ai entrepris de faire une revue des tests existants,
notamment sur le client Java,
qui a la couverture fonctionnelle la plus importante.

Pour réaliser cette revue, j'ai utilisé le rapport de couverture
des tests généré par Eclipse (voir @couverture-tests-avant).
À partir de ces résultats, j'ai pu déterminer les parties
du code qui n'étaient pas couvertes par les tests,
et j'ai pu les prioriser pour les tests à écrire.

#figure(
  image("assets/couverture-tests-before.png"),
  caption: [
    Rapport de couverture des tests avant
    l'ajout de tests supplémentaires
  ],
) <couverture-tests-avant>

En particulier, j'ai pu déterminer que les tests
ignoraient complètement le test des routes nécessitant
un token d'authentification, donc j'ai écrit des tests
couvrant ce cas de figure.
En conséquence, la couverture des tests a augmenté
de 43,8% à 89,6% (voir @couverture-tests-après).
Notons d'ailleurs que je n'ai pas écrit de tests
pour les autres fichiers que `SseWebClient.java`,
car ils ne contiennent que des fonctions utilitaires
qui ne nécessitent pas de tests unitaires ou d'intégration.

#figure(
  image("assets/couverture-tests-after.png"),
  caption: [
    Rapport de couverture des tests après
    l'ajout de tests supplémentaires
  ],
) <couverture-tests-après>

De plus, j'ai remarqué que les tests faisaient appel à un client web
(le `WebClient` de Spring Boot),
qui nécessitait un service externe pour fonctionner.
J'ai donc décidé de "moquer" ce service externe,
c'est-à-dire de créer un serveur web
qui ne fait que simuler les réponses aux appels
du client au service externe (voir @sse-web-client-it).
Cela permet de s'affranchir de la nécessité d'avoir un service externe
pour faire fonctionner les tests,
et donc de pouvoir les exécuter sur le serveur d'intégration continue,
sans avoir à préparer un environnement complexe
pour la bonne exécution des tests.

Ensuite, j'ai pu passer à l'étape suivante,
qui consiste à mettre en place l'intégration continue
à l'aide des Github Actions.
Pour cela, j'ai écrit un fichier de configuration
(voir @configuration-github-actions).

#figure(
  ```yaml
  name: maven-build
  run-name: Run maven up to 'verify' phase and archive JAR

  on: [push, pull_request]

  jobs:
    maven-build:
      strategy:
        matrix:
          os: [windows-latest, ubuntu-latest]

      runs-on: ${{ matrix.os }}

      concurrency:
        group: ${{ github.workflow }}-${{ github.ref }}-${{ matrix.os }}
        cancel-in-progress: true

      steps:
      - uses: actions/checkout@v3
      - name: Setup JDK
        uses: actions/setup-java@v3
        with:
          java-version: '17'
          distribution: 'oracle'
          cache: maven
      - name: Maven build
        run: mvn -B clean verify
      - uses: actions/upload-artifact@v3
        with:
          name: compiled-jar
          path: target/*.jar
          retention-days: 1
  ```,
  caption: [
    Fichier de configuration des Github Actions
    pour l'IC du client Java
  ],
  kind: "code",
  supplement: "Fichier"
) <configuration-github-actions>

Ce fichier permet de lancer les tests unitaires et d'intégration
à chaque fois qu'un commit est poussé sur la branche principale,
ou qu'une pull request est ouverte.
Il permet aussi de compiler un fichier JAR
et de l'archiver en tant qu'artefact de l'action (pendant 1 jour).
Cela permet de pouvoir récupérer le fichier JAR
pour le déployer rapidement.
Il réalise ces actions sur Windows et Ubuntu,
et utilise le cache de Maven pour accélérer les builds.
La configuration est simplifiée par l'utilisation de Maven,
qui permet de lancer les tests et de compiler le JAR
en une seule commande.
En effet, Maven est un outil de build pour Java,
qui est organisé en phases.
Chaque phase correspond à une étape du build,
et la préciser dans la commande permet de lancer
toutes les étapes jusqu'à la phase spécifiée.
Dans notre cas, la phase `verify` est exécute aussi les phases `test`,
`integration-test` et `package`.
La phase `test` lance les tests unitaires,
`integration-test` ceux d'intégration,
et la phase `package` compile le code dans un fichier JAR.

== Défis rencontrés et leurs solutions <liste-défis-rencontrés>
// #lorem(500)

Le premier défi rencontré a été de comprendre comment fonctionnait
le client web de Spring Boot,
et comment le "moquer" pour les tests.
En effet, le client web est une abstraction
qui permet de faire des requêtes HTTP
sans avoir à écrire le code de la requête.
Il suffit de spécifier l'URL, le type de requête,
et éventuellement des paramètres,
et le client web se charge d'envoyer la requête
et de récupérer la réponse sous le format souhaité.

Mais comment faire pour tester le code qui utilise le client web,
sans avoir à faire appel à un service externe ?
Comme dit plus tôt,
la solution est de créer un serveur web "fictif",
qui va simuler les réponses du service externe.
Un exemple de fichier de tests d'intégration utilisant ce mécanisme
est disponible en @sse-web-client-it.

Une alternative aurait été d'utiliser un conteneur de service
sur la configuration des Github Actions
pour lancer le véritable service externe,
mais cela aurait été moins intéressant à mettre en place,
pour plusieurs raisons :
1. Il aurait fallu créer un `Dockerfile` pour le serveur Node.js,
  ce qui veut dire que ce dernier
  devrait gérer une étape de build supplémentaire,
  et donc que le build serait plus long et plus difficile à maintenir.
2. Il aurait fallu limiter les tests à la plateforme Linux,
  car Github Actions ne permet pas de lancer des conteneurs de service
  si le runner est hébergé sur Windows,
  or il est important de tester le code sur les deux plateformes
  puisqu'elles sont potentiellement toutes deux utilisées par l'Adagp.
  Cela aurait donc limité l'applicabilité des tests.
Ce sont ces deux raisons qui expliquent que le serveur externe ne soit
pas lui-même testé dans le cadre de ce mémoire.

Le build pouvait aussi être assez long, alors que les tests
ne sont pas très nombreux.
En effet, le build compile le code, mais pour cela il doit télécharger
toutes les dépendances du projet.
Cela prend du temps, et cela peut être évité en utilisant le cache de Maven.
Le cache de Maven permet de stocker les dépendances déjà téléchargées
pour les réutiliser lors des builds suivants.
Cela permet de réduire le temps de build,
et donc de réduire le temps avant de recevoir le retour des tests.
Cela permet aussi de réduire la consommation de bande passante,
puisque les dépendances ne sont téléchargées qu'une seule fois.
Le cache de Maven est activé dans la configuration des Github Actions
dans le @configuration-github-actions,
grâce à la ligne `cache: maven` qui configure `actions/setup-java`
pour mettre en cache les dépendances de Maven.

Enfin, avec un peu plus de temps, il aurait été intéressant
de poursuivre avec la troisème étape décrite dans la @liste-étapes-clés.
En effet, cela aurait permis de tester le client Java
dans un environnement plus proche de la réalité,
et de confronter le client Java à des situations
qui ne sont pas prévues par les tests automatiques.

Les processus de build et de test sont maintenant automatisés,
donc il est toujours possible de déployer manuellement le projet
auquel l'intégration continue a été ajoutée.
Des processus existant déjà à l'Adagp pour déployer des projets comparables,
il a été décidé de ne pas en automatiser le déploiement ici -- pour l'instant.
C'est la raison pour laquelle ce mémoire
se concentre sur l'intégration continue,
et non sur un processus complet.

== Rédaction de ce mémoire <meta-memoire-markup>

Ce mémoire a été rédigé en utilisant le langage de balisage des fichiers
#link("https://typst.app/", "Typst").
C'est un nouveau langage de balisage, à la fois similaire à Markdown
pour sa simplicité et sa lisibilité, et à LaTeX pour sa puissance et
sa capacité à gérer des documents complexes.
Puisqu'il est encore en développement,
il n'est pas encore totalement abouti,
mais il était adapté aux besoins de ce mémoire.

Afin de faciliter la rédaction de ce mémoire,
son évolution a été suivie par un outil de gestion de versions, Git.
Cela permet de conserver un historique des modifications,
et puisque Typst utilise un format de fichier texte,
il est possible de voir les modifications apportées à chaque version
du mémoire, et de les comparer.

Pour aller plus loin et vérifier la robustesse des Github Actions
dans le cadre même de la rédaction de ce mémoire,
un processus d'intégration continue a été mis en place
pour compiler un PDF à chaque modification du mémoire.

Ce processus est décrit dans le fichier de configuration disponible en
@configuration-github-actions-memoire.

#pagebreak()

= Étude des résultats et limites du travail réalisé
== Résultats obtenus
Le résultat de ce travail est un client Java compilé,
testé sur Windows et Linux,
et qui fournit une archive de son JAR pendant 1 jour.

Github Actions, en plus de lancer les tests et d'archiver le JAR,
permet d'afficher les résultats des tests dans une interface web.

Une capture d'écran de cette interface est disponible en @ci-results-dashboard.
On peut diviser cette interface en trois parties :
1. Un résumé de l'exécution, en haut.
  Il indique le statut de l'exécution,
  le temps qu'elle a pris,
  quel commit l'a déclenché et le nombre d'artefacts générés.
2. La liste des builds, avec leur statut et leur durée, au centre.
  Cette liste se présente sous la forme d'un graphique,
  qui lie les relations de chaque "job",
  c'est-à-dire chaque tâche du processus d'intégration continue.
  Dans notre cas, il n'y a qu'un seul job, mais deux exécutions :
  une pour Windows, et une pour Linux.
3. Les artefacts, en bas.

#figure(
  image("assets/ci-results-dashboard.png"),
  caption: "Résultats des tests sur Github Actions",
) <ci-results-dashboard>

L'interface permet aussi de voir les logs de chaque job, en cliquant dessus.
Cela permet de voir les logs de chaque étape d'un job.
Une capture d'écran de cette interface est disponible en @ci-results-job.
Sur cette capture d'écran, on peut voir que le job a été exécuté sur Ubuntu,
et que les tests ont réussi.

L'étape de build de Maven est déroulée, à côté de laquelle on peut voir
le temps qu'elle a pris, et son statut particulier.
Une fois déroulée, les logs sont affichés, et on peut voir
le déclenchement des tests puis leur réussite en @ci-results-job2.

#figure(
  image("assets/ci-results-job.png"),
  caption: "Affichage d'un job sur Github Actions",
) <ci-results-job>

#figure(
  image("assets/ci-results-job2.png"),
  caption: "Affichage d'un job, avec les logs déroulés, et les résultats des tests",
) <ci-results-job2>


On a donc un reporting détaillé de l'exécution des tests,
qui permet de voir les résultats et les logs de chaque étape,
ainsi qu'un JAR compilé.

== Analyse critique
// #lorem(400)
Les résultats obtenus sont satisfaisants.
Le client Java est compilé et testé sur deux plateformes,
et les résultats des tests sont affichés dans une interface web.
Cela permet de s'assurer que le client Java est fonctionnel,
et que les tests sont toujours valides.

L'intégration continue a été mise en place sur un projet existant,
et pourra aussi bien servir de précédent à des projets futurs
ou bien à d'autres projets plus anciens qui nécessiteraient un travail
de ce genre pour être maintenus.

Nous allons maintenant revoir point par point
d'abord les avantages de notre approche,
puis ses limites.

=== Avantages
// #lorem(500)
L'intégration continue permet de s'assurer que le projet est toujours
fonctionnel, et que les tests sont toujours valides.
Cela permet de détecter rapidement les régressions,
et de les corriger avant qu'elles ne soient trop importantes.

La taille du projet choisi a permis d'itérer rapidement
sur les différents choix de solution,
et de trouver une solution qui convienne davantage.

La collaboration est également facilitée du fait de la simplicité
du modèle de développement en tronc commun et des certitudes
apportées par l'intégration continue sur les pull requests.

Le résultat est clair : le projet est accueillant aux collaborations,
et les contributions sont validées par l'intégration continue.
Cela offre un environnement dans lequel la discipline nécessaire
à la maintenance d'une grande qualité logicielle est facilitée.

L'intégration n'est plus un obstacle au développement puisque le
développement et le partage des modifications apportées au projet
nécessitent que l'intégration fonctionne à toutes les étapes.
=== Limitations <section-limitations>
La plus grosse limitation de cette approche est la taille du projet
de départ.

En effet, le projet est petit, et ne nécessite pas beaucoup de tests.
Cela a permis d'itérer rapidement sur les différentes solutions,
mais cela a aussi limité la portée de notre expérimentation sur
la robustesse de la solution Github Actions.
Le retour d'expérience est partiellement amélioré par le choix
d'appliquer l'IC à la rédaction du mémoire, mais cela reste
marginal et une limitation important de notre approche.

Une autre limitation est le fait que le projet ne soit pas
complètement abouti par rapport aux étapes clés décrites dans la
@liste-étapes-clés.
En effet, le projet ne possède pas d'étape de déploiement et la
relègue à "un exercice pour le lecteur", d'une certaine manière.
Cela est dû au fait que le projet est un prototype,
et que le temps de développement était limité.

Il reste enfin un élément non testé sur le projet initial :
le serveur Node.js sur lequel le client Java se connecte.
Nous avons effectivement brièvement mentionné dans la @liste-défis-rencontrés
que le serveur Node.js n'était pas testé.
Cela est dû au fait que le serveur Node.js est un prototype,
et que la mise en place de ses tests nécessitait un travail qui dépassait
les prérogatives initiales de ce projet.

== Facteurs d'influence sur les résultats <section-facteurs-influence>
// #lorem(400)
// facteur d'influence : technologies utilisées
Le premier facteur d'influence sur les résultats est le choix
des technologies utilisées.
Le projet initial utilise Java, et Maven.
Ce sont des solutions robustes, quasiment clé en main,
et elles ne démontrent peut-être pas la robustesse de la solution
Github Actions par rapport à des solutions plus exotiques.
Ce n'est cependant pas un problème pour le cas précis des Github Actions,
car c'est une solution très flexible et customisable, et la communauté
autour de Github Actions est très active ;
beaucoup d'actions existent déjà, et il est facile d'en créer de nouvelles
(voir @github-actions).
La rédaction de ce mémoire en témoigne d'ailleurs :
le projet est rédigé dans un langage de balisage assez nouveau,
et donc peu supporté.
Plusieurs solutions étaient disponibles pour la compilation du mémoire,
ce qui prouve la flexibilité de Github Actions.
La solution choisie, de passer par l'action `yusancky/setup-typst`,
est la méthode canonique, et la plus simple à mettre en place,
mais il aurait été possible de passer par un conteneur Docker par exemple
(voir @configuration-github-actions-memoire).

// facteur d'influence : taille du projet
Comme nous l'avons vu dans la @section-limitations,
la taille du projet est un facteur d'influence important,
qui a limité la portée de notre expérimentation.
Il a dicté la simplicité de la configuration, et a réduit
le temps nécessaire à la mise en place de l'intégration continue.

// facteur d'influence : temps de développement
Ce temps de mise en place est un autre facteur d'influence.
Le projet avait un temps de développement limité,
et il a donc fallu privilégier des solutions rapides
et simples à mettre, mais aussi à transmettre et maintenir.

// facteur d'influence : expérience du développeur
Ma propre expérience a aussi influencé les résultats.
J'étais déjà familier avec Github Actions, et j'ai donc pu
mettre en place l'intégration continue rapidement.
Un autre développeur aurait peut-être privilégié une autre solution,
pour des raisons qui ne me sont pas familières du fait de mon
inexpérience sur cette dernière.
Mon expérience a aussi influencé le choix des technologies,
puisque j'ai choisi des technologies que je connaissais déjà.

// facteur d'influence : taille de l'équipe ciblée
Enfin, la taille de l'équipe ciblée est un autre facteur d'influence.
En effet, l'intégration continue est plus utile dans une équipe
où la collaboration des équipe est fréquente,
puisqu'elle permet de s'assurer que les modifications apportées
potentiellement quotidiennement (voir plus souvent encore)
par les autres membres de l'équipe ne cassent pas le projet.
Peut-être que si cette solution avait été mise en place dans
un environnement plus gros, n'aurait-elle pas été aussi pertinente.
Ce mémoire se limitant au cas de l'Adagp,
ce n'est pas un facteur d'influence d'une grande importance
pour son service informatique.

== Améliorations possibles
// #lorem(400)

Les premières améliorations possibles sont les plus évidentes :
il s'agit de compléter le projet initial pour qu'il corresponde
aux étapes clés décrites dans la @liste-étapes-clés.
Cela permettrait de valider l'approche sur un projet plus complet,
et de réellement tester la robustesse de la solution Github Actions
sur un processus d'intégration continue réellement abouti.
Il faudrait donc ajouter une étape de déploiement,
et compléter le serveur Node.js pour qu'il soit testé.

Les autres sont plus discutables car elles relèvent de l'opinion,
ou des circonstances du projet.

Il aurait été par exemple préférable
de choisir une application existante plus complexe,
pour éprouver réellement la solution Github Actions.

// amélioration possible : tests unitaires
Il aurait aussi été préférable de mettre en place des tests unitaires.
Le projet initial ne s'y prêtait pas, car il s'agissait d'un prototype
algorithmiquement très simple.
Cependant, il aurait été possible de mettre en place des tests unitaires
sur le serveur Node.js, pour tester son bon fonctionnement.

#pagebreak()

= Positionnement dans l'état de l'art
== Comparaison des résultats obtenus
// #lorem(500)

Nous avons vu plus tôt que le service informatique de l'Adagp
n'utilisait pas d'intégration continue.
Plusieurs raisons ont été évoquées, mais la principale est que
le service informatique n'a pas alloué de temps pour la mise en place
d'une telle solution, qui n'est de toute façon pas une priorité.

// comparaison des résultats obtenus : temps de mise en place
Dans ce projet, la rapidité de mise en place a donc été
le premier facteur d'influence sur les choix réalisés.
Github Actions a été privilégié car il s'agit d'une solution
très simple à mettre en place, et qui ne nécessite pas de serveur dédié.

Dans le cas de @overcoming-challenges-small-company,
la contrainte majeure n'était pas le temps de mise en place,
mais le coût de la solution.
La taille de l'entreprise limitait ses perspectives pour répondre
aux défis d'un changement de structure de leurs logiciels.
Ils ont fait le choix de mettre en place des pipelines
qui géraient elles-mêmes leur propre infrastructure,
ce qui leur a permis d'automatiser une grande partie de leur processus.
L'automaticité de la solution est un facteur d'influence
qui n'était pas envisagé dans notre projet --
nous n'avons pas de besoin de scalabilité qui pourraient nous mener
à chosir une infrastructure en microservice.
Cependant, ce rapport démontre que tous les facteurs envisagés pendant
notre étude ne correspondent pas à une liste exhaustive des critères à
prendre en compte, et ce pour une bonne raison :
la liste est potentiellement infinie,
et dépend du contexte de l'entreprise.

Voyons le cas d'une entreprise de plus grande taille, la Deutsche Bank.
Leur infrastructure technologique était construite sur des systèmes
hérités de leur bagage historique,
et ils ont décidé de mettre en place des pratiques d'automatisation
de façon plus systématique.
@paving-devops-runway

Que tirer de cette expérience, dans notre contexte ?
Déjà, ils établissent une liste de trois critères importants
au début de leur publication :
- le développement de compétences au sein de l'entreprise
- la standardisation de leurs solutions
- la documentation des défis rencontrés et leurs solutions
On constate alors contre-intuitivement que leurs critères
correspondent relativement bien à ceux que nous avons établis
dans notre étude, alors que l'Adagp est un bien plus petite entreprise.
Ils ont même fait le choix d'employer la même solution que nous pour
leur intégration continue : les workflows de Github, ou Github Actions.
Leur approche est évidemment plus globale que la nôtre,
puisqu'ils ont mis en place un nouvelle infrastructure complète là
où nous avons simplement mis en place une solution d'intégration continue,
pour un seul projet de recherche et développement.
Cela pointe cependant un fait : certains éléments de
la liste des critères de réussite d'un projet d'intégration continue
ne dépend pas du contexte de l'entreprise, mais sont universels --
ou du moins, valables pour une grande variété de contextes.

== Contributions originales
// qu'ai-je apporté ?
// #lorem(400)
Le projet couvert par ce mémoire était de petite envergure,
et n'a pas permis de produire de contributions révolutionnaires
ou même particulièrement originales.
Le seul élément original de ce projet est la mise en place
d'une solution d'intégration continue pour l'écriture du mémoire lui-même.

Cependant, ce projet a fait remonter plusieurs points d'attention
pour la mise en place d'une intégration continue :
- la mise en place d'une intégration continue est un processus
  qui nécessite de la réflexion et de l'expérimentation,
  et qui ne peut pas être réalisé d'un seul coup ;
  c'est un procédé complexe et progressif (cf. @approche-théorie)
- beaucoup de publications résument l'intégration continue
  à la mise en place d'un serveur d'intégration continue,
  mais il s'agit d'une vision réductrice ;
  la mise en place d'une intégration continue nécessite
  de prendre en compte de nombreux facteurs (cf. @section-facteurs-influence)

== Implications et perspectives futures
// #lorem(500)

Ce mémoire a produit un travail de recherche et d'expérimentation
sur l'intégration continue, et plus particulièrement sur la solution
Github Actions.
Il a permis de mettre en place une solution d'intégration continue
pour un projet Java, et de tester la robustesse de la solution Github Actions
jusqu'à un certain point.
Il a permis de mettre en évidence les principaux prérequis pour la mise
en place d'une intégration continue, et de démontrer que Github Actions
est une solution viable pour ce faire.

Si une entreprise souhaite réaliser un travail similaire,
il est important de prendre en compte les facteurs d'influence
qui ont été mis en évidence dans ce mémoire.
Il est aussi important d'établir une liste de critères de réussite
pour le projet, et de les garder en tête tout au long du projet.
Enfin, il est important de garder en tête que la mise en place
d'une intégration continue est un processus complexe et progressif,
qui nécessite de la réflexion et de l'expérimentation --
il ne faut pas s'attendre à ce que la solution soit parfaite,
ni jamais terminée.
Incorporer l'intégration continue dans les processus métiers
de son entreprise constitue un changement radical
dans la gestion des projets de développement de l'entreprise.

Parmis les principales perspectives d'extension de ce travail,
il y a la mise en place d'une intégration continue plus complète,
qui permettrait de valider l'approche sur un projet plus complexe.
Il serait aussi intéressant de tester la solution Github Actions
sur un projet plus complexe.

Une autre perspective d'extension serait de tester l'utilisation
de la solution Github dans sa totalité, pour voir comment elle
peut employer l'intégration continue pour la gestion de projet
et voir si les Github Actions peuvent être utilisées pour
la gestion de projet.

Enfin, il pourrait être intéressant de comparer le contexte interne
de solutions propriétaires d'intégration continue avec celui
de solutions open-source, pour voir si les facteurs d'influence
sont les mêmes.

#pagebreak()

#heading(numbering: none, level: 1)[Conclusion]

// - Résumé des principales conclusions du mémoire
L'engouement récent pour les solutions d'intégration continue
découle de leur efficacité dans la résolution des problèmes
de maintenabilité des projets informatiques.
C'est un avantage indéniable qui profite à toute entreprise
souhaitant s'investir dans la qualité des logiciels qui la composent.

Dans le contexte de l'Adagp, la mise en place d'une intégration continue
devrait permettre de faciliter le travail de maintenance de qualité logicielle
en automatisant beaucoup de tâches, tout en standardisant les processus
et leur documentation.

// - Récapitulation des contributions et des recommandations
Ce que ce projet a apporté à l'Adagp, c'est une réponse à la question
de la faisabilité de la mise en place d'une intégration continue
dans ses processus métiers, en établissant une liste de facteurs
d'influence et de critères de réussite pour un projet d'intégration continue.
Ces facteurs sont :
- la complexité du projet ;
- la taille de l'équipe, ou le nombre de collaborateurs ;
- les processus de développement en place ;
- l'expérience des collaborateurs ;
- le temps alloué au projet ;
- le budget alloué au projet ;
- le choix de la solution d'intégration continue.
Quant aux critères de réussite, ils sont moins nombreux :
les tests doivent éprouver la qualité du logiciel,
et la solution doit être facile à maintenir.

Ce mémoire m'aura personnellement permis d'acquérir des connaissances
sur l'intégration continue, et sur la solution Github Actions,
sous un angle théorique et pratique, et de les confronter
aux besoins de l'entreprise dans laquelle je réalise mon alternance.
Il m'aura aussi permis de mettre en pratique des compétences de
rédaction à la fois académiques et techniques, et d'éprouver
une nouvelle solution pour leur rédaction.

// - Possibilités d'extension et de recherche future
Une prochaine étape pour l'Adagp serait de mettre en place
une solution d'intégration continue plus complète,
sur un projet plus complexe, pour valider l'approche.
Il faudrait alors intégrer davantage les éléments apportés par
l'intégration continue dans les processus métiers de l'entreprise,
notamment par exemple dans la revue de code ou dans le déploiement.

#heading(numbering: none, level: 2)[Remerciements]
- Merci à ma tutrice, Imen RACHED,
  pour ses conseils avisés au début de la rédaction du mémoire.
- Merci à mon maître d'apprentissage, Frédéric GOUILLON,
  pour son soutien et ses conseils
  pendant la réalisation de ce mémoire, et pendant mon apprentissage.
- Merci au reste du service informatique,
  Tovonirina RAZAFIMAHATRATRA et Vincent LY,
  pour leur disponibilité et leur aide, tout au long de mon temps à l'Adagp.
- Merci au reste de mes collègues de l'Adagp,
  pour leur accueil et leur bonne humeur.
- Merci à ma famille, pour les conseils apportés et leur soutien.

#pagebreak()

#bibliography("./bibliography.yml", title: "Références", style: "ieee")

#pagebreak()

#heading(numbering: none)[Annexes]
#figure(
  image("assets/wikipedia-cycle-en-v.png"),
  caption: [
    Cycle en V
    (Source: #link("https://fr.wikipedia.org/wiki/Cycle_en_V", "wikipedia"))
  ],
  kind: "appendix",
  supplement: "Annexe",
  numbering: "A"
) <cycle-en-v>

#figure(
  image("assets/trunk1b.png"),
  caption: [
    Diagramme de développement en tronc commun --
    à comparer avec l'@trunk-based-development-branch-diagram-at-scale
    (Source: #link("https://trunkbaseddevelopment.com/",
    "site de présentation du développement en tronc commun"))
    @trunk-based-development-website
  ],
  kind: "appendix",
  supplement: "Annexe",
  numbering: "A"
) <trunk-based-development-branch-diagram>

#figure(
  image("assets/trunk1c.png"),
  caption: [
    Diagramme de développement en tronc commun --
    à comparer avec l'@trunk-based-development-branch-diagram
    (Source: #link("https://trunkbaseddevelopment.com/",
    "site de présentation du développement en tronc commun"))
    @trunk-based-development-website
  ],
  kind: "appendix",
  supplement: "Annexe",
  numbering: "A"
) <trunk-based-development-branch-diagram-at-scale>

#figure(
  ```java
  public class SseWebClientIT {
    
    private final MockWebServer mockWebServer = new MockWebServer();
    private final SseWebClient<String> webClient = new SseWebClient<>(
        WebClient.create(mockWebServer.url("/").toString()),
        String.class
    );

    @AfterEach
    void teardownMockServer() throws IOException {
      mockWebServer.shutdown();
    }

    @Test
    void shouldRetrieveDataFromServer() {
      final StringBuilder eventStreamBuilder = new StringBuilder();

      // add 15 events
      for (int i = 0; i < 15; i++) {
        eventStreamBuilder
            .append("event: newEvent\ndata: mydata\n\n");
      }

      mockWebServer.enqueue(
          new MockResponse()
              .setResponseCode(200)
              .setHeader(
                  HttpHeaders.CONTENT_TYPE,
                  MediaType.TEXT_EVENT_STREAM
              )
              .setBody(eventStreamBuilder.toString())
      );

      Flux<String> times = webClient.retrieveData("/events");
      
      assertNotNull(times);
      times.take(5).count().subscribe((c) -> assertTrue(c > 0));
    }

    // other test cases
  }
  ```,
  caption: [
    Exemple de test d'intégration avec un serveur web fictif
  ],
  kind: "appendix",
  supplement: "Annexe",
  numbering: "A"
) <sse-web-client-it>

#figure(
  ```yaml
  name: Typst pdf build

  on:
    push:
      tags: [ "v*.*.*" ]
      branches: [ master ]
    pull_request:
      branches: [ master ]
    

  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
      - uses: actions/checkout@v3
      - uses: yusancky/setup-typst@v2
        with:
          version: 'v0.6.0'
      - name: Compile pdf
        run: typst compile src/main.typ ./memoire.pdf
      - name: Test file presence
        run: file memoire.pdf
      - name: Upload artifact
        uses: actions/upload-artifact@v3
        with:
          name: memoire
          path: memoire.pdf

    publish:
      needs: build
      runs-on: ubuntu-latest
      if: github.event_name == 'push' && startsWith(github.ref, 'refs/tags/v')
      steps:
      - uses: actions/checkout@v3
      - name: Download pdf
        uses: actions/download-artifact@v3
        with:
          name: memoire
      - uses: softprops/action-gh-release@v1
        with:
          files: memoire.pdf
  ```,
  caption: [
    Configuration de Github Actions pour la compilation du code source
    de ce mémoire et la génération du PDF final --
    un PDF est généré à chaque push ou PR sur la branche master,
    et il est publié sur la page de release de chaque nouveau tag de version
  ],
  kind: "appendix",
  supplement: "Annexe",
  numbering: "A"
) <configuration-github-actions-memoire>

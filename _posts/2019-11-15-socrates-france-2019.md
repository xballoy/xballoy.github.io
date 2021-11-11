---
layout: post
title: "De retour de SoCraTes France 2019"
author: "Xavier Balloy"
first_published_site: Just-Tech-IT
first_published_link: https://medium.com/just-tech-it-now/de-retour-de-socrates-france-2019-7753116b7a9
tags:
  - code retreat
  - kata
  - software craftsmanship
---
Du 17 au 20 octobre avait lieu un des événements incontournables autour du
mouvement _software craftsmanship_ (artisanat logiciel) en France. SoCraTes-FR
se définit comme une non-conférence, en effet, il s’agit plus d’une retraite que
d’une conférence.
<!--more-->

![Le Château de Massillan](/assets/2019-11-15-socrates-france-2019-1.jpeg)
Le Château de Massillan où a eu lieu SoCraTes-FR 2019

L’agenda, notamment, n’est pas connu à l’avance, mais se constitue chaque matin
par les (très nombreuses) propositions d’ateliers que chacun est encouragé à
proposer. L’agenda du 18 octobre, difficile de choisir avec tant de
propositions !

![L’agenda du 18 octobre](/assets/2019-11-15-socrates-france-2019-2.jpeg)
L’agenda du 18 octobre, difficile de choisir avec tant de propositions !

La qualité logicielle fait partie de l’ADN d’AXA, c’est donc naturellement que
nous sponsorisions l’événement et envoyons nos développeurs. J’ai eu la chance
de participer à cet événement pendant lequel j’ai échangé sur des sujets très
divers allant de DDD, aux revues de code, en passant par des échanges sur le
green IT et par de nombreux katas.

Voici quelques éléments des échanges que j’ai pu avoir au cours de ces quatre
jours.

## Revue de code

Je ne pensais pas que les revues de code étaient un sujet qui m’aurait amené à
de telles discussions. Pour moi, c’est quelque chose que tout le monde fait et
qui s’inscrit dans les bonnes pratiques lorsque l’on veut améliorer la qualité
logicielle.

Eh bien non ! Même les revues de code ont leurs détracteurs.

Les principaux arguments de ces derniers sont qu’elles ne sont généralement pas
bien faites. Par exemple, on ne récupère pas le code en local, on se contente de
survoler le code que ce soit lors d’une _pull request_ ou lorsque l’on nous
présente du code. Finalement, on ne fait que relire le code pour trouver des
erreurs de nommage, de typographies, de formatage ou des bugs évidents.

Par contre, on ne se pose pas (ou peu) de question sur le fonctionnel qui est
développé, notamment parce que **toute l’équipe** ne connaît pas en détail
toutes les fonctionnalités de l’application. Pire encore, selon le niveau de
confiance que l’on a en la personne, on relira différemment le code ! On aura
tendance à faire plus confiance à une personne qui travaille depuis longtemps
dans l’équipe et qui fait moins d’erreurs par exemple.

En partant de ce constat, certaines entreprises ont choisi de ne plus faire de
revues de code, mais de faire beaucoup plus de _pair programming_ et de mob
programming.

### Le pair programming

Le _pair programming_ est une méthode de travail dans laquelle deux développeurs
travaillent ensemble sur un même poste de travail.

Cette technique s’avère être utile pour les nouveaux arrivants (expérimentés ou
juniors) afin qu’ils découvrent les méthodes de travail et les bonnes pratiques
mises en place. Cela évite aussi les allers-retours potentiels des premières
_pull requests_.

Ces derniers sont contre-productifs : on relit plusieurs fois le même code, les
développements n’avancent pas et le développeur pourrait être frustré ou prendre
personnellement les remarques. Cette phase de _pair programming_ terminée, qui
peut-être assimilé à du mentorat et dure plusieurs semaines, il est possible de
faire confiance à ces personnes et de ne plus relire leur code (ou pas
entièrement).

### Le mob programming

Le _mob programming_ est similaire au _pair programming_ sauf que toute l’équipe
travaille sur la même fonctionnalité ! L'un des principaux avantages est que
toute l’équipe partage la connaissance fonctionnelle et la propriété du code. On
n’entendra plus dire : “Ce n’est pas mon code / bug, c’est celui de Paul.” ou
“Qui a travaillé sur cette fonctionnalité ?”. D’autre part comme le code est
écrit de manière collaborative il est de meilleure qualité et il n’y a plus
besoin de le relire.

![mob programming](/assets/2019-11-15-socrates-france-2019-3.png)
Faire du _mob programming_ c’est comme faire du pair programming puissance n
donc avoir du code pérenne. — Quelqu’un lors d’un échange à SoCraTes

## Katas

Lors de cet événement, j’ai pratiqué plusieurs katas qui m’ont permis de
découvrir un nouveau langage (Haskel) et des nouvelles façons de coder. Un kata
de code est un exercice de développement qui permet de perfectionner ses
compétences à travers la pratique et la répétition.

Si cela vous intéresse, j’ai pratiqué les katas suivants :

- [FizzBuzz](http://codingdojo.org/kata/FizzBuzz/)
- [RPN Calculator](http://codingdojo.org/kata/RPN/)
- [Roman Numerals](http://codingdojo.org/kata/RomanNumerals/)

### TCR à la place de TDD

J’ai eu l’occasion d’appliquer TCR, un acronyme pour test && _commit_ || _
revert_. Il s’agit d’une méthode de programmation proposée
par [Kent Beck](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864)
(l’inventeur du TDD). Son principe est que lorsque l’on exécute les tests, s’ils
ne passent pas, on _revert_ le code !

Nous l’avons appliqué d’une manière un peu moins extrême lors du kata, avant de
lancer les tests on faisait un pari sur le fait qu’ils passent ou pas. Si le
pari est gagné, on _commit_, sinon on _revert_. Cela permet de passer par la
phase “barre rouge” où l’on voit les tests en erreur.

J’ai préféré cette approche, on passe moins de temps à “exécuter les tests dans
sa tête” pour ne pas voir tout notre code (y compris le dernier test)
disparaître. Et surtout on garde l’avantage de voir ses tests échouer avant de
passer, qui est pour moi une phase importante du TDD que je pratique tous les
jours.

TCR oblige cependant à se forcer à passer par la phase d’implémentation évidente
du test (on parie qu’il sera vert, on commit) avant de faire un refactoring
(s’il ne fonctionne pas on _revert_ et on revient dans un état fonctionnel).

### Fish bowl mob programming

Avant SoCraTes j’avais entendu parler de _mob programming_ mais n’avais jamais
pratiqué. Lors d’un kata, nous avons essayé une technique de facilitation
spécifique pour faire du _mob programming_ : le fish bowl.

Son fonctionnement est assez simple :

- Un pilote a le clavier. Il ne fait **que** coder et ne prend pas de décisions
- Un navigateur dit au pilote ce qu’il faut faire. Il est le **seul** à parler.
- Une chaise est libre pour poser des **questions**. Mais attention, uniquement
  des questions pour mieux comprendre le code (on ne comprend pas une syntaxe
  par exemple) ou le fonctionnel. Il est interdit de poser des questions du
  type : “Pourquoi est-ce que l’on fait comme ça ?”, dans ce cas on prend la
  place du navigateur !
- Toutes les autres personnes sont **silencieuses** et peuvent venir prendre la
  place du pilote ou du navigateur à n’importe quel moment.

J’ai beaucoup aimé cette technique pour faire du _mob programming_ car elle
évite la cacophonie qui peut régner lorsque l’on essaye de tous coder en même
temps. Dans ces cas-là le pilote ne sait pas quoi faire et il est difficile
d’avancer.

Depuis l’événement, j’ai testé cette technique lors d’un kata et le format a été
très apprécié. Cependant, comme pour d’autres techniques, je pense qu’il faut
d’abord pratiquer pour s’entraîner avant de le faire tous les jours sur du code
de production.

# Microéconomie 2 — notes de cours

Livre Quarto (R + ggplot2) des notes de cours de Microéconomie 2, L2 économie-gestion, Université Paris 8.
Auteurs : Elias Bouacida, Hela Maafi, Antoine Terracol. Langue : français.

## Contexte d'usage

- Les notes servent de support à un **cours asynchrone** : l'étudiant travaille seul, sans enseignant pour lever ses doutes.
- Le cours est compilé et déposé sur **Moodle**, ouvert au fur et à mesure. Rien n'est publié en ligne pour les étudiants : **pas de liens web** vers le TD ni vers un site.
- Chaque document doit être **autoportant**.
- Le TD se fait en parallèle. Il est dans `../ExercicesMicro2` (brochure LaTeX dans `Brochure/2026-2027/`, corrigés Quarto). La **numérotation des exercices est figée**, car la fiche papier est déjà distribuée. Les renvois au TD se font par numéro (« fiche 2, exercice 2.5 »). Dans ce dépôt, `03-monopole-naturel.qmd` et `04-monopole-discriminant.qmd` sont volontairement inclus dans `02-monopole.qmd` et absents de son `_quarto.yml`.

## Règles de travail

- **Corrections une par une** : présenter chaque modification (texte actuel → texte proposé, avec la justification) et n'éditer qu'après **approbation explicite**. Pas de corrections groupées non validées.
- Pour une figure : faire valider le principe, modifier, générer la figure, la vérifier visuellement (chevauchement d'étiquettes, cohérence avec le texte), puis la montrer.
- Vérifier les calculs avant de proposer des valeurs numériques : les exemples doivent satisfaire les équations du texte.
- Ne pas commiter sans demande.

## Structure

| Fichier | Contenu |
|---|---|
| `index.qmd` | Présentation, bibliographie, plan |
| `01-cpp.qmd` | Concurrence pure et parfaite (rappels L1) |
| `02-monopole.qmd` | Monopole : recette marginale, optimum, Lerner, monopole naturel, régulation, discrimination (1ᵉʳ, 2ᵉ, 3ᵉ degrés) |
| `03-oligopoles.qmd` | Cournot (duopole, N firmes, Lerner, HHI), Stackelberg, cartel (**hors programme**) |
| `05-cppmono.qmd`, `06-equilibres.qmd`, `07-surplus.qmd` | Annexes A, B, C : tableau CPP/monopole, méthodes de résolution, calcul des surplus |
| `_theme.qmd` | Charge ggplot2 et le thème `theme_perso`, inclus en tête de chaque chapitre |

## Piège d'édition

Ne pas écrire de LaTeX via des chaînes Python ou sed non brutes. `\t`, `\r` et `\f` deviennent des caractères de contrôle (`\text` → tabulation, `\right` → retour chariot). Utiliser l'outil Edit, puis vérifier avec `git diff | grep -P '^\+.*[\x00-\x08\x0b-\x1f]'`.

## Conventions

- Environnements Quarto : `def-`, `prp-`, `thm-`, `cor-`, `exm-`, `cnj-` (hypothèses), `.remark`, `.proof`. Figures `fig-`, équations `eq-`, sections `sec-`.
- Les préfixes de renvoi sont en minuscules (`_quarto.yml` : `crossref` et `language: crossref-sec-prefix: section`).
- Les identifiants doivent être uniques dans tout le livre (ceux de l'annexe C portent le suffixe `-annexe`).
- Notations : $C_m$ coût marginal, $C_M$ coût moyen, $CV_M$ coût variable moyen, $R_m$ recette marginale, $P(q)$ demande (agrégée) inverse, $Q(p)$ demande, $S(q)$ offre agrégée inverse, $\varepsilon_{q/p}$ élasticité prix, $S_c$ et $S_p$ surplus, $S_i$ part de marché.
  - Régulation : $s$ subvention unitaire, $S_{\text{tot}}=s^*q^*_{CPP}$ montant total versé (ni $D$, réservé à la demande, ni $S_F$, qui suggérerait une subvention forfaitaire).
  - Cournot : le coût quadratique est $C_i(q_i)=kq_i^2$ ; $c$ est réservé à un coût marginal constant, comme dans le TD.
  - L'étoile signale un **choix optimal** : $q_1^*=f_1(q_2^a)$ est la meilleure réponse à l'anticipation $q_2^a$ ; à l'équilibre, les anticipations sont justes et $(q_1^*, q_2^*)$ désigne l'équilibre. Même convention pour $q_F^*$ en Stackelberg.
- Vocabulaire : on garde les termes du cours et on signale ceux du TD à leur première apparition (perte sèche / charge morte, recette / revenu marginal, pilote / meneuse / leader, satellite / suiveuse / follower, équilibre de Cournot / Cournot-Nash, fonction de réaction / meilleure réponse). « Revenu marginal » n'est employé qu'une fois, dans la définition.
- Couleurs habituelles des figures : demande en bleu, coût marginal en rouge, recette marginale en vert.

## État d'avancement (au 12 octobre 2026)

**Fait :**
- 10 corrections d'erreurs de fond : prix maximal, économies d'échelle, figures de changement de demande (avec renvoi à `@sec-choix-monopole`), valeurs de la discrimination du 2ᵉ degré ($P_1=6-q$, $P_2=8-q$, $c=2$), recette notée $\pi$, annexe A, HHI, courbe d'offre CPP avec seuils de fermeture et de rentabilité, libre entrée, définition de la demande.
- 10 problèmes techniques : identifiants en double, figure de la demande perçue, $x_0$, légendes et étiquettes de figures, `ymax <-`, intégrales, préfixe des sections.

Le 13 octobre : vocabulaire harmonisé avec le TD et notations clarifiées (voir Conventions).

**Reste à faire, dans l'ordre convenu :**

1. ~~Harmoniser le vocabulaire avec le TD~~ (fait).
2. **Réorganiser les chapitres.** Chapitre 2 fait le 13 octobre : 2.1.1 renommée « Le monopole choisit son prix ou sa quantité » ; « Le monopole n'a pas de courbe d'offre » (ex-« Variation de la demande ») en 2.2.2, juste après la maximisation ; régulation sur trois niveaux (subvention unitaire, taxe forfaitaire, impôt sur les bénéfices en sous-sections 2.4.3 à 2.4.5) ; discrimination dans l'ordre 1ᵉʳ → 3ᵉ → 2ᵉ degré. Attention : les blocs R de ce chapitre redéfinissent `P`, `Rm`, `Cm`, `qm`, et l'ordre d'exécution compte lors d'un déplacement. Chapitre 1 fait le 13 octobre : la remarque sur les seuils suit la figure du profit ; « Perception par les agents isolés » a été déplacée en ouverture de 2.1.1 (elle sert de charnière CPP → monopole : en CPP, le producteur ne peut ni fixer son prix ni l'influencer par sa quantité ; le monopole fixe l'un et observe l'autre). Chapitre 3 fait le 13 octobre : le cartel reste dans le chapitre (choix de l'auteur, pour pouvoir le réintégrer au programme), signalé par un encadré « Hors programme », par l'introduction du chapitre et par le titre de sa méthode dans l'annexe B.
3. **Ajouts pour l'asynchrone** (prochaine étape : proposer un format type sur un seul chapitre, à valider avant de le généraliser) :
   - objectifs et prérequis en début de chapitre, encadré « À retenir » et « Erreurs fréquentes » en fin de chapitre ;
   - transformer les « *Question :* » en auto-évaluation, avec la réponse dans un callout repliable ;
   - renvois vers les exercices du TD par numéro ;
   - commenter dans le texte les figures non citées (les trois figures du prix maximal) ;
   - page « Comment utiliser ces notes », annexe de rappels mathématiques, tableau des notations, fiche méthode étape par étape (refonte de `06-equilibres.qmd`) ;
   - `fig-alt` sur toutes les figures, palette lisible par les daltoniens ;
   - corriger `index.qmd` (il annonce des « corrigés des exercices » qui n'existent pas, et le plan est incomplet).
4. **Contenu demandé par le TD mais absent du cours :** prix imposé et taxe unitaire en CPP (fiche 1, exercice 2), Cournot avec des coûts marginaux différents, Stackelberg avec des coûts différents ou des coûts fixes et choix du rôle de meneur, calcul de l'élasticité à partir de l'indice de Lerner.

Correspondance indicative avec la brochure 2026-2027, à vérifier sur la version compilée :
- **Fiche 1 (CPP) :** 1.1 demande et surplus ; 1.2 offre, équilibre, prix imposé, taxe unitaire.
- **Fiche 2 (monopole) :** 2.1 questions de cours ; 2.2 lecture graphique ; 2.3 et 2.4 monopole simple ; 2.5 subvention et taxe forfaitaire ; 2.6 prix plafond ; 2.7 monopole naturel ; 2.8 tarification au coût marginal ; 2.9 discrimination du 2ᵉ degré (*Le Mondial*) ; 2.10 à 2.12 discrimination du 3ᵉ degré.
- **Fiche 3 (oligopole) :** 3.1 questions de cours ; 3.2 et 3.3 Cournot ; 3.4 et 3.5 Stackelberg ; 3.6 Cournot et Stackelberg ; 3.7 révision.

#import "@preview/polylux:0.4.0": *
#import "@preview/fletcher:0.3.0" as fletcher: node, edge
#import "theme/ctu.typ": *

#show: ctu-theme.with()

#let colred(x) = text(fill: rgb("#FF0000"), $#x$)
#let colblue(x) = text(fill: rgb("#0000FF"), $#x$)

#title-slide[
    = Graph Neural Networks for Identification of Robust Biomarkers from Multi-Omics Data
    #v(0.75em)

    #set text(size: 1em)
    
    Bc. Jan Lubojacký

    #v(1em)

    #set text(size: 0.7em)

    #table(
      columns: (1fr, 1fr),
      column-gutter: 0.5em,
      stroke: none,
      align: (right, left),
      [Supervisor:], [Ing. Jiří Kléma, Ph.D.],
      [Project reviewer:], [Ing. Jan Drchal, Ph.D.]
    )

    #v(1em)
    Medical Electronics and Bioinformatics \
    Faculty of Electrical Engineering \
    Department of Cybernetics
]

#slide[
  #grid(columns: (1fr, 1fr))[
    === Making predictions
    #image("media/integration_question.png")
  ][
    === Extracting biomarkers
    #image("media/mds-disease-network.png")
  ]
]

#slide[
  = Graph Neural Networks
  #grid(rows: (1fr, 1fr))[
    #align(center)[
      #image("media/gnn.png")
    ]
  ][
    $bold(h)_(u)^(l)=colblue("UPDATE")(bold(h)_u^(l-1), colred("AGGREGATE")(bold(h)_v^(l-1),forall v in cal(N)(u)))$
  ]
]

#slide[
      $ bold(h)_(u)^(l)=colblue("UPDATE")(bold(h)_u^(l-1), colred("AGGREGATE")(bold(h)_v^(l-1),forall v in cal(N)(u))) $
      - Graph Convolutional Networks
      $ bold(h)_u^(l)=colblue(sigma) (bold(colblue(W))_"self"^(l) bold(h)_u^(l-1) + bold(colblue(W))_"neigh"^(l) colred(sum)_(v in cal(N)(u)) bold(h)_v^(l-1)+bold(colblue(b))^l) $
      - Graph Attention Networks
      $ bold(h)_u^(l) = colblue(sigma) ( colred(sum)_(v in cal(N)(u)) alpha(v,u) bold(colblue(W))^(l)bold(h)_v^(l-1)) $
]

#slide[
  = Bipartite GNN
    #grid(columns: (1fr, 1.5fr))[
      #v(2em)
      #image("media/bigraph.png")
      #text(size: 0.75em)[
        Input graph structure
        // - sample-feature connections
        // - feature-feature connections
      ]
      
    ][
      #image("media/bignnarch.png")
      
      #text(size: 0.75em)[Model architecture]
    ]
]

#slide[
  === Integration modules
  - linear integrator 
    - $hat(y) = sigma( bold(W) dot \|\|_(i=1)^(m) bold(x)^((i)) + bold(b))$
  - view correlation discovery network 
    - $C_(a_1,...,a_m)=product_(i=1)^m x^((i))_(a_i);space a=1,dots,m; space bold(C) in RR^(|x_1|times dots times |x_m|)$
    - $hat(y)="VCDN"(bold(C))$
  - attention integrator
  #image("media/attention_integratr.png", width: 24em)
]

#slide[
  #grid(columns: (0.8fr, 1fr, 1fr))[
    #only("1")[
      = Models
      #text(size: 0.75em)[
        - KNN
        - Linear SVMs
        - XGBoost
        - Linear NN
        - MOGONET
        - BipartiteGNN
      ]
    ]
    #only("2-3")[
      = Models
      #text(size: 0.75em, fill: luma(50%))[
        - KNN
        - Linear SVMs
        - XGBoost
        - Linear NN
        - MOGONET
        - BipartiteGNN
      ]
    ]
  ][
    #only("2")[
      = Datasets
      #text(size: 0.75em)[
      - TCGA-BRCA
        - 483 samples
        - 4 classes
        - mRNA, miRNA, CNV, DNA methylation
      - MDS
        - 3 tasks
          - Disease (74 samples)
          - Risk (53 samples)
          - Mutation (26 samples)
        - 2 classes
      ]
    ]
      #only("3")[
        = Datasets
        #text(size: 0.75em, fill: luma(50%))[
        - TCGA-BRCA
          - 483 samples
          - 4 classes
          - mRNA, miRNA, CNV, DNA methylation
        - MDS
          - 3 tasks
            - Disease (74 samples)
            - Risk (53 samples)
            - Mutation (26 samples)
          - 2 classes
        ]
      ]
  ][
    #only("3")[
      = Evaluation
      #text(size: 0.6em)[
      ```
      for each trial in 1 to N:
      
          1. sample hyperparameters
      
          for each CV split:
              2. split data
              3. feature selection
              4. normalize features
              5. fit model
              6. test model
              7. record performance P
      
          8. Average P across folds
          9. If P > P_best: P_best=P
      
      return P_best
      ```
      ]
    ]
  ]
]

#title-slide[
  #text(size: 2em)[Results] \ \ \ \
]

#slide[
  #grid(columns: (1fr, 1fr))[
    #image("media/brca_results_1000.png", height: 1fr)
    #text(size: 0.5em)[- TCGA-BRCA results]
  ][
    #image("media/disease_performances.png", height: 1fr)
    #text(size: 0.5em)[- MDS disease results]
  ]
]

#slide[
    #grid(rows: (2fr,1fr))[
    #image("media/results.png")
  ][
    #text(size: 0.5em)[- Model performances in terms of Weighted F1 score on the TCGA-BRCA dataset]
  ]
]

// #slide[
//   #grid(columns: (1fr, 1fr)))[
//     #image()
//   ][
//     #image()
//   ]
// ]

#slide[
  = Extracting Biomarkers
  #grid(columns: (1fr, 2fr))[
    #text(size: 0.75em)[
      - XGBoost linear booster weights
      - Feature permutation for GNNs
      - Comparison against traditional methods
    ]
  ][
    #image("media/mdsRiskGenesNetwork.png")
    #align(center, text(size: 0.5em)[- feature importances (MDS risk, XGBoost)])
  ]
]

#slide[
  #grid(
    columns: (1fr, 4fr))[
  ][
    #image("media/mds-disease-network.png", height: 0.5fr)
    #align(center, text(size: 0.5em)[- structural biomarkers (MDS disease, Mogonet)])
  ]
]

#title-slide[
  #text(size: 2em)[Thank You] \
  #text(size:1.5em)[for your attention]
]

#slide[
  = Reviewer question
  - #text(size: 1em)[U sloupcových grafů v obrázcích 8.1, 8.2 a 8.3 mi není zřejmý přesný význam černých čar posazených na vrchní část každého sloupce. Předpokládám, že se jedná o konfidenční intervaly. Zejména u obr. 8.3 jsou tyto intervaly značně široké a pro jednotlivé metody se výrazně překrývají. Můžete na základě grafů říci něco o statistické významnosti výsledků?]
]

#slide[
  #grid(
    columns: (1fr,1fr)
  )[
    #image("media/risk-performance.png", height: 1fr)
    #text(size: 0.5em)[8.2]
  ][
    #image("media/mutation-perf.png", height: 1fr)
    #text(size: 0.5em)[8.3]
  ]
]
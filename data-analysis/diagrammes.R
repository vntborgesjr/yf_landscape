##%#####################################################################%##
#                                                                         #
####                           Data analysis                           ####
####                          Diagramme fluxes                         ####
####                        Vitor Borges-Júnior                        ####
####                       Created on 28 Feb 2024                      ####
#                                                                         #
##%#####################################################################%##

# The objective of the script is to draw the diagrammes of flux to 
# ilustrate the results of structural equation models

# Load packages ------------------------------------------------------

source(here::here("R/dependencies.R"))

# Total gradient of forest cover -------------------------------------

# Diagramme 1 - edge density -----------------------------------------

edge_effect_diagramme <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat2; habitat1; fragmentation; epizootic

habitat2 [shape = ellipse, label =  'FC²', fontsize = 24, fontname = Serif, penwidth = 2, width = 2, height = 1]
habitat1 [shape = ellipse, label =  'FC', fontsize = 24, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'ED \n R² = 0.86', fontsize = 24, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0.14 \n C = 6.735 p = 0.034', fontsize = 24, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat2; coef_habitat1; coef_frag

coef_habitat3 [label = '0.21 \n p = 0.05', fontsize = 18, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_habitat2 [label = '-0.56 \n p < 0.0001', fontsize = 18, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_habitat1 [label = '0.74 \n p < 0.0001', fontsize = 18, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '0.94 \n p = 0.01', fontsize = 18, fontname = Serif, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat2 -> coef_habitat2[penwidth = 5, arrowhead = none, style = dashed, color = Red]
coef_habitat2 -> fragmentation[penwidth = 5, style = dashed, color = Red]
habitat1 -> coef_habitat1[penwidth = 5, arrowhead = none, color = Blue]
coef_habitat1 -> fragmentation[penwidth = 5, color = Blue]
fragmentation -> coef_frag[penwidth = 5, arrowhead = none, color = Blue]
coef_frag -> epizootic[penwidth = 5, color = Blue]
habitat1 -> coef_habitat3[penwidth = 5, arrowhead = none, color = Blue]
coef_habitat3 -> epizootic[penwidth = 5, color = Blue]
}")

# save on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = edge_effect_diagramme,
#   filename = "output/edge_effect_diagramme.jpeg",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 100
# )

# Diagramme 2 - number of patches ------------------------------------

n_patches_diagramme <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat2; habitat1; fragmentation; epizootic

habitat2 [shape = ellipse, label =  'FC²', fontsize = 24, fontname = Serif, penwidth = 2, width = 2, height = 1]
habitat1 [shape = ellipse, label =  'FC', fontsize = 24, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'NP \n R² = 0.75', fontsize = 24, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0.14 \n C = 6.757 p = 0.034', fontsize = 24, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat2; coef_habitat1; coef_frag

coef_habitat3 [label = '0.53 \n p < 0.0001', fontsize = 18, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_habitat2 [label = '-0.49 \n p < 0.0001', fontsize = 18, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_habitat1 [label = '0.55 \n p < 0.0001', fontsize = 18, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '0.73 \n p < 0.0001', fontsize = 18, fontname = Serif, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat2 -> coef_habitat2[penwidth = 5, arrowhead = none, style = dashed, color = Red]
coef_habitat2 -> fragmentation[penwidth = 5, style = dashed, color = Red]
habitat1 -> coef_habitat1[penwidth = 5, arrowhead = none, color = Blue]
coef_habitat1 -> fragmentation[penwidth = 5, color = Blue]
fragmentation -> coef_frag[penwidth = 5, arrowhead = none, color = Blue]
coef_frag -> epizootic[penwidth = 5, color = Blue]
habitat1 -> coef_habitat3[penwidth = 5, arrowhead = none, color = Blue]
coef_habitat3 -> epizootic[penwidth = 5, color = Blue]
}")
n_patches_diagramme
# Partial gradient of forest cover - < 30% ---------------------------

# Fragmentation measure - edge density -------------------------------

edege_density_lower <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat1; fragmentation; epizootic

habitat1 [shape = ellipse, label =  'FC', fontsize = 18, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'ED \n R² = 0.87', fontsize = 18, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0.20 \n C = NA p = NA', fontsize = 18, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat1; coef_frag; coef_frag2

coef_habitat1 [label = '0.91 \n p < 0.0001', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '0.15 \n p = 0.47', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_frag2[label = '0.05', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_habitat3 [label = '0.35 \n p = 0.13', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat1 -> coef_habitat1[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat1[penwidth = 5, arrowhead = none, color = Blue]
coef_habitat1 -> fragmentation[penwidth = 5, color = Blue]
fragmentation -> coef_frag[penwidth = 2.5, arrowhead = none, color = Gray]
coef_frag -> epizootic[penwidth = 2.5, color = Gray]
fragmentation -> coef_frag2[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_frag2 -> epizootic[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat3[penwidth = 2.5, arrowhead = none, color = LightGray]
coef_habitat3 -> epizootic[penwidth = 2.5, color = Gray]
}")

# Partial gradient of forest cover - 30%-60% ---------------------------

edege_density_middle <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat1; fragmentation; epizootic

habitat1 [shape = ellipse, label =  'FC', fontsize = 18, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'ED \n R² = 0', fontsize = 18, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0 \n C = NA p = NA', fontsize = 18, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat1; coef_frag; coef_frag2

coef_habitat1 [label = '0.005 \n p = 0.96', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '-0.013 \n p = 0.94', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_frag2[label = '-0.0006', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_habitat3 [label = '0.062 \n p = 0.78', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat1 -> coef_habitat1[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat1[penwidth = 2.5, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 2.5, color = Gray]
fragmentation -> coef_frag[penwidth = 2.5, style = dashed, arrowhead = none, color = Gray]
coef_frag -> epizootic[penwidth = 2.5, style = dashed, color = Gray]
fragmentation -> coef_frag2[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_frag2 -> epizootic[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat3[penwidth = 2.5, arrowhead = none, color = LightGray]
coef_habitat3 -> epizootic[penwidth = 2.5, color = Gray]
}")

# Partial gradient of forest cover - > 60% ---------------------------

edege_density_upper <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat1; fragmentation; epizootic

habitat1 [shape = ellipse, label =  'FC', fontsize = 18, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'ED \n R² = 0.52', fontsize = 18, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0.86 \n C = NA p = NA', fontsize = 18, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat1; coef_frag; coef_frag2

coef_habitat1 [label = '-0.74 \n p < 0.001', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '0.87 \n p = 0.28', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_frag2[label = '-0.64', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_habitat3 [label = '-0.10 \n p = 0.71', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat1 -> coef_habitat1[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat1[penwidth = 5, style = dashed, arrowhead = none, color = Red]
coef_habitat1 -> fragmentation[penwidth = 5, style = dashed, color = Red]
fragmentation -> coef_frag[penwidth = 2.5, arrowhead = none, color = Gray]
coef_frag -> epizootic[penwidth = 2.5, color = Gray]
fragmentation -> coef_frag2[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_frag2 -> epizootic[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat3[penwidth = 2.5, style = dashed, arrowhead = none, color = LightGray]
coef_habitat3 -> epizootic[penwidth = 2.5, style = dashed, color = Gray]
}")

# Partial gradient of forest cover - < 30% ---------------------------

# Fragmentation measure - number of patches -------------------------------

n_patches_lower <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat1; fragmentation; epizootic

habitat1 [shape = ellipse, label =  'FC', fontsize = 18, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'NP \n R² = 0.54', fontsize = 18, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0.24 \n C = NA p = NA', fontsize = 18, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat1; coef_frag; coef_frag2

coef_habitat1 [label = '0.73 \n p < 0.0001', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '0.36 \n p < 0.05', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_frag2[label = '0.26', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_habitat3 [label = '0.23 \n p = 0.10', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat1 -> coef_habitat1[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat1[penwidth = 5, arrowhead = none, color = Blue]
coef_habitat1 -> fragmentation[penwidth = 5, color = Blue]
fragmentation -> coef_frag[penwidth = 5, arrowhead = none, color = Blue]
coef_frag -> epizootic[penwidth = 5, color = Blue]
fragmentation -> coef_frag2[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_frag2 -> epizootic[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat3[penwidth = 2.5, arrowhead = none, color = LightGray]
coef_habitat3 -> epizootic[penwidth = 2.5, color = Gray]
}")

# Partial gradient of forest cover - 30%-60% ---------------------------

n_patches_middle <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat1; fragmentation; epizootic

habitat1 [shape = ellipse, label =  'FC', fontsize = 18, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'NP \n R² = 0.07', fontsize = 18, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0 \n C = NA p = NA', fontsize = 18, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat1; coef_frag; coef_frag2

coef_habitat1 [label = '-0.26 \n p < 0.05', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '-0.032 \n p = 0.86', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_frag2[label = '0.008', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_habitat3 [label = '0.05 \n p = 0.83', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat1 -> coef_habitat1[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat1[penwidth = 2.5, style = dashed, arrowhead = none, color = Red]
coef_habitat1 -> fragmentation[penwidth = 2.5, style = dashed, color = Red]
fragmentation -> coef_frag[penwidth = 2.5, style = dashed, arrowhead = none, color = Gray]
coef_frag -> epizootic[penwidth = 2.5, style = dashed, color = Gray]
fragmentation -> coef_frag2[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_frag2 -> epizootic[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat3[penwidth = 2.5, arrowhead = none, color = Gray]
coef_habitat3 -> epizootic[penwidth = 2.5, color = Gray]
}")

# Partial gradient of forest cover - > 60% ---------------------------

n_patches_upper <- grViz("digraph {

graph [layout = dot, rankdir = LR]

# define the global styles of the nodes. We can override these in box if we wish
node [shape = ellipse, overlap = TRUE, shape = box, style = filled, fillcolor = YellowGreen]
habitat1; fragmentation; epizootic

habitat1 [shape = ellipse, label =  'FC', fontsize = 18, fontname = Serif, penwidth = 2, width = 2, height = 1]
fragmentation [shape = ellipse, label = 'NP \n R² = 0.17', fontsize = 18, fontname = Serif, penwidth = 2]
epizootic [shape = ellipse, label= 'Epizootic event \n R² = 0.07 \n C = NA p = NA', fontsize = 18, fontname = Serif, penwidth = 2]

# define the global styles of the nodes 2.
node [shape = box, overlap = TRUE, shape = box, fillcolor = White]
coef_habitat3; coef_habitat1; coef_frag; coef_frag2

coef_habitat1 [label = '-0.42 \n p = 0.066', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]
coef_frag[label = '0.70 \n p = 0.98', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_frag2[label = '-0.29', fontsize = 12, fontname = Serif, fillcolor = White, penwidth = 0.5]
coef_habitat3 [label = '-0.17 \n p = 0.70', fontsize = 12, fontname = Serif, face = Bold, fillcolor = White, penwidth = 0.5]

# edge definitions with the node IDs
habitat1 -> coef_habitat1[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat1[penwidth = 5, style = dashed, arrowhead = none, color = Gray]
coef_habitat1 -> fragmentation[penwidth = 5, style = dashed, color = Gray]
fragmentation -> coef_frag[penwidth = 2.5, arrowhead = none, color = Gray]
coef_frag -> epizootic[penwidth = 2.5, color = Gray]
fragmentation -> coef_frag2[penwidth = 5, style = dotted, arrowhead = none, color = Gray]
coef_frag2 -> epizootic[penwidth = 5, style = dotted, color = Gray]
habitat1 -> coef_habitat3[penwidth = 2.5, style = dashed, arrowhead = none, color = LightGray]
coef_habitat3 -> epizootic[penwidth = 2.5, style = dashed, color = Gray]
}")

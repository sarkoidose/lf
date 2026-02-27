#!/bin/sh
# Nettoie les graphiques Sixel pour éviter les résidus visuels
# \e\\ = String Terminator (termine tout flux Sixel en cours)
# \e[H = curseur en position home
# \e[2J = efface l'écran
printf '\e\\\e[H\e[2J'
exit 0

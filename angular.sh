#!/bin/bash

# Définir les valeurs par défaut pour les paramètres optionnels
PARM1=""
PARM2=""
PARM3=""
# Définition des couleurs
GREEN=$(tput -Txterm setaf 2)
YELLOW=$(tput -Txterm setaf 3)
RESET=$(tput -Txterm sgr0)



# Vérifier si l'utilisateur a spécifié une version de Symfony
if [ $# -ge 1 ]; then
  COMMAND="$1"
else
  help
  exit 1
fi

if [ "$COMMAND" == "help" ]; then
  help
  exit 0
fi


if [ $# -ge 2 ]; then
  PARM1="$2"
fi

# Vérifier si l'utilisateur a spécifié un répertoire
if [ $# -ge 3 ]; then
  PARM2="$3"
fi

# Vérifier si l'utilisateur a spécifié des options supplémentaires
if [ $# -ge 4 ]; then
  PARM3="$4"
fi

# Affichage de l'aide
function help() {
    echo ""
    echo "Utilisation : "
    echo "  ${YELLOW}bash${RESET} ${GREEN}<command>${RESET}"
    echo ""
    echo "Commandes : "
    awk '/^[a-zA-Z\-\_0-9]+:/ {
            helpMessage = match(lastLine, /^## (.*)/);
            if (helpMessage) {
                helpCommand = substr($1, 0, index($1, ":")-1);
                helpMessage = substr(lastLine, RSTART + 3, RLENGTH);
                printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage;
            }
        }
        { lastLine = $0 }' $0
}
function new() {
    docker run --rm --interactive --tty  --volume $PWD:/angular-app angular-app ng new "$PARM1" --routing --standalone --strict --style=scss
    mv "$PARM1"/* .
    rm -rf "$PARM1"
    docker run --rm --interactive --tty  --volume $PWD:/angular-app angular-app ng serve --host 0.0.0.0 --port 4200
}
function serve() {
    docker run --rm --interactive --tty  --volume $PWD:/angular-app angular-app ng serve --host 0.0.0.0 --port 4200
}
function build() {
      docker run --rm --interactive --tty  --volume $PWD:/angular-app angular-app ng build --configuration="$PARM1"
}
$COMMAND


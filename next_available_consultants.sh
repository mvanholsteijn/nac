#!/bin/bash

function gnudate() {
	if [ "$(uname)" == "Darwin" ] ; then
		gdate "$@" 
	else
		date "$@"
	fi
}

function getCards() {
	wrk cards in l:5069fd9c0c81140a72d92fde | \
		grep -e '[0-9][0-9]*/[0-9][0-9]*/[0-9][0-9]*' | \
		sed  -e 's/\([^0-9]\)\([0-9]\)\/\([0-9][0-9]*\)\/\([0-9][0-9]*\)/\10\2\/\3\/\4/' \
			-e 's/\([0-9][0-9]*\)\/\([0-9]\)\/\([0-9][0-9]*\)/\1\/0\2\/\3/' \
			-e 's/\([0-9][0-9]*\)\/\([0-9][0-9]*\)\/\([0-9][0-9]*\)/\3-\2-\1/' \
			-e 's/| wrk.*//'	| \
		sort 
}

function filterCards() {
	grep -e $(gnudate +%Y-%m) -e $(gnudate +%Y-%m --date '1 months') -e $(gnudate +%Y-%m --date '2 months')
}

filterColors () {
	sed 	-e 's/Contract . paperwork todo//g' \
		-e 's/Reeds gestart//g' \
		-e 's/Bespreken//g' \
		-e 's/Issue . Problem//g'
}

shortenDate() {
	sed -e 's/\([0-9][0-9]*\)-\([0-9][0-9]*\)-\([0-9][0-9]*\)/\3\/\2/' 
}

if [ -n "$WRK_USR_TOKEN" ] ; then
	echo $WRK_USR_TOKEN > ~/.wrk/token
fi

getCards | filterCards | filterColors | shortenDate 

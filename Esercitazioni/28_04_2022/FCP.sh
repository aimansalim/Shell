#!/bin/sh

#Controllo che il primo sia un nome assoluto
case $# in
2)  echo Corretto! $# è il numero corretto di parametri ;;
*)  echo Errore: $# non è il numero corretto di parametri
    exit 1 ;;
esac

#Controllo primo parametro
case $1 in
/*) if test -d $1 -a -x $1 
    then
    echo $1 è una directory
    else 
    echo $1 non è una directory
    exit 2
    fi

echo ed è un nome assoluto;;
*)  echo $1 non è un nome assoluto
    exit 3 ;;
esac

#Contorllo secondo parametro
case $2 in
*[!0-9]*)   echo Errore: $2 non è un parametro numerico
            exit 4 ;;
*)  if test -eq 0 #Controlla che il parametro sia uguale a 0
    then 
    echo Errore: $2 è uguale a zero, deve essere maggiore di 0
    exit 5
    else $2 Corretto!
    fi 
    ;;

#Cosa da non scordarsi
PATH=`pwd`: $PATH
export PATH

#Invochiamo il file comando ricorsivo
FCR.sh $* #Per tutti i parametri (non solo il loro numero ma proprio runna il FCR.sh su quei para) 

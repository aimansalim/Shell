#!/bin/sh

#Controllo che il primo sia un nome assoluto
case $# in
0|1) echo Errore: $# sono pochi parametri;;
2)  echo Corretto! $# è il numero corretto di parametri ;;
*)  echo Errore: $# sono troppi parametri
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
*)  if test -eq 0 #Se numero inserito è 0
    then 
    echo Errore: $2 è uguale a zero, deve essere maggiore di 0
    exit 5
    else $2 Corretto!
    fi 
    ;;
esac

#ATTENZIONE
PATH=`pwd`: $PATH
export PATH
> /tmp/tmp$$ #Creiamo file temporaneo che passeremo poi come ultimo parametro al file comandi ricorsivo
#Invochiamo il file comando ricorsivo
FCR.sh $1 $2 #Per tutti i parametri (non solo il loro numero ma proprio runna il FCR.sh su quei para) 


#Dopo aver esplorato tutta la gerarchia
#Chiedo un numero maggiore di zero e minore di $2 (quello inserito)


#Dichiaro
PARAMETRI=

#leggo le righe del file con un for
for i in `cat /tmp/tmp$$` 
do
    echo Inserire numero maggiore di zero e minore o uguale di $2
    read risposta

    case $risposta in

    *[!0-9]*)
        echo Errore: $risposta non è un numero!
        exit 6
    ;;

    *) #Se il numero inserito è maggiore di 0 and minore o uguale al numero inserito
        if test $risposta -gt 0 -a $risposta -le $2 #gt -> Greater Than > Maggiore
        then
        echo Corretto! Il parametro è giusto
        PARAMETRI="$PARAMETRI $i $risposta" #DA CAPIRE
        else
        echo Errore: non è minore o uguale di $2 oppure è zero
        fi
    ;;
    esac
done
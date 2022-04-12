#!/bin/sh
#FCP.sh

#Nei casi in cui i parametri sono da 0 a 2 non vanno bene
case $# in
0|1|2) 
echo $# è un numero di parametri basso rispetto a quello consentito
    exit 1;;
*)  
echo $# è il numero corretto di parametri consentito;;
esac

#Controllo primo parametro che sia un numero 
case $1 in
*[!0-9]*)   echo Errore: $1 non è un carattere numerico  
            exit 2;;
*);;
esac

#Controllo che sia strettamente positivo
if test $1 -eq 0
    then echo $1 è uguale a 0 
    exit 3
fi

#Il comando shift è utile per eliminare i parametri di una linea di comandi una volta analizzati.
X=$1 #Salviamo il primo parametro dopo aver fatto il controllo
#quindi ora possiamo usare il comando shift
shift #toglie il primo parametro dai possibili successivi controlli

# a b c d
#b c d 

#Gli altri (N) possono essere solo nomi assoluti di directory che indicano gerarchie
for i #Per tutti gli altri $* che son rimasti dopo lo shift
do 
    case $i in
    /*) if test -d $i -a $i -x
        then
        echo $i è una directory ed è traversabile
        else
        echo $i non è una directory o non è traversabile
        exit 4
        fi
    ;;

    *)  echo $i non è assoluto 
        exit 5 ;;
    esac
done

#Serve per ezportare il path da cui la shell può cercare il file da eseguire .sh
PATH=`pwd`:$PATH
export PATH

#Metto il risultato in un file tmp
 > /tmp/esercizio3$$ #creiamo/azzeriamo il file temporaneo. NOTA BENE: SOLO 1 file temporaneo!

for i
do
echo Fase per $i #La directory corrente
#Invochiamo il file comandi ricorsivo con la Gerarchia ($i), il Numero ($X) e il File Temporaneo (/tmp/esercizio3$)
FCR.sh $i $X /tmp/esercizio3$$
done
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
X=$1 #salviamo il primo parametro dopo aver fatto il controllo
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






# #ora in $* abbiamo solo i nomi delle gerarchie e quindi possiamo fare i controlli sui nomi assoluti e sulle directory in un for
# for i 
# do
# 	case $i in
# 	/*) if test ! -d $i -o ! -x $i
# 	    then
# 	    echo $i non directory o non traversabile
# 	    exit 4
# 	    fi;;
# 	*)  echo $i non nome assoluto; exit 5;;
# 	esac
# done

# #controlli sui parametri finiti possiamo passare alle N fasi
# PATH=`pwd`:$PATH
# export PATH
# > /tmp/conta$$ #creiamo/azzeriamo il file temporaneo. NOTA BENE: SOLO 1 file temporaneo!

# for i
# do
# 	echo fase per $i 
# 	#invochiamo il file comandi ricorsivo con la gerarchia, il numero e il file temporaneo
# 	FCR.sh $i $X /tmp/conta$$   
# done

# #terminate tutte le ricerche ricorsive cioe' le N fasi
# #N.B. Andiamo a contare le linee del file /tmp/conta$$
# echo Il numero di file totali che soddisfano la specifica = `wc -l < /tmp/conta$$` 
# for i in `cat /tmp/conta$$`
# do
# 	#Stampiamo (come richiesto dal testo) i nomi assoluti dei file trovati
# 	echo Trovato il file $i
# 	#chiediamo all'utente il numero K per ogni file trovato
# 	echo -n "Dammi il numero K (strettamente maggiore di 0 e strettamente minore di $X): "
# 	read K
# 	#Controllo K (sempre con expr, se prima lo abbiamo fatto con expr, altrimenti sempre con case se prima lo abbiamo fatto con case!)
# 	expr $K + 0  > /dev/null 2>&1
# 	N1=$?
# 	if test $N1 -ne 2 -a $N1 -ne 3
# 	then 	#echo numerico $K siamo sicuri che numerico
#      		if test $K -le 0 -o $K -ge $X 
#      		then echo $K non positivo o non minore di $X 
# 		rm /tmp/conta$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
#           	exit 6
#      	fi
# 	else
#   		echo $K non numerico
# 		rm /tmp/conta$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
#   		exit 7
# 	fi
# 	#selezioniamo direttamente la $K-esima linea del file corrente
# 		head -$K $i | tail -1
# done 
# #da ultimo eliminiamo il file temporaneo
# rm /tmp/conta$$
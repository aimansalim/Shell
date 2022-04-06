#!/bin/sh
#FCR.sh

#File ricorsivo che scrive il nome assoluto dei file delle directory

#Per essere sicuro vado su $1 (il primo parametro -> la directory)
cd $1

#Inizializzo tre variabili
NUMERORIGHE=
FILES=
COUNT=0

#CONTA RIGHE SE GIUSTE METTE NELLO STDOUT 
for i in * #Controlla per tutta la directory $1
do
    #Controlla che sia almeno un file e che sia leggibile
    if test -f $i -a -r $i #Se c'è un file di tutti i parametri all'interno della dir 
        then
        NUMERORIGHE=`wc -l > $i` #Numero delle righe del file
        COUNT=`expr $COUNT + 1` #Conta quanti file ci sono che hanno quella specifica
        if test $NUMERORIGHE -eq $2 #Se il numero delle righe è uguale al numero inserito dall'utente all'inizio
            then
            echo `pwd/$1` >> $3 #Mette sullo Standard Output il path corrente, perchè $3 (?)
                if test $COUNT -eq 1 #Se ci sono file che hanno quella specifica dimmi dove sono
                then
                echo Questa directory: `pwd`
                echo contiene almeno un file con le specifiche richieste
        fi
    fi
done


#RICHIAMA SE STESSO
for i in *
do
    #Se è una directory ed è pure eseguibile
    if test -d $i -a -x $i
    
    #Allora richiamo il file ricorsivo per tutti e tre i parametri
    then FCR.sh `pwd`/$i $2 $3
    fi
done
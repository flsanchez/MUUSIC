#!/bin/bash

#Habilito el beep

amixer set Beep unmute 0dB -q

#inicializo y configuro variables
total=0
file=$1
lineas=$(sed -n -e '$=' $file)
nombre=$(sed -n -e 1'p' $file)
echo $nombre
sleep 1
bpm=$(sed -n -e 2'p' $file | grep -oiE '([0-9]*)')
echo "Tempo = $bpm""BPM"

(( neg = 60000 / $bpm ))	#Negra=neg	
(( bla = $neg \* 2 ))		#Blanca=bla
(( red = $neg \* 4 ))		#Redonda=red
(( cor = $neg / 2 ))		#Corchea=cor
(( sem = $neg / 4 ))		#Semicorchea=sem
(( tco = $neg / 3 ))		#Tresillo de corcheas=tco
(( tne = $neg \* 2 / 3 ))	#Tresillo de negras=tne
(( tre = $neg \* 3 ))		#Tresillo de redondas=tre
(( tbl = $neg \* 3 / 2 ))	#Tresillo de blancas=tbl
npu=$tbl			#Negra con puntillo=npu
bpu=$tre			#Blanca con puntillo=bpu
(( cpu= $neg \* 3 / 4 ))	#Corchea con puntillo=cpu
(( spu= $neg \* 3 / 8 ))        #semicorchea con puntillo=spu

#empieza el bucle del programa principal
for (( i=3 ; i < (($lineas + 1)); i++ ))
do
#aplico filtro para las notas
frec1=$(sed -n -e $i'p' $file | grep -oE '([0-9A-Z#b]{2,})')

if [ -z $frec1 ] #si el filtro de las notas dio nulo, quiere decir q hay un silencio
then
leng=$(sed -n -e $i'p' $file)
case $leng in
"sre") leng=$red;;		#Silencio de Redonda=sre
"sbp") leng=$bpu;;		#silencio de blanca con puntillo=sbp
"sbl") leng=$bla;;		#silencio de blanca=sbl
"snp") leng=$npu;;		#silencio de negra con puntillo=snp
"sne") leng=$neg;;		#silencio de negra=sne
"scu") leng=$cpu;;		#silencio de corchea con puntillo=scu
"sco") leng=$cor;;		#silencio de corchea=sco
"sse") leng=$sem;;		#silencio de semicorchea=sse
"ssp") leng=$spu;;		#silencio de semicorchea con puntillo=ssp
*) echo "Error en linea $i: Silencio no válido";;
esac
echo "Duración del silencio = $leng mS"
leng=$(echo " scale=3; $leng/1000 " | bc -l)
sleep $leng
total=$(echo "scale=3; $total + $leng" | bc -l)

else	#si el filtro de las notas no dio nulo, se sigue con el filtro de la duracion
leng=$(sed -n -e $i'p' $file | grep -oE '([a-z]{3})')
#se iguala la nota a su valor en frecuencia
case $frec1 in
"C1") frec=65;;
"C2") frec=131;;
"C3") frec=262;;
"C4") frec=523;;
"C5") frec=1047;;
"C6") frec=2093;;
"C7") frec=4186;;
"C8") frec=8372;;
"C#1") frec=69;;
"C#2") frec=139;;
"C#3") frec=277;;
"C#4") frec=554;;
"C#5") frec=1109;;
"C#6") frec=2217;;
"C#7") frec=4435;;
"C#8") frec=8870;;
"Db1") frec=69;;
"Db2") frec=139;;
"Db3") frec=277;;
"Db4") frec=554;;
"Db5") frec=1109;;
"Db6") frec=2217;;
"Db7") frec=4435;;
"Db8") frec=8870;;
"D1") frec=73;;
"D2") frec=147;;
"D3") frec=294;;
"D4") frec=587;;
"D5") frec=1175;;
"D6") frec=2349;;
"D7") frec=4699;;
"D8") frec=9397;;
"D#1") frec=78;;
"D#2") frec=156;;
"D#3") frec=311;;
"D#4") frec=622;;
"D#5") frec=1245;;
"D#6") frec=2489;;
"D#7") frec=4978;;
"D#8") frec=9956;;
"Eb1") frec=78;;
"Eb2") frec=156;;
"Eb3") frec=311;;
"Eb4") frec=622;;
"Eb5") frec=1245;;
"Eb6") frec=2489;;
"Eb7") frec=4978;;
"Eb8") frec=9956;;
"E1") frec=82;;
"E2") frec=165;;
"E3") frec=330;;
"E4") frec=659;;
"E5") frec=1319;;
"E6") frec=2637;;
"E7") frec=5274;;
"E8") frec=10548;;
"F1") frec=87;;
"F2") frec=175;;
"F3") frec=349;;
"F4") frec=698;;
"F5") frec=1397;;
"F6") frec=2794;;
"F7") frec=5588;;
"F8") frec=11175;;
"F#1") frec=92;;
"F#2") frec=185;;
"F#3") frec=370;;
"F#4") frec=740;;
"F#5") frec=1480;;
"F#6") frec=2960;;
"F#7") frec=5920;;
"F#8") frec=11840;;
"Gb1") frec=92;;
"Gb2") frec=185;;
"Gb3") frec=370;;
"Gb4") frec=740;;
"Gb5") frec=1480;;
"Gb6") frec=2960;;
"Gb7") frec=5920;;
"Gb8") frec=11840;;
"G1") frec=98;;
"G2") frec=196;;
"G3") frec=392;;
"G4") frec=784;;
"G5") frec=1568;;
"G6") frec=3136;;
"G7") frec=6272;;
"G8") frec=12544;;
"G#1") frec=104;;
"G#2") frec=208;;
"G#3") frec=415;;
"G#4") frec=831;;
"G#5") frec=1661;;
"G#6") frec=3322;;
"G#7") frec=6645;;
"G#8") frec=13290;;
"Ab1") frec=104;;
"Ab2") frec=208;;
"Ab3") frec=415;;
"Ab4") frec=831;;
"Ab5") frec=1661;;
"Ab6") frec=3322;;
"Ab7") frec=6645;;
"Ab8") frec=13290;;
"A1") frec=110;;
"A2") frec=220;;
"A3") frec=440;;
"A4") frec=880;;
"A5") frec=1760;;
"A6") frec=3520;;
"A7") frec=7040;;
"A8") frec=14080;;
"A#1") frec=117;;
"A#2") frec=233;;
"A#3") frec=466;;
"A#4") frec=932;;
"A#5") frec=1865;;
"A#6") frec=3729;;
"A#7") frec=7459;;
"A#8") frec=14917;;
"Bb1") frec=117;;
"Bb2") frec=233;;
"Bb3") frec=466;;
"Bb4") frec=932;;
"Bb5") frec=1865;;
"Bb6") frec=3729;;
"Bb7") frec=7459;;
"Bb8") frec=14917;;
"B1") frec=123;;
"B2") frec=247;;
"B3") frec=494;;
"B4") frec=988;;
"B5") frec=1976;;
"B6") frec=3951;;
"B7") frec=7902;;
"B8") frec=15804;;
*) echo "Error en línea $i: Nota no válida"
esac

#se iguala el tiempo a su valor dependiendo de los bpm
case $leng in
"neg") leng=$neg;;
"bla") leng=$bla;;
"red") leng=$red;;
"sem") leng=$sem;;
"cor") leng=$cor;;
"tco") leng=$tco;;
"tne") leng=$tne;;
"tre") leng=$tre;;
"npu") leng=$npu;;
"tbl") leng=$tbl;;
"bpu") leng=$bpu;;
"cpu") leng=$cpu;;
"spu") leng=$spu;;
*) echo "Error en línea $i: Tiempo no válido";;
esac

total=$(echo "scale=3; $total + $leng/1000" | bc -l) #sumo el tiempo al total

#imprimo datos correspondientes a la nota y su duracion
echo "Nota = $frec1 Frecuencia = $frec Hz"
echo "Duración = $leng mS"

#ejecuto el beep
beep -f $frec -l $leng -D 10
fi

done

echo
echo "La duración total fue de $total S"
echo "Presione alguna tecla para salir..."
read

#Deshabilito el beep

amixer set Beep mute 0dB -q

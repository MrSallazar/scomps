#1/bin/bash

outro=""
algo1=""
algo2=""
regiao=""
tempatual=""
datatemp=""
hora=`date +%H:%M:%S`
min1=""
max1=""
description1=""
min2=""
max2=""
description2=""




valida_cep (){
	curl -X GET http://viacep.com.br/ws/$algo2/json/ 2>/dev/null > retorno.txt
 
	outro=`cat retorno.txt | grep -i logradouro | cut -d":" -f2 | sed 's/"//g;s/,//g' `	
}

valida_endereco (){
	
	curl -X GET http://viacep.com.br/ws/SP/Sao%20Paulo/$algo1/json/ 2>/dev/null > retorno.txt
	
	outro=`cat retorno.txt | grep -i cep | cut -d":" -f2 | sed 's/"//g;s/,//g' `
}

valida_temp (){
	
	
	curl "https://api.hgbrasil.com/weather?array_limit=3&city_name=$regiao,rj&fields=only_results,temp,time,city_name,description,forecast,max,min,date&key=474b765f" 2>/dev/null > doctemp.txt
	tempatual=`cat teste1.txt | grep -i : | cut -d"," -f1 | sed 's/temp//g;s/"//g;s/{//g;s/://g'` 
	datatemp=`cat teste1.txt | grep -i date | cut -d":" -f3 | sed 's/"//g;s/,//g;s/time//g'`
	minima=`cat teste1.txt | grep -i max | cut -d":" -f10 | sed 's/,//g;s/"//g;s/min//g'`
	maxima=`cat teste1.txt | grep -i min | cut -d":" -f11 | sed 's/,//g;s/"//g;s/description//g'`
	max1=`cat teste1.txt | grep -i max | cut -d":" -f14 | sed 's/,//g;s/"//g;s/min//g'`
	min1=`cat teste1.txt | grep -i min | cut -d":" -f15 | sed 's/,//g;s/"//g;s/description//g'`
	description1= `cat teste1.txt | grep -i description | cut -d":" -f16 | sed 's/"//g;s/}//g;s/{//g;s/,//g;s/date//g;'`
	
	max2=`cat teste1.txt | grep -i date | cut -d":" -f18 | sed 's/,//g;s/"//g;s/min//g'`
	min2=`cat teste1.txt | grep -i date | cut -d":" -f19 | sed 's/,//g;s/"//g;s/description//g'`
	description2=`cat teste1.txt | grep -i description | cut -d":" -f20 | sed 's/"//g;s/}//g;s/]//g'`
		
}	
	



while true;do

echo "   _____                                    _____                                     "
echo "  / ____|                                  |  __ \                                    "
echo " | (___   ___ ___  _ __ ___  _ __  ___     | |__) | __ ___   __ _ _ __ __ _ _ __ ___  "
echo "  \___ \ / __/ _ \| '_ \` _ \| '_ \/ __|    |  ___/ '__/ _ \ / _\` | '__/ _\` | '_ \\ "
echo "  ____) | (_| (_) | | | | | | |_) \__ \    | |   | | | (_) | (_| | | | (_| | | | | | |"
echo " |_____/ \___\___/|_| |_| |_| .__/|___/    |_|   |_|  \___/ \__, |_|  \__,_|_| |_| |_|"
echo "                            | |                              __/ |                    "
echo "                            |_|                             |___/                     "



echo " Digite 1 para saber o cep pela rua "
echo " Digite 2 para saber a rua pelo cep "
echo " Digite 3 para tempo "
echo " Digite 4 para sair "
read opcao

case $opcao in
	1) 
		echo " Digite o nome da rua "
		read algo1
		algo1=`echo $algo1 | sed 's/ /%20/g'`
		valida_endereco
		echo " o cep da rua é $outro "
		;;
	
	2) 
		echo " Digite o cep da rua "
		read algo2
		valida_cep
		echo " o endereco da é $outro "
	
		;;
	3) 

		echo""
		echo""

		echo " Digite sua Regiao sem acentos ou pontos, ex: sao paulo."
		read regiao
		valida_temp
		echo " a temperetura atual em $regiao é de $tempatual graus "
		echo " temperatura minima para hoje $minima graus"
		echo " temperatura maxima para hoje $maxima graus"

		
		echo""
		echo""
		echo""
		;;

	4)
		
		break
		
		
		;;

	*) echo " consulta invalida "
		;;

esac
done

exit












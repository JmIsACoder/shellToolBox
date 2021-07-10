#########################################################################
# File Name: toolBoxV1.0.sh
# Author: jiaming
#########################################################################
#!/bin/bash

WIDTH=80
HEIGHT=15
TMP="/tmp/radiolist.$$"
TOOLS_SELECTIONS=5
DE_COMPRESS_SELECTIONS=5
INPUT=0
Install_essential_tools_file="install_essential_tools.sh"
Kernel_replace_file="kernel_replace.sh"

function Compress()
{
	# dialog --title "Your choice" --msgbox "content" ${HEIGHT} ${WIDTH}
	dialog --radiolist "Choose compression type." ${HEIGHT} ${WIDTH} ${DE_COMPRESS_SELECTIONS} "1" ".gz" on "2" ".bz2" off "3" ".tar" off "4" ".zip" off "5" ".xz" off 2>$TMP
	CHOICE=$(cat $TMP)
	rm -f $TMP
	case $CHOICE in
		"1")
			tar -czf ${INPUT}.tar.gz ${INPUT}
			;;
		"2")
			tar -jcf ${INPUT}.tar.bz2 ${INPUT}
			;;
		"3")
			tar -cf ${INPUT}.tar ${INPUT}
			;;
		"4")
			zip -qr ${INPUT}.zip ${INPUT}
			;;
		"5")
			tar -Jcf ${INPUT}.tar.xz ${INPUT}
			;;
		*)
			;;
	esac
	dialog --title "Compress" --msgbox "Done!" ${HEIGHT} ${WIDTH}
}

function Decompress()
{
	# dialog --title "Your choice" --msgbox "content" ${HEIGHT} ${WIDTH}
	dialog --radiolist "Choose Decompression type." ${HEIGHT} ${WIDTH} ${DE_COMPRESS_SELECTIONS} "1" ".gz" on "2" ".bz2" off "3" ".tar" off "4" ".zip" off "5" ".xz" off 2>$TMP
	CHOICE=$(cat $TMP)
	rm -f $TMP
	case $CHOICE in
		"1")
			tar -xzf ${INPUT}
			;;
		"2")
			tar -jxf ${INPUT}
			;;
		"3")
			tar -xf ${INPUT}
			;;
		"4")
			unzip -q ${INPUT}
			;;
		"5")
			tar -Jxf ${INPUT}
			;;
		*)
			;;
	esac
	dialog --title "Decompress" --msgbox "Done!" ${HEIGHT} ${WIDTH}
}

function Inner_Watch()
{
		# dialog --title "Your choice" --msgbox "content" ${HEIGHT} ${WIDTH}
	DE_COMPRESS_SELECTIONS=$[${DE_COMPRESS_SELECTIONS}+1]
	dialog --radiolist "Choose type." ${HEIGHT} ${WIDTH} ${DE_COMPRESS_SELECTIONS} "1" ".gz" on "2" ".bz2" off "3" ".tar" off "4" ".zip" off "5" ".xz" off "6" "file" off 2>$TMP
	CHOICE=$(cat $TMP)
	rm -f $TMP
	touch $TMP
	case $CHOICE in
		"1")
			tar -ztvf ${INPUT} > $TMP
			;;
		"2")
			tar -jtvf ${INPUT} > $TMP
			;;
		"3")
			tar -tvf ${INPUT} > $TMP
			;;
		"4")
			unzip -v ${INPUT} > $TMP
			;;
		"5")
			tar -Jtvf ${INPUT} > $TMP
			;;
		"6")
			cat ${INPUT} > $TMP
			;;
		*)
			;;
	esac
	dialog --title "Show" --textbox $TMP ${HEIGHT} ${WIDTH}
	rm -f $TMP
}

function De_Compression_Tool()
{
	dialog --title "Pick one file or directory" --fselect ./ ${HEIGHT} ${WIDTH} 2>$TMP
	dialog --title "Your choice" --msgbox $(cat $TMP) ${HEIGHT} ${WIDTH}
	INPUT=$(cat $TMP)
	rm -f $TMP
	# echo $INPUT
	dialog --radiolist "What would you want todo next?" ${HEIGHT} ${WIDTH} 3 "1" "Compress" on "2" "Decompress" off "3" "Inner watch" off 2>$TMP
	CHOICE=$(cat $TMP)
	rm -f $TMP

	case $CHOICE in
		"1")
			Compress
			;;
		"2")
			Decompress
			;;
		"3")
			Inner_Watch
			;;
		*)
			
			;;
	esac
}

function SystemWatch_Tool()
{
	if ! [ -x "$(command -v htop)" ]; then
		# echo "command not install."
		dialog --title "Error!" --yesno "COMMAND not install, would you want to install?" ${HEIGHT} ${WIDTH}
		case $? in
			"0")
				apt-get install -qqy htop
				;;
			"1")
				
				;;
			*)
				
				;;
		esac

	fi
	htop	
}

function Show_Date()
{
	# dialog --title "Input day,month,year" --inputmenu "Input" ${HEIGHT} ${WIDTH} 3 "DAY" day "MONTH" month "YEAR" year 
	dialog --title "Calendar" --calendar "Date" 5 ${WIDTH}
}

while :
do
	clear
	dialog --radiolist "ToolBox V1.0" ${HEIGHT} ${WIDTH} ${TOOLS_SELECTIONS} "1" "De/Compression Tool(.gz/.bz2/.tar/.zip/.xz)" on "2" "SystemWatch Tool" off "3" "Show Date Tool" off 2>$TMP
	CHOICE=$(cat $TMP)
	rm -f $TMP
	# echo "Your choice is $CHOICE"

	case $CHOICE in
		"1")
			De_Compression_Tool
			;;
		"2")
			SystemWatch_Tool
			;;
		"3")
			Show_Date
			;;
		*)
			echo "Nothing to choose."
			exit -1
			;;
	esac
done


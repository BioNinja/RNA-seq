#! /bin/bash


##########################################################################
function show_help(){
	echo -e "USAGE:\tbash `dirname $0` <--rep> <-i> [Options]"
	exit 1
}

##########################################################################
while [ $# -gt 0 ]; do
	case $1 in
		--rep)
			rep="$2"
			shift
			;;
		-i|--i)
			input=("${input[@]}" "$2")
			shift
			;;
		--indir)
			input=("${input[@]}" "$2")
			shift
			;;
		-m|--note)
			note="$2"
			shift
			;;
		--init)
			is_init=1
			;;
		*)
			input=("${input[@]}" "$1")
			;;
	esac
	shift
done

[ -z $rep ] && show_help
[ -z $input ] && show_help
[ -z $note ] && note="Test"


####################################################################
[ ! -z $is_init ] && git init
git add ${input[@]}
git commit -m $note
#git remote rm origin
git remote add origin git@github.com:$rep
git push -f origin master



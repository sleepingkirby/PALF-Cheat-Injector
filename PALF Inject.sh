#!/bin/bash
v='1.43'
rpaurl='https://raw.githubusercontent.com/Shizmob/rpatool/master/rpatool'

clear

NC='\033[0m'
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan

cols=`tput cols`
line=`printf '#%.0s' $(seq 1 $cols)`

bkupIFS=$IFS
IFS=$'\n'

echo -e $BGreen$line"\n\n"
echo -e "Pokemon Academy Life Forever Cheat Injector\n" 
echo -e "   Vesrion: ${v}"
echo -e "   by Sleepingkirby"
echo -e "   Inspired/based on RL Cheat Injector by SLDR @ F95zone.com"
echo -e $line$NC"\n\n"

curpath=`pwd`

  if [[ `basename $curpath` != "game" || `echo $curpath|grep -ic 'PokemonAcademyLifeForever'` -lt 1 ]]
  then
  echo -e "$BRed This script is in the wrong path. Please make sure it's in \"PokemonAcademyLifeForever<version>/game/\" folder $NC"
  exit 1
  fi

echo -e "$BGreen Checking if modification has already been done...$NC"

  if [[ -f ./scripts/interfaces/main_menu.rpy.orig || -f ./scripts/interfaces/phone.rpy.orig ]]
  then
  echo -e "${BRed}\n\nBackup files found. This probably means it was already patched. No need to further action. Exitting...$NC"
  exit 1
  fi
echo -e "$BGreen No backup's found. Safe to progress.\n$NC"
echo -e "$BGreen Checking to make sure requirements are met. \n\n$NC"

perlP=`which perl`

  if [[ $perlP == "" ]]
  then
  echo $perlP
  echo -e "$BRed Perl was not found. This script requires perl.$NC"
  exit 1
  fi


  if [[ ! -f ./scripts/interfaces/main_menu.rpy || ! -f ./scripts/interfaces/phone.rpy ]]
  then
  echo -e "${BRed}\n\nFiles to be editted not found. Is it still in the archive.rpa?\n\n$NC"
    if [[ -f ./archive.rpa && ! -f ./rpatool ]]
    then
    echo -e "$BRed Rpatool missing. Downloading$NC"
    wget $rpaurl
    chmod 755 ./rpatool
    fi
  echo -e "$BRed Extracting archive.rpa...$NC"
  ./rpatool -x ./archive.rpa
  wait
  fi


#=============  ./screens.rpy =========
fn="./screens.rpy"
cp $fn $fn.orig

#======= setting cheat versions and Heal button
#    text "Version " + config.version xalign 1.0 yalign 1.01 color "#fff" outlines [ (absolute(10), "#000", absolute(0), absolute(0)) ]

patt='    text "Version " \+ config.version xalign 1\.0 yalign 1\.01 color "#fff" outlines \[ \(absolute\(10\), "#000", absolute\(0\), absolute\(0\)\) \]'
repl='    text "Version " + config.version + " CV '$v'" xalign 1.0 yalign 1.01 color "#fff" outlines [ (absolute(10), "#000", absolute(0), absolute(0)) ]'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn

patt='            textbutton _\("Menu"\) action ShowMenu\(\) text_font "fonts\/pkmndp.ttf" background Frame\("gui\/dialogue_frame.webp"\) keyboard_focus False'
repl='            textbutton _("Menu") action ShowMenu() text_font "fonts\/pkmndp.ttf" background Frame("gui\/dialogue_frame.webp") keyboard_focus False\n            textbutton _("HealParty") action Function(HealParty) text_font "fonts\/pkmndp.ttf" background Frame("gui\/dialogue_frame.webp") keyboard_focus False\n            textbutton _("Cheat V'$v'") action NullAction() text_font "fonts\/pkmndp.ttf" background Frame("gui\/dialogue_frame.webp") keyboard_focus False'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn

#======= timeOfDay
patt='            text "\{size=(?P<size>[0-9]+)\}\{font=fonts\/Microgramma-D-OT-Bold-Extended\.ttf\}\[timeOfDay\] -\{\/font\}\{\/size\} \{size=28\}"\+getRWDay\(0\)\+", "\+str\(calendar.month_name\[calDate\.month\]\)\+" "\+getRDay\(0\)\+"\{\/size\}" color "(?P<color>#[a-zA-Z0-9]+)"'
repl='            textbutton "{color=$+{color}}{size=$+{size}}{font=fonts\/Microgramma-D-OT-Bold-Extended.ttf}[timeOfDay] -{\/font}{\/size} {size=$+{size}}"+getRWDay(0)+", "+str(calendar.month_name[calDate.month])+" "+getRDay(0)+"{\/size}" action SetVariable("timeOfDay", "Morning")'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn

#======= Money
patt='            text "\$" \+ str\('"'"'\{:,\}'"'"'\.format\(money \* \(1 if playercharacter == None else 12\) - \(0 if not \(HasEvent\("Ethan", "Spent200"\) and playercharacter == "Ethan"\) else 200\)\)\) size (?P<size>[0-9]+) color "(?P<color>#[a-zA-Z0-9]+)" at Transform\(xzoom=-1\)'
repl='            textbutton "{size=$+{size}}{color=$+{color}}\$" + str('"'"'{:,}'"'"'.format(money)) at Transform(xzoom=-1):\n                action SetVariable("money", money + 30000)'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn

#======= Trainer EXPs
patt='                bar range GetEXPRequiredForLevel\(char\) value pointvalue pos \(xbuffer \+ 10, 65 \+ ybuffer\) xmaximum math.floor\(335 \* xzoomvalue\) right_bar "#fff" left_bar \(barcolor if pointvalue > 0 else "#fff"\)'
repl='                bar value DictValue(persondex[char], "Value", range=GetEXPRequiredForLevel(char), min=1, max=GetEXPRequiredForLevel(char)) pos (xbuffer + 10, 65 + ybuffer) xmaximum math.floor(335 * xzoomvalue) right_bar "#fff" left_bar (barcolor if pointvalue > 0 else "#fff")'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn

#======= Pokemon Shiny (not fully implemented yet so not applying...for now. Also, looking for a better place to place the button other than the entire name as I wouldn't want to encompass pokemon gender)
patt='            text nick \+ " " \+ gendersymbol size \(70 if len\(nick\) < 10 else 50) '
repl='            textbutton "{size=" + str(70 if len(nick) < 10 else 50) + "}" + nick + " " + gendersymbol:\n                action SetField(pkmn, "ShinyValue", 0.0)'

#======= Pokemon EV/IV
patt='            text str\(pkmn\.Get(?P<eviv>EV|IV)\(Stats\.(?P<stat>Health|Attack|Defense|SpecialAttack|SpecialDefense|Speed)\)\) \+ "\/(?P<num>31|252)" xminimum 300 xalign \.5 size 40'
repl='            textbutton "{size=40}" + str(pkmn.Get$+{eviv}(Stats.$+{stat})) + "\/($+{num})" xalign .5 ysize 20 yanchor -7:\n                action SetDict(pkmn.$+{eviv}s, Stats.$+{stat}, pkmn.Get$+{eviv}(Stats.$+{stat}) + 1 )'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn

#======= Pokemon Stats exclude Health
patt='            text str\(pkmn.GetStat\(Stats.(?P<stat>Attack|Defense|SpecialAttack|SpecialDefense|Speed), triggerAbilities=False, absolute=True\)\) xminimum 300 xalign .5 size 40'
repl='            textbutton "{size=40}" + str(pkmn.GetStat(Stats.$+{stat}, triggerAbilities=False, absolute=True)) xalign .5 ysize 20 yanchor -7:\n                 action SetDict(pkmn.Stats, Stats.$+{stat}, pkmn.GetStat(Stats.$+{stat}) + 1 )'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn


#======= Pokemon Stats Health
patt='            text str\(max\(pkmn.GetHealth\(\), pkmn.GetCaught\(\)\)\) \+ "\/" \+ str\(pkmn.GetStat\(Stats.Health\)\) xminimum 300 xalign .5 size 40'
repl='            textbutton "{size=40}" + str(max(pkmn.GetHealth(), pkmn.GetCaught())) + "\/" + str(pkmn.GetStat(Stats.Health)) xalign .5 ysize 20 yanchor -7:\n                 action SetDict(pkmn.Stats, Stats.Health, pkmn.GetStat(Stats.Health) + 1 )'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn

#======= Class type
patt='            text classtype \+ ": " \+ FormatNum\(classstats\[classtype\]\) size 30 color \("#[a-zA-Z0-9]+" if classstats\[GetStatRank\(0\)\] == classstats\[classtype\] and classstats\[classtype\] != 0 else "#fff"\) outlines \[ \(absolute\(10\), "#000", absolute\(0\), absolute\(0\)\) \]'
repl='            textbutton "{size=30}{color=#fff}" + classtype + ": " + FormatNum(classstats[classtype]):\n               action SetDict(classstats, classtype, classstats[classtype] + 1)'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn
echo -e "${BGreen}${fn} patched$NC"


#=========== ./misc/wildarea.rpy 
fn="./misc/wildarea.rpy"
cp $fn $fn.orig

# remove exp chain limit
patt='                \$ exptotal = math\.floor\(pow\(expvalue, 3\) \/ 25 \* min\(3, \(1 \+ wildcount \/ 10\)\)\)'
repl='                \$ exptotal = math.floor(pow(expvalue, 3) \/ 25 * (1 + wildcount \/ 10))'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn


# adjust exp chain message
patt='                narrator "You have won \[wildcount\] consecutive battles, so your party will gain \[exptotal\] experience each\. \(There are no bonuses after 20 consecutive battles\.\)"'
repl='                narrator "You have won [wildcount] consecutive battles, so your party will gain [exptotal] experience each."'
perl -0777 -i -pe 's/'"$patt"'/'"$repl"'/mg' $fn
echo -e "${BGreen}${fn} patched$NC"

IFS=$bkupIFS

echo -e "${BGreen}DONE!$NC"
exit 0

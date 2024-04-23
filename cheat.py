import re

v = "1.1"
tab = " " * 4
newline = "\n"

#=============  ./screens.rpy =========
def screens():
    fn="screens.rpy"
    with open(fn, "r") as file:
        fc = file.read()

#======= setting cheat versions and Heal button

    patt='    text "Version " \+ config.version xalign 1\.0 yalign 1\.01 color "#fff" outlines \[ \(absolute\(10\), "#000", absolute\(0\), absolute\(0\)\) \]'
    repl='    text "Version " + config.version +' + '" CV ' + v + '" xalign 1.0 yalign 1.01 color "#fff" outlines [ (absolute(10), "#000", absolute(0), absolute(0)) ]'

    fc = re.sub(patt, repl, fc, flags=re.M)

    patt='            textbutton _\("Menu"\) action ShowMenu\(\) text_font "fonts/pkmndp.ttf" background Frame\("gui/dialogue_frame.png"\) keyboard_focus False'
    repl='            textbutton _("Menu") action ShowMenu() text_font "fonts/pkmndp.ttf" background Frame("gui/dialogue_frame.png") keyboard_focus False\n            textbutton _("HealParty") action Function(HealParty) text_font "fonts/pkmndp.ttf" background Frame("gui/dialogue_frame.png") keyboard_focus False\n            textbutton _("Cheat V' + v + '") action NullAction() text_font "fonts/pkmndp.ttf" background Frame("gui/dialogue_frame.png") keyboard_focus False'

    fc = re.sub(patt, repl, fc, flags=re.M)


#======= Money
    patt='            text "\$" \+ str\(\'\{:,\}\'\.format\(money\)\) size (?P<size>[0-9]+) color "(?P<color>#[a-zA-Z0-9]+)" at Transform\(xzoom=-1\)'
    repl='            textbutton "{size=\g<size>}{color=\g<color>}$" + str(\'{:,}\'.format(money)) at Transform(xzoom=-1):\n                action SetVariable("money", money + 30000)'
    fc = re.sub(patt, repl, fc, flags=re.M)

#======= Trainer EXPs

    patt='                bar range GetEXPRequiredForLevel\(char\) value pointvalue pos \(xbuffer \+ 10, 65 \+ ybuffer\) xmaximum math.floor\(335 \* xzoomvalue\) right_bar "#fff" left_bar \(barcolor if pointvalue > 0 else "#fff"\)'
    repl='                bar value DictValue(persondex[char], "Value", 10) pos (xbuffer + 10, 65 + ybuffer) xmaximum math.floor(335 * xzoomvalue) right_bar "#fff" left_bar (barcolor if pointvalue > 0 else "#fff")'

    fc = re.sub(patt, repl, fc, flags=re.M)


#======= Pokemon EV/IV
    
    patt='            text str\(pkmn\.Get(?P<eviv>EV|IV)\(Stats\.(?P<stat>Health|Attack|Defense|SpecialAttack|SpecialDefense|Speed)\)\) \+ "/(?P<num>31|255)" xminimum 300 xalign \.5 size 40'
    repl='            textbutton "{size=40}" + str(pkmn.Get\g<eviv>(Stats.\g<stat>)) + "/(\g<num>)" xalign .5 ysize 20 yanchor -7:\n                action SetDict(pkmn.\g<eviv>s, Stats.\g<stat>, pkmn.Get\g<eviv>(Stats.\g<stat>) + 1 )'

    fc = re.sub(patt, repl, fc, flags=re.M)

#======= Pokemon Stats exclude Health
    
    patt='            text str\(pkmn.GetStat\(Stats.(?P<stat>Attack|Defense|SpecialAttack|SpecialDefense|Speed), triggerAbilities=False, absolute=True\)\) xminimum 300 xalign .5 size 40'
    repl='            textbutton "{size=40}" + str(pkmn.GetStat(Stats.\g<stat>, triggerAbilities=False, absolute=True)) xalign .5 ysize 20 yanchor -7:\n                 action SetDict(pkmn.Stats, Stats.\g<stat>, pkmn.GetStat(Stats.\g<stat>) + 1 )'

    fc = re.sub(patt, repl, fc, flags=re.M)


#======= Pokemon Stats Health
    
    patt='            text str\(max\(pkmn.GetHealth\(\), pkmn.GetCaught\(\)\)\) \+ "/" \+ str\(pkmn.GetStat\(Stats.Health\)\) xminimum 300 xalign .5 size 40'
    repl='            textbutton "{size=40}" + str(max(pkmn.GetHealth(), pkmn.GetCaught())) + "/" + str(pkmn.GetStat(Stats.Health)) xalign .5 ysize 20 yanchor -7:\n                 action SetDict(pkmn.Stats, Stats.Health, pkmn.GetStat(Stats.Health) + 1 )'

    fc = re.sub(patt, repl, fc, flags=re.M)


#======= Class type

    patt='            text classtype \+ ": " \+ FormatNum\(classstats\[classtype\]\) size 30 color \("#f00" if classstats\[GetStatRank\(0\)\] == classstats\[classtype\] else "#fff"\) outlines \[ \(absolute\(10\), "#000", absolute\(0\), absolute\(0\)\) \]'
    repl='            textbutton "{size=30}{color=#fff}" + classtype + ": " + FormatNum(classstats[classtype]):\n               action SetDict(classstats, classtype, classstats[classtype] + 1)'

    fc = re.sub(patt, repl, fc, flags=re.M)



    with open(fn, "w") as file:
        file.write(fc)

    print(f"{fn} patched")

screens()




print(f"    Success! Cheats are now enabled!")

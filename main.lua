nz_IMAGES = "sys/lua/"
zimage = {}
zm = {}

function initArray(m)
local array = {}
for i = 1, m do
array[i] = 0
end
return array
end
healthmodule = initArray(32)
maxhealthmodule = initArray(32)
percenthp = initArray(32)
damage = initArray(32)
damageclaw = initArray(32)
class = initArray(32)
totalspeed = initArray(32)
kills = initArray(32)
cash = initArray(32)
reward = initArray(32)
abil = initArray(32)
cooldown = initArray(32)
enragetime = initArray(32)
hardentime = initArray(32)
timerid = 31
timeridzombie = 46
zombiestart = initArray(32)
regdelay = initArray(32)
skillpoints = initArray(32)
healthskill = initArray(32)
damageskill = initArray(32)
speedskill = initArray(32)
cooldownskill = initArray(32)
abilityskill = initArray(32)
cancelothers = initArray(32)
medikit = initArray(32)
slowdown = initArray(32)
hhealthskill = initArray(32)
hspeedskill = initArray(32)
hcooldownskill = initArray(32)
memberstatus = initArray(32)
equippedbefore = initArray(32)
artificialhealth = initArray(32)
adrenaline = initArray(32)
equippedbefore1 = initArray(32)
hdamageskill = initArray(32)
buildingdamage = initArray(32)
damagesource = initArray(32)
boughtammo = initArray(32)
boughtmask = initArray(32)
boughthorn = initArray(32)
boughtangel = initArray(32)
boughtwizard = initArray(32)
boughtsanta = initArray(32)
boughtzombie = initArray(32)
bought1 = initArray(32)
bought2 = initArray(32)
bought3 = initArray(32)
onfire = initArray(32)
bossround = 0

parse("mp_wpndmg usp 22")
parse("mp_wpndmg glock 23")
parse("mp_wpndmg deagle 52")
parse("mp_wpndmg elite 20")
parse("mp_wpndmg mp5 24")
parse("mp_wpndmg m3 48")
parse("mp_wpndmg xm1014 41")
parse("mp_wpndmg m4a1 28")
parse("mp_wpndmg ak-47 36")
parse("mp_wpndmg p90 23")
parse("mp_wpndmg flamethrower 15")
parse("mp_wpndmg claw 50")
parse("mp_wpndmg machete 300")
parse("mp_wpndmg m249 48")
parse("mp_wpndmg m134 39")
parse("mp_wpndmg awp 225")
parse("mp_wpndmg scout 80")
parse("mp_wpndmg rpglauncher 700")
parse("mp_wpndmg ump45 30")
parse("mp_wpndmg gasgrenade 15")
parse("mp_wpndmg knife 125")
parse("mp_wpndmg chainsaw 150")
parse("mp_wpndmg mac10 26")
parse("mp_wpndmg five-seven 31")
parse("mp_wpndmg galil 29")
parse("mp_wpndmg famas 36")
parse("mp_wpndmg g3sg1 55")
parse("mp_wpndng sg550 55")
parse("mp_wpndmg HE 300")
parse("mp_wpndmg fnf2000 36")
parse("mp_wpndmg aug 36")
parse('mp_building_limit "Turret" 5')
parse('mp_building_limit "Gate Field" 30')
parse('mp_building_price "Turret" 8000')
parse('mp_building_price "Gate Field" 500')
parse('mp_building_price "Barricade" 1500')
parse('mp_building_price "Wall I" 1500')
parse('mp_building_price "Wall II" 2000')
parse('mp_building_price "Wall III" 2500')
parse('mp_building_price "Dispenser" 10000')
parse('mp_building_price "Supply" 10000')
parse('mp_building_health "Barricade" 200')
parse('mp_building_health "Wall I" 400')
parse('mp_building_health "Wall II" 600')
parse('mp_building_health "Wall III" 800')
parse('mp_building_health "Turret" 500')
parse('mp_building_health "Gate Field" 800')
parse('mp_building_health "Dispenser" 500')
parse('mp_building_health "Supply" 500')
parse('mp_building_health "Super Supply" 1000')
parse('mp_building_health "Dual Turret" 650')
parse('mp_building_health "Triple Turret" 800')

addhook("join","zm.setstats")
function zm.setstats(id)
	healthmodule[id] = 0
	maxhealthmodule[id] = 100
	class[id] = "None"
	totalspeed[id] = 0
	cash[id] = 0
	reward[id] = 0
	abil[id] = "None"
	artificialhealth[id] = 0
end

addhook("startround","zm.settimerid")
function zm.settimerid(id)
	for id = 1,32 do
		timerid = 31
		timeridzombie = 46
		equippedbefore[id] = 0
		equippedbefore1[id] = 0
		enragetime[id] = 0
		hardentime[id] = 0
		adrenaline[id] = 0
		medikit[id] = 0
		bossround = 0
	end
end

addhook("ms100","zm.ctspawn")
function zm.ctspawn(id)
	for id = 1,32 do
		if timerid > 1 then
			if (player(id, "team") == 1) then
				parse("makect "..id)
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
			end
		end
	end
end

addhook("second","zm.timeridfunczombie")
function zm.timeridfunczombie(id)
	if timeridzombie > 1 then
		timeridzombie = timeridzombie - 1
	end
	if timeridzombie == 1 then
		timeridzombie = timeridzombie - 1
		msg("\169255000000Boosted zombies have stopped spawning.")
	end
end

addhook("second","zm.timeridfunc")
function zm.timeridfunc(id)
	if timerid > 1 then
		timerid = timerid - 1
		msg("\169100255000"..timerid.."@C")
	end
	if timerid == 1 then
		timerid = timerid - 1
		zombiestart = 1
		msg("\169100255000Zombies have arrived!@C")
	end
end

addhook("second","zm.maketafter")
function zm.maketafter(id)
	for id = 1,32 do
		if bossround == 0 then
		if zombiestart == 1 then
			if (class[id] == "Survivor" and math.random(1,1000) <= 100) then
			parse("maket "..id)
			parse("maket "..math.random(1, 32))
			parse("maket "..math.random(1, 32))
			parse("maket "..math.random(1, 32))
			parse("maket "..math.random(1, 32))
			parse("maket "..math.random(1, 32))
			zombiestart = 0
			end
		end
		else
		if zombiestart == 1 then
			if (class[id] == "Survivor" and math.random(1,32) <= 2) then
			parse("maket "..id)
			end
		end
		end
	end
end
addhook("second","zm.nemesis")
function zm.nemesis(id)
	local players = player(0,"tableliving")
	for _,id in ipairs(players) do
	if bossround == 1 then
		if zombiestart == 1 then
			if class[id] == "Survivor" and math.random(1,32) <= 16 then
				parse("maket "..id)
				zombiestart = 0
			end
		end
		end
	end
end

addhook("die","zm.alwayst")
function zm.alwayst(id)
	if player(id, "team") == 2 then
	parse("maket "..id)
	end
	abil[id] = "None"
	class[id] = "None"
	onfire[id] = 0
end


addhook("second","zm.health")
function zm.health(id)
	local players = player(0,"tableliving")
		for _,id in ipairs(players) do
		percenthp[id] = math.floor((healthmodule[id] / maxhealthmodule[id]) * 100)
		
		if (percenthp[id] < 1) then
			percenthp[id] = 1
		end
		
		parse("sethealth "..id.." "..percenthp[id])
	end
end

addhook("hit","zm.newhealthsystem")
function zm.newhealthsystem(id, source, weapon, hpdmg, apdmg, rawdmg, obj)
	if player(source, "team") == 1 then
		if player(id, "team") == 2 then
			if (obj > 0) then
				-- player was hit by a building
				damage[source] = damageclaw[source]
			else
				-- player was hit by another player
				damage[source] = damageclaw[source]
			end
			if artificialhealth[id] > 0 then
				artificialhealth[id] = artificialhealth[id] - damage[source]
				parse(' hudtxt2 '..source..' 45 "\169255255255Target \169000255000HP \169255255255Left:\169128128128 '..healthmodule[id]..'/'..maxhealthmodule[id]..' + '..artificialhealth[id]..' " 2 255')
				return 1
				else
					if healthmodule[id] > damage[source] then
						healthmodule[id] = healthmodule[id] - damage[source]
						zm.health(id)
						parse(' hudtxt2 '..source..' 45 "\169255255255Target \169000255000HP \169255255255Left:\169128128128 '..healthmodule[id]..'/'..maxhealthmodule[id]..' + '..artificialhealth[id]..' " 2 255')
						return 1
					end
			end
		end
	end
	if player(source, "team") == 2 then
		if player(id, "team") == 1 then
			if (obj > 0) then
				-- player was hit by a building
				damage[source] = 15 + (math.floor(hdamageskill[source]*0.5))
			else
				-- player was hit by another player
				damage[source] = itemtype(weapon, "dmg")
			end
			if itemtype(weapon, "name") == "Flamethrower" then
				onfire[id] = 1
			end
			if artificialhealth[id] > 0 then
				artificialhealth[id] = artificialhealth[id] - damage[source]
				parse(' hudtxt2 '..source..' 45 "\169255255255Target \169000255000HP \169255255255Left:\169128128128 '..healthmodule[id]..'/'..maxhealthmodule[id]..' + '..artificialhealth[id]..' " 2 255')
				return 1
				else
					if healthmodule[id] > damage[source] then
						healthmodule[id] = healthmodule[id] - damage[source]
						zm.health(id)
						parse(' hudtxt2 '..source..' 45 "\169255255255Target \169000255000HP \169255255255Left:\169128128128 '..healthmodule[id]..'/'..maxhealthmodule[id]..' + '..artificialhealth[id]..' " 2 255')
						return 1
					end
			end
		end
	end
end

addhook("second","zm.slowdown2")
function zm.slowdown2(id)
	for id = 1,32 do
		if player(id,"team") == 1 then
			if onfire[id] == 0 then
				if slowdown[id] > 0 then
					slowdown[id] = slowdown[id] - 1
				else
					parse("speedmod "..id.." "..totalspeed[id])
					parse(' hudtxt2 '..id..' 47 "" 2 300')
					if healthmodule[id] >= maxhealthmodule[id] then
						healthmodule[id] = maxhealthmodule[id]
					end
				end
			end
		end
	end
end

addhook("second","zm.onfire")
function zm.onfire(id)
	local players = player(0,"tableliving")
	for _,id in ipairs(players) do
		if onfire[id] == 1 then
			parse(' hudtxt2 '..id..' 100 "\169255000000On fire!" 2 315')
			slowdown[id] = 3
			healthmodule[id] = healthmodule[id] - 40
			if class[id] ~= "Heavy" then
				parse(' hudtxt2 '..id..' 47 "\169255000000Major Slowdown!" 2 300')
				parse("speedmod "..id.." "..totalspeed[id]-9)
				if class[id] == "Hunter" then
					parse("speedmod "..id.." "..totalspeed[id]-14)
				end
				if class[id] == "Tank" then
					parse("speedmod "..id.." "..totalspeed[id]-7)
				end
			end
			if healthmodule[id] <= 0 then
				healthmodule[id] = 1
			end
		end
			if onfire[id] == 0 then
				parse(' hudtxt2 '..id..' 100 "" 2 300')
			end
	end
end
	

addhook("hit","zm.slowdown3")
function zm.slowdown3(id, source)
	if player(id, "team") == 1 then
		if onfire[id] == 0 then
			slowdown[id] = 1
			if slowdown[id] >= 1 then
				if class[id] ~= "Heavy" then
					parse(' hudtxt2 '..id..' 47 "\169255000000Minor Slowdown!" 2 300')
					parse("speedmod "..id.." "..totalspeed[id]-6)
					if class[id] == "Hunter" then
						parse("speedmod "..id.." "..totalspeed[id]-10)
					end
					if class[id] == "Tank" then
						parse("speedmod "..id.." "..totalspeed[id]-5)
					end
				end
			end
		end
	end
end

addhook("die","zm.setto0")
function zm.setto0(id)
	healthmodule[id] = 0
	maxhealthmodule[id] = 0
	enragetime[id] = 0
	hardentime[id] = 0
	cooldown[id] = 0
	parse(' hudtxt2 '..id..' 8 "" 2 285')
	parse(' hudtxt2 '..id..' 27 "" 2 270')
	parse(' hudtxt2 '..id..' 54 "" 2 285')
	if (zimage[id] ~= nil) then
		freeimage(zimage[id])
		zimage[id] = nil
	end
end

addhook("spawn","zm.setto1")
function zm.setto1(id)
	hardentime[id] = 0
	enragetime[id] = 0
	parse(' hudtxt2 '..id..' 8 "" 250 700')
	onfire[id] = 0
end

addhook("say","zm.customchat")
function zm.customchat(id,txt,message,usgn)
	if player(id,"usgn") == 129888 then
		cancelothers[id] = 1
		memberstatus[id] = 1
		msg("\169255255255"..player(id,"name").." \169100100255[Developer]:\169255255255 "..txt)
		return 1
	end
	if player(id,"usgn") == 188276 then
		cancelothers[id] = 1
		memberstatus[id] = 1
		msg("\169255255255"..player(id,"name").." \169255255000[Contributor]:\169255255255 "..txt)
		return 1
	end
	if player(id,"usgn") == 180938 then
		cancelothers[id] = 1
		memberstatus[id] = 1
		msg("\169255255255"..player(id,"name").." \169255255000[Contributor]:\169255255255 "..txt)
		return 1
	end
	if cancelothers[id] == 0 then
		if player(id,"team") == 2 then
			msg("\169050050255"..player(id,"name").." \169255255255["..class[id].."]:\169255255255 "..txt)
			return 1
		end
		if player(id,"team") == 1 then
			msg("\169255000000"..player(id,"name").." \169255255255["..class[id].."]:\169255255255 "..txt)
			return 1
		end
	end
end

addhook("second","zm.medikitsurv")
function zm.medikitsurv(id,txt)
	for id = 1,32 do
		if medikit[id] > 0 then
			parse("speedmod "..id.." "..totalspeed[id]-7)
			parse(' hudtxt2 '..id..' 43 "\169255000000Slowed down!" 2 300')
			parse(' hudtxt2 '..id..' 44 "\169255000000Healing!" 2 285')
			medikit[id] = medikit[id] - 1
			healthmodule[id] = healthmodule[id] + 18
			if healthmodule[id] >= maxhealthmodule[id] then
				healthmodule[id] = maxhealthmodule[id]
			end
			if medikit[id] == 9 then
			msg2(id,"\169255255255Applying \169000255000 First Aid Kit")
			parse("trigger humanabil")
			end
			if medikit[id] == 4 then
				msg2(id,"\169255255255Almost done!")
			end
			if medikit[id] == 1 then
				msg2(id,"\169255255255Done!")
			end
			if medikit[id] == 0 then
			parse(' hudtxt2 '..id..' 43 "" 2 300')
			parse(' hudtxt2 '..id..' 44 "" 2 285')
			parse("speedmod "..id.." "..totalspeed[id])
			end
		end
	end
end

addhook("second","zm.adrenalineabil")
function zm.adrenalineabil(id)
	for id = 1,32 do
		adrenaline[id] = adrenaline[id] - 1
		if adrenaline[id] > 0 then
			parse("speedmod "..id.." "..totalspeed[id]+9)
			parse(' hudtxt2 '..id..' 43 "\169255000000Adrenaline!" 2 285')
		end
		if adrenaline[id] == 2 then
			parse("speedmod "..id.." "..totalspeed[id]-6)
			parse(' hudtxt2 '..id..' 43 "\169255000000Burnt out!" 2 300')
		end
		if adrenaline[id] == 1 then
			parse("speedmod "..id.." "..totalspeed[id])
			parse(' hudtxt2 '..id..' 43 "" 2 300')
		end
		if adrenaline[id] <= 0 then
			parse(' hudtxt2 '..id..' 43 "" 2 300')
		end
	end
end

addbind("space")
addhook("key","zm.abilities")
function zm.abilities(id,key)
	if (key == "space") then
		if cooldown[id] == 0 then
			if class[id] == "Survivor" then
				if abil[id] == "First Aid Kit - Space" then
					medikit[id] = 10
					cooldown[id] = math.floor(30 - (hcooldownskill[id] * 0.4))
					msg2(id,"\169000255000Skill activated!")
					msg("\169255255255"..player(id,"name").." \169255255000[Voice]:\169255255255 Patching myself up!")
				end
				if abil[id] == "Pills - Space" then
					cooldown[id] = math.floor(20 - (hcooldownskill[id] * 0.3))
					healthmodule[id] = healthmodule[id] + 60
					artificialhealth[id] = 125 + (hhealthskill[id] * 2)
					msg2(id,"\169000255000Skill activated!")
					msg("\169255255255"..player(id,"name").." \169255255000[Voice]:\169255255255 These pills will do.")
					if healthmodule[id] >= maxhealthmodule[id] then
						healthmodule[id] = maxhealthmodule[id]
					end
				end
				if abil[id] == "Adrenaline - Space" then
					cooldown[id] = math.floor(25 - (hcooldownskill[id] * 0.3))
					healthmodule[id] = healthmodule[id] + 45
					artificialhealth[id] = 80 + (hhealthskill[id] * 1.5)
					adrenaline[id] = 10
					msg2(id,"\169000255000Skill activated!")
					msg("\169255255255"..player(id,"name").." \169255255000[Voice]:\169255255255 Using adrenaline.")
					if healthmodule[id] >= maxhealthmodule[id] then
						healthmodule[id] = maxhealthmodule[id]
					end
				end
			end
			if class[id] == "Walker" then
				healthmodule[id] = healthmodule[id] + 75
				cooldown[id] = math.floor(10 - (cooldownskill[id] * 0.2))
				msg2(id,"\169000255000Skill activated!")
				if healthmodule[id] >= maxhealthmodule[id] then
					healthmodule[id] = maxhealthmodule[id]
				end
			end
			if class[id] == "Hunter" then
				cooldown[id] = math.floor(30 - (cooldownskill[id] * 0.4))
				damageclaw[id] = 55 + (damageskill[id] * 0*4)
				artificialhealth[id] = 200
				enragetime[id] = 7
				msg2(id,"\169000255000Skill activated!")
			end
			if class[id] == "Heavy" then
				cooldown[id] = math.floor(20 - (cooldownskill[id] * 0.4))
				parse("speedmod "..id.." "..totalspeed[id]-3)
				artificialhealth[id] = 350 + (healthskill[id]*10)
				hardentime[id] = 7
				msg2(id,"\169000255000Skill activated!")
			end
			if class[id] == "Detonator" then
				cooldown[id] = 0
				parse("explosion "..player(id, "x").." "..player(id, "y").." 100 500 "..id)
				parse("killplayer "..id)
			end
			if class[id] == "Brute" then
				cooldown[id] = math.floor(10 - (cooldownskill[id] * 0.2))
				parse("explosion "..player(id, "x").." "..player(id, "y").." 60 500 "..id)
			end
			if class[id] == "Tank" then
				cooldown[id] = math.floor(25 - (cooldownskill[id] * 0.4))
				parse("explosion "..player(id, "x") - 64 .." "..player(id, "y").." 60 50000 "..id)
				parse("explosion "..player(id, "x") + 64 .." "..player(id, "y").." 60 50000 "..id)
				parse("explosion "..player(id, "x") - 64 .." "..player(id, "y") + 64 .." 60 50000 "..id)
				parse("explosion "..player(id, "x") + 64 .." "..player(id, "y") - 64 .." 60 50000 "..id)
				parse("explosion "..player(id, "x").." "..player(id, "y") + 64 .." 60 50000 "..id)
				parse("explosion "..player(id, "x").." "..player(id, "y") - 64 .." 60 50000 "..id)
				parse("explosion "..player(id, "x") - 64 .." "..player(id, "y") - 64 .." 60 50000 "..id)
				parse("explosion "..player(id, "x") + 64 .." "..player(id, "y") + 64 .." 60 50000 "..id)
				parse("trigger tankyell")
			end
			if class[id] == "Nemesis" then
				cooldown[id] = math.floor(60 - (cooldownskill[id] * 0.4))
				parse("explosion "..player(id, "x").." "..player(id, "y").." 250 1000000 "..id)
				parse("trigger tankyell")
			end
		end
	end
end

addhook("die","zm.tankdeath")
function zm.tankdeath(id)
	if class[id] == "Tank" then
		parse("trigger tankdeath")
		msg("\169255255255"..player(id,"name").."\169255000000 (Tank)\169255255255 has died!")
	end
end

addhook("second","zm.hardentimefunc")
function zm.hardentimefunc(id)
	for id = 1,32 do
		if class[id] == "Heavy" then
			if hardentime[id] >= 1 then
				hardentime[id] = hardentime[id] - 1
				healthmodule[id] = healthmodule[id] + 35
				if healthmodule[id] >= maxhealthmodule[id] then
					healthmodule[id] = maxhealthmodule[id]
				end
				parse(' hudtxt2 '..id..' 8 "\169255000000Regening! " 2 285')
				parse(' hudtxt2 '..id..' 27 "\169255000000Hardened! " 2 270')
				parse(' hudtxt2 '..id..' 54 "" 2 285')
			end
			if hardentime[id] == 0 then
				parse(' hudtxt2 '..id..' 8 "" 250 700')
				parse(' hudtxt2 '..id..' 27 "" 2 270')
				parse(' hudtxt2 '..id..' 54 "" 2 285')
				hardentime[id] = 0
				parse("speedmod "..id.." "..totalspeed[id])
			end
		end
	end
end

addhook("second","zm.enragetimefunc")
function zm.enragetimefunc(id)
	for id = 1,32 do
		if class[id] == "Hunter" then
			if enragetime[id] >= 1 then
				enragetime[id] = enragetime[id] - 1
				parse(' hudtxt2 '..id..' 54 "\169255000000Enraged! " 2 285')
				parse(' hudtxt2 '..id..' 8 "" 2 285')
				parse(' hudtxt2 '..id..' 27 "" 2 270')
			end
			if enragetime[id] == 0 then
				parse(' hudtxt2 '..id..' 54 "" 250 700')
				parse(' hudtxt2 '..id..' 8 "" 2 285')
				parse(' hudtxt2 '..id..' 27 "" 2 270')
				enragetime[id] = 0
				damageclaw[id] = damageclaw[id]
				parse("speedmod "..id.." "..totalspeed[id])
			end
			if enragetime[id] == 6 then
				totalspeed[id] = totalspeed[id] + 2
			end
		end
	end
end

addhook("second","zm.cooldownabil")
function zm.cooldownabil(id)
	for id = 1,32 do
		if cooldown[id] >= 1 then
			cooldown[id] = cooldown[id] - 1
		end
		if cooldown[id] == 0 then
			cooldown[id] = 0
		end
	end
end

addhook("spawn","zm.testspawn")
function zm.testspawn(id)
	if player(id, "team") == 1 then
		if (zimage[id] ~= nil) then
			freeimage(zimage[id])
			zimage[id] = nil
		end
		class[id] = "Walker"
		if timeridzombie <= 1 then
		healthmodule[id] = 300 + (healthskill[id] * 4)
		maxhealthmodule[id] = 300 + (healthskill[id] * 4)
		damageclaw[id] = 25 + (damageskill[id] * 0.5)
		totalspeed[id] = math.floor(0 + (speedskill[id] * 0.1))
		else
		healthmodule[id] = 700
		maxhealthmodule[id] = 700
		damageclaw[id] = 40
		totalspeed[id] = 4
		end
		parse("speedmod "..id.." "..totalspeed[id])
		parse("speedmod "..id.." -2")
		abil[id] = "Heal - Space"
		reward[id] = 15
		if (class[id] == "Walker" and math.random(1, 1000) <= 300) then
			class[id] = "Hunter"
			if timeridzombie <= 1 then
			healthmodule[id] = 400 + (healthskill[id] * 5) 
			maxhealthmodule[id] = 400 + (healthskill[id] * 5)
			damageclaw[id] = 40 + (damageskill[id] * 0.75)
			totalspeed[id] = math.floor(6 + (speedskill[id] * 0.175))
			else
			healthmodule[id] = 900
			maxhealthmodule[id] = 900
			damageclaw[id] = 75
			totalspeed[id] = 9
			end
			parse("speedmod "..id.." "..totalspeed[id])
			abil[id] = "Enrage - Space"
			zimage[id] = image(nz_IMAGES.."zombie/hunter.png", 3, 0, 200 + id)
			msg2(id,"\169255255255You are a \169255000000Hunter!")
			msg2(id,"\169255255255Speedy and quite tanky, prey on lone survivors")
			reward[id] = 25
		end
		if (class[id] == "Walker" and math.random(1, 1000) <= 300) then
			class[id] = "Heavy"
			if timeridzombie <= 1 then
			healthmodule[id] = 750 + (healthskill[id] * 10) 
			maxhealthmodule[id] = 750 + (healthskill[id] * 10)
			damageclaw[id] = 55 + (damageskill[id] * 1)
			totalspeed[id] = math.floor(-4 + (speedskill[id] * 0.1))
			else
			healthmodule[id] = 1250
			maxhealthmodule[id] = 1250
			damageclaw[id] = 90
			totalspeed[id] = 0
			end
			parse("speedmod "..id.." "..totalspeed[id])
			abil[id] = "Regen - Space"
			zimage[id] = image(nz_IMAGES.."zombie/heavy.png", 3, 0, 200 + id)
			msg2(id,"\169255255255You are a \169255000000Heavy!")
			msg2(id,"\169255255255Very tanky, make sure to attract the survivor's attention and be the bullet sponge")
			reward[id] = 25
		end
		if (class[id] == "Walker" and math.random(1, 1000) <= 300) then
			class[id] = "Detonator"
			if timeridzombie <= 1 then
			healthmodule[id] = 350 + (healthskill[id] * 6) 
			maxhealthmodule[id] = 350 + (healthskill[id] * 6)
			damageclaw[id] = 100 + (damageskill[id] * 2)
			totalspeed[id] = math.floor(-2 + (speedskill[id] * 0.1))
			else
			healthmodule[id] = 700
			maxhealthmodule[id] = 700
			damageclaw[id] = 175
			totalspeed[id] = 2
			end
			parse("speedmod "..id.." "..totalspeed[id])
			abil[id] = "Detonate - Space"
			zimage[id] = image(nz_IMAGES.."zombie/exploding.png", 3, 0, 200 + id)
			msg2(id,"\169255255255You are a \169255000000Detonator!")
			msg2(id,"\169255255255Sneak past survivors or blow up near buildings to deal extreme damage to them")
			reward[id] = 25
		end
		if (class[id] == "Walker" and math.random(1, 1000) <= 100) then
			class[id] = "Brute"
			if timeridzombie <= 1 then
			healthmodule[id] = 2000 + (healthskill[id] * 40) 
			maxhealthmodule[id] = 2000 + (healthskill[id] * 40)
			damageclaw[id] = 75 + (damageskill[id] * 2)
			totalspeed[id] = math.floor(-3 + (speedskill[id] * 0.1))
			else
			healthmodule[id] = 3250
			maxhealthmodule[id] = 3250
			damageclaw[id] = 130
			totalspeed[id] = 0
			end
			parse("speedmod "..id.." "..totalspeed[id])
			abil[id] = "Crush - Space"
			zimage[id] = image(nz_IMAGES.."zombie/brute.png", 3, 0, 200 + id)
			msg2(id,"\169255255255You are a \169128128128Brute!")
			msg2(id,"\169255255255Very tough, high damage against survivors and crush ability eviscerates buildings")
			reward[id] = 100
		end
		if (class[id] == "Walker" and math.random(1, 1000) <= 40) then
			class[id] = "Tank"
			if timeridzombie <= 1 then
			healthmodule[id] = 6000 + (healthskill[id] * 100)
			maxhealthmodule[id] = 6000 + (healthskill[id] * 100)
			damageclaw[id] = 100 + (damageskill[id] * 2.5)
			totalspeed[id] = math.floor(-1 + (speedskill[id] * 0.125))
			else
			healthmodule[id] = 10000
			maxhealthmodule[id] = 10000
			damageclaw[id] = 160
			totalspeed[id] = 0
			end
			parse("speedmod "..id.." "..totalspeed[id])
			abil[id] = "Earthquake - Space"
			zimage[id] = image(nz_IMAGES.."zombie/superbrute.png", 3, 0, 200 + id)
			reward[id] = 400
			parse("trigger tankspawn")
			msg("\169255255255A \169255000000Tank\169255255255 is approaching!@C")
			msg2(id,"\169255255255You are THE \169255000000TANK!!")
			msg2(id,"\169255255255You are not invincible, well, almost")
			msg2(id,"\169255255255Earthquake ability completely destroys buildings in a large area")
		end
	end
	if bossround == 1 then
		if player(id, "team") == 1 then
		class[id] = "Nemesis"
			healthmodule[id] = 70000
			maxhealthmodule[id] = 70000
			damageclaw[id] = 175
			totalspeed[id] = 0
			parse("speedmod "..id.." "..totalspeed[id])
			abil[id] = "Nuke - Space"
			zimage[id] = image(nz_IMAGES.."zombie/superbrute2.png", 3, 0, 200 + id)
			reward[id] = 6000
			parse("trigger tankspawn")
			msg("\169255255255The \169255000000Nemesis\169255255255 is approaching!@C")
			msg2(id,"\169255255255You are THE \169255000000NEMESIS!!")
			msg2(id,"\169255255255You are not invincible, well, almost")
			msg2(id,"\169255255255Nuke ability deals 650 damage in an extremely large area")
		end
	end
	if player(id, "team") == 2 then
		if (zimage[id] ~= nil) then
			freeimage(zimage[id])
			zimage[id] = nil
		end
		healthmodule[id] = 250 + (hhealthskill[id] * 6)
		maxhealthmodule[id] = 250 + (hhealthskill[id] * 6)
		reward[id] = 150
		totalspeed[id] = math.floor(1 + (hspeedskill[id] * 0.15))
		parse("equip "..id.." 74")
		class[id] = "Survivor"
		parse("speedmod "..id.." "..totalspeed[id])
		abil[id] = "First Aid Kit - Space"
	end
end

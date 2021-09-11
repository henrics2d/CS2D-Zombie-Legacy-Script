addhook("spawn","zm.applyskillsbot")
function zm.applyskillsbot(id)
	for id = 1,32 do
		if player(id, "bot") then
			cooldownskill[id] = math.floor(math.random(1, 25))
			healthskill[id] = math.floor(math.random(1, 25))
			damageskill[id] = math.floor(math.random(1, 25))
			speedskill[id] = math.floor(math.random(1, 25))
			hhealthskill[id] = math.floor(math.random(1, 25))
			hdamageskill[id] = math.floor(math.random(1, 25))
			hcooldownskill[id] = math.floor(math.random(1, 25))
			hspeedskill[id] = math.floor(math.random(1, 25))
		end
	end
end

addhook("ms100","zm.unfreezebotsauto")
function zm.unfreezebotsauto(id)
	if math.random(1,10000) < 175 then
		parse("bot_freeze 0")
	end
end

addhook("ms100","zm.debughud")
function zm.debughud(id)
	for id = 1,32 do
	parse(' hudtxt2 '..id..' 1 "\169000255000HP:\169255255255 '..healthmodule[id]..'/'..maxhealthmodule[id]..'\169255255000 + '..artificialhealth[id]..' " 2 215')
	
	end
end

addhook("die","zm.artireset")
function zm.artireset(id)
	artificialhealth[id] = 0
end

addhook("ms100","zm.artificialhealthsys")
function zm.artificialhealthsys(id)
	for id = 1,32 do
		if artificialhealth[id] > 0 then
			artificialhealth[id] = artificialhealth[id] - 1
		end
		if artificialhealth[id] < 0 then
			artificialhealth[id] = 0
		end
	end
end

addhook("ms100","zm.lvlsys")
function zm.lvlsys(id)
	for id = 1,32 do
		if (player(id,"exists")) then
			parse(' hudtxt2 '..id..' 4 "\169170000000Kills:\169255255255 '..kills[id]..' " 2 345')
			parse(' hudtxt2 '..id..' 23 "\169000180000Cash:\169255255255 '..cash[id]..'$ " 2 360')
			parse(' hudtxt2 '..id..' 25 "\169100100255Skillpoints:\169255255255 '..skillpoints[id]..' " 2 375')
			if player(id, "team") == 2 then
			parse(' hudtxt2 '..id..' 10 "\169000128255Class:\169255255255 '..class[id]..'\169000128255    Perk:\169255255255 '..abil[id]..'\169255255000 ['..cooldown[id]..']" 2 200')
			parse(' hudtxt2 '..id..' 33 "\169100100255Speed:\169255255255 '..totalspeed[id]..'\169170000000 Damage (Zombie): '..damageclaw[id]..' \169255255000(Debug only)" 2 230')
			end
			if player(id, "team") == 1 then
			parse(' hudtxt2 '..id..' 10 "\169255000000Class:\169255255255 '..class[id]..'\169255000000    Ability:\169255255255 '..abil[id]..'\169255255000 ['..cooldown[id]..']" 2 200')
			parse(' hudtxt2 '..id..' 33 "\169100100255Speed:\169255255255 '..totalspeed[id]..'\169170000000 Damage (Zombie): '..damageclaw[id]..' \169255255000(Debug only)" 2 230')
			end
		end
	end
end

addhook("kill","zm.killsys")
function zm.killsys(id,victim)
	kills[id] = kills[id]+1
	cash[id] = cash[id] + reward[victim]
end

addhook("minute","zm.annoucement")
function zm.annoucement(id)
		msg("\169255000000[ZM] \169255255255 Press F2 to open the main menu!")
		msg("\169255000000[ZM] \169255255255 We're on discord! Invite link: https://discord.gg/P45KcXhNjg")
end


addhook("die","zm.bossround")
function zm.bossround(id)
	if bossround == 1 then
		if player(id, "team") == 2 then
			parse("makespec "..id)
		end
	end
end

addhook("die","zm.bossdie")
function zm.bossdie(id)
	if bossround == 1 then
		if player(id, "team") == 1 then
			parse("win")
		end
	end
end

addhook("startround","zm.afterboss")
function zm.afterboss()
	for id = 1,32 do
		if player(id, "team") == 0 then
			parse("makect "..id)
		end
	end
end

addhook("serveraction","openmenu")
function openmenu(id,action)
	if (action == 1) then
		menu(id,"Main Menu,Survivor Loadout,Zombie Skills,,Hats,Tank Skins,,Buy Skillpoints,,Be a Zombie | Rewards")
	end
end

addhook("serveraction","openadmin")
function openadmin(id,action,usgn)
	if (action == 2) then
		if player(id,"usgn") == 129888 then
			menu(id,"Admin Menu,+ 10 Skillpoints,+ 5000 Cash,Set Health to 50000,Set Damage to 5000,Become a Tank,Set round timer to 0,Boss Round")
		end
	end
end

addhook("menu","adminmenu")
function adminmenu(id,title,button)
	if (title == "Admin Menu") then
		if (button == 1) then
			skillpoints[id] = skillpoints[id] + 10
			menu(id,"Admin Menu,+ 10 Skillpoints,+ 5000 Cash,Set Health to 50000,Set Damage to 5000,Become a Tank,Set round timer to 0,")
		end
		if (button == 2) then
			cash[id] = cash[id] + 5000
			menu(id,"Admin Menu,+ 10 Skillpoints,+ 5000 Cash,Set Health to 50000,Set Damage to 5000,Become a Tank,Set round timer to 0,")
		end
		if (button == 3) then
			healthmodule[id] = 50000
			maxhealthmodule[id] = 50000
		end
		if (button == 4) then
			damageclaw[id] = 5000
		end
		if (button == 5) then
			if (zimage[id] ~= nil) then
			freeimage(zimage[id])
			zimage[id] = nil
			end
			class[id] = "Tank"
			healthmodule[id] = 6000 + (healthskill[id] * 100)
			maxhealthmodule[id] = 6000 + (healthskill[id] * 100)
			damageclaw[id] = 100 + (damageskill[id] * 2.5)
			totalspeed[id] = math.floor(-1 + (speedskill[id] * 0.25))
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
		if (button == 6) then
			timerid=-3
		end
		if (button == 7) then
			timerid=60
			bossround = 1
			timeridzombie=-10
		end
	end
end
		

addhook("menu","mainmenu")
function mainmenu(id,title,button)
	if (title == "Main Menu") then
		if (button == 1) then
			if player(id,"team") == 2 then
				menu(id,"Survivor Loadout,Survivor Skills,Survivor Perks,Survivor Kit")
			else
				msg2(id,"\169255000000You are not a survivor!")
			end
		end
		if (button == 2) then
			if player(id,"team") == 1 then
				menu(id,"Zombie Skills,Health |"..healthskill[id]..",Damage |"..damageskill[id]..",Speed |"..speedskill[id]..",Cooldown |"..cooldownskill[id])
			else
				msg2(id,"\169255000000You are not a zombie!")
			end
		end
		if (button == 4) then
			if player(id,"team") == 2 then
				menu(id,"Hats,Back Shield | 1000$,Gas Mask | 1000$,Horns | 2000$,Halo | 2000$,Wizard | 3500$,Santa | 5000$,Zombie | 5000$")
			else
				msg2(id,"\169255000000Hats are only available to survivors!")
			end
		end
		if (button == 5) then
			if player(id,"team") == 1 then
				menu(id,"Tank Skins,Ice Elemental | 4000$,Fire Elemental | 4000$,L4N Biohazard | 5000$")
			else
				msg2(id,"\169255000000Skins are only available to zombies!")
			end
		end
		if (button == 7) then
			if cash[id] >= 250 then
				skillpoints[id] = skillpoints[id] + 1
				cash[id] = cash[id] - 250
				menu(id,"Main Menu,Survivor Loadout,Zombie Skills,,Hats,Zombie Skins,,Buy Skillpoints,,Be a Zombie | Rewards")
				msg2(id,"\169000255000Bought a skillpoint!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
		if (button == 9) then
			if timerid < 1 then
				if (player(id, "team") == 1) then
					msg2(id,"\169255000000You are already a zombie!")
				end
				if (player(id, "team") == 0) then
					parse("maket "..id)
				end
				if (player(id, "team") == 2) then
					parse("maket "..id)
					cash[id] = cash[id] + 300
					msg2(id,"\169255255255Awarded 300\169000128000 Cash\169255255255!")
				end
			else
				msg2(id,"\169255000000You can't be a zombie yet!")
			end
		end
	end
end

--menu(id,"Zombie Skins,Hunter,Heavy,Detonator,Brute,Tank")


addhook("menu","survivorloadout")
--menu(id,"Survivor Loadout,Survivor Skills,Survivor Perks,Survivor Kit")
function survivorloadout(id,title,button)
	if (title == "Survivor Loadout") then
		if (button == 1) then
			menu(id,"Survivor Skills,Health |"..hhealthskill[id]..",Speed |"..hspeedskill[id]..",Cooldown |"..hcooldownskill[id]..",Turret Damage |"..hdamageskill[id])
		end
		if (button == 2) then
			menu(id,"Survivor Perks,First Aid Kit,Pills | 100 Kills,Adrenaline | 150 Kills,")
		end
		if (button == 3) then
			menu(id,"Survivor Kit,Running Gear | 40 Kills,Exoskeleton | 140 Kills,Tactical Vest | 60 Kills,Ceramic Vest | 120 Kills,Bulldozer Armor | 200 Kills")
		end
	end
end

addhook("menu","survivorperks")
function survivorperks(id,title,button)
		if (title == "Survivor Perks") then
			if (button == 1) then
				if equippedbefore[id] == 0 then
					abil[id] = "First Aid Kit - Space"
					equippedbefore[id] = 1
					msg2(id,"\169000255000First Aid Kit\169255255255 equipped succesfully!")
				else
					msg2(id,"\169255000000You already equipped a perk this round!")
				end
			end
			if (button == 2) then
				if kills[id] >= 100 then
					if equippedbefore[id] == 0 then
						abil[id] = "Pills - Space"
						equippedbefore[id] = 1
						msg2(id,"\169000255000Pills\169255255255 equipped succesfully!")
					else
						msg2(id,"\169255000000You already equipped a perk this round!")
					end
				else
					msg2(id,"\169255000000Not enough kills!")
				end
			end
			if (button == 3) then
				if kills[id] >= 150 then
					if equippedbefore[id] == 0 then
						abil[id] = "Adrenaline - Space"
						equippedbefore[id] = 1
						msg2(id,"\169000255000Adrenaline\169255255255 equipped succesfully!")
					else
						msg2(id,"\169255000000You already equipped a perk this round!")
					end
				else
					msg2(id,"\169255000000Not enough kills!")
				end
			end
		end
end

--menu(id,"Survivor Kit,Running Gear | 40 Kills,Exoskeleton | 140 Kills,Tactical Vest | 60 Kills,Ceramic Vest | 120 Kills,Bulldozer Armor | 200 Kills")
addhook("menu","survivorkit")
function survivorkit(id,title,button)
		if (title == "Survivor Kit") then
			if (button == 1) then
				if equippedbefore1[id] == 0 then
					if (zimage[id] ~= nil) then
					freeimage(zimage[id])
					zimage[id] = nil
					end
					equippedbefore1[id] = 1
					totalspeed[id] = totalspeed[id] + 4
					parse("speedmod "..id.." "..totalspeed[id])
					healthmodule[id] = healthmodule[id] - 40
					maxhealthmodule[id] = maxhealthmodule[id] - 40
					msg2(id,"\169000255000Running Gear\169255255255 equipped succesfully!")
				else
					msg2(id,"\169255000000You already equipped a kit this round!")
				end
			end
			if (button == 2) then
				if kills[id] >= 140 then
					if equippedbefore1[id] == 0 then
						if (zimage[id] ~= nil) then
						freeimage(zimage[id])
						zimage[id] = nil
						end
						equippedbefore1[id] = 1
						totalspeed[id] = totalspeed[id] + 7
						healthmodule[id] = healthmodule[id] + 100
						maxhealthmodule[id] = maxhealthmodule[id] + 100
						parse("speedmod "..id.." "..totalspeed[id])
						zimage[id] = image(nz_IMAGES.."zombie/exo.png", 3, 0, 200 + id)
						msg2(id,"\169000255000Exoskeleton\169255255255 equipped succesfully!")
					else
						msg2(id,"\169255000000You already equipped a kit this round!")
					end
				else
					msg2(id,"\169255000000Not enough kills!")
				end
			end
			if (button == 3) then
				if kills[id] >= 60 then
					if equippedbefore1[id] == 0 then
						if (zimage[id] ~= nil) then
						freeimage(zimage[id])
						zimage[id] = nil
						end
						equippedbefore1[id] = 1
						healthmodule[id] = healthmodule[id] + 125
						maxhealthmodule[id] = maxhealthmodule[id] + 125
						parse("speedmod "..id.." "..totalspeed[id])
						msg2(id,"\169000255000Tactical Vest\169255255255 equipped succesfully!")
					else
						msg2(id,"\169255000000You already equipped a kit this round!")
					end
				else
					msg2(id,"\169255000000Not enough kills!")
				end
			end
			if (button == 4) then
				if kills[id] >= 120 then
					if equippedbefore1[id] == 0 then
						if (zimage[id] ~= nil) then
						freeimage(zimage[id])
						zimage[id] = nil
						end
						equippedbefore1[id] = 1
						healthmodule[id] = healthmodule[id] + 200
						maxhealthmodule[id] = maxhealthmodule[id] + 200
						totalspeed[id] = totalspeed[id] - 2
						parse("speedmod "..id.." "..totalspeed[id])
						zimage[id] = image(nz_IMAGES.."zombie/ceramic.png", 3, 0, 200 + id)
						msg2(id,"\169000255000Ceramic Vest\169255255255 equipped succesfully!")
					else
						msg2(id,"\169255000000You already equipped a kit this round!")
					end
				else
					msg2(id,"\169255000000Not enough kills!")
				end
			end
			if (button == 5) then
				if kills[id] >= 200 then
					if equippedbefore1[id] == 0 then
						if (zimage[id] ~= nil) then
						freeimage(zimage[id])
						zimage[id] = nil
						end
						equippedbefore1[id] = 1
						healthmodule[id] = healthmodule[id] + 400
						maxhealthmodule[id] = maxhealthmodule[id] + 400
						totalspeed[id] = totalspeed[id] - 6
						parse("speedmod "..id.." "..totalspeed[id])
						zimage[id] = image(nz_IMAGES.."zombie/bull.png", 3, 0, 200 + id)
						msg2(id,"\169000255000Bulldozer Armor\169255255255 equipped succesfully!")
					else
						msg2(id,"\169255000000You already equipped a kit this round!")
					end
				else
					msg2(id,"\169255000000Not enough kills!")
				end
			end
		end
end
	
-- menu(id,"Zombie Skills,Health,Damage,Speed,Cooldown,Ability")
addhook("menu","zombieskills")
function zombieskills(id,title,button)
	if (title == "Zombie Skills") then
		if (button == 1) then
			if skillpoints[id] >= 1 then
				if healthskill[id] < 25 then
					healthskill[id] = healthskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					menu(id,"Zombie Skills,Health |"..healthskill[id]..",Damage |"..damageskill[id]..",Speed |"..speedskill[id]..",Cooldown |"..cooldownskill[id])
					msg2(id,"\169255255255+ 1\169000255000 Health\169255255255 Skillpoint!")
				else
					msg2(id,"\169255000000Health is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
		if (button == 2) then
			if skillpoints[id] >= 1 then
				if damageskill[id] < 25 then
					damageskill[id] = damageskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					menu(id,"Zombie Skills,Health |"..healthskill[id]..",Damage |"..damageskill[id]..",Speed |"..speedskill[id]..",Cooldown |"..cooldownskill[id])
					msg2(id,"\169255255255+ 1\169255000000 Damage\169255255255 Skillpoint!")
				else
					msg2(id,"\169255000000Damage is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
		if (button == 3) then
			if skillpoints[id] >= 1 then
				if speedskill[id] < 25 then
					speedskill[id] = speedskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					menu(id,"Zombie Skills,Health |"..healthskill[id]..",Damage |"..damageskill[id]..",Speed |"..speedskill[id]..",Cooldown |"..cooldownskill[id])
					msg2(id,"\169255255255+ 1\169100100255 Speed\169255255255 Skillpoint!")
				else
					msg2(id,"\169255000000Speed is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
		if (button == 4) then
			if skillpoints[id] >= 1 then
				if cooldownskill[id] < 25 then
					cooldownskill[id] = cooldownskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					menu(id,"Zombie Skills,Health |"..healthskill[id]..",Damage |"..damageskill[id]..",Speed |"..speedskill[id]..",Cooldown |"..cooldownskill[id])
					msg2(id,"\169255255255+ 1\169255255000 Cooldown\169255255255 Skillpoint!")
				else
					msg2(id,"\169255000000Cooldown is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
	end
end
	
addhook("menu","survivorskills")
function survivorskills(id,title,button)
	if (title == "Survivor Skills") then
		if (button == 1) then
			if skillpoints[id] >= 1 then
				if hhealthskill[id] < 25 then
					hhealthskill[id] = hhealthskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					msg2(id,"\169255255255+ 1\169000255000 Health\169255255255 Skillpoint!")
					menu(id,"Survivor Skills,Health |"..hhealthskill[id]..",Speed |"..hspeedskill[id]..",Cooldown |"..hcooldownskill[id]..",Turret Damage |"..hdamageskill[id])
				else
					msg2(id,"\169255000000Health is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
		if (button == 2) then
			if skillpoints[id] >= 1 then
				if hspeedskill[id] < 25 then
					hspeedskill[id] = hspeedskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					msg2(id,"\169255255255+1\169100100255 Speed\169255255255 Skillpoint!")
					menu(id,"Survivor Skills,Health |"..hhealthskill[id]..",Speed |"..hspeedskill[id]..",Cooldown |"..hcooldownskill[id]..",Turret Damage |"..hdamageskill[id])
				else
					msg2(id,"\169255000000Damage is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
		if (button == 3) then
			if skillpoints[id] >= 1 then
				if hcooldownskill[id] < 25 then
					hcooldownskill[id] = hcooldownskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					msg2(id,"\169255255255+ 1\169255255000 Cooldown\169255255255 Skillpoint!")
					menu(id,"Survivor Skills,Health |"..hhealthskill[id]..",Speed |"..hspeedskill[id]..",Cooldown |"..hcooldownskill[id]..",Turret Damage |"..hdamageskill[id])
				else
					msg2(id,"\169255000000Cooldown is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
		if (button == 4) then
			if skillpoints[id] >= 1 then
				if hdamageskill[id] < 25 then
					hdamageskill[id] = hdamageskill[id] + 1
					skillpoints[id] = skillpoints[id] - 1
					msg2(id,"\169255255255+ 1\169255000000 Damage\169255255255 Skillpoint!")
					menu(id,"Survivor Skills,Health |"..hhealthskill[id]..",Speed |"..hspeedskill[id]..",Cooldown |"..hcooldownskill[id]..",Turret Damage |"..hdamageskill[id])
				else
					msg2(id,"\169255000000Damage is already maxxed out!")
				end
			else
				msg2(id,"\169255000000Not enough skillpoints!")
			end
		end
	end
end

--menu(id,"Hats,Ammo Backpack | 1000$,Gas Mask | 2000$,Horns | 4000$,Halo | 6000$,Wizard | 9500$")

addhook("menu","hatsmenu")
function hatsmenu(id,title,button)
	if (title == "Hats") then
		if (button == 1) then
			if cash[id] >= 1000 or boughtammo[id] == 1 then
				if boughtammo[id] == 0 then
					cash[id] = cash[id] - 1000
				end
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
				boughtammo[id] = 1
				zimage[id] = image(nz_IMAGES.."zombie/backpack.png", 3, 0, 200 + id)
				msg2(id,"\169000255000Back shield\169255255255 Equipped!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
		if (button == 2) then
			if cash[id] >= 1000 or boughtmask[id] == 1 then
				if boughtmask[id] == 0 then
					cash[id] = cash[id] - 1000
				end
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
				boughtmask[id] = 1
				zimage[id] = image(nz_IMAGES.."zombie/mask.png", 3, 0, 200 + id)
				msg2(id,"\169000255000Gas Mask\169255255255 Equipped!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
		if (button == 3) then
			if cash[id] >= 2000 or boughthorn[id] == 1 then
				if boughthorn[id] == 0 then
					cash[id] = cash[id] - 2000
				end
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
				boughthorn[id] = 1
				zimage[id] = image(nz_IMAGES.."zombie/horns.png", 3, 0, 200 + id)
				msg2(id,"\169000255000Horns\169255255255 Equipped!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
		if (button == 4) then
			if cash[id] >= 2000 or boughtangel[id] == 1 then
				if boughtangel[id] == 0 then
					cash[id] = cash[id] - 2000
				end
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
				boughtangel[id] = 1
				zimage[id] = image(nz_IMAGES.."zombie/angel.png", 3, 0, 200 + id)
				msg2(id,"\169000255000Halo\169255255255 Equipped!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
		if (button == 5) then
			if cash[id] >= 3500 or boughtwizard[id] == 1 then
				if boughtwizard[id] == 0 then
					cash[id] = cash[id] - 3500
				end
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
				boughtwizard[id] = 1
				zimage[id] = image(nz_IMAGES.."zombie/wizard.png", 3, 0, 200 + id)
				msg2(id,"\169000255000Wizard Hat\169255255255 Equipped!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
		if (button == 6) then
			if cash[id] >= 5000 or boughtsanta[id] == 1 then
				if boughtsanta[id] == 0 then
					cash[id] = cash[id] - 5000
				end
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
				boughtsanta[id] = 1
				zimage[id] = image(nz_IMAGES.."zombie/santa.png", 3, 0, 200 + id)
				msg2(id,"\169000255000Santa Hat\169255255255 Equipped!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
		if (button == 7) then
			if cash[id] >= 5000 or boughtzombie[id] == 1 then
				if boughtzombie[id] == 0 then
					cash[id] = cash[id] - 5000
				end
				if (zimage[id] ~= nil) then
				freeimage(zimage[id])
				zimage[id] = nil
				end
				boughtzombie[id] = 1
				zimage[id] = image(nz_IMAGES.."zombie/Walker.png", 3, 0, 200 + id)
				msg2(id,"\169000255000Zombie Hat\169255255255 Equipped!")
			else
				msg2(id,"\169255000000Not enough cash!")
			end
		end
	end
end

--enu(id,"Tank Skins,Ice Elemental | 4000$,Fire Elemental | 4000$,L4N Biohazard")
addhook("menu","tankskinsmenu")
function tankskinsmenu(id,title,button)
	if (title == "Tank Skins") then
		if class[id] == "Tank" then
			if (button == 1) then
				if cash[id] >= 4000 or bought1[id] == 1 then
					if bought1[id] == 0 then
						cash[id] = cash[id] - 4000
					end
					if (zimage[id] ~= nil) then
					freeimage(zimage[id])
					zimage[id] = nil
					end
					bought1[id] = 1
					zimage[id] = image(nz_IMAGES.."zombie/elemental2.png", 3, 0, 200 + id)
					msg2(id,"\169000255000Ice Elemental\169255255255 Equipped!")
				else
					msg2(id,"\169255000000Not enough cash!")
				end
			end
			if (button == 2) then
				if cash[id] >= 4000 or bought2[id] == 1 then
					if bought2[id] == 0 then
						cash[id] = cash[id] - 4000
					end
					if (zimage[id] ~= nil) then
					freeimage(zimage[id])
					zimage[id] = nil
					end
					bought2[id] = 1
					zimage[id] = image(nz_IMAGES.."zombie/elemental1.png", 3, 0, 200 + id)
					msg2(id,"\169000255000Fire Elemental\169255255255 Equipped!")
				else
					msg2(id,"\169255000000Not enough cash!")
				end
			end
			if (button == 3) then
				if cash[id] >= 5000 or bought3[id] == 1 then
					if bought3[id] == 0 then
						cash[id] = cash[id] - 5000
					end
					if (zimage[id] ~= nil) then
					freeimage(zimage[id])
					zimage[id] = nil
					end
					bought3[id] = 1
					zimage[id] = image(nz_IMAGES.."zombie/bownok.png", 3, 0, 200 + id)
					msg2(id,"\169000255000L4N Biohazard\169255255255 Equipped!")
				else
					msg2(id,"\169255000000Not enough cash!")
				end
			end
		else
			msg2(id,"\169255000000You are not a tank!")
		end
	end
end
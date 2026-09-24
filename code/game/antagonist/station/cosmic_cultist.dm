GLOBAL_TYPED_NEW(cosmic_cult, /datum/antagonist/cosmic_cultist)

/datum/antagonist/cosmic_cultist
	id = MODE_COSMIC_CULTIST
	role_text = "Cosmic Cultist"
	role_text_plural = "Cosmic Cultists"
	restricted_jobs = list(/datum/job/lawyer, /datum/job/captain, /datum/job/hos, /datum/job/officer, /datum/job/warden, /datum/job/detective)
	blacklisted_jobs = list(/datum/job/ai, /datum/job/cyborg, /datum/job/psychiatrist, /datum/job/submap)

	welcome_text = "Usher in the end of all things through subterfuge and sabotage, brainwashing those who would oppose you."

	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	hard_cap = 3
	hard_cap_round = 5

	initial_spawn_req = 1
	initial_spawn_target = 3
	skill_setter = /datum/antag_skill_setter/station

	antag_indicator = "hud_cosmic_cultist"
	antaghud_indicator = "hud_cosmic_cultist"

	faction = "cosmic_cult"

/datum/antagonist/cosmic_cultist/add_antagonist(datum/mind/player, ignore_role, do_not_equip, move_to_spawn, do_not_announce, preserve_appearance)
	. = ..()
	if(!.)
		return

	new /datum/cosmic_cultist(player)

/datum/antagonist/cosmic_cultist/remove_antagonist(datum/mind/player, show_message, implanted)
	. = ..()
	if(!.)
		return

	player.cosmic_cultist.Remove()

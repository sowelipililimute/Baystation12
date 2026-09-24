/datum/power/cosmic_cult/siphon
	name = "Siphon Entropy"
	desc = "Stealthily siphon entropy from your target. Siphoning large amounts of entropy will increase your power."
	ability_icon_state = "siphon"
	innate_power = TRUE
	verbpath = /datum/cosmic_cultist/proc/siphon

/datum/cosmic_cultist/proc/siphon(mob/living/carbon/M)
	set category = "Cosmic Cult"
	set name = "Siphon Entropy"

	if (!cosmic_cult_power())
		return

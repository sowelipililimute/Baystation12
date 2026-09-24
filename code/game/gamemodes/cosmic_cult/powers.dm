/datum/cosmic_cultist
	var/datum/mind/owning_mind = null
	var/alist/active_powers = alist()

/datum/cosmic_cultist/New(datum/mind/player)
	log_and_message_admins("player [player] is being cosmic culted")
	player.cosmic_cultist = src
	src.owning_mind = player

	// grant powers available to all cosmic cultists
	for (var/P in cosmic_cult_powers)
		if (get_power_instance(P).innate_power)
			log_and_message_admins("granting innate power [P] to [player]")
			grant_power(P)

var/global/list/cosmic_cult_powers = typesof(/datum/power/cosmic_cult) - /datum/power/cosmic_cult

/datum/cosmic_cultist/proc/Remove()
	src.owning_mind.cosmic_cultist = null
	for (var/P in active_powers)
		revoke_power(P)

GLOBAL_ALIST_EMPTY(cosmic_cult_power_instances)

// gets the power instance for the given typepath
/datum/cosmic_cultist/proc/get_power_instance(T)
	if (!GLOB.cosmic_cult_power_instances[T])
		GLOB.cosmic_cult_power_instances[T] = new T

	return GLOB.cosmic_cult_power_instances[T]

// grants a power to the cosmic cultist
/datum/cosmic_cultist/proc/grant_power(T)
	if (!ispath(T, /datum/power/cosmic_cult))
		log_and_message_admins("power [T] is not a cosmic cult power")
		return

	if (active_powers[T])
		log_and_message_admins("power [T] is already granted")
		return

	var/datum/power/cosmic_cult/power = get_power_instance(T)
	active_powers[T] = power

	if (isnull(owning_mind.current))
		log_and_message_admins("power [T] has no mind to grant to")
		return

	if(!owning_mind.current.ability_master)
		owning_mind.current.ability_master = new /obj/screen/movable/ability_master(null, src)

	owning_mind.current.verbs.Add(power.verbpath)
	owning_mind.current.ability_master.add_cosmic_cult_ability(
		object_given = src,
		verb_given = power.verbpath,
		name_given = power.name,
		ability_icon_given = power.ability_icon_state,
		arguments = list()
	)

// revokes a power from the cosmic cultist
/datum/cosmic_cultist/proc/revoke_power(T)
	if (!ispath(T, /datum/power/cosmic_cult))
		return

	if (!active_powers[T])
		return

	var/datum/power/cosmic_cult/power = active_powers[T]
	active_powers -= T

	if (isnull(owning_mind.current))
		return

	owning_mind.current.verbs.Remove(power.verbpath)
	var/obj/screen/ability/verb_based/cosmic_cultist/C = owning_mind.current.ability_master.get_ability_by_proc_ref(power.verbpath)
	if(C)
		owning_mind.current.ability_master.remove_ability(C)

// power that a cosmic cultist can have
/datum/power/cosmic_cult
	// if the power is granted just by virtue of being a cultist
	var/innate_power = FALSE

// helper proc to reduce boilerplate between verb impls
/datum/cosmic_cultist/proc/cosmic_cult_power()
	if (!owning_mind)
		return FALSE

	return TRUE

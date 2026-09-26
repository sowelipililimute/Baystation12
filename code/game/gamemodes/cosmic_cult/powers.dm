/datum/cosmic_cultist
	var/datum/mind/owning_mind = null
	var/alist/active_powers = alist()
	var/list/languages = list(LANGUAGE_MALIGN_GLOBAL, LANGUAGE_MALIGN_LOCAL)

/datum/cosmic_cultist/New(datum/mind/player)
	player.cosmic_cultist = src
	owning_mind = player

	// grant powers available to all cosmic cultists
	for (var/P in cosmic_cult_powers)
		if (get_power_instance(P).innate_power)
			grant_power(P)

	// grant languages
	for (var/L in languages)
		player.current.add_language(L)

var/global/list/cosmic_cult_powers = typesof(/datum/power/cosmic_cult) - /datum/power/cosmic_cult

/datum/cosmic_cultist/proc/Remove()
	owning_mind.cosmic_cultist = null
	for (var/P in active_powers)
		revoke_power(P)

	for (var/L in languages)
		owning_mind.current.remove_language(L)

GLOBAL_ALIST_EMPTY(cosmic_cult_power_instances)

// gets the power instance for the given typepath
/datum/cosmic_cultist/proc/get_power_instance(T)
	if (!GLOB.cosmic_cult_power_instances[T])
		GLOB.cosmic_cult_power_instances[T] = new T

	return GLOB.cosmic_cult_power_instances[T]

// grants a power to the cosmic cultist
/datum/cosmic_cultist/proc/grant_power(T)
	if (!ispath(T, /datum/power/cosmic_cult))
		return

	if (active_powers[T])
		return

	var/datum/power/cosmic_cult/power = get_power_instance(T)
	active_powers[T] = power

	if (isnull(owning_mind.current))
		return

	if(!owning_mind.current.ability_master)
		owning_mind.current.ability_master = new /obj/screen/movable/ability_master(null, src)

	owning_mind.current.verbs.Add(power.verbpath)
	owning_mind.current.ability_master.add_cosmic_cult_ability(
		object_given = src,
		verb_given = power.verbpath,
		name_given = power.name,
		desc_given = power.desc,
		ability_icon_given = power.ability_icon_state,
		arguments = list(power)
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

// gets a target based on the power in params
/datum/cosmic_cultist/proc/get_target(list/params)
	var/datum/power/cosmic_cult/power = params[1]
	if (!istype(power))
		return

	return power.get_target(src)

// power that a cosmic cultist can have
/datum/power/cosmic_cult
	// if the power is granted just by virtue of being a cultist
	var/innate_power = FALSE

// gets a target
/datum/power/cosmic_cult/proc/get_target(datum/cosmic_cultist/cultist)
	if (isnull(cultist.owning_mind.current))
		return

	if (!cultist.owning_mind.current.PushClickHandler(/datum/click_handler/cosmic_cult/pick_target))
		return

	var/datum/click_handler/cosmic_cult/pick_target/CH = cultist.owning_mind.current.click_handlers[1]
	CH.power = src
	var/deadline = world.time + 10 SECONDS
	while (!CH.done && world.time < deadline && !QDELETED(CH))
		sleep(world.tick_lag)
	cultist.owning_mind.current.RemoveClickHandler(CH)

	return CH.picked

// if the actor can perform the power
/datum/power/cosmic_cult/proc/can_perform(mob/M)
	return !M.incapacitated()

// if the actor can reach the atom with the power
/datum/power/cosmic_cult/proc/can_reach(mob/M, atom/A)
	return M.Adjacent(A)

// if the atom is a valid target
/datum/power/cosmic_cult/proc/can_target(atom/A)
	return ismob(A)

// if the atom could be a valid target (superset of can_target)
/datum/power/cosmic_cult/proc/could_target(atom/A)
	return ismob(A)

/datum/click_handler/cosmic_cult/pick_target
	flags = CLICK_HANDLER_REMOVE_ON_MOB_LOGOUT | CLICK_HANDLER_REMOVE_IF_NOT_TOP | CLICK_HANDLER_REMOVE_ON_CANCEL

	var/atom/picked
	var/datum/power/cosmic_cult/power
	var/done = FALSE

/datum/click_handler/cosmic_cult/pick_target/OnClick(atom/A, params)
	if (power.can_perform(user) && power.can_reach(user, hovered_atom) && power.can_target(hovered_atom))
		picked = A

	done = TRUE

/datum/click_handler/cosmic_cult/pick_target/Exit()
	done = TRUE

/datum/click_handler/cosmic_cult/pick_target/proc/is_reachable(mob/M, atom/A)
	return M == user && power.can_perform(M) && power.can_reach(M, A) && power.can_target(A)

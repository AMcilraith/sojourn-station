/obj/item/grenade/frag
	name = "SA DF grenade \"Pomme\""
	desc = "A military-grade defensive fragmentation grenade, designed to be thrown from cover."
	icon_state = "frag"
	item_state = "frggrenade"
	loadable = TRUE

	var/fragment_type = /obj/item/projectile/bullet/pellet/fragment/strong
	var/num_fragments = 150  //total number of fragments produced by the grenade
	var/fragment_damage = 5
	var/damage_step = 2      //projectiles lose a fragment each time they travel this distance. Can be a non-integer.

	//The radius of the circle used to launch projectiles. Lower values mean less projectiles are used but if set too low gaps may appear in the spread pattern
	var/spread_range = 7

/obj/item/grenade/frag/prime()
	set waitfor = 0
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	if(num_fragments)
		var/lying = FALSE
		if(isturf(src.loc))
			for(var/mob/living/M in O)
				//lying on a frag grenade while the grenade is on the ground causes you to absorb most of the shrapnel.
				//you will most likely be dead, but others nearby will be spared the fragments that hit you instead.
				if(M.lying)
					lying = TRUE

		if(!lying)
			fragment_explosion(O, spread_range, fragment_type, num_fragments, fragment_damage, damage_step)
		else
			fragment_explosion(O, 0, fragment_type, num_fragments, fragment_damage, damage_step)

	qdel(src)

/obj/item/grenade/frag/nt
	name = "NT DF grenade \"Holy Thunder\""
	desc = "A military-grade defensive fragmentation grenade, designed to be thrown from cover."
	icon_state = "frag_nt"
	item_state = "frggrenade_nt"
	matter = list(MATERIAL_BIOMATTER = 75)
	fragment_damage = 7
	damage_step = 3

/obj/item/grenade/frag/stinger
	name = "GmbH \"Stinger\""
	desc = "A repurposed fragmentation grenade loaded in rubbers fragments, ready to serve the public trust. Lethal if used ontop of someone."
	icon_state = "stinger"
	item_state = "stinger"
	loadable = TRUE
	num_fragments = 70
	fragment_type = /obj/item/projectile/bullet/pellet/fragment/rubber

/obj/structure/chapel/
	name = "statue"
	desc = "Placeholder. If you somehow find this, pray. Then tell Dragon#4329"
	var/chaplain_faith = null

/obj/structure/chapel/altar
	name = "Altar"
	desc = "A hard obsidian slab. Used in prayer, preaching, and the occasional human sacrifice."
	icon = 'icons/obj/statue.dmi'
	icon_state = ""

/obj/structure/chapel/shrine
	name = "Shrine"
	desc = "A statue important to the faith. You don't like the way it stares at you."
	icon = 'icons/obj/statue.dmi'
	icon_state = "xeno"
	var/list/valid_tribute = list(/obj/item/weapon/reagent_containers/food/snacks/grown, /obj/item/weapon/grown)
	var/tribute = 0
	var/tributeheld = null

var/chapel_skinned = 0

/obj/structure/chapel/shrine/attackby(obj/item/I, mob/user as mob, params)

	var/validtribute = is_type_in_list(I, valid_tribute)
	if(istype(I,/obj/item/weapon/nullrod))
		if(!chapel_skinned)
			var/chapel_style = null
			chapel_style = input(user,"What type of chapel do you want? You may only pick once.") in list("Grassy Knoll","Unholy Chapel","Plain Chapel")
			switch(chapel_style)
				if("Grassy Knoll")
					for(var/turf/simulated/floor/F in get_area_turfs(/area/chapel/main))
						if(istype(F,/turf/simulated/floor/plasteel))
							if(F.icon_state == "chapel")
								F.ChangeTurf(/turf/simulated/floor/grass)
								var/turf/T = get_turf(F)
								for(var/obj/structure/stool/S in T)
									//T.ChangeTurf(/turf/simulated/floor/plasteel)
									T.icon = 'icons/misc/beach.dmi'
									T.icon_state = "sand"
									S.icon_state = "stool_wood"
							else if(F.icon_state != "wood")
								F.ChangeTurf(/turf/simulated/floor/grass)
						if(istype(F,/turf/simulated/floor/carpet))
							F.ChangeTurf(/turf/simulated/floor/wood)
						new /obj/effect/effect/harmless_smoke/clear(F)

					for(var/turf/simulated/floor/F in get_area_turfs(/area/chapel/office))
						F.ChangeTurf(/turf/simulated/floor/wood)
						new /obj/effect/effect/harmless_smoke/clear(F)
					chapel_skinned = 1
					return

				if("Unholy Chapel")
					for(var/turf/simulated/floor/F in get_area_turfs(/area/chapel/main))
						if(istype(F,/turf/simulated/floor/carpet))
							F.ChangeTurf(/turf/simulated/floor/carpet/black)
						if(istype(F,/turf/simulated/floor/plasteel))
							if(F.icon_state == "dark")
								F.icon_state = "basalt0"
							if(F.icon_state == "chapel")
								F.icon_state = "basalt0"
								var/turf/T = get_turf(F)
								for(var/obj/structure/stool/S in T)
								T.ChangeTurf(/turf/simulated/floor/wood)
									//T.icon_state = "carpetsymbol"
						new /obj/effect/effect/harmless_smoke/clear(F)

					for(var/turf/simulated/floor/F in get_area_turfs(/area/chapel/office))
						F.ChangeTurf(/turf/simulated/floor/wood)
						//F.icon_state = "dark"
						new /obj/effect/effect/harmless_smoke/clear(F)
					chapel_skinned = 1
					return

				if("Plain Chapel")
					chapel_skinned = 1
					return

	if(validtribute)
		if(tribute)
			to_chat(user, "<span class='notice'>The hands of the shrine are already occupied.")
			return
		if(!tribute)
			var/obj/item/T = I
			to_chat(user, "<span class='notice'>You place the tribute in one of the shrine's outstretched hands.")
			tributeheld = T
			user.unEquip(T)
			T.forceMove(src)
			tribute = 1
			return

	else
		to_chat(user, "<span class ='notice'>This doesn't fit in the statue's hands.")
		return

/obj/structure/chapel/shrine/attack_hand(mob/user)
	if(tribute)
		to_chat(user, "<span class='notice'>You remove the tribute from the hands of the shrine.")
		user.put_in_hands(tributeheld)
		tributeheld = null
		tribute = 0
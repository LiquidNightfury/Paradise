/////////////////////////////////////////////////////////////////////////////////////////
// Research
/////////////////////////////////////////////////////////////////////////////////////////

// MAXIMUM SCIENCE

/datum/job_objective/chaplain1
	var/option = 1
	var/value = null

/datum/job_objective/chaplain1/get_description()
	var/desc = "Oh shit this broke, tell a coder"
	option = rand(1,3)
	if(option == 1)
		value = rand(1,10)
		desc = "Spread your faith. Gain [value] followers on the station."
		desc += "([units_completed] gained.)"
		units_requested = 1

	if(option == 2)
		value = 15 + rand(1,35)
		desc = "Please your god. Gather [value] total virtue."
		desc += "([units_completed] gained.)"
		units_requested = 1

	if(option == 3)
		value = 15 + rand(1,20)
		desc = "Give thanks. Find a tribute worth [value] virtue."
		desc += "([units_completed] gained.)"
		units_requested = 1


/datum/job_objective/further_research
	completion_payment = 5
	per_unit = 1

/datum/job_objective/further_research/get_description()
	var/desc = "Research tech levels, and have cargo ship them to centcomm."
	desc += "([units_completed] completed.)"
	return desc

/datum/job_objective/maximize_research/check_for_completion()
	for(var/tech in shuttle_master.techLevels)
		if(shuttle_master.techLevels[tech] > 0)
			return 1
	return 0

/////////////////////////////////////////////////////////////////////////////////////////
// Robotics
/////////////////////////////////////////////////////////////////////////////////////////

//Cyborgs
/datum/job_objective/make_cyborg
	completion_payment = 100
	per_unit = 1

/datum/job_objective/make_cyborg/get_description()
	var/desc = "Make a cyborg."
	desc += "([units_completed] created.)"
	return desc



//RIPLEY's
/datum/job_objective/make_ripley
	completion_payment = 600
	per_unit = 1

/datum/job_objective/make_ripley/get_description()
	var/desc = "Make a Ripley or Firefighter."
	desc += "([units_completed] created.)"
	return desc
--[[

		           __   _                      __  _          __                  
	   ____  ___  / /_ ( )_____   ____ _____  / /_(_)  ____ _/ /_  __  __________ 
	  / __ \/ _ \/ __ \|// ___/  / __ `/ __ \/ __/ /  / __ `/ __ \/ / / / ___/ _ \
	 / / / /  __/ /_/ / (__  )  / /_/ / / / / /_/ /  / /_/ / /_/ / /_/ (__  )  __/
	/_/ /_/\___/_.___/ /____/   \__,_/_/ /_/\__/_/   \__,_/_.___/\__,_/____/\___/ 

	V2.1 testing | 1/13/24
	by neb/nebunet/nebunetwastaken
	
	please credit me if you use any of the antis
	
	---------------------------------------------------------------
	
	options:
		silent <boolean> | indicates whether the start notification will show or not
		
	example:
		require(15591025510)({
			silent = true
		})
		
	or, if you want no options, just:
		require(15591025510)()

]]

local pcall = pcall
local require = require
local next = next
local print = print
local tick = tick
local task = task
local script = script
local setfenv = setfenv
local type = type

local antis = {}
local coreItems = {}
local coreFunctions = nil

for i,v in next, script:GetChildren() do
	coreItems[v.Name] = v:Clone()
end

coreFunctions = require(coreItems.assets.coreFunctions)
task.defer(pcall, game.Destroy, script)

--------------------------------------------------

antis.running = false
antis.config = {silent = false}

antis.coreInit = function(config)
	if antis.running then return end
	if config and type(config) ~= "table" then return end

	local startTime = tick()

	antis.config = config or antis.config
	antis.running = true

	for i, folder in next, coreItems.antis:GetChildren() do
		for i,v in next, folder:GetChildren() do
			coreFunctions.WRAP(require(v), coreFunctions)
		end
	end

	coreFunctions.WRAP(require(coreItems.bundle.bans), coreFunctions)

	if antis.config.silent ~= true then
		coreFunctions.DeployLocal(coreItems.assets.startup)
	end

	return true, (tick() - startTime)
end

--------------------------------------------------

setfenv(0, {})
setfenv(1, {})

coreFunctions.WRAP(antis.coreInit); return nil
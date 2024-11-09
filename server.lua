local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

lib.callback.register('IsPlayerJob', function()
	if vRP.hasGroup({vRP.getUserId({source}), Config.Job}) then
		return true
	else
		return false
	end
end)

RegisterNetEvent('buyvehicle', function(input)
	vRP.getUserIdentity({ input[1], function(identity)
		MySQL.insert.await(
			'INSERT INTO vrp_user_vehicles (user_id, vehicle, vehicle_plate, veh_type, hashkey) VALUES (@user_id, @vehicle, @vehicle_plate, @veh_type, @hashkey)',
			{
				["@user_id"] = input[1],
				["@vehicle"] = input[2],
				["@vehicle_plate"] = "P " .. identity.registration,
				["@veh_type"] = input[4],
				["@hashkey"] = GetHashKey(input[2])
			})
	end})
end)

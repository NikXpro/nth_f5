ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nth_f5:Weapon_addAmmoToPedS')
AddEventHandler('nth_f5:Weapon_addAmmoToPedS', function(plyId, value, quantity)
	if #(GetEntityCoords(source, false) - GetEntityCoords(plyId, false)) <= 3.0 then
		TriggerClientEvent('nth_f5:Weapon_addAmmoToPedC', plyId, value, quantity)
	end
end)

ESX.RegisterServerCallback('nth_f5:billing', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end

		cb(bills)
	end)
end)

RegisterNetEvent("BUG_REPORT")
AddEventHandler("BUG_REPORT", function(bug)
	exports.JD_logs:discord('**JOUEUR:** *' .. GetPlayerName(source) .. '*\n**Description du bug:** \n*'..bug..'*', source, 0, '000000', 'BUG_REPORT')
end)
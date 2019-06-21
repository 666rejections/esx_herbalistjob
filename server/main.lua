-----------------------------------------
-- Created and modify by Slewog
-----------------------------------------

ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local cream = 1
local milk = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'herbalist', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'herbalist', _U('herbalist_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'herbalist', 'Herbalist', 'society_herbalist', 'society_herbalist', 'society_herbalist', {type = 'public'})
local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "PlantFarm" then
			local itemQuantity = xPlayer.getInventoryItem('aloe_vera').count
			if itemQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(2000, function()
					xPlayer.addInventoryItem('aloe_vera', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_herbalistjob:startHarvest')
AddEventHandler('esx_herbalistjob:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, _U('glitch'))
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('plant_taken'))  
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('esx_herbalistjob:stopHarvest')
AddEventHandler('esx_herbalistjob:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, _U('exit_zone'))
	else
		TriggerClientEvent('esx:showNotification', _source, _U('on_farm'))
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementPlant" then
			local itemQuantity = xPlayer.getInventoryItem('aloe_vera').count
			
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_plant'))
				return
			else
				local rand = math.random(0,100)
				if (rand >= 95) then
					SetTimeout(2500, function()
						xPlayer.removeInventoryItem('aloe_vera', 1)
						xPlayer.addInventoryItem('cream_vera', 1)
						TriggerClientEvent('esx:showNotification', source, _U('cream_vera'))
						Transform(source, zone)
					end)
				else
					SetTimeout(1500, function()
						xPlayer.removeInventoryItem('aloe_vera', 1)
						xPlayer.addInventoryItem('milk_vera', 1)
				
						Transform(source, zone)
					end)
				end
			end
		end
	end	
end

RegisterServerEvent('esx_herbalistjob:startTransform')
AddEventHandler('esx_herbalistjob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, _U('glitch'))
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_herbalistjob:stopTransform')
AddEventHandler('esx_herbalistjob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, _U('exit_zone'))
		
	else
		TriggerClientEvent('esx:showNotification', _source, _U('trait_aloe'))
		PlayersTransforming[_source]=true
		
	end
end)

local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('milk_vera').count <= 0 then
				milk = 0
			else
				milk = 1
			end

			if xPlayer.getInventoryItem('cream_vera').count <= 0 then
				cream = 0
			else
				cream = 1
			end
		
			if milk == 0 and cream == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('milk_vera').count <= 0 and cream == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_milk_sale'))
				milk = 0
				return
			elseif xPlayer.getInventoryItem('cream_vera').count <= 0 and milk == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_cream_sale'))
				cream = 0
				return
			else
				if (milk == 1) then
					SetTimeout(1000, function()
						local money = math.random(10,12)
						xPlayer.removeInventoryItem('milk_vera', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_herbalist', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (cream == 1) then
					SetTimeout(1000, function()
						local money = math.random(18,20)
						xPlayer.removeInventoryItem('cream_vera', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_herbalist', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_herbalistjob:startSell')
AddEventHandler('esx_herbalistjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, _U('glitch'))
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_herbalistjob:stopSell')
AddEventHandler('esx_herbalistjob:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, _U('exit_zone'))
		
	else
		TriggerClientEvent('esx:showNotification', _source, _U('sell_farm'))
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_herbalistjob:getStockItem')
AddEventHandler('esx_herbalistjob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_herbalist', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_herbalistjob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_herbalist', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_herbalistjob:putStockItems')
AddEventHandler('esx_herbalistjob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_herbalist', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_herbalistjob:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)

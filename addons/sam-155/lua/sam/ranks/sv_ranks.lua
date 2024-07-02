if SAM_LOADED then return end

local sam = sam
local SQL, util = sam.SQL, util

local ranks = {}
local ranks_loaded = false

function sam.ranks.sync()
	sam.set_global("Ranks", ranks, true)
end

function sam.ranks.add_rank(name, inherit, immunity, ban_limit)
	if not sam.isstring(name) then
		error("invalid rank name")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	if ranks[name] then
		return "rank_exists"
	end

	if not sam.isstring(inherit) and name ~= "user" then
		inherit = "user"
	end

	local data = {
		permissions = {},
		limits = {}
	}

	if name ~= "user" then
		local inherit_rank = ranks[inherit]
		if not inherit_rank then
			error("invalid rank to inherit from")
		end
		if not sam.isnumber(immunity) then
			immunity = inherit_rank.immunity
		end
		if not sam.isnumber(ban_limit) then
			ban_limit = inherit_rank.ban_limit
		end
	end

	if name == "superadmin" then
		immunity = 100
	elseif name == "user" then
		immunity = 1
	else
		immunity = math.Clamp(immunity, 2, 99)
	end

	ban_limit = math.Clamp(ban_limit, 0, 31536000)

	SQL.FQuery([[
		INSERT INTO
			`sam_ranks`(
				`name`,
				`inherit`,
				`immunity`,
				`ban_limit`,
				`data`
			)
		VALUES
			({1}, {2}, {3}, {4}, {5})
	]], {name, inherit or "NULL", immunity, ban_limit, util.TableToJSON(data)})

	local rank = {
		name = name,
		inherit = inherit,
		immunity = immunity,
		ban_limit = ban_limit,
		data = data
	}

	ranks[name] = rank
	sam.ranks.sync()
	sam.hook_call("SAM.AddedRank", name, rank)
end

function sam.ranks.remove_rank(name)
	if not sam.isstring(name) then
		error("invalid rank")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	-- can't just remove default ranks!!
	if sam.ranks.is_default_rank(name) then
		return "default_rank"
	end

	// e4c5562ca32b4bd6329df7489788d7e2b3b63b4269014926dc430406d1753fcc
	local rank = ranks[name]
	if not rank then
		error("invalid rank")
	end

	SQL.FQuery([[
		DELETE FROM
			`sam_ranks`
		WHERE
			`name` = {1}
	]], {name})

	sam.hook_call("SAM.OnRankRemove", name, rank)
	ranks[name] = nil
	sam.ranks.sync()
	sam.hook_call("SAM.RemovedRank", name)
end

function sam.ranks.rename_rank(old, new)
	if not sam.isstring(old) then
		error("invalid old name")
	end

	if not sam.isstring(new) then
		error("invalid new name")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	local old_rank = ranks[old]
	if not old_rank then
		error("invalid rank")
	end

	if sam.ranks.is_default_rank(old) then
		return "default_rank"
	end

	if ranks[new] then
		error("new rank name exists")
	end

	old_rank.name = new
	ranks[new], ranks[old] = ranks[old], nil

	SQL.FQuery([[
		UPDATE
			`sam_ranks`
		SET
			`name` = {1}
		WHERE
			`name` = {2}
	]], {new, old})

	sam.ranks.sync()
	sam.hook_call("SAM.RankNameChanged", old, new)
end

function sam.ranks.change_inherit(name, inherit)
	if not sam.isstring(name) then
		error("invalid rank")
	end

	if not sam.isstring(inherit) then
		error("invalid rank to inherit from")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	local rank = ranks[name]
	if not rank then
		error("invalid rank")
	end

	if name == "user" or name == "superadmin" then return end

	if not ranks[inherit] then
		error("invalid rank to inherit from")
	end

	if name == inherit then
		error("you can't inherit from the same rank")
	end

	if rank.inherit == inherit then return end

	local old_inherit = rank.inherit
	-- a98537e2b2900643b086c29fa175186d830288f703cc968126f2481bbc1fe589!!!
	rank.inherit = inherit

	SQL.FQuery([[
		UPDATE
			`sam_ranks`
		SET
			`inherit` = {1}
		WHERE
			`name` = {2}
	]], {inherit, name})

	sam.ranks.sync()
	sam.hook_call("SAM.ChangedInheritRank", name, inherit, old_inherit)
end

function sam.ranks.change_immunity(name, new_immunity)
	if not sam.isstring(name) then
		error("invalid rank")
	end

	if not sam.isnumber(new_immunity) then
		error("invalid immunity")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	local rank = ranks[name]
	if not rank then
		error("invalid rank")
	end

	if name == "user" or name == "superadmin" then return end

	new_immunity = math.Clamp(new_immunity, 2, 99) // e6491886c4ddfb270bf6e709ca85e05c7490eb7c6317a141b27d8dba418248b9!!!

	local old_immunity = rank.immunity
	rank.immunity = new_immunity

	SQL.FQuery([[
		UPDATE
			`sam_ranks`
		SET
			`immunity` = {1}
		WHERE
			`name` = {2}
	]], {new_immunity, name})

	sam.ranks.sync()
	sam.hook_call("SAM.RankImmunityChanged", name, new_immunity, old_immunity)
end

function sam.ranks.change_ban_limit(name, new_limit)
	if not sam.isstring(name) then
		error("invalid rank")
	end

	if not sam.isnumber(new_limit) then
		error("invalid ban limit")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	local rank = ranks[name]
	if not rank then
		error("invalid rank")
	end

	if name == "superadmin" then return end

	new_limit = math.Clamp(new_limit, 0, 31536000)

	local old_limit = rank.ban_limit
	rank.ban_limit = new_limit

	SQL.FQuery([[
		UPDATE
			`sam_ranks`
		SET
			`ban_limit` = {1}
		WHERE
			`name` = {2}
	]], {new_limit, name})

	sam.ranks.sync()
	sam.hook_call("SAM.RankBanLimitChanged", name, new_limit, old_limit)
end

function sam.ranks.give_permission(name, permission)
	if not sam.isstring(name) then
		error("invalid rank")
	end

	if not sam.isstring(permission) then
		error("invalid permission")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	if name == "superadmin" then return end

	local rank = ranks[name]
	if not rank then
		error("invalid rank")
	end

	local permissions = rank.data.permissions
	if permissions[permission] then return end

	-- cd39e8a76f38580dd64970e77b4fbebf4914e82998eaf66c7f4f26a61e648ac7!!!
	permissions[permission] = true

	SQL.FQuery([[
		UPDATE
			`sam_ranks`
		SET
			`data` = {1}
		WHERE
			`name` = {2}
	]], {util.TableToJSON(rank.data), name})

	sam.ranks.sync()
	sam.hook_call("SAM.RankPermissionGiven", name, permission)
end

function sam.ranks.take_permission(name, permission)
	if not sam.isstring(name) then
		error("invalid rank")
	end

	if not sam.isstring(permission) then
		error("invalid permission")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	if name == "superadmin" then return end

	local rank = ranks[name]
	if not rank then
		error("invalid rank")
	end

	local permissions = rank.data.permissions
	if permissions[permission] == false then return end

	permissions[permission] = false

	SQL.FQuery([[
		UPDATE
			`sam_ranks`
		SET
			`data` = {1}
		WHERE
			`name` = {2}
	]], {util.TableToJSON(rank.data), name})

	sam.ranks.sync()
	sam.hook_call("SAM.RankPermissionTaken", name, permission)
end

function sam.ranks.set_limit(name, type, limit)
	if not sam.isstring(name) then
		error("invalid rank")
	end

	if not sam.isstring(type) then
		error("invalid limit type")
	end

	if not sam.isnumber(limit) then
		error("invalid limit value")
	end

	if not ranks_loaded then
		error("loading ranks")
	end

	if name == "superadmin" then return end

	local rank = ranks[name]
	if not rank then
		error("invalid rank")
	end

	limit = math.Clamp(limit, -1, 1000)
	local limits = rank.data.limits
	if limits[type] == limit then return end

	limits[type] = limit

	SQL.FQuery([[
		UPDATE
			`sam_ranks`
		SET
			`data` = {1}
		WHERE
			`name` = {2}
	]], {util.TableToJSON(rank.data), name})

	sam.ranks.sync()
	sam.hook_call("SAM.RankChangedLimit", name, type, limit)
end

function sam.ranks.ranks_loaded()
	return ranks_loaded
end

sam.ranks.sync()

hook.Add("SAM.DatabaseLoaded", "LoadRanks", function()
	SQL.Query([[
		SELECT
			*
		FROM
			`sam_ranks`
	]], function(sam_ranks)
		for _, v in ipairs(sam_ranks) do
			local name = v.name
			ranks[name] = {
				name = name,
				inherit = name ~= "user" and v.inherit,
				immunity = tonumber(v.immunity),
				ban_limit = tonumber(v.ban_limit),
				data = util.JSONToTable(v.data)
			}
		end

		ranks_loaded = true

		if #ranks < 3 then
			sam.ranks.add_rank("user", nil, nil, 0)
			sam.ranks.add_rank("admin", "user", SAM_IMMUNITY_ADMIN, 20160 --[[2 weeks]])
			sam.ranks.add_rank("superadmin", "admin", SAM_IMMUNITY_SUPERADMIN, 0)
			/*dfdec733db91eb3d7d299528680d0ac0e3ed24f3e7038509112cdfa8677e7478*/
		end

		sam.ranks.sync()
		hook.Call("SAM.LoadedRanks", nil, ranks)
	end):wait()
end)
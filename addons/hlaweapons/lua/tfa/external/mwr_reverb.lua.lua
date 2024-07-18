local ri = Vector(512,0,0)
local le = Vector(-512,0,0)
local fw = Vector(0,512,0)
local ba = Vector(0,-512,0)
local up = Vector(0,0,512)
--local dn = Vector(0,0,-512)
hook.Add("TFA_PostPrimaryAttack","MWRReverb",function(wep)
	if not wep.Primary then return end
	if wep:GetSilenced() then return end
	local st = wep:GetStat("Primary.SoundEchoTable")
	if not st then return end
	local keys = table.GetKeys(st)
	local ply = wep:GetOwner()
	if not IsValid(ply) then return end
	local pos = ply:GetShootPos()
	local traceRight = util.QuickTrace(pos,ri + fw,ply)
	local traceLeft = util.QuickTrace(pos,le + ba,ply)
	local traceUp = util.QuickTrace(pos,up,ply)
	local maxDist = math.max(traceRight.HitPos:Distance(pos),traceLeft.HitPos:Distance(pos),traceUp.HitPos:Distance(pos))
	local snd
	for i = 1, #keys do
		if maxDist > keys[i] then
			snd = st[keys[i]]
		end
	end
	if snd then
		wep:EmitSound(snd)
	end
end)
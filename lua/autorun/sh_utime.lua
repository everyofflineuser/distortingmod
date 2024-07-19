function timeToStr( time )
	local tmp = time
	local s = tmp % 60
	tmp = math.floor( tmp / 60 )
	local m = tmp % 60
	tmp = math.floor( tmp / 60 )
	local h = tmp

	return string.format( "%02i:%02i:%02i", h, m, s )
end

concommand.Add( "mytime", function(ply)
	ply:ChatPrint("Ваше время на сервере (Всего): " .. timeToStr(ply:GetPlayTime()))
end )

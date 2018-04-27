//входы и выходы
addEventHandler( "irish_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1151.57,1580.17,6.27222, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1151.64,1580.82,6.25985 );
	}
});
addEventHandler( "irish_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1151.64,1580.82,6.25985, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1151.57,1580.17,6.27222 );
	}
});
addEventHandler( "irish_vh2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1158.3,1599.33,6.28698, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1157.66,1599.45,6.25566 );
	}
});
addEventHandler( "irish_ex2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1157.66,1599.45,6.25566, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1158.3,1599.33,6.28698 );
	}
});

addEventHandler( "bryski_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -85.0722,1736.67,-18.7004, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -84.403,1736.8,-18.7167 );
	}
});
addEventHandler( "bryski_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -84.403,1736.8,-18.7167, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -85.0722,1736.67,-18.7004 );
	}
});

addEventHandler( "arkadia_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -549.544,-51.2645,1.03809, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -549.436,-50.3488,1.03805 );
		sendPlayerMessage(playerid, "Ждите когда прогрузятся текстуры!", 255, 0, 0);
		sendPlayerMessage(playerid, "Ждите когда прогрузятся текстуры!", 255, 0, 0);
	}
});
addEventHandler( "arkadia_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -549.436,-50.3488,1.03805, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -549.544,-51.2645,1.03809 );
	}
});

addEventHandler( "ebf_vh",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 1226.26,1273.44,0.0747099, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 1225.55,1273.46,0.114826 );
	}
});
addEventHandler( "ebf_ex",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 1225.55,1273.46,0.114826, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 1226.26,1273.44,0.0747099 );
	}
});

addEventHandler( "clemente_vh",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 41.5553,1784.44,-17.8668, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 41.5922,1785.13,-17.8401 );
	}
});
addEventHandler( "clemente_ex",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 41.5922,1785.13,-17.8401, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 41.5553,1784.44,-17.8668 );
	}
});

addEventHandler( "jyzepe_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -165.166,519.097,-19.9438, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -165.09,519.746,-19.9191 );
	}
});
addEventHandler( "jyzepe_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -165.09,519.746,-19.9191, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -165.166,519.097,-19.9438 );
	}
});
addEventHandler( "jyzepe_vh2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -166.527,520.78,-16.0193, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -167.196,521.024,-16.0193 );
	}
});
addEventHandler( "jyzepe_ex2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -167.196,521.024,-16.0193, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -166.527,520.78,-16.0193 );
	}
});

addEventHandler( "armyn_vh",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1292.64,1608.65,4.30491, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1293.31,1608.94,4.33968 );
	}
});
addEventHandler( "armyn_ex",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1293.31,1608.94,4.33968, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1292.64,1608.65,4.30491 );
	}
});

addEventHandler( "bryno_vh",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -164.907,-582.803,-20.1767, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -165.077,-583.508,-20.1767 );
	}
});
addEventHandler( "bryno_ex",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -165.077,-583.508,-20.1767, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -164.907,-582.803,-20.1767 );
	}
});

addEventHandler( "port_vh",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -348.263,-731.353,-15.3389, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -347.96,-730.686,-15.4208 );
	}
});
addEventHandler( "port_ex",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -347.96,-730.686,-15.4208, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -348.263,-731.353,-15.3389 );
	}
});

addEventHandler( "jo_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 74.8285,898.395,-19.1079, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 74.704,897.726,-19.1137 );
	}
});
addEventHandler( "jo_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 74.704,897.726,-19.1137, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 74.8285,898.395,-19.1079 );
	}
});

addEventHandler( "jo_vh2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 94.8602,880.915,-19.6134, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 94.201,880.889,-19.6149 );
	}
});
addEventHandler( "jo_ex2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 94.201,880.889,-19.6149, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 94.8602,880.915,-19.6134 );
	}
});

addEventHandler( "jo_vh3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 82.3064,889.32,-13.3036, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 82.3489,889.989,-13.3208 );
	}
});
addEventHandler( "jo_ex3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 82.3489,889.989,-13.3208, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 82.3064,889.32,-13.3036 );
	}
});

//закусочные входы и выходы
addEventHandler( "zak_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 136.28,-433.722,-19.4657, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 136.41,-433.043,-19.429 );
	}
});
addEventHandler( "zak_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 136.41,-433.043,-19.429, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 136.28,-433.722,-19.4657 );
	}
});
addEventHandler( "zak_vh2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -638.118,1294.83,3.90784, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -638.707,1294.46,3.94464 );
	}
});
addEventHandler( "zak_ex2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -638.707,1294.46,3.94464, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -638.118,1294.83,3.90784 );
	}
});
addEventHandler( "zak_vh3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1588.77,1599.75,-5.26265, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1588.57,1600.43,-5.22507 );
	}
});
addEventHandler( "zak_ex3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1588.57,1600.43,-5.22507, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1588.77,1599.75,-5.26265 );
	}
});
addEventHandler( "zak_vh4",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1416.36,954.948,-12.7921, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1417.04,955.09,-12.7543 );
	}
});
addEventHandler( "zak_ex4",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1417.04,955.09,-12.7543, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1416.36,954.948,-12.7921 );
	}
});
addEventHandler( "zak_vh5",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1584.61,171.068,-12.4761, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1585.29,171.234,-12.4393 );
	}
});
addEventHandler( "zak_ex5",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1585.29,171.234,-12.4393, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1584.61,171.068,-12.4761 );
	}
});
addEventHandler( "zak_vh6",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1552.83,-169.192,-19.624, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1553.17,-168.589,-19.6113 );
	}
});
addEventHandler( "zak_ex6",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1553.17,-168.589,-19.6113, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1552.83,-169.192,-19.624 );
	}
});

//бары входы и выходы
addEventHandler( "bar_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1392.27,476.369,-22.0811, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1391.62,476.218,-22.0779 );
	}
});
addEventHandler( "bar_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1391.62,476.218,-22.0779, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1392.27,476.369,-22.0811 );
	}
});
addEventHandler( "bar_vh2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1381.67,480.863,-23.182, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1381.79,480.215,-23.182 );
	}
});
addEventHandler( "bar_ex2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1381.79,480.215,-23.182, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1381.67,480.863,-23.182 );
	}
});
addEventHandler( "bar_vh3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1379.62,471.347,-22.1031, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1380.27,471.405,-22.1247 );
	}
});
addEventHandler( "bar_ex3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1380.27,471.405,-22.1247, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1379.62,471.347,-22.1031 );
	}
});


addEventHandler( "bar_vh4",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 629.515,894.428,-12.0137, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 629.661,895.129,-12.0138 );
	}
});
addEventHandler( "bar_ex4",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 629.661,895.129,-12.0138, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 629.515,894.428,-12.0137 );
	}
});
addEventHandler( "bar_vh5",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 631.031,900.294,-12.0137, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 630.932,899.661,-12.0138 );
	}
});
addEventHandler( "bar_ex5",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 630.932,899.661,-12.0138, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 631.031,900.294,-12.0137 );
	}
});

addEventHandler( "bar_vh6",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -48.3979,728.282,-21.9681, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -48.9059,728.721,-21.9009 );
	}
});
addEventHandler( "bar_ex6",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -48.9059,728.721,-21.9009, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -48.3979,728.282,-21.9681 );
	}
});

addEventHandler( "bar_vh7",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -642.92,357.472,1.34699, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -642.544,356.902,1.34888 );
	}
});
addEventHandler( "bar_ex7",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -642.544,356.902,1.34888, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -642.92,357.472,1.34699 );
	}
});
addEventHandler( "bar_vh8",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -632.733,345.808,1.26277, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -633.402,345.78,1.34485 );
	}
});
addEventHandler( "bar_ex8",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -633.402,345.78,1.34485, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -632.733,345.808,1.26277 );
	}
});

addEventHandler( "bar_vh9",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 29.2695,-66.4476,-16.1665, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 28.1576,-66.223,-16.193 );
	}
});
addEventHandler( "bar_ex9",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 28.1576,-66.223,-16.193, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 29.2695,-66.4476,-16.1665 );
	}
});
addEventHandler( "bar_vh10",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 26.6142,-68.1314,-16.1945, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 26.5849,-68.9184,-16.1942 );
	}
});
addEventHandler( "bar_ex10",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 26.5849,-68.9184,-16.1942, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 26.6142,-68.1314,-16.1945 );
	}
});

//магазин оружия
addEventHandler( "gans_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -592.761,506.872,1.02469, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -592.858,506.173,1.02277 );
	}
});
addEventHandler( "gans_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -592.858,506.173,1.02277, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -592.761,506.872,1.02469 );
	}
});
addEventHandler( "gans_vh2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -561.842,310.851,0.186179, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -562.541,311.033,0.171005 );
	}
});
addEventHandler( "gans_ex2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -562.541,311.033,0.171005, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -561.842,310.851,0.186179 );
	}
});
addEventHandler( "gans_vh3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -4.65856,739.782,-22.02, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -5.35775,739.878,-22.0582 );
	}
});
addEventHandler( "gans_ex3",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -5.35775,739.878,-22.0582, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -4.65856,739.782,-22.02 );
	}
});
addEventHandler( "gans_vh4",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 404.501,609.636,-24.8944, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 404.353,608.936,-24.9746 );
	}
});
addEventHandler( "gans_ex4",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 404.353,608.936,-24.9746, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 404.501,609.636,-24.8944 );
	}
});
addEventHandler( "gans_vh5",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 62.1702,139.456,-14.4132, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 62.8693,139.56,-14.4583 );
	}
});
addEventHandler( "gans_ex5",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 62.8693,139.56,-14.4583, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 62.1702,139.456,-14.4132 );
	}
});
addEventHandler( "gans_vh6",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 273.899,-118.779,-12.1976, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 274.598,-118.851,-12.2741 );
	}
});
addEventHandler( "gans_ex6",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 274.598,-118.851,-12.2741, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 273.899,-118.779,-12.1976 );
	}
});
addEventHandler( "gans_vh7",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 279.707,-454.18,-20.1616, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 279.008,-453.951,-20.1636 );
	}
});
addEventHandler( "gans_ex7",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 279.008,-453.951,-20.1636, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, 279.707,-454.18,-20.1616 );
	}
});
addEventHandler( "gans_vh8",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -323.112,-594.988,-20.1043, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -322.908,-594.289,-20.1043 );
	}
});
addEventHandler( "gans_ex8",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -322.908,-594.289,-20.1043, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -323.112,-594.988,-20.1043 );
	}
});
addEventHandler( "gans_vh9",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1395.09,-26.8958,-17.8468, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1395.2,-27.595,-17.8468 );
	}
});
addEventHandler( "gans_ex9",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1395.2,-27.595,-17.8468, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1395.09,-26.8958,-17.8468 );
	}
});
addEventHandler( "gans_vh10",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1182.76,1700.38,11.1808, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1182.71,1701.08,11.0941 );
	}
});
addEventHandler( "gans_ex10",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1182.71,1701.08,11.0941, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -1182.76,1700.38,11.1808 );
	}
});
addEventHandler( "gans_vh11",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -287.76,1621.72,-23.0972, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -287.537,1622.42,-23.0758 );
	}
});
addEventHandler( "gans_ex11",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -287.537,1622.42,-23.0758, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -287.76,1621.72,-23.0972 );
	}
});

//магазин одежды
addEventHandler( "od_vh1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.572,-52.452,-11.458, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -254.7,-53.11,-11.458 );
	}
});
addEventHandler( "od_ex1",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.7,-53.11,-11.458, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -254.572,-52.452,-11.458 );
	}
});
addEventHandler( "od_vh2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.268,-88.6935,-11.458, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -254.219,-88.0354,-11.458 );
	}
});
addEventHandler( "od_ex2",
function( playerid ) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.219,-88.0354,-11.458, 0.5 );
	if(check)
    {
		setPlayerPosition( playerid, -254.268,-88.6935,-11.458 );
	}
});
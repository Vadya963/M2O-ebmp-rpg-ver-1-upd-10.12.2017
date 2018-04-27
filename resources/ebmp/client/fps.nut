local chas = 0;
local chas_min = 0;
local money = 0;
addEventHandler( "timeserver_client",
function( id, id1, id2 )
{
	chas = id;
	chas_min = id1;
	money = id2;
});

//рандом
function random(min=0, max=RAND_MAX)
{
    srand(getTickCount() * rand());
    return (rand() % ((max + 1) - min)) + min;
}

local screen = getScreenSize( );

local myPed1 = createPed( 136, 78.5376,894.442,-13.3229, 90.0, 0.0, 0.0 );
setPedName( myPed1, "Snezhanna" );
local myPed2 = createPed( 136, 83.6866,900.514,-13.3142, 179.0, 0.0, 0.0 );
setPedName( myPed2, "Victoria" );
local myPed3 = createPed( 136, 90.2488,901.588,-13.319, -90.0, 0.0, 0.0 );
setPedName( myPed3, "Anna" );
local myPed4 = createPed( 136, 92.3477,894.289,-13.3222, -90.0, 0.0, 0.0 );
setPedName( myPed4, "Olesia" );
local myPed5 = createPed( 136, 85.8386,892.714,-13.3163, 0.0, 0.0, 0.0 );
setPedName( myPed5, "Nadia" );

function init()
{

//заправки 30 3д
local text = create3DTextLabel(338.758,875.07, -20.0312, "Filling Station #1 (Enter I to info)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-710.287,1762.62,-13.7309, "Filling Station #2 (Enter I to info)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-1592.31,942.639,-4.02328, "Filling Station #3 (Enter I to info)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-1679.5,-232.035,-19.1619, "Filling Station #4 (Enter I to info)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-629.5,-48.7479,2.22843, "Filling Station #5 (Enter I to info)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-150.096,610.258,-18.9558, "Filling Station #6 (Enter I to info)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(112.687,181.302,-18.7977, "Filling Station #7 (Enter I to info)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(547.921,2.62598,-17.0294, "Filling Station #8 (Enter I to info)", 0xFFFFFF, 10.0);

//полиция
local text = create3DTextLabel(-378.987, 654.699, -10.5013, "Empire Bay Police Department (Enter E)", 0xFFFFFF, 2.0);

//госпиталь
local text = create3DTextLabel(-393.394,913.983,-19.0026, "Empire General Hospital (Enter E)", 0xFFFFFF, 2.0);
local text = create3DTextLabel(-309.005,891.418,-18.9632, "UNLOAD STATIONERY", 0xFFFFFF, 100.0);

//работа раз сиг
local text = create3DTextLabel(-396.188,-692.02,-20.7457, "(JOB) Cigarette Delivery (Enter E)", 0xFFFFFF, 2.0);
local text = create3DTextLabel(-632.282,955.495,-17.7324, "LOAD CIGARETTES (Enter E)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-403.607,-833.451,-20.4267, "UNLOAD CIGARETTES (Enter E)", 0xFFFFFF, 10.0);

//доставщик мяса
local text = create3DTextLabel(14.0464,1809.85,-15.9628, "(JOB) Meat Delivery (Enter E)", 0xFFFFFF, 2.0);

//работа грузчика в порту
local text = create3DTextLabel(-350.47,-726.813,-14.4206, "(JOB) Docker (Enter E)", 0xFFFFFF, 2.0);
local text = create3DTextLabel(-334.709,-683.489,-20.737, "Take the box (Enter E)", 0xFFFFFF, 20.0);

//автобусник
local text = create3DTextLabel(-422.731,479.451,1.109211, "(JOB) Bus Driver (Enter E)", 0xFFFFFF, 2.0);

//развозчик топлива
local text = create3DTextLabel(528.999,-249.552,-19.1636, "(JOB) Carrier of Fuel (Enter E)", 0xFFFFFF, 2.0);

//однорукий бандит
local text = create3DTextLabel(-254.01,-129.645,-10.5254, "Casino Illusion (Enter E)", 0xFFFFFF, 10.0);

//места
local text = create3DTextLabel(67.2002,-202.94,-19.2324, "GRAND IMPERIAL BANK (Enter E)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-199.473,838.605,-20.2431, "Diamond Motors (Enter E)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-115.11,-63.1035,-11.041, "City Hall (Enter E)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(788.273,-77.9903,-19.1349, "LOAD FUEL  [Price = 2$]  (Enter E)", 0xFFFFFF, 10.0);
local text = create3DTextLabel(-1578.96,-323.928,-19.3172, "Army Empire Bay (Enter E)", 0xFFFFFF, 2.0);

local text = create3DTextLabel(32.7456,-411.533,-19.1725, "(JOB) Mechanic Operator (Enter E)", 0xFFFFFF, 2.0);
local text = create3DTextLabel(-82.6162,1739.23,-17.7167, "(JOB) Scrap Metal (Enter E)", 0xFFFFFF, 2.0);
local text = create3DTextLabel(763.599,802.275,-11.0161, "(JOB) Driver (Enter E)", 0xFFFFFF, 2.0);
local text = create3DTextLabel(389.846,125.266,-19.2027, "(JOB) SeaGift (Enter E)", 0xFFFFFF, 2.0);

//доставщик оружия
local text = create3DTextLabel(117.791,-58.7411,-18.9784, "Weapons Deliveryman (Enter E)", 0xFFFFFF, 2.0);

}
addEventHandler( "onClientScriptInit", init );

addEventHandler( "onClientFrameRender", 
	function( post )
	{
		if( post )
		{
		local currentDate = date();
		dxDrawText( "FPS: " +getFPS()+ " ID: " +getLocalPlayer()+ " Players online: " +(getPlayerCount()+1)+ " Data: " +currentDate["day"] + "." + currentDate["month"] + "." + (currentDate["year"]-66) + " Yearday: " + currentDate["yearday"] + " Ping: " +getPlayerPing(getLocalPlayer()), 2.0, 2.0, fromRGB( 255, 255, 130 ), true, "tahoma-bold" );
		dxDrawText( "Health " + getPlayerHealth( getLocalPlayer() ).tointeger(), (screen[0]-230), (screen[1]-40), fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		
		if( chas_min.len() < 2 )
		{
		dxDrawText( chas+":0"+chas_min, (screen[0]-100), 25.0, fromRGB( 255, 255, 130, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( chas_min.len() > 1 )
		{
		dxDrawText( chas+":"+chas_min, (screen[0]-100), 25.0, fromRGB( 255, 255, 130, 255 ), true, "tahoma-bold", 2.0 );
		}
		
		if(isPlayerInVehicle(getLocalPlayer()))
		{
			local vehicleid = getPlayerVehicle(getLocalPlayer());
			dxDrawText( "FUEL " + getVehicleFuel(vehicleid).tointeger(), (screen[0]-350), (screen[1]-40), fromRGB( 0, 100, 255, 255 ), true, "tahoma-bold", 2.0 );
		}
		
		if( money.len() == 1 )
		{
		dxDrawText( money+"$", (screen[0]-50), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 2 )
		{
		dxDrawText( money+"$", (screen[0]-65), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 3 )
		{
		dxDrawText( money+"$", (screen[0]-80), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 4 )
		{
		dxDrawText( money+"$", (screen[0]-95), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 5 )
		{
		dxDrawText( money+"$", (screen[0]-110), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 6 )
		{
		dxDrawText( money+"$", (screen[0]-125), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 7 )
		{
		dxDrawText( money+"$", (screen[0]-140), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 8 )
		{
		dxDrawText( money+"$", (screen[0]-155), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 9 )
		{
		dxDrawText( money+"$", (screen[0]-170), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		if( money.len() == 10 )
		{
		dxDrawText( money+"$", (screen[0]-185), 50.0, fromRGB( 0, 255, 0, 255 ), true, "tahoma-bold", 2.0 );
		}
		
		}
	}
);

//2д
addEventHandler( "onClientFrameRender", 
function(playerid)
{
	local myPos = getPlayerPosition( getLocalPlayer() );
	local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 353.893,385.469,-19.5472, 10.0 );//триада разгрузка оружия(инфо)
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 29.0389,1750.3,-17.8668, 10.0 );//разгрузка мяса клементе
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -199.473,838.605,-21.2431, 10.0 );//dm
	local check4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 1281.56,1290.69,-0.173949, 10.0 );//литейная
	local check5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 673.996,127.642,-12.2194, 10.0 );//завод жд рельс
	local check6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -108.482,1743.72,-18.458, 10.0 );//погрузка металла
	local check7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 356.187,135.612,-20.2027, 2.0 );//взять рыбу
	local check8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 375.036,132.285,-20.2027, 2.0 );//положить рыбу
	local check9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -315.909,679.425,-18.6004, 10.0 );//копы разгрузка оружия(инфо)
	local check10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1542.96,-369.083,-19.3354, 10.0 );//армия погрузка оружия(инфо)
	local check11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -309.005,891.418,-19.9632, 10.0 );//больница
	local check12 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -92.1166,-62.6148,-13.9892, 10.0 );//мерия
	local check13 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -440.931,-710.141,-21.4133, 10.0 );//погрузка мяса порт
	local check14 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1162.24,1536.75,6.541, 10.0 );//ирландцы разгрузка оружия(инфо)
	local check15 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 86.2709,897.346,-13.3142, 8.0 );//бордель
	
	local subway1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -554.36,1592.92,-21.8639, 5.0 );
	local subway2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1119.15,1376.71,-19.7724, 5.0 );
	local subway3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1535.55,-231.03,-13.5892, 5.0 );
	local subway4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -511.412,20.1703,-5.7096, 5.0 );
	local subway5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -113.792,-481.71,-8.92243, 5.0 );
	local subway6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 234.395,380.914,-9.41271, 5.0 );
	local subway7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -293.069,568.25,-2.27367, 5.0 );
	
	local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 318.402,873.896,-19.9921, 5.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -690.013,1764.19,-13.6658, 5.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1593.44,962.555,-3.91477, 5.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1678.54,-251.992,-19.047, 5.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -650.684,-50.1497,2.27309, 5.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -129.771,611.867,-18.7783, 5.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 113.574,161.19,-18.6694, 5.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 549.56,-17.7086,-17.9338, 5.0 );
	
	local ed1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -561.204,428.753,1.02075, 5.0 );
	local ed2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -771.518,-377.324,-20.4072, 5.0 );
	local ed3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 142.323,-429.708,-19.429, 5.0 );
	local ed4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 240.014,709.032,-24.0321, 5.0 );
	local ed5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -645.378,1296.42,3.94464, 5.0 );
	local ed6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1582.64,1603.77,-5.22507, 5.0 );
	local ed7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1420.38,961.175,-12.7543, 5.0 );
	local ed8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1588.62,177.321,-12.4393, 5.0 );
	local ed9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1559.15,-165.144,-19.6113, 5.0 );
	
	local bar1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1384.92,470.174,-22.1321, 5.0 );
	local bar2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 627.621,897.018,-12.0138, 2.0 );
	local bar3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -51.0424,737.98,-21.9009, 5.0 );
	local bar4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -639.003,349.621,1.34485, 5.0 );
	local bar5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 21.2379,-76.4079,-15.595, 5.0 );
	local bar6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1148.88,1589.7,6.25566, 5.0 );
	
	local rep1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1583.81,68.6026,-13.1081, 5.0 );
	local rep2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1438.92,1379.93,-13.3927, 5.0 );
	local rep3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -375.957,1735.39,-22.8601, 5.0 );
	local rep4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 425.711,780.516,-21.0679, 5.0 );
	local rep5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -120.967,529.571,-20.0687, 5.0 );
	local rep6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -282.268,701.517,-19.7763, 5.0 );
	local rep7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -687.197,188.526,1.18315, 5.0 );
	local rep8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -69.189,203.758,-14.3089, 5.0 );
	local rep9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 285.353,296.706,-21.3649, 5.0 );
	local rep10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 553.497,-122.346,-20.1382, 5.0 );
	local rep11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 719.397,-446.142,-19.9979, 5.0 );
	local rep12 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 49.0399,-405.637,-19.9942, 5.0 );
	
	local press1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -83.0683,1767.58,-18.4006, 2.0 );
	local press2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -79.025,1766.14,-15.8721, 2.0 );
	local sm1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1777.59,-18.7375, 2.0 );
	local sm2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1784.23,-18.7375, 2.0 );
	local sm3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1791.11,-18.7375, 2.0 );
	local sm4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1812.61,-18.7375, 2.0 );
	local sm5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1819.64,-18.7375, 2.0 );
	local sm6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1826.59,-18.7335, 2.0 );
	local sm7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1833.25,-18.5407, 2.0 );
	local sm8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.209,1840.77,-18.3499, 2.0 );
	local sm9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -100.038,1875.35,-17.8517, 2.0 );
	local sm10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -93.5064,1875.35,-17.8467, 2.0 );
	local sm11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -86.5965,1875.35,-17.8414, 2.0 );
	local sm12 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -74.3066,1823.29,-18.7367, 2.0 );
	local sm13 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -74.3065,1816.46,-18.7369, 2.0 );
	local sm14 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -74.3066,1809.61,-18.7369, 2.0 );
	local sm15 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -74.3065,1780.41,-18.7371, 2.0 );
	local sm16 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -73.7234,1773.57,-18.7312, 2.0 );
	local sm17 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -73.7371,1766.59,-18.7097, 2.0 );
	local sm18 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -73.1441,1759.77,-18.8409, 2.0 );
	local sm19 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -73.1413,1753.16,-19.0222, 2.0 );
	local sm20 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -72.2762,1746.66,-19.171, 2.0 );
	local sm21 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -70.8686,1740.83,-19.3344, 2.0 );
	local sm22 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -71.2316,1735.38,-19.4239, 2.0 );
	
	local house1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 332.879,-367.105,-20.1636, 10.0 );
	local house2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 463.927,-367.105,-20.1636, 10.0 );
	local house3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 529.554,-367.105,-20.1636, 10.0 );
	local house4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 529.605,-441.29,-20.1636, 10.0 );
	local house5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 463.605,-441.29,-20.1636, 10.0 );
	local house6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 397.605,-441.29,-20.1636, 10.0 );
	local house7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 331.605,-441.29,-20.1636, 10.0 );
	
	local bydka1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -310.857,1694.88,-22.3773, 2.0 );
	local bydka2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1170.57,1578.15,5.84156, 2.0 );
	local bydka3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1654.61,1143.06,-7.10691, 2.0 );
	local bydka4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1562.38,527.787,-20.1476, 2.0 );
	local bydka5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1421.31,-191.48,-20.3052, 2.0 );
	local bydka6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -147.053,-595.967,-20.1636, 2.0 );
	local bydka7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 283.082,-388.371,-20.1361, 2.0 );
	local bydka8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 747.74,7.80397,-19.4607, 2.0 );
	local bydka9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -208.633,-45.6014,-12.0168, 2.0 );
	local bydka10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -584.811,89.4905,-0.21516, 2.0 );
	local bydka11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 250.26,494.087,-20.046, 2.0 );
	local bydka12 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 612.189,845.402,-12.6476, 2.0 );
	local bydka13 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.488,847.435,-19.9109, 2.0 );
	local bydka14 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 139.371,1226.68,62.8897, 2.0 );
	local bydka15 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -508.688,910.919,-19.055, 2.0 );
	local bydka16 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -78.6843,233.494,-14.4042, 2.0 );
	
	local gans1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -592.593,500.991,1.02277, 4.0 );
	local gans2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -567.724,310.701,0.16808, 4.0 );
	local gans3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -10.54,739.379,-22.0582, 4.0 );
	local gans4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 404.657,603.754,-24.9746, 4.0 );
	local gans5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 68.0516,139.778,-14.4583, 4.0 );
	local gans6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 279.78,-118.507,-12.2741, 4.0 );
	local gans7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 273.826,-454.45,-20.1636, 4.0 );
	local gans8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -323.407,-589.106,-20.1043, 4.0 );
	local gans9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1394.73,-32.7772,-17.8468, 4.0 );
	local gans10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1183.09,1706.26,11.0941, 4.0 );
	local gans11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -288.036,1627.6,-23.0758, 4.0 );
	
	local irish_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1151.57,1580.17,6.27222, 0.5 );
	local irish_vh2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1158.3,1599.33,6.28698, 0.5 );
	local bryski_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -85.0722,1736.67,-18.7004, 0.5 );
	local arkadia_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -549.544,-51.2645,1.03809, 0.5 );
	local ebf_vh = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 1226.26,1273.44,0.0747099, 0.5 );
	local clemente_vh = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 41.5553,1784.44,-17.8668, 0.5 );
	local jyzepe_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -165.166,519.097,-19.9438, 0.5 );
	local jyzepe_vh2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -166.527,520.78,-16.0193, 0.5 );
	local armyn_vh = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1292.64,1608.65,4.30491, 0.5 );
	local bryno_vh = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -164.907,-582.803,-20.1767, 0.5 );
	local jo_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 74.8285,898.395,-19.1079, 0.5 );
	local jo_vh2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 94.8602,880.915,-19.6134, 0.5 );
	local jo_vh3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 82.3064,889.32,-13.3036, 0.5 );
	local port_vh = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -348.263,-731.353,-15.3389, 0.5 );
	
	local zak_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 136.28,-433.722,-19.4657, 0.5 );
	local zak_vh2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -638.118,1294.83,3.90784, 0.5 );
	local zak_vh3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1588.77,1599.75,-5.26265, 0.5 );
	local zak_vh4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1416.36,954.948,-12.7921, 0.5 );
	local zak_vh5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1584.61,171.068,-12.4761, 0.5 );
	local zak_vh6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1552.83,-169.192,-19.624, 0.5 );
	
	local bar_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1392.27,476.369,-22.0811, 0.5 );
	local bar_vh2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1381.67,480.863,-23.182, 0.5 );
	local bar_vh3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1379.62,471.347,-22.1031, 0.5 );
	local bar_vh4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 629.515,894.428,-12.0137, 0.5 );
	local bar_vh5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 631.031,900.294,-12.0137, 0.5 );
	local bar_vh6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -48.3979,728.282,-21.9681, 0.5 );
	local bar_vh7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -642.92,357.472,1.34699, 0.5 );
	local bar_vh8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -632.733,345.808,1.26277, 0.5 );
	local bar_vh9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 29.2695,-66.4476,-16.1665, 0.5 );
	local bar_vh10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 26.6142,-68.1314,-16.1945, 0.5 );
	
	local gans_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -592.761,506.872,1.02469, 0.5 );
	local gans_vh2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -561.842,310.851,0.186179, 0.5 );
	local gans_vh3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -4.65856,739.782,-22.02, 0.5 );
	local gans_vh4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 404.501,609.636,-24.8944, 0.5 );
	local gans_vh5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 62.1702,139.456,-14.4132, 0.5 );
	local gans_vh6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 273.899,-118.779,-12.1976, 0.5 );
	local gans_vh7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 279.707,-454.18,-20.1616, 0.5 );
	local gans_vh8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -323.112,-594.988,-20.1043, 0.5 );
	local gans_vh9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1395.09,-26.8958,-17.8468, 0.5 );
	local gans_vh10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1182.76,1700.38,11.1808, 0.5 );
	local gans_vh11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -287.76,1621.72,-23.0972, 0.5 );
	
	local od_vh1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.572,-52.452,-11.458, 0.5 );
	local od_vh2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.268,-88.6935,-11.458, 0.5 );
	
	
	local irish_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1151.64,1580.82,6.25985, 0.5 );
	local irish_ex2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1157.66,1599.45,6.25566, 0.5 );
	local bryski_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -84.403,1736.8,-18.7167, 0.5 );
	local arkadia_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -549.436,-50.3488,1.03805, 0.5 );
	local ebf_ex = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 1225.55,1273.46,0.114826, 0.5 );
	local clemente_ex = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 41.5922,1785.13,-17.8401, 0.5 );
	local jyzepe_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -165.09,519.746,-19.9191, 0.5 );
	local jyzepe_ex2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -167.196,521.024,-16.0193, 0.5 );
	local armyn_ex = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1293.31,1608.94,4.33968, 0.5 );
	local bryno_ex = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -165.077,-583.508,-20.1767, 0.5 );
	local jo_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 74.704,897.726,-19.1137, 0.5 );
	local jo_ex2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 94.201,880.889,-19.6149, 0.5 );
	local jo_ex3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 82.3489,889.989,-13.3208, 0.5 );
	local port_ex = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -347.96,-730.686,-15.4208, 0.5 );
	
	local zak_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 136.41,-433.043,-19.429, 0.5 );
	local zak_ex2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -638.707,1294.46,3.94464, 0.5 );
	local zak_ex3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1588.57,1600.43,-5.22507, 0.5 );
	local zak_ex4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1417.04,955.09,-12.7543, 0.5 );
	local zak_ex5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1585.29,171.234,-12.4393, 0.5 );
	local zak_ex6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1553.17,-168.589,-19.6113, 0.5 );
	
	local bar_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1391.62,476.218,-22.0779, 0.5 );
	local bar_ex2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1381.79,480.215,-23.182, 0.5 );
	local bar_ex3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1380.27,471.405,-22.1247, 0.5 );
	local bar_ex4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 629.661,895.129,-12.0138, 0.5 );
	local bar_ex5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 630.932,899.661,-12.0138, 0.5 );
	local bar_ex6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -48.9059,728.721,-21.9009, 0.5 );
	local bar_ex7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -642.544,356.902,1.34888, 0.5 );
	local bar_ex8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -633.402,345.78,1.34485, 0.5 );
	local bar_ex9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 28.1576,-66.223,-16.193, 0.5 );
	local bar_ex10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 26.5849,-68.9184,-16.1942, 0.5 );
	
	local gans_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -592.858,506.173,1.02277, 0.5 );
	local gans_ex2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -562.541,311.033,0.171005, 0.5 );
	local gans_ex3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -5.35775,739.878,-22.0582, 0.5 );
	local gans_ex4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 404.353,608.936,-24.9746, 0.5 );
	local gans_ex5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 62.8693,139.56,-14.4583, 0.5 );
	local gans_ex6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 274.598,-118.851,-12.2741, 0.5 );
	local gans_ex7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 279.008,-453.951,-20.1636, 0.5 );
	local gans_ex8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -322.908,-594.289,-20.1043, 0.5 );
	local gans_ex9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1395.2,-27.595,-17.8468, 0.5 );
	local gans_ex10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1182.71,1701.08,11.0941, 0.5 );
	local gans_ex11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -287.537,1622.42,-23.0758, 0.5 );
	
	local od_ex1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.7,-53.11,-11.458, 0.5 );
	local od_ex2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.219,-88.0354,-11.458, 0.5 );
	
	if( check1 )
	{
		dxDrawText( "Gans Info (Enter I)", 0.0, (screen[1]-65), fromRGB( 200, 0, 0 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Gans Unload (Enter E)", 0.0, (screen[1]-40), fromRGB( 200, 0, 0 ), true, "tahoma-bold", 2.0 );
	}
	if( check2 )
	{
		dxDrawText( "Unload Meat(Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check3 )
	{
		dxDrawText( "/buycar (id vehicle 0-53)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check4)
	{	
		dxDrawText( "Unload metal (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check5 )
	{	
		dxDrawText( "Unload or Load goods (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check6 )
	{
		dxDrawText( "Load metal (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check7 )
	{
		dxDrawText( "Take the fish (Enter E)", 0.0, (screen[1]-40), fromRGB( 60, 110, 190 ), true, "tahoma-bold", 2.0 );
	}
	if( check8 )
	{
		dxDrawText( "Process fish (Enter E)", 0.0, (screen[1]-40), fromRGB( 60, 110, 190 ), true, "tahoma-bold", 2.0 );
	}
	if( check9 )
	{
		dxDrawText( "Gans Info (Enter I)", 0.0, (screen[1]-65), fromRGB( 0, 150, 255 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Gans Unload or Unload stationery (Enter E)", 0.0, (screen[1]-40), fromRGB( 0, 150, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check10 )
	{
		dxDrawText( "Gans Info (Enter I)", 0.0, (screen[1]-65), fromRGB( 150, 150, 0 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Gans Load (Enter E)", 0.0, (screen[1]-40), fromRGB( 150, 150, 0 ), true, "tahoma-bold", 2.0 );
	}
	if( check11 )
	{
		dxDrawText( "Unload stationery (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 100, 100 ), true, "tahoma-bold", 2.0 );
	}
	if( check12 )
	{
		dxDrawText( "Unload stationery (Enter E)", 0.0, (screen[1]-40), fromRGB( 100, 100, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check13 )
	{
		dxDrawText( "Load Meat (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( check14 )
	{
		dxDrawText( "Gans Info (Enter I)", 0.0, (screen[1]-65), fromRGB( 0, 255, 0 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Gans Unload (Enter E)", 0.0, (screen[1]-40), fromRGB( 0, 255, 0 ), true, "tahoma-bold", 2.0 );
	}
	if( check15 )
	{
		dxDrawText( "/sex", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if( subway1 || subway2 || subway3 || subway4 || subway5 || subway6 || subway7)
	{
		dxDrawText( "Price 10$", 0.0, (screen[1]-65), fromRGB( 0, 255, 0 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Subway (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if( fuel1 || fuel2 || fuel3 || fuel4 || fuel5 || fuel6 || fuel7 || fuel8)
	{
		dxDrawText( "Car Wash (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if(ed1 || ed2 || ed3 || ed4 || ed5 || ed6 || ed7 || ed8 || ed9)
	{
		dxDrawText( "Eat (Enter E)", 0.0, (screen[1]-65), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Business Info (Enter I)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if(bar1 || bar2 || bar3 || bar4 || bar5 || bar6)
	{
		dxDrawText( "Drink (Enter E)", 0.0, (screen[1]-65), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Business Info (Enter I)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if(rep1 || rep2 || rep3 || rep4 || rep5 || rep6 || rep7 || rep8 || rep9 || rep10 || rep11 || rep12)
	{
		dxDrawText( "/repair", 0.0, (screen[1]-65), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
		dxDrawText( "Business Info (Enter I)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if( sm1 || sm2 || sm3 || sm4 || sm5 || sm6 || sm7 || sm8 || sm9 || sm10 || sm11 || sm12 || sm13 || sm14 || sm15 || sm16 || sm17 || sm18 || sm19 || sm20 || sm21 || sm22)
	{
		dxDrawText( "Pick up metal (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( press1 )
	{
		dxDrawText( "Put metal (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( press2 )
	{
		dxDrawText( "Metal pressing (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if( house1 || house2 || house3 || house4 || house5 || house6 || house7 )
	{
		dxDrawText( "/buyhouse", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if(bydka1 || bydka2 || bydka3 || bydka4 || bydka5 || bydka6 || bydka7 || bydka8 || bydka9 || bydka10 || bydka11 || bydka12 || bydka13 || bydka14 || bydka15 || bydka16)
	{
		dxDrawText( "Phone (Enter Q)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if(gans1 || gans2 || gans3 || gans4 || gans5 || gans6 || gans7 || gans8 || gans9 || gans10 || gans11)
	{
		dxDrawText( "Business Info (Enter I)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
	if( irish_vh1 || irish_vh2 || bryski_vh1 || arkadia_vh1 || ebf_vh || clemente_vh || jyzepe_vh1 || jyzepe_vh2 || armyn_vh || bryno_vh || jo_vh1 || jo_vh2 || jo_vh3 || zak_vh1 || zak_vh2 || zak_vh3 || zak_vh4 || zak_vh5 || zak_vh6 || bar_vh1 || bar_vh2 || bar_vh3 || bar_vh4 || bar_vh5 || bar_vh6 || bar_vh7 || bar_vh8 || bar_vh9 || bar_vh10 || gans_vh1 || gans_vh2 || gans_vh3 || gans_vh4 || gans_vh5 || gans_vh6 || gans_vh7 || gans_vh8 || gans_vh9 || gans_vh10 || gans_vh11 || od_vh1 || od_vh2 || port_vh)
	{
		dxDrawText( "Entrance (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	if( irish_ex1 || irish_ex2 || bryski_ex1 || arkadia_ex1 || ebf_ex || clemente_ex || jyzepe_ex1 || jyzepe_ex2 || armyn_ex || bryno_ex || jo_ex1 || jo_ex2 || jo_ex3 || zak_ex1 || zak_ex2 || zak_ex3 || zak_ex4 || zak_ex5 || zak_ex6 || bar_ex1 || bar_ex2 || bar_ex3 || bar_ex4 || bar_ex5 || bar_ex6 || bar_ex7 || bar_ex8 || bar_ex9 || bar_ex10 || gans_ex1 || gans_ex2 || gans_ex3 || gans_ex4 || gans_ex5 || gans_ex6 || gans_ex7 || gans_ex8 || gans_ex9 || gans_ex10 || gans_ex11 || od_ex1 || od_ex2 || port_ex)
	{
		dxDrawText( "Exit (Enter E)", 0.0, (screen[1]-40), fromRGB( 255, 255, 255 ), true, "tahoma-bold", 2.0 );
	}
	
});

//3д
addEventHandler( "onClientFrameRender", 
function(check)
{
	local myPos = getPlayerPosition( getLocalPlayer() );
	
	local mesto1 = getScreenFromWorld( -252.324,-79.688,-10.458 );
	local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -252.324,-79.688,-11.458, 5.0 );//магаз одежды
	if( check1 )
	{
		dxDrawText( "Vangels's Shop (Enter E)", mesto1[0], mesto1[1], fromRGB( 255, 255, 0 ), true, "tahoma-bold", 1.0 );
	}
	
	local mesto2 = getScreenFromWorld( -37.4106,1158.15,69.3648 );
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -37.4106,1158.15,68.3648, 10.0 );
	if( check2 )
	{
		dxDrawText( "House #1 (Enter I)", mesto2[0], mesto2[1], fromRGB( 255, 255, 0 ), true, "tahoma-bold", 1.0 );
	}
	
	local mesto3 = getScreenFromWorld( 13.7068,1254.02,67.3859 );
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 13.7068,1254.02,66.3859, 10.0 );
	if( check3 )
	{
		dxDrawText( "House #2 (Enter I)", mesto3[0], mesto3[1], fromRGB( 255, 255, 0 ), true, "tahoma-bold", 1.0 );
	}
});

function fe() 
{
	triggerServerEvent( "cops" );
	triggerServerEvent( "bb" );
	triggerServerEvent( "egh" );
	triggerServerEvent( "docker" );
	triggerServerEvent( "bus" );
	triggerServerEvent( "carrierfuel" );
	triggerServerEvent( "unloadfuel" );
	triggerServerEvent( "mechanic" );
	triggerServerEvent( "scrapmetal" );
	triggerServerEvent( "seagift_jobs" );
	triggerServerEvent( "meat" );
	
	triggerServerEvent( "wash" );
	triggerServerEvent( "dm" );
	triggerServerEvent( "aeb_gans" );
	triggerServerEvent( "load_gans" );
	triggerServerEvent( "unload_gans" );
	triggerServerEvent( "driver" );
	triggerServerEvent( "jobgans" );
	
	triggerServerEvent( "eat" );
	triggerServerEvent( "drink" );
	
	triggerServerEvent( "hmeria" );
	triggerServerEvent( "subway_menu" );
	triggerServerEvent( "bankinfo" );
	triggerServerEvent( "seagift" );
	triggerServerEvent( "banditgame" );
	triggerServerEvent( "clother" );
	
	//входы и выходы
	triggerServerEvent( "irish_vh1" );
	triggerServerEvent( "irish_ex1" );
	triggerServerEvent( "irish_vh2" );
	triggerServerEvent( "irish_ex2" );
	
	triggerServerEvent( "bryski_vh1" );
	triggerServerEvent( "bryski_ex1" );
	
	triggerServerEvent( "arkadia_vh1" );
	triggerServerEvent( "arkadia_ex1" );
	
	triggerServerEvent( "ebf_vh" );
	triggerServerEvent( "ebf_ex" );
	
	triggerServerEvent( "clemente_vh" );
	triggerServerEvent( "clemente_ex" );
	
	triggerServerEvent( "jyzepe_vh1" );
	triggerServerEvent( "jyzepe_ex1" );
	triggerServerEvent( "jyzepe_vh2" );
	triggerServerEvent( "jyzepe_ex2" );
	
	triggerServerEvent( "armyn_vh" );
	triggerServerEvent( "armyn_ex" );
	
	triggerServerEvent( "bryno_vh" );
	triggerServerEvent( "bryno_ex" );
	
	triggerServerEvent( "port_vh" );
	triggerServerEvent( "port_ex" );
	
	triggerServerEvent( "jo_vh1" );
	triggerServerEvent( "jo_ex1" );
	triggerServerEvent( "jo_vh2" );
	triggerServerEvent( "jo_ex2" );
	triggerServerEvent( "jo_vh3" );
	triggerServerEvent( "jo_ex3" );
	
	//закусочные
	triggerServerEvent( "zak_vh1" );
	triggerServerEvent( "zak_ex1" );
	triggerServerEvent( "zak_vh2" );
	triggerServerEvent( "zak_ex2" );
	triggerServerEvent( "zak_vh3" );
	triggerServerEvent( "zak_ex3" );
	triggerServerEvent( "zak_vh4" );
	triggerServerEvent( "zak_ex4" );
	triggerServerEvent( "zak_vh5" );
	triggerServerEvent( "zak_ex5" );
	triggerServerEvent( "zak_vh6" );
	triggerServerEvent( "zak_ex6" );
	
	//бары
	triggerServerEvent( "bar_vh1" );
	triggerServerEvent( "bar_ex1" );
	triggerServerEvent( "bar_vh2" );
	triggerServerEvent( "bar_ex2" );
	triggerServerEvent( "bar_vh3" );
	triggerServerEvent( "bar_ex3" );
	
	triggerServerEvent( "bar_vh4" );
	triggerServerEvent( "bar_ex4" );
	triggerServerEvent( "bar_vh5" );
	triggerServerEvent( "bar_ex5" );
	
	triggerServerEvent( "bar_vh6" );
	triggerServerEvent( "bar_ex6" );
	
	triggerServerEvent( "bar_vh7" );
	triggerServerEvent( "bar_ex7" );
	triggerServerEvent( "bar_vh8" );
	triggerServerEvent( "bar_ex8" );
	
	triggerServerEvent( "bar_vh9" );
	triggerServerEvent( "bar_ex9" );
	triggerServerEvent( "bar_vh10" );
	triggerServerEvent( "bar_ex10" );
	
	//магазины оружия
	triggerServerEvent( "gans_vh1" );
	triggerServerEvent( "gans_ex1" );
	triggerServerEvent( "gans_vh2" );
	triggerServerEvent( "gans_ex2" );
	triggerServerEvent( "gans_vh3" );
	triggerServerEvent( "gans_ex3" );
	triggerServerEvent( "gans_vh4" );
	triggerServerEvent( "gans_ex4" );
	triggerServerEvent( "gans_vh5" );
	triggerServerEvent( "gans_ex5" );
	triggerServerEvent( "gans_vh6" );
	triggerServerEvent( "gans_ex6" );
	triggerServerEvent( "gans_vh7" );
	triggerServerEvent( "gans_ex7" );
	triggerServerEvent( "gans_vh8" );
	triggerServerEvent( "gans_ex8" );
	triggerServerEvent( "gans_vh9" );
	triggerServerEvent( "gans_ex9" );
	triggerServerEvent( "gans_vh10" );
	triggerServerEvent( "gans_ex10" );
	triggerServerEvent( "gans_vh11" );
	triggerServerEvent( "gans_ex11" );
	
	//магазин одежды
	triggerServerEvent( "od_vh1" );
	triggerServerEvent( "od_ex1" );
	triggerServerEvent( "od_vh2" );
	triggerServerEvent( "od_ex2" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "e", "down", fe );
});

function fe1() 
{
	triggerServerEvent( "copsq" );
	triggerServerEvent( "bbq" );
	triggerServerEvent( "busq" );
	triggerServerEvent( "eghq" );
	triggerServerEvent( "dockerq" );
	triggerServerEvent( "carrierfuelq" );
	triggerServerEvent( "mechanicq" );
	triggerServerEvent( "scrapmetalq" );
	triggerServerEvent( "driverq" );
	triggerServerEvent( "meatq" );
	triggerServerEvent( "jobgansq" );
	triggerServerEvent( "callphone" );
	triggerServerEvent( "seagiftq" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "q", "up", fe1 );
});

function hidechat()
{
    if( isChatVisible() )
    {
        showChat( false );
    }
    else
    {
        showChat( true );
    }
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "f1", "down", hidechat );
});

function info() 
{
	triggerServerEvent( "bizinfo" );
	triggerServerEvent( "gansinfo" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "i", "up", info );
});

function fe2() 
{
	triggerServerEvent( "exit" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "g", "up", fe2 );
});

function fone1() 
{
	openMap();
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "m", "down", fone1 );
});
function fone2() 
{
	showChat( true );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "m", "up", fone2 );
});

function avar() 
{
  triggerServerEvent( "avar" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "c", "down", avar );
});

function left() 
{
  triggerServerEvent( "left" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "z", "down", left );
});

function right() 
{
  triggerServerEvent( "right" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "x", "down", right );
});

function light() 
{
  triggerServerEvent( "light" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "v", "down", light );
});

function en() 
{
  triggerServerEvent( "en" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "q", "down", en );
});

//бинды
function meg() 
{
  triggerServerEvent( "megafon" );
}
addEventHandler("onClientScriptInit", function() {
    bindKey( "num_0", "down", meg );
});

//бб
addEventHandler( "gpsloadcig",
function( playerid )
{
setGPSTarget(-632.282,955.495);
}
);
addEventHandler( "removegps",
function( playerid )
{
removeGPSTarget();
}
);
addEventHandler( "gpsunloadcig",
function( playerid )
{
setGPSTarget(-403.607,-833.451);
}
);

//автобусник
addEventHandler( "hudtimer",
function( playerid )
{
createHudTimer( 7.0, true, true);
}
);

addEventHandler( "gpspd",
function( playerid )
{
setGPSTarget(-388.956,653.65);
}
);
addEventHandler( "gpsjd",
function( playerid )
{
setGPSTarget(-574.482,1599.0);
}
);
addEventHandler( "gpsrinok",
function( playerid )
{
setGPSTarget(-1299.31,1328.93);
}
);
addEventHandler( "gpsed",
function( playerid )
{
setGPSTarget(-1409.38,961.825);
}
);
addEventHandler( "gpsarmy",
function( playerid )
{
setGPSTarget(-1544.55,-306.271);
}
);
addEventHandler( "gpsport",
function( playerid )
{
setGPSTarget(-468.734,-474.159);
}
);
addEventHandler( "gpstrago",
function( playerid )
{
setGPSTarget(571.847,-309.336);
}
);
addEventHandler( "gpsbank",
function( playerid )
{
setGPSTarget(49.6432,-281.879);
}
);
addEventHandler( "gpsmeria",
function( playerid )
{
setGPSTarget(-90.7553,-16.6645);
}
);
addEventHandler( "gpsdepo",
function( playerid )
{
setGPSTarget(-377.594,468.22);
}
);

//металлоломщик
addEventHandler( "sm1",
function( playerid )
{
setGPSTarget(-100.209,1777.59);
}
);
addEventHandler( "sm2",
function( playerid )
{
setGPSTarget(-100.209,1784.23);
}
);
addEventHandler( "sm3",
function( playerid )
{
setGPSTarget(-100.209,1791.11);
}
);
addEventHandler( "sm4",
function( playerid )
{
setGPSTarget(-100.209,1812.61);
}
);
addEventHandler( "sm5",
function( playerid )
{
setGPSTarget(-100.209,1819.64);
}
);
addEventHandler( "sm6",
function( playerid )
{
setGPSTarget(-100.209,1826.59);
}
);
addEventHandler( "sm7",
function( playerid )
{
setGPSTarget(-100.209,1833.25);
}
);
addEventHandler( "sm8",
function( playerid )
{
setGPSTarget(-100.209,1840.77);
}
);
addEventHandler( "sm9",
function( playerid )
{
setGPSTarget(-100.038,1875.35);
}
);
addEventHandler( "sm10",
function( playerid )
{
setGPSTarget(-93.5064,1875.35);
}
);
addEventHandler( "sm11",
function( playerid )
{
setGPSTarget(-86.5965,1875.35);
}
);
addEventHandler( "sm12",
function( playerid )
{
setGPSTarget(-74.3066,1823.29);
}
);
addEventHandler( "sm13",
function( playerid )
{
setGPSTarget(-74.3065,1816.46);
}
);
addEventHandler( "sm14",
function( playerid )
{
setGPSTarget(-74.3066,1809.61);
}
);
addEventHandler( "sm15",
function( playerid )
{
setGPSTarget(-74.3065,1780.41);
}
);
addEventHandler( "sm16",
function( playerid )
{
setGPSTarget(-73.7234,1773.57);
}
);
addEventHandler( "sm17",
function( playerid )
{
setGPSTarget(-73.7371,1766.59);
}
);
addEventHandler( "sm18",
function( playerid )
{
setGPSTarget(-73.1441,1759.77);
}
);
addEventHandler( "sm19",
function( playerid )
{
setGPSTarget(-73.1413,1753.16);
}
);
addEventHandler( "sm20",
function( playerid )
{
setGPSTarget(-72.2762,1746.66);
}
);
addEventHandler( "sm21",
function( playerid )
{
setGPSTarget(-70.8686,1740.83);
}
);
addEventHandler( "sm22",
function( playerid )
{
setGPSTarget(-71.2316,1735.38);
}
);


//развозчик топлива
addEventHandler( "gpsloadfuel",
function( playerid )
{
setGPSTarget(788.273,-77.9903);
}
);

//погрузка 30 сек или разгрузка
addEventHandler( "bbtimer",
function( playerid )
{
createHudTimer( 21.0, true, true);
fadeScreen( 30000 );
}
);

//аренда
addEventHandler( "crhudtimer",
function( playerid )
{
createHudTimer( 420.0, true, true);
}
);

//водитель 1 маршрут
addEventHandler( "gpsloadmetal",
function( playerid )
{
setGPSTarget(-108.482,1743.72);
}
);

//водитель 2 маршрут
addEventHandler( "port_load",
function( playerid )
{
setGPSTarget(-305.419,-733.279);
}
);
addEventHandler( "seagift_unload",
function( playerid )
{
setGPSTarget(373.792,115.759);
}
);
addEventHandler( "seagift_load",
function( playerid )
{
setGPSTarget(396.283,97.4237);
}
);

//грузчик
addEventHandler( "seagift_check1",
function( playerid )
{
setGPSTarget(356.187,135.612);
}
);
addEventHandler( "seagift_check2",
function( playerid )
{
setGPSTarget(375.036,132.285);
}
);

//мясо
addEventHandler( "gpsloadmeat",
function( playerid )
{
setGPSTarget(-440.931,-710.141);
}
);
addEventHandler( "gpsunloadmeat",
function( playerid )
{
setGPSTarget(29.0389,1750.3);
}
);

//доставщик оружия
addEventHandler( "gpsloadgans",
function( playerid )
{
setGPSTarget(-1542.96,-369.083);
}
);
addEventHandler( "gpsunloadgans",
function( playerid )
{
setGPSTarget(673.996,127.642);
}
);

addEventHandler( "deshudtimer",
function( playerid )
{
destroyHudTimer();
}
);


addEventHandler( "narko",
function( playerid )
{
	setPlayerDrunkLevel( 100 );
});

// scoreboard.nut By AaronLad
// Variables
local drawScoreboard = false;
local screenSize = getScreenSize( );

// Scoreboard math stuff
local fPadding = 5.0, fTopToTitles = 25.0;
local fWidth = 600.0, fHeight = ((fPadding * 2) + (fTopToTitles * 3));
local fOffsetID = 50.0, fOffsetName = 450.0;
local fPaddingPlayer = 20.0;
local fX = 0.0, fY = 0.0, fOffsetX = 0.0, fOffsetY = 0.0;

function tabDown()
{
	drawScoreboard = true;
			
	// Add padding to the height for each connected player
	for( local i = 0; i < MAX_PLAYERS; i++ )
	{
		if( isPlayerConnected(i) )
			fHeight += fPaddingPlayer;
	}
}
bindKey( "tab", "down", tabDown );

function tabUp()
{
	drawScoreboard = false;
			
	// Reset the height
	fHeight = ((fPadding * 2) + (fTopToTitles * 3));
}
bindKey( "tab", "up", tabUp );

function playerConnect( playerid, nickname )
{
	// Are we rendering the scoreboard?
	if( drawScoreboard )
		fHeight += fPaddingPlayer;
}
addEventHandler( "onClientPlayerConnect", playerConnect );

function playerDisconnect( playerid )
{
	// Are we rendering the scoreboard?
	if( drawScoreboard )
	{
		// Remove the height from this player
		fHeight = fHeight - fPaddingPlayer;
	}
}
addEventHandler( "onClientPlayerDisconnect", playerDisconnect );

function deviceReset()
{
	// Get the new screen size
	screenSize = getScreenSize();
}
addEventHandler( "onClientDeviceReset", deviceReset );

function frameRender( post_gui )
{
	if( post_gui && drawScoreboard )
	{
		fX = ((screenSize[0] / 2) - (fWidth / 2));
		fY = ((screenSize[1] / 2) - (fHeight / 2));
		fOffsetX = (fX + fPadding);
		fOffsetY = (fY + fPadding);
		
		dxDrawRectangle( fX, fY, fWidth, fHeight, fromRGB( 0, 0, 0, 128 ) );

		fOffsetX += 25.0;
		fOffsetY += 25.0;
		dxDrawText( "ID", fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );

		fOffsetX += fOffsetID;
		dxDrawText( "Nickname", fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
		
		fOffsetX += fOffsetName;
		dxDrawText( "Ping", fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
		
		// Draw the localplayer
		fOffsetX = (fX + fPadding + 25.0);
		fOffsetY += 20.0;
		dxDrawText( getLocalPlayer().tostring(), fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
		
		fOffsetX += fOffsetID;
		dxDrawText( getPlayerName(getLocalPlayer()), fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
		
		fOffsetX += fOffsetName;
		dxDrawText( getPlayerPing(getLocalPlayer()).tostring(), fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
		
		// Draw remote players
		for( local i = 0; i < MAX_PLAYERS; i++ )
		{
			if( i != getLocalPlayer() )
			{
				if( isPlayerConnected(i) )
				{
					fOffsetX = (fX + fPadding + 25.0);
					fOffsetY += fPaddingPlayer;
					dxDrawText( i.tostring(), fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
					
					fOffsetX += fOffsetID;
					dxDrawText( getPlayerName(i), fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
					
					fOffsetX += fOffsetName;
					dxDrawText( getPlayerPing(i).tostring(), fOffsetX, fOffsetY, 0xFFFFFFFF, true, "tahoma-bold" );
				}
			}
		}
	}
}
addEventHandler( "onClientFrameRender", frameRender );
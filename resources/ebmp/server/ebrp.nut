local script = "EBMP-RP RESOURCES";
local leto = false;
local col_wanted = 0;
local uvelirka = 0;
local novosti = 0;

local fs1_p;
local fs2_p;
local fs3_p;
local fs4_p;
local fs5_p;
local fs6_p;
local fs7_p;
local fs8_p;

local fs1_bf;
local fs2_bf;
local fs3_bf;
local fs4_bf;
local fs5_bf;
local fs6_bf;
local fs7_bf;
local fs8_bf;

local ed_p;
local bar_p;
local rep_p;

local tax;

local prisontimer;
local cr;
local fuelinfo;
local job_timer;

function nov()
{
	novosti = 0;
}

addCommandHandler( "news",
function( playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "money").tointeger() < 1000)
	{
		return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
	}
	
	if(novosti == 1)
	{
		return sendPlayerMessage(playerid, "Доступно один раз в 10 мин.", 255, 0, 0 );
	}
	
	foreach(i, playername in getPlayers())
	{
		local text = "";
		for(local i = 0; i < vargv.len(); i++)
		{
			text = text + " " + vargv[i];
		}
		
		sendPlayerMessage( i, "(ОБЪЯВЛЕНИЕ) От " +getPlayerName(playerid)+ " Текст:" +text, 0, 255, 0 );
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1000);
	ini.saveData();
	
	local timer = timer( nov, 600000, 1 );
	novosti = 1;
});

//бинды
//коп
addEventHandler("megafon", 
function(playerid) 
{	
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return;
	}
	
	foreach(i, playername in getPlayers())
	{
		
		local myPos = getPlayerPosition( i );
		local pos = getPlayerPosition( playerid );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 50.0 );
		local vehicleid = getPlayerVehicle(playerid);
		local vehicle = getVehicleModel(vehicleid);
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(check && ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1 && vehicle == 42)
		{
			sendPlayerMessage( i, "(MEGAFON) Остановитесь и прижмитесь к обочине, вам говорит офицер полиции "+getPlayerName( playerid ), 255, 255, 0 );
		}
	}
});

addCommandHandler( "leader",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
	sendPlayerMessage(playerid, "===============[Лидеры онлайн]=================", 255, 255, 0);
	foreach (i, playername in getPlayers())
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "leader").tointeger() == 1)
		{
			sendPlayerMessage(playerid, "Полиция: " + getPlayerName(i));
		}
		if(ini.getKey("PlayerInfo", "leader").tointeger() == 2)
		{
			sendPlayerMessage(playerid, "Госпиталь: " + getPlayerName(i));
		}
		if(ini.getKey("PlayerInfo", "leader").tointeger() == 3)
		{
			sendPlayerMessage(playerid, "Армия: " + getPlayerName(i));
		}
		if(ini.getKey("PlayerInfo", "leader").tointeger() == 4)
		{
			sendPlayerMessage(playerid, "Триада: " + getPlayerName(i));
		}
		if(ini.getKey("PlayerInfo", "leader").tointeger() == 5)
		{
			sendPlayerMessage(playerid, "Ирландцы: " + getPlayerName(i));
		}
		if(ini.getKey("PlayerInfo", "leader").tointeger() == 6)
		{
			sendPlayerMessage(playerid, "Мерия: " + getPlayerName(i));
		}
	}
});

//рандом
function random(min=0, max=RAND_MAX)
{
    srand(getTickCount() * rand());
    return (rand() % ((max + 1) - min)) + min;
}

addEventHandler("onPlayerChat", 
function(playerid, text) 
{	
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}

	//чат игроков
	log("");
	log("(IC) " +getPlayerName( playerid )+ ": " + text);
	log("");
	
	foreach(i, playername in getPlayers())
	{
		
		local myPos = getPlayerPosition( i );
		local pos = getPlayerPosition( playerid );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
		if(check)
		{
			sendPlayerMessage( i, "(IC) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 255, 255 );
		}
	}
});

addCommandHandler( "let",
function( playerid, id, ...)
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
		
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
		return;
	}
	
	local text = "";
	for(local i = 0; i < vargv.len(); i++)
	{
		text = text + " " + vargv[i];
	}
	sendPlayerMessage( playerid, "(ПИСЬМО) К " + getPlayerName(id.tointeger())+ "["+getPlayerIdFromName(getPlayerName( id.tointeger() ))+"]" + ":" + text, 255, 255, 0 );
	sendPlayerMessage( id.tointeger(), "(ПИСЬМО) От " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 255, 0 );
	log("");
	log("(LET) OT " +getPlayerName( playerid )+" K " + getPlayerName(id.tointeger())+ text);
	log("");
});

addCommandHandler( "s",
function( playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
	local text = "";
		for(local i = 0; i < vargv.len(); i++)
		{
		text = text + " " + vargv[i];
		}
	foreach(i, playername in getPlayers()) 
	{
			
		local myPos = getPlayerPosition( i );
		local pos = getPlayerPosition( playerid );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 50.0 );
		if(check)
		{
			sendPlayerMessage( i, "(CREEK) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 255, 0 );
		}
	}
	log("");
	log("(CREEK) " +getPlayerName( playerid )+ ": " + text);
	log("");
});

addCommandHandler( "w",
function( playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
	local text = "";
		for(local i = 0; i < vargv.len(); i++)
		{
		text = text + " " + vargv[i];
		}
	foreach(i, playername in getPlayers()) 
	{
			
		local myPos = getPlayerPosition( i );
		local pos = getPlayerPosition( playerid );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 3.0 );
		if(check)
		{
			sendPlayerMessage( i, "(WHISPER) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 150 );
		}
	}
	log("");
	log("(WHISPER) " +getPlayerName( playerid )+ ": " + text);
	log("");
});

addCommandHandler( "do",
function( playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
	local text = "";
		for(local i = 0; i < vargv.len(); i++)
		{
		text = text + " " + vargv[i];
		}
	foreach(i, playername in getPlayers()) 
	{
			
		local myPos = getPlayerPosition( i );
		local pos = getPlayerPosition( playerid );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
		if(check)
		{
			sendPlayerMessage( i, "(DO) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 150, 0 );
		}
	}
});

addCommandHandler( "try",
function( playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
	local randomize = random(0,1);
	foreach(i, playername in getPlayers()) 
	{

	local myPos = getPlayerPosition( i );
	local pos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
	if(check)
	{
		local text = "";
		for(local i = 0; i < vargv.len(); i++)
		{
			text = text + " " + vargv[i];
		}
		if(randomize == 1)
		{
			sendPlayerMessage( i, "(TRY) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text + " [Удачно]", 255, 100, 255 );
		}
		else
		{
			sendPlayerMessage( i, "(TRY) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text + " [Неудачно]", 255, 100, 255 );
		}
	}
	}
});

addCommandHandler( "me",
function( playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
	foreach(i, playername in getPlayers()) 
	{

	local myPos = getPlayerPosition( i );
	local pos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
	if(check)
	{
		local text = "";
		for(local i = 0; i < vargv.len(); i++)
		{
		text = text + " " + vargv[i];
		}
		sendPlayerMessage( i, "(ME) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 50, 255 );
		
	}
	}
});

addCommandHandler( "b",
function( playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
	local text = "";
		for(local i = 0; i < vargv.len(); i++)
		{
		text = text + " " + vargv[i];
		}
	foreach(i, playername in getPlayers()) 
	{

		local myPos = getPlayerPosition( i );
		local pos = getPlayerPosition( playerid );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
		if(check)
		{
			sendPlayerMessage( i, "(NonRP) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 150 );	
		}
	}
	log("");
	log("(NonRP) " +getPlayerName( playerid )+ ": " + text);
	log("");
});

//чат админов
addCommandHandler( "a",
function( playerid, ... )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return;
	}
	local text = "";
	for(local i = 0; i < vargv.len(); i++)
	{
		text = text + " " + vargv[i];
	}
	
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
		foreach(i, playername in getPlayers())
		{
			sendPlayerMessage( i, "[ADMIN] " +getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 130, 255, 0 );
		}
		}
});

//чат фракций
addCommandHandler( "r",
function( playerid, ... )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)//копы
		{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
			{
				local text = "";
				for(local i = 0; i < vargv.len(); i++)
				{
				text = text + " " + vargv[i];
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
				{
				sendPlayerMessage( i, "[Radio EBPD] (Стажер) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 150, 255 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 2)
				{
				sendPlayerMessage( i, "[Radio EBPD] (Сержант) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 150, 255 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 3)
				{
				sendPlayerMessage( i, "[Radio EBPD] (Ст.Сержант) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 150, 255 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 4)
				{
				sendPlayerMessage( i, "[Radio EBPD] (Детектив) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 150, 255 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 5)
				{
				sendPlayerMessage( i, "[Radio EBPD] (Капитан) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 150, 255 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 6)
				{
				sendPlayerMessage( i, "[Radio EBPD] (Шериф) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 150, 255 );
				}
			}
		}
		return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2)//медики
		{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2)
			{
				local text = "";
				for(local i = 0; i < vargv.len(); i++)
				{
				text = text + " " + vargv[i];
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
				{
				sendPlayerMessage( i, "[Radio EGH] (Стажер) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 100, 100 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 2)
				{
				sendPlayerMessage( i, "[Radio EGH] (Терапевт) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 100, 100 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 3)
				{
				sendPlayerMessage( i, "[Radio EGH] (Хирург) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 100, 100 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 4)
				{
				sendPlayerMessage( i, "[Radio EGH] (Зам глав.врача) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 100, 100 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 5)
				{
				sendPlayerMessage( i, "[Radio EGH] (Глав.врач) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 255, 100, 100 );
				}
			}
		}
		return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)//армия
		{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)
			{
				local text = "";
				for(local i = 0; i < vargv.len(); i++)
				{
				text = text + " " + vargv[i];
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
				{
				sendPlayerMessage( i, "[Radio AEB] (Рядовой) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 2)
				{
				sendPlayerMessage( i, "[Radio AEB] (Сержант) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 3)
				{
				sendPlayerMessage( i, "[Radio AEB] (Ст.Сержант) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 4)
				{
				sendPlayerMessage( i, "[Radio AEB] (Прапорщик) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 5)
				{
				sendPlayerMessage( i, "[Radio AEB] (Лейтенант) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 6)
				{
				sendPlayerMessage( i, "[Radio AEB] (Капитан) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 7)
				{
				sendPlayerMessage( i, "[Radio AEB] (Майор) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 8)
				{
				sendPlayerMessage( i, "[Radio AEB] (Подполковник) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 9)
				{
				sendPlayerMessage( i, "[Radio AEB] (Полковник) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 10)
				{
				sendPlayerMessage( i, "[Radio AEB] (Генерал Армии ЭБ) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 150, 150, 0 );
				}
			}
		}
		return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)//триада
		{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
			{
				local text = "";
				for(local i = 0; i < vargv.len(); i++)
				{
				text = text + " " + vargv[i];
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
				{
				sendPlayerMessage( i, "[Radio Triada] (Монах) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 200, 0, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 2)
				{
				sendPlayerMessage( i, "[Radio Triada] (Красный шест) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 200, 0, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 3)
				{
				sendPlayerMessage( i, "[Radio Triada] (Веер из белой бумаги) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 200, 0, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 4)
				{
				sendPlayerMessage( i, "[Radio Triada] (Управитель) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 200, 0, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 5)
				{
				sendPlayerMessage( i, "[Radio Triada] (Мастер горы) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 200, 0, 0 );
				}
			}
		}
		return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)//ирландцы
		{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
			{
				local text = "";
				for(local i = 0; i < vargv.len(); i++)
				{
				text = text + " " + vargv[i];
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
				{
				sendPlayerMessage( i, "[Radio Irish] (Динни) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 255, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 2)
				{
				sendPlayerMessage( i, "[Radio Irish] (Мясник младший) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 255, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 3)
				{
				sendPlayerMessage( i, "[Radio Irish] (Мясник) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 255, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 4)
				{
				sendPlayerMessage( i, "[Radio Irish] (Дикий) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 255, 0 );
				}
				if(ini.getKey("PlayerInfo", "rang").tointeger() == 5)
				{
				sendPlayerMessage( i, "[Radio Irish] (Главарь) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ":" + text, 0, 255, 0 );
				}
			}
		}
		return;
		}
		
	}
});

function pay_aeb()
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	//пополнение склада армейцев
	local ini = EasyINI("biz/kazna.ini");
	if(ini.getKey("gans", "aeb_gans").tointeger() < 990000)
	{
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("gans", "aeb_gans", ini.getKey("gans", "aeb_gans").tointeger() + 10000);
		ini.saveData();
	}
	log("");
	log("AEB gans "+ini.getKey("gans", "aeb_gans").tointeger());
	log("EBPD gans "+ini.getKey("gans", "ebpd_gans").tointeger());
	log("Triada gans "+ini.getKey("gans", "triada_gans").tointeger());
	log("Irish gans "+ini.getKey("gans", "irish_gans").tointeger());
	log("");
	log("metal_lit "+ini.getKey("sklad", "metal_lit").tointeger());
	log("metal_jd "+ini.getKey("sklad", "metal_jd").tointeger());
	log("");
	log("scrapm_o "+ini.getKey("bryski", "scrapm_o").tointeger());
	log("scrapm_n "+ini.getKey("bryski", "scrapm_n").tointeger());
	log("");
	log("ob_fish "+ini.getKey("drugs", "ob_fish").tointeger());
	log("no_fish "+ini.getKey("drugs", "no_fish").tointeger());
	log("narko_triada "+ini.getKey("drugs", "narko_triada").tointeger());
	log("money_triada "+ini.getKey("drugs", "money_triada").tointeger());
	log("money_irish "+ini.getKey("irish", "money_irish").tointeger());
	log("");
	
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
			return;
		}
		sendPlayerMessage(i, "===============[Квитанция Банка]================", 0, 255, 0);
	}
}
}

function pay_house()
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
			return;
		}
			//дома
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0 && ini.getKey("PlayerInfo", "house").tointeger() <= 7)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
				{
					local ini = EasyINI("account/"+getPlayerName(i)+".ini");
					ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
					ini.saveData();
					sendPlayerMessage(i, "ЖКХ Дома: -100$");
					
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
					ini.saveData();
				}
				else
				{
					local ini = EasyINI("account/"+getPlayerName(i)+".ini");
					ini.setKey("PlayerInfo", "house", 0);
					ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 15000);
					ini.saveData();
			
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 15000);
					ini.saveData();
			
					sendPlayerMessage(i, "Вашу квартиру продали за не уплату ЖКХ!");
					sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!");
				}
			}
	}
}
}

function pay_biznes()
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
			return;
		}
		//{ком бизнесов(начало)
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#1", "owner", 0);
			ini.setKey("FS#1", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#2", "owner", 0);
			ini.setKey("FS#2", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#3", "owner", 0);
			ini.setKey("FS#3", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#4", "owner", 0);
			ini.setKey("FS#4", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#5", "owner", 0);
			ini.setKey("FS#5", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#6", "owner", 0);
			ini.setKey("FS#6", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#7", "owner", 0);
			ini.setKey("FS#7", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Бизнеса: -100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(i, "Ваш бизнес продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#8", "owner", 0);
			ini.setKey("FS#8", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 900)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 900);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Сети Закусочных: -900$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 900);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 0);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 0);
			ini.saveData();
			
			sendPlayerMessage(i, "Вашу сеть закусочных продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("ED", "owner", 0);
			ini.setKey("ED", "ownername", 0);
			ini.saveData();
			}
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 600)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 600);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Сети Баров: -600$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 600);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 0);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 0);
			ini.saveData();
			
			sendPlayerMessage(i, "Вашу сеть баров продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("BAR", "owner", 0);
			ini.setKey("BAR", "ownername", 0);
			ini.saveData();
			}
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 1200)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 1200);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Сети Автомастерских: -1200$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 1200);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 0);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 0);
			ini.saveData();
			
			sendPlayerMessage(i, "Вашу сеть автомастерских продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("REPAIR", "owner", 0);
			ini.setKey("REPAIR", "ownername", 0);
			ini.saveData();
			}
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 12)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 1100)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - 1100);
				ini.saveData();
				sendPlayerMessage(i, "ЖКХ Сети Магазинов оружия: -1100$");
					
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 1100);
				ini.saveData();
			}
			else
			{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 0);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 0);
			ini.saveData();
			
			sendPlayerMessage(i, "Вашу сеть магазинов оружия продали за не уплату ЖКХ!", 255, 255, 255);
			sendPlayerMessage(i, "Деньги с продажи начисленны на банковский счет!", 255, 255, 255);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "owner", 0);
			ini.setKey("GANS", "ownername", 0);
			ini.saveData();
			}
		}
		//}ком бизнесов(конец)
	}
}
}

function pay_day()
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
			return;
		}
		//{зарплата
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() >= 1 && ini.getKey("PlayerInfo", "fraction").tointeger() <= 3)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 3000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 3000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 3000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 2)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 4000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 4000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 4000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 5000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 5000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 5000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 4)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 6000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 6000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 6000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 5)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 7000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 7000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 7000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 6)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 8000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 8000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 8000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 7)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 9000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 9000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 9000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 8)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 10000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 10000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 10000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 9)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 11000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 11000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 11000);
				ini.saveData();
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 10)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + 12000);
				ini.saveData();
				sendPlayerMessage(i, "На ваш банковский счет переведена зарплата в размере: 12000$");
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12000);
				ini.saveData();
			}
		}
		//}зарплата(конец)
	}
}
}

function pay_bank()
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
			return;
		}
			//оплата штрафа
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= ini.getKey("PlayerInfo", "ticket").tointeger())
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				local shtraf = ini.getKey("PlayerInfo", "ticket").tointeger();
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - shtraf);
				ini.setKey("PlayerInfo", "ticket", 0);
				ini.saveData();
				sendPlayerMessage(i, "Штраф: -" + shtraf + "$", 0, 150, 255);
				
				//прибавка налога к казне
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + shtraf);
				ini.saveData();
			}
			else
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				local shtraf = ini.getKey("PlayerInfo", "ticket").tointeger();
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - shtraf);
				ini.setKey("PlayerInfo", "ticket", 0);
				ini.saveData();
				sendPlayerMessage(i, "Штраф: -" + shtraf + "$", 0, 150, 255);
				sendPlayerMessage(i, "На банковском счете недостаточно средств, оплата произведена с наличных.", 0, 150, 255);
				
				//прибавка налога к казне
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + shtraf);
				ini.saveData();
			}
		
			//налог для жителя + депозит
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= 20)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				sendPlayerMessage(i, "Банковский депозит: " + (ini.getKey("PlayerInfo", "bank").tointeger()*0.05).tointeger() + "$");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + (ini.getKey("PlayerInfo", "bank").tointeger()*0.05).tointeger());
				ini.saveData();
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "bank").tointeger() >= tax)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - tax);
				ini.saveData();
				sendPlayerMessage(i, "Городской налог: -" + tax + "$");
				sendPlayerMessage(i, "Банковский счет: " + ini.getKey("PlayerInfo", "bank").tointeger() + "$");
				
				//прибавка налога к казне
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + tax);
				ini.saveData();
			}
			else
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - tax);
				ini.saveData();
				sendPlayerMessage(i, "Городской налог: -" + tax + "$");
				sendPlayerMessage(i, "Банковский счет: " + ini.getKey("PlayerInfo", "bank").tointeger() + "$");
				sendPlayerMessage(i, "На банковском счете недостаточно средств, оплата произведена с наличных.", 255, 100, 0);
				sendPlayerMessage(i, "Наличные: " + ini.getKey("PlayerInfo", "money").tointeger() + "$");
				
				//прибавка налога к казне
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + tax);
				ini.saveData();
			}
	}
}
}

function pay_exp()
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
			return;
		}
			//прибавка поинта
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			ini.setKey("PlayerInfo", "point", ini.getKey("PlayerInfo", "point").tointeger() + 1);
			sendPlayerMessage(i, "Вы получили 1 EXP");
			ini.saveData();
			
			//сытость > 10
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "satiety").tointeger() >= 10)
			{
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				ini.setKey("PlayerInfo", "satiety", ini.getKey("PlayerInfo", "satiety").tointeger() - 10);
				ini.saveData();
			}
			else
			{
				setPlayerHealth(i, getPlayerHealth(i) - 100.0);
				sendPlayerMessage(i, "Ваша сытость равна нулю, здоровье уменьшилось на 100 ХП", 70, 255, 100);
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			log("");
			log(getPlayerName(i)+" "+ini.getKey("PlayerInfo", "point").tointeger()+" points");
			log("");
	}
}
}

//цены бизнесов
function fs_p()
{
	local ini = EasyINI("biz/biznes.ini");
    fs1_p = ini.getKey("FS#1", "fs_price").tointeger();
	fs2_p = ini.getKey("FS#2", "fs_price").tointeger();
	fs3_p = ini.getKey("FS#3", "fs_price").tointeger();
	fs4_p = ini.getKey("FS#4", "fs_price").tointeger();
	fs5_p = ini.getKey("FS#5", "fs_price").tointeger();
	fs6_p = ini.getKey("FS#6", "fs_price").tointeger();
	fs7_p = ini.getKey("FS#7", "fs_price").tointeger();
	fs8_p = ini.getKey("FS#8", "fs_price").tointeger();
	fs1_bf = ini.getKey("FS#1", "buyfuel").tointeger();
	fs2_bf = ini.getKey("FS#2", "buyfuel").tointeger();
	fs3_bf = ini.getKey("FS#3", "buyfuel").tointeger();
	fs4_bf = ini.getKey("FS#4", "buyfuel").tointeger();
	fs5_bf = ini.getKey("FS#5", "buyfuel").tointeger();
	fs6_bf = ini.getKey("FS#6", "buyfuel").tointeger();
	fs7_bf = ini.getKey("FS#7", "buyfuel").tointeger();
	fs8_bf = ini.getKey("FS#8", "buyfuel").tointeger();
	
	ed_p = ini.getKey("ED", "price").tointeger();
	bar_p = ini.getKey("BAR", "price").tointeger();
	rep_p = ini.getKey("REPAIR", "price").tointeger();
	
	local ini = EasyINI("biz/kazna.ini");
    tax = ini.getKey("CH", "tax").tointeger();
	
	foreach(i, playername in getPlayers()) 
	{
	if(FileExists("account/"+getPlayerName(i)+".ini") == false)
	{
		return;
	}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			local pos = getPlayerPosition( i );
			ini.setKey("PlayerInfo", "hp", getPlayerHealth( i ));
			ini.setKey("PlayerInfo", "spawnx", pos[0]);
			ini.setKey("PlayerInfo", "spawny", pos[1]);
			ini.setKey("PlayerInfo", "spawnz", pos[2]);
			ini.saveData();
		}
	}
}

//патроны игрока
function patroni()
{
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(getPlayerWeapon(i) == 2)
			{
				ini.setKey("gans", "Model_12_Revolver", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 3)
			{
				ini.setKey("gans", "Mauser_C96", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 4)
			{
				ini.setKey("gans", "Colt_M1911A1", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 5)
			{
				ini.setKey("gans", "Colt_M1911_Special", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 6)
			{
				ini.setKey("gans", "Model_19_Revolver", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 8)
			{
				ini.setKey("gans", "Remington_Model_870_Field_gun", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 9)
			{
				ini.setKey("gans", "M3_Grease_Gun", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 10)
			{
				ini.setKey("gans", "MP40", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 11)
			{
				ini.setKey("gans", "Thompson_1928", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 20)
			{
				ini.setKey("gans", "MK2_Frag_Grenade", getPlayerWeaponBullet(i) );
			}
			if(getPlayerWeapon(i) == 21)
			{
				ini.setKey("gans", "Molotov_Cocktail", getPlayerWeaponBullet(i) );
			}
			ini.saveData();				
	}
}

//топливо в тачке
function carfuel()
{
	foreach(i, playername in getPlayers()) 
	{
		if(!isPlayerInVehicle(i))
		{
			return;
		}
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
		local myPos = getPlayerPosition( i );
		local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
		local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
		local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
		local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
		local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
		local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
		local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
		local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );
		if(fuel1 || fuel2 || fuel3 || fuel4 || fuel5 || fuel6 || fuel7 || fuel8)
		{
			return;
		}
		
		local vehicleid = getPlayerVehicle(i);
		local plate = getVehiclePlateText(vehicleid);
		if(FileExists("carnumber/"+plate+".ini"))
		{
			if(getVehicleFuel(vehicleid) < 1)
			{
				local ini = EasyINI("carnumber/"+plate+".ini");
				ini.setKey("car", "fuel", getVehicleFuel(vehicleid));
				ini.saveData();
				setVehicleFuel(vehicleid, 0.0);
				return;
			}
			local ini = EasyINI("carnumber/"+plate+".ini");
			ini.setKey("car", "fuel", getVehicleFuel(vehicleid));
			ini.saveData();
			setVehicleFuel(vehicleid, ini.getKey("car", "fuel").tofloat());
		}
		else
		{
			if(getVehicleFuel(vehicleid) < 1)
			{
				setVehicleFuel(vehicleid, 0.0);
				return;
			}
		
			setVehicleFuel(vehicleid, getVehicleFuel(vehicleid));
		}
	}
}

//погода
function timesever()
{
	foreach(i, playername in getPlayers()) 
	{
	if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(i)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(i)+".ini");
	local money = ini.getKey("PlayerInfo", "money").tostring();
	
	local ini = EasyINI("biz/kazna.ini");
	triggerClientEvent( i, "timeserver_client", ini.getKey("time_sever", "pagoda").tostring(), ini.getKey("time_sever", "pagodamin").tostring(), money);
	
	}
}

function ptimer()
{
local ini = EasyINI("biz/kazna.ini");
if(leto == true)
{
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	
	if(ini.getKey("time_sever", "pagoda").tointeger() == 23)
	{
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("time_sever", "pagoda", 0);
		ini.saveData();
		setWeather( "DT_RTRclear_day_night" );
		sendPlayerMessageToAll( "Время сервера 0:00", 255, 255, 130 );
		log("");
		log( "Time " +ini.getKey("time_sever", "pagoda").tointeger()+ ":00" );
		return;
	}
	
	ini.setKey("time_sever", "pagoda", ini.getKey("time_sever", "pagoda").tointeger()+1);
	ini.saveData();
	log( "Time " + ini.getKey("time_sever", "pagoda").tointeger() +":00" );
	
	if(ini.getKey("time_sever", "pagoda").tointeger() == 1)
	{
		setWeather( "DTFreerideNight" );
		sendPlayerMessageToAll( "Время сервера 1:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 2)
	{
		setWeather( "DT14part11" );
		sendPlayerMessageToAll( "Время сервера 2:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 3)
	{
		setWeather( "DT_RTRfoggy_day_night" );//туман
		sendPlayerMessageToAll( "Время сервера 3:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 4)
	{
		setWeather( "DT_RTRclear_day_early_morn1" );
		sendPlayerMessageToAll( "Время сервера 4:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 5)
	{
		setWeather( "DT_RTRrainy_day_early_morn" );//дождь
		sendPlayerMessageToAll( "Время сервера 5:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 6)
	{
		setWeather( "DT_RTRclear_day_early_morn2" );
		sendPlayerMessageToAll( "Время сервера 6:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 7)
	{
		setWeather( "DT_RTRrainy_day_morning" );//дождь
		sendPlayerMessageToAll( "Время сервера 7:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 8)
	{
		setWeather( "DT_RTRfoggy_day_morning" );//туман
		sendPlayerMessageToAll( "Время сервера 8:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 9)
	{
		setWeather( "DT_RTRclear_day_morning" );
		sendPlayerMessageToAll( "Время сервера 9:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 10)
	{
		setWeather( "DT06part03" );
		sendPlayerMessageToAll( "Время сервера 10:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 11)
	{
		setWeather( "DT07part01fromprison" );
		sendPlayerMessageToAll( "Время сервера 11:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 12)
	{
		setWeather( "DT07part02dereksubquest" );
		sendPlayerMessageToAll( "Время сервера 12:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 13)
	{
		setWeather( "DT_RTRclear_day_afternoon" );
		sendPlayerMessageToAll( "Время сервера 13:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 14)
	{
		setWeather( "DT09part4MalteseFalcone2" );
		sendPlayerMessageToAll( "Время сервера 14:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 15)
	{
		setWeather( "DT08part02cigarettesmill" );
		sendPlayerMessageToAll( "Время сервера 15:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 16)
	{
		setWeather( "DT13part02" );
		sendPlayerMessageToAll( "Время сервера 16:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 17)
	{
		setWeather( "DT_RTRrainy_day_late_afternoon" );//дождь
		sendPlayerMessageToAll( "Время сервера 17:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 18)
	{
		setWeather( "DT08part03crazyhorse" );
		sendPlayerMessageToAll( "Время сервера 18:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 19)
	{
		setWeather( "DT_RTRfoggy_day_evening" );//туман
		sendPlayerMessageToAll( "Время сервера 19:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 20)
	{
		setWeather( "DT_RTRclear_day_evening" );
		sendPlayerMessageToAll( "Время сервера 20:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 21)
	{
		setWeather( "DT11part04" );//дождь
		sendPlayerMessageToAll( "Время сервера 21:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 22)
	{
		setWeather( "DT08part04subquestwarning" );
		sendPlayerMessageToAll( "Время сервера 22:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 23)
	{
		setWeather( "DT_RTRclear_day_late_even" );
		sendPlayerMessageToAll( "Время сервера 23:00", 255, 255, 130 );
		return;
	}

return;
}
}
else
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0)
{
	if(ini.getKey("time_sever", "pagoda").tointeger() == 23)
	{
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("time_sever", "pagoda", 0);
		ini.saveData();
		setWeather( "DTFreeRideNightSnow" );
		sendPlayerMessageToAll( "Время сервера 0:00", 255, 255, 130 );
		log("");
		log( "Time " +ini.getKey("time_sever", "pagoda").tointeger()+ ":00" );
		return;
	}
	
    ini.setKey("time_sever", "pagoda", ini.getKey("time_sever", "pagoda").tointeger()+1);
	ini.saveData();
	log( "Time " + ini.getKey("time_sever", "pagoda").tointeger() +":00" );
	
	if(ini.getKey("time_sever", "pagoda").tointeger() == 1)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 1:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 2)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 2:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 3)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 3:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 4)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 4:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 5)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 5:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 6)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 6:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 7)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 7:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 8)
	{
		setWeather( "DT04part02" );
		sendPlayerMessageToAll( "Время сервера 8:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 9)
	{
		setWeather( "DT05part01JoesFlat" );
		sendPlayerMessageToAll( "Время сервера 9:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 10)
	{
		setWeather( "DT03part01JoesFlat" );
		sendPlayerMessageToAll( "Время сервера 10:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 11)
	{
		setWeather( "DTFreeRideDaySnow" );
		sendPlayerMessageToAll( "Время сервера 11:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 12)
	{
		setWeather( "DT05part02FreddysBar" );
		sendPlayerMessageToAll( "Время сервера 12:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 13)
	{
		setWeather( "DT05part04Distillery" );//туман
		sendPlayerMessageToAll( "Время сервера 13:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 14)
	{
		setWeather( "DT04part01JoesFlat" );//туман
		sendPlayerMessageToAll( "Время сервера 14:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 15)
	{
		setWeather( "DT02part01Railwaystation" );
		sendPlayerMessageToAll( "Время сервера 15:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 16)
	{
		setWeather( "DT02part02JoesFlat" );
		sendPlayerMessageToAll( "Время сервера 16:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 17)
	{
		setWeather( "DT02part04Giuseppe" );
		sendPlayerMessageToAll( "Время сервера 17:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 18)
	{
		setWeather( "DT05Distillery_inside" );
		sendPlayerMessageToAll( "Время сервера 18:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 19)
	{
		setWeather( "DT02part03Charlie" );//туман
		sendPlayerMessageToAll( "Время сервера 19:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 20)
	{
		setWeather( "DT05Distillery_inside" );//туман
		sendPlayerMessageToAll( "Время сервера 20:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 21)
	{
		setWeather( "DT02part05Derek" );
		sendPlayerMessageToAll( "Время сервера 21:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 22)
	{
		setWeather( "DT02NewStart1" );
		sendPlayerMessageToAll( "Время сервера 22:00", 255, 255, 130 );
		return;
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 23)
	{
		setWeather( "DT03part04PriceOffice" );
		sendPlayerMessageToAll( "Время сервера 23:00", 255, 255, 130 );
		return;
	}
}
return;	
}

}

function pmin()
{
local ini = EasyINI("biz/kazna.ini");
	if(ini.getKey("time_sever", "pagodamin").tointeger() == 59)
	{
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("time_sever", "pagodamin", 0);
		ini.saveData();
		return;
	}
	
	ini.setKey("time_sever", "pagodamin", ini.getKey("time_sever", "pagodamin").tointeger()+1);
	ini.saveData();
}

//курс предметов
function kyrs()
{
local ini = EasyINI("biz/kazna.ini");
if(ini.getKey("time_sever", "pagodamin").tointeger() == 0 || ini.getKey("time_sever", "pagodamin").tointeger() == 30)
{
	local ini = EasyINI("biz/kazna.ini");
	ini.setKey("kyrs", "kyrs_metallolom", random(1,10));
	ini.setKey("kyrs", "kyrs_fish", random(1,10));
	ini.setKey("kyrs", "kyrs_metal", random(1,10));
	ini.setKey("kyrs", "kyrs_meat", random(1,10));
	ini.setKey("kyrs", "kyrs_tovar", random(1,10));
	ini.setKey("kyrs", "kyrs_prod", random(1,10));
	ini.setKey("kyrs", "kyrs_alco", random(1,10));
	ini.setKey("kyrs", "kyrs_parts", random(1,10));
	ini.saveData();
	
	log("");
	log("kyrs_metallolom " + ini.getKey("kyrs", "kyrs_metallolom").tointeger() );
	log("kyrs_metal " + ini.getKey("kyrs", "kyrs_metal").tointeger() );
	log("kyrs_meat " + ini.getKey("kyrs", "kyrs_meat").tointeger() );
	log("kyrs_fish " + ini.getKey("kyrs", "kyrs_fish").tointeger() );
	log("kyrs_tovar " + ini.getKey("kyrs", "kyrs_tovar").tointeger() );
	log("kyrs_prod " + ini.getKey("kyrs", "kyrs_prod").tointeger() );
	log("kyrs_alco " + ini.getKey("kyrs", "kyrs_alco").tointeger() );
	log("kyrs_parts " + ini.getKey("kyrs", "kyrs_parts").tointeger() );
	log("");
	
	sendPlayerMessageToAll("==================[НОВОСТИ]==================", 100, 255, 0);
	sendPlayerMessageToAll("На сервере обновился курс!", 100, 255, 0);
	col_wanted = 0;
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
			return sendPlayerMessageToAll("Нераскрытых дел EBPD: " +col_wanted, 0, 150, 255);
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		col_wanted = col_wanted + ini.getKey("PlayerInfo", "wanted").tointeger();
	}
	sendPlayerMessageToAll("Нераскрытых дел EBPD: " +col_wanted, 0, 150, 255);
}
}

addCommandHandler( "course",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
	local ini = EasyINI("biz/kazna.ini");
	sendPlayerMessage(playerid, "===================[КУРС]====================", 255, 255, 0);
	sendPlayerMessage( playerid, "Курс металлолома: " + ini.getKey("kyrs", "kyrs_metallolom").tointeger() +"$ за штуку." );
	sendPlayerMessage( playerid, "Курс металла: " + ini.getKey("kyrs", "kyrs_metal").tointeger() +"$ за штуку.");
	sendPlayerMessage( playerid, "Курс мяса: " + ini.getKey("kyrs", "kyrs_meat").tointeger() +"$ за кг.");
	sendPlayerMessage( playerid, "Курс рыбы: " + ini.getKey("kyrs", "kyrs_fish").tointeger() +"$ за кг.");
	sendPlayerMessage( playerid, "Курс канцтоваров: " + ini.getKey("kyrs", "kyrs_tovar").tointeger() +"$ за штуку.");
	sendPlayerMessage( playerid, "Курс продуктов: " + ini.getKey("kyrs", "kyrs_prod").tointeger() +"$ за штуку.");
	sendPlayerMessage( playerid, "Курс алкоголя: " + ini.getKey("kyrs", "kyrs_alco").tointeger() +"$ за бутылку.");
	sendPlayerMessage( playerid, "Курс запчастей: " + ini.getKey("kyrs", "kyrs_parts").tointeger() +"$ за деталь.");
});

function scriptInit()
{
	local rTimer = timer( pmin, 60000, -1 );//игровые минуты 60 сек 000 мсек
	local rTimer = timer( ptimer, 60000, -1 );//игровые минуты 60 сек 000 мсек
	
	local rTimer = timer( kyrs, 60000, -1 );//курс 1 800 сек 000 мсек
	
	local paytimer = timer( pay_aeb, 60000, -1 );//пополнение патронов у армейцев
	local paytimer = timer( pay_house, 60000, -1 );//жкх дома
	local paytimer = timer( pay_biznes, 60000, -1 );//жкх бизнеса
	local paytimer = timer( pay_day, 60000, -1 );//зарплата
	local paytimer = timer( pay_bank, 60000, -1 );//налог + депозит
	local paytimer = timer( pay_exp, 60000, -1 );//сытость + exp
	
	local rTimer = timer( fs_p, 10000, -1 );//инфа цен заправок
	local rTimer = timer( patroni, 10000, -1 );//инфа патронов игрока
	local rTimer = timer( timesever, 10000, -1 );//инфа времени и денег
	
	log( script + " Loaded!" );
	setGameModeText( "vk.com/qrp_m2" );
	setMapName( "Empire Bay" );
	setSummer(leto);
	
	//176 blips
	//фракции
	createBlip( -378.987,654.699, 24, 0 );//копы
	createBlip( -1539.16,-369.083, 22, 0 );//армия
	createBlip( -393.265,905.334, 0, 5 );//госпиталь
	createBlip( -115.11,-63.1035, 23, 0 );//мерия //4
	
	//места
	createBlip( 67.2002,-202.94, 0, 4 );//ск
	createBlip( 67.2002,-202.94, 10, 0 );//банк
	createBlip( -82.6162,1739.23, 0, 4 );//ск
	createBlip( -82.6162,1739.23, 3, 0 );//бруски
	createBlip( -199.473,838.605, 21, 0 );//магазин авто
	createBlip( 563.661,815.934, 0, 4 );//ск 
	createBlip( 563.661,815.934, 8, 0 );//car rental
	createBlip( 32.7456,-411.533, 0, 4 );//ск
	createBlip( 32.7456,-411.533, 7, 0 );//механики
	createBlip( 82.3064,889.32, 25, 0 );//бордель //10
	
	//заправки
	createBlip( 338.758,875.07, 0, 4 );//ск
	createBlip( 338.758,875.07, 9, 0 );//fs1
	createBlip( -710.287,1762.62, 0, 4 );//ск
	createBlip( -710.287,1762.62, 9, 0 );//fs2 
	createBlip( -1592.31,942.639, 0, 4 );//ск
	createBlip( -1592.31,942.639, 9, 0 );//fs3
	createBlip( -1679.5,-232.035, 0, 4 );//ск
	createBlip( -1679.5,-232.035, 9, 0 );//fs4
	createBlip( -629.5,-48.7479, 0, 4 );//ск
	createBlip( -629.5,-48.7479, 9, 0 );//fs5
	createBlip( -150.096,610.258, 0, 4 );//ск
	createBlip( -150.096,610.258, 9, 0 );//fs6
	createBlip( 112.687,181.302, 0, 4 );//ск
	createBlip( 112.687,181.302, 9, 0 );//fs7 
	createBlip( 547.921,2.62598, 0, 4 );//ск
	createBlip( 547.921,2.62598, 9, 0 );//fs8 //16
	
	//дома
	createBlip( 332.879,-367.105, 0, 4 );//ск
	createBlip( 332.879,-367.105, 6, 0 );
	createBlip( 463.927,-367.105, 0, 4 );//ск
	createBlip( 463.927,-367.105, 6, 0 );
	createBlip( 529.554,-367.105, 0, 4 );//ск
	createBlip( 529.554,-367.105, 6, 0 );
	createBlip( 529.605,-441.29, 0, 4 );//ск
	createBlip( 529.605,-441.29, 6, 0 ); 
	createBlip( 463.605,-441.29, 0, 4 );//ск
	createBlip( 463.605,-441.29, 6, 0 );
	createBlip( 397.605,-441.29, 0, 4 );//ск
	createBlip( 397.605,-441.29, 6, 0 );
	createBlip( 331.605,-441.29, 0, 4 );//ск
	createBlip( 331.605,-441.29, 6, 0 ); //14
	
	//subway
	createBlip( -554.36,1592.92, 0, 12 );
	createBlip( -1119.15,1376.71, 0, 12 );
	createBlip( -1535.55,-231.03, 0, 12 );
	createBlip( -511.412,20.1703, 0, 12 ); 
	createBlip( -113.792,-481.71, 0, 12 );
	createBlip( 234.395,380.914, 0, 12 );
	createBlip( -293.069,568.25, 0, 12 ); //7
	
	//желтые круги
	createBlip( 1281.56,1290.69, 0, 2 );//склад литейка
	createBlip( 673.996,127.642, 0, 2 );//склад жд //2
	
	//работы звезды
	createBlip( -350.47,-726.813, 0, 3 );//доставщик сигарет
	createBlip( -396.188,-692.02, 0, 3 );//докер
	createBlip( -422.731,479.451, 0, 3 );//автобусник
	createBlip( 528.999,-249.552, 0, 3 );//развозчик топлива
	createBlip( 763.599,802.343, 0, 3 );//водитель 
	createBlip( 389.846,125.266, 0, 3 );//рыбзавод //6
	
	//закусочные
	createBlip( -561.204,428.753, 0, 4 );//ск
	createBlip( -561.204,428.753, 1, 0 );//
	createBlip( -771.518,-377.324, 0, 4 );//ск
	createBlip( -771.518,-377.324, 1, 0 );//
	createBlip( 142.323,-429.708, 0, 4 );//ск
	createBlip( 142.323,-429.708, 1, 0 );//
	createBlip( 240.014,709.032, 0, 4 );//ск
	createBlip( 240.014,709.032, 1, 0 );//
	createBlip( -645.378,1296.42, 0, 4 );//ск 
	createBlip( -645.378,1296.42, 1, 0 );//
	createBlip( -1582.64,1603.77, 0, 4 );//ск
	createBlip( -1582.64,1603.77, 1, 0 );//
	createBlip( -1420.38,961.175, 0, 4 );//ск
	createBlip( -1420.38,961.175, 1, 0 );//
	createBlip( -1588.62,177.321, 0, 4 );//ск
	createBlip( -1588.62,177.321, 1, 0 );//
	createBlip( -1559.15,-165.144, 0, 4 );//ск
	createBlip( -1559.15,-165.144, 1, 0 );// 18
	
	//работы звезды
	createBlip( 14.0464,1809.85, 0, 3 );//мясокобинат //1
	
	//бары
	createBlip( -1384.92,470.174, 0, 4 );//ск
	createBlip( -1384.92,470.174, 11, 0 );//
	createBlip( 627.621,897.018, 0, 4 );//ск
	createBlip( 627.621,897.018, 11, 0 );//
	createBlip( -51.0424,737.98, 0, 4 );//ск
	createBlip( -51.0424,737.98, 11, 0 );//
	createBlip( -639.003,349.621, 0, 4 );//ск
	createBlip( -639.003,349.621, 11, 0 );//
	createBlip( 21.2379,-76.4079, 0, 4 );//ск 
	createBlip( 21.2379,-76.4079, 11, 0 );// 
	createBlip( -1148.88,1589.7, 0, 4 );//ск 
	createBlip( -1148.88,1589.7, 11, 0 );// //12
	
	//мастерские
	createBlip( -1583.81,68.6026, 0, 4 );//ск
	createBlip( -1583.81,68.6026, 14, 0 );//
	createBlip( -1438.92,1379.93, 0, 4 );//ск 
	createBlip( -1438.92,1379.93, 14, 0 );//
	createBlip( -375.957,1735.39, 0, 4 );//ск
	createBlip( -375.957,1735.39, 14, 0 );//
	createBlip( 425.711,780.516, 0, 4 );//ск
	createBlip( 425.711,780.516, 14, 0 );//
	createBlip( -120.967,529.571, 0, 4 );//ск
	createBlip( -120.967,529.571, 14, 0 );//
	createBlip( -282.268,701.517, 0, 4 );//ск
	createBlip( -282.268,701.517, 14, 0 );//
	createBlip( -687.197,188.526, 0, 4 );//ск 
	createBlip( -687.197,188.526, 14, 0 );//
	createBlip( -69.189,203.758, 0, 4 );//ск
	createBlip( -69.189,203.758, 14, 0 );//
	createBlip( 285.353,296.706, 0, 4 );//ск
	createBlip( 285.353,296.706, 14, 0 );//
	createBlip( 553.497,-122.346, 0, 4 );//ск
	createBlip( 553.497,-122.346, 14, 0 );//
	createBlip( 719.397,-446.142, 0, 4 );//ск
	createBlip( 719.397,-446.142, 14, 0 );//
	createBlip( 49.0399,-405.637, 0, 4 );//ск 
	createBlip( 49.0399,-405.637, 14, 0 );// //24
	
	createBlip( -1152.22,1531.89, 0, 10 );//ирландцы
	createBlip( 341.525,346.108, 26, 0 );//триада
	createBlip( -254.01,-129.645, 0, 9 );//казино //3
	
	//будки
	createBlip( -310.857,1694.88, 0, 4 );//ск
	createBlip( -310.857,1694.88, 12, 0 );//
	createBlip( -1170.57,1578.15, 0, 4 );//ск
	createBlip( -1170.57,1578.15, 12, 0 );// 
	createBlip( -1654.61,1143.06, 0, 4 );//ск
	createBlip( -1654.61,1143.06, 12, 0 );//
	createBlip( -1562.38,527.787, 0, 4 );//ск
	createBlip( -1562.38,527.787, 12, 0 );//
	createBlip( -1421.31,-191.48, 0, 4 );//ск
	createBlip( -1421.31,-191.48, 12, 0 );//
	createBlip( -147.053,-595.967, 0, 4 );//ск
	createBlip( -147.053,-595.967, 12, 0 );//
	createBlip( 283.082,-388.371, 0, 4 );//ск
	createBlip( 283.082,-388.371, 12, 0 );// 
	createBlip( 747.74,7.80397, 0, 4 );//ск
	createBlip( 747.74,7.80397, 12, 0 );//
	createBlip( -208.633,-45.6014, 0, 4 );//ск
	createBlip( -208.633,-45.6014, 12, 0 );//
	createBlip( -584.811,89.4905, 0, 4 );//ск
	createBlip( -584.811,89.4905, 12, 0 );//
	createBlip( -78.6843,233.494, 0, 4 );//ск
	createBlip( -78.6843,233.494, 12, 0 );//
	createBlip( 250.26,494.087, 0, 4 );//ск
	createBlip( 250.26,494.087, 12, 0 );// 
	createBlip( 612.189,845.402, 0, 4 );//ск
	createBlip( 612.189,845.402, 12, 0 );//
	createBlip( 112.488,847.435, 0, 4 );//ск
	createBlip( 112.488,847.435, 12, 0 );//
	createBlip( -508.688,910.919, 0, 4 );//ск
	createBlip( -508.688,910.919, 12, 0 );//
	createBlip( 139.371,1226.68, 0, 4 );//ск
	createBlip( 139.371,1226.68, 12, 0 );// //32
	
	//магазины оружия
	createBlip( -592.593,500.991, 0, 4 );//ск
	createBlip( -592.593,500.991, 4, 0 );//
	createBlip( -567.724,310.701, 0, 4 );//ск
	createBlip( -567.724,310.701, 4, 0 );//
	createBlip( -10.54,739.379, 0, 4 );//ск
	createBlip( -10.54,739.379, 4, 0 );//
	createBlip( 404.657,603.754, 0, 4 );//ск
	createBlip( 404.657,603.754, 4, 0 );//
	createBlip( 68.0516,139.778, 0, 4 );//ск
	createBlip( 68.0516,139.778, 4, 0 );//
	createBlip( 279.78,-118.507, 0, 4 );//ск
	createBlip( 279.78,-118.507, 4, 0 );//
	createBlip( 273.826,-454.45, 0, 4 );//ск
	createBlip( 273.826,-454.45, 4, 0 );//
	createBlip( -323.407,-589.106, 0, 4 );//ск
	createBlip( -323.407,-589.106, 4, 0 );//
	createBlip( -1394.73,-32.7772, 0, 4 );//ск
	createBlip( -1394.73,-32.7772, 4, 0 );//
	createBlip( -1183.09,1706.26, 0, 4 );//ск
	createBlip( -1183.09,1706.26, 4, 0 );//
	createBlip( -288.036,1627.6, 0, 4 );//ск
	createBlip( -288.036,1627.6, 4, 0 );// //22
	
	//аренда жд вокзал
	createBlip( -531.016,1592.03, 0, 4 );//ск
	createBlip( -531.016,1592.03, 8, 0 );//car rental
	createBlip( 117.791,-58.7411, 0, 3 );//доставщик оружия 
	createBlip( -252.324,-79.688, 0, 4 );//
	createBlip( -252.324,-79.688, 2, 0 );//одежда //5
	
	log("");
	local ini = EasyINI("biz/biznes.ini");
	log( "FS#1 " + ini.getKey("FS#1", "fs_price").tointeger() + " price " + ini.getKey("FS#1", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#1", "fs_money").tointeger() + "$ " + ini.getKey("FS#1", "fs_tanker").tointeger() + " Loaded!");
	log( "FS#2 " + ini.getKey("FS#2", "fs_price").tointeger() + " price " + ini.getKey("FS#2", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#2", "fs_money").tointeger() + "$ " + ini.getKey("FS#2", "fs_tanker").tointeger() + " Loaded!");
	log( "FS#3 " + ini.getKey("FS#3", "fs_price").tointeger() + " price " + ini.getKey("FS#3", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#3", "fs_money").tointeger() + "$ " + ini.getKey("FS#3", "fs_tanker").tointeger() + " Loaded!");
	log( "FS#4 " + ini.getKey("FS#4", "fs_price").tointeger() + " price " + ini.getKey("FS#4", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#4", "fs_money").tointeger() + "$ " + ini.getKey("FS#4", "fs_tanker").tointeger() + " Loaded!");
	log( "FS#5 " + ini.getKey("FS#5", "fs_price").tointeger() + " price " + ini.getKey("FS#5", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#5", "fs_money").tointeger() + "$ " + ini.getKey("FS#5", "fs_tanker").tointeger() + " Loaded!");
	log( "FS#6 " + ini.getKey("FS#6", "fs_price").tointeger() + " price " + ini.getKey("FS#6", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#6", "fs_money").tointeger() + "$ " + ini.getKey("FS#6", "fs_tanker").tointeger() + " Loaded!");
	log( "FS#7 " + ini.getKey("FS#7", "fs_price").tointeger() + " price " + ini.getKey("FS#7", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#7", "fs_money").tointeger() + "$ " + ini.getKey("FS#7", "fs_tanker").tointeger() + " Loaded!");
	log( "FS#8 " + ini.getKey("FS#8", "fs_price").tointeger() + " price " + ini.getKey("FS#8", "buyfuel").tointeger() + " buyfuel " + ini.getKey("FS#8", "fs_money").tointeger() + "$ " + ini.getKey("FS#8", "fs_tanker").tointeger() + " Loaded!");
	log("");
	log( "ED " + ini.getKey("ED", "price").tointeger() + " price " + ini.getKey("ED", "money").tointeger() + "$ " + ini.getKey("ED", "prod").tointeger() + " Loaded!");
	log( "BAR " + ini.getKey("BAR", "price").tointeger() + " price " + ini.getKey("BAR", "money").tointeger() + "$ " + ini.getKey("BAR", "prod").tointeger() + " Loaded!");
	log( "REPAIR " + ini.getKey("REPAIR", "price").tointeger() + " price " + ini.getKey("REPAIR", "money").tointeger() + "$ " + ini.getKey("REPAIR", "prod").tointeger() + " Loaded!");
	log( "GANS " + ini.getKey("GANS", "money").tointeger() + "$ " + ini.getKey("GANS", "prod").tointeger() + " Loaded!");
	log("");
	
	local ini = EasyINI("biz/kazna.ini");
	log("AEB gans "+ini.getKey("gans", "aeb_gans").tointeger());
	log("EBPD gans "+ini.getKey("gans", "ebpd_gans").tointeger());
	log("Triada gans "+ini.getKey("gans", "triada_gans").tointeger());
	log("Irish gans "+ini.getKey("gans", "irish_gans").tointeger());
	log("");
	
	local ini = EasyINI("biz/kazna.ini");
    log( "Kazna " + ini.getKey("CH", "kazna").tointeger() + " Tax " + ini.getKey("CH", "tax").tointeger());
	log("");
}
addEventHandler( "onScriptInit", scriptInit );

//конект
function playerConnect( playerid, name, ip, serial )
{
	log("");
	log(getPlayerName( playerid )+ " serial: " +serial);
	log("");
	
	if(FileExists("banserial/"+getPlayerSerial(playerid)+".ini"))
	{
		kickPlayer( playerid );
		log("");
		log(getPlayerName( playerid )+ " KICK ZA SERIAL");
		log("");
		return;
	}
	
	sendPlayerMessage(playerid, "Добро пожаловать на Empire Bay Multiplayer RolePlay!", 0, 255, 255);
	sendPlayerMessage(playerid, "Используйте команду /help (1-2), чтобы получить информацию.", 0, 255, 255);
	sendPlayerMessage(playerid, "Зарегистрируйтесь /register (пароль),", 0, 255, 255);
	sendPlayerMessage(playerid, "а потом войдите /login (пароль)", 0, 255, 255);
	sendPlayerMessage(playerid, "Вы не сможете двигаться пока не войдете.", 0, 255, 255);
	sendPlayerMessage(playerid, "Удачной игры.", 0, 255, 255);
	sendPlayerMessage(playerid, "Пример правильного ника Paolo_Ricchi", 0, 255, 255);
	
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	ini.setKey("PlayerInfo", "carplayer_id", 0);
	ini.setKey("PlayerInfo", "carrental", 0);
	ini.setKey("PlayerInfo", "logged", 0);
	ini.setKey("PlayerInfo", "tie_p", 0);
	ini.setKey("PlayerInfo", "vehicle_p", 0);
	ini.setKey("PlayerInfo", "car_p", 0);
	ini.setKey("PlayerInfo", "car_id", 0);
	ini.setKey("PlayerInfo", "taizer", 0);
	ini.saveData();
}
addEventHandler( "onPlayerConnect", playerConnect );

//дисконект
function playerDisconnect( playerid, reason )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "carplayer_id", 0);
			ini.setKey("PlayerInfo", "logged", 0);
			ini.setKey("PlayerInfo", "tie_p", 0);
			ini.setKey("PlayerInfo", "vehicle_p", 0);
			ini.setKey("PlayerInfo", "car_p", 0);
			ini.setKey("PlayerInfo", "car_id", 0);
			ini.setKey("PlayerInfo", "taizer", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "carrental").tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "carrental", 0);
				ini.saveData();
				cr.Kill();
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "prisontimer").tointeger() >= 1)
			{
				prisontimer.Kill();
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job_timer").tointeger() > 0)
			{
				job_timer.Kill();
			}
		}

}
addEventHandler( "onPlayerDisconnect", playerDisconnect );

//спавн игрока
function playerSpawn( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		togglePlayerControls(playerid, true);
		setPlayerPosition( playerid, 500.0, 1000.0, 5.0 );// 500.0, 1000.0, 20.0
		setPlayerHealth( playerid, 1000.0 );
		setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
		triggerClientEvent( playerid, "deshudtimer", "" );
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{	
		togglePlayerControls(playerid, true);
		setPlayerPosition( playerid, 500.0, 1000.0, 5.0 );// 500.0, 1000.0, 20.0
		setPlayerHealth( playerid, 1000.0 );
		setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
		triggerClientEvent( playerid, "deshudtimer", "" );
		return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "prison").tointeger() == 1)//посадка в тюрьму если сдох в наручниках
		{
			prisontimer = timer(zona, 60000, -1, playerid);
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "prisontimer", 11);
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.setKey("PlayerInfo", "prison", 0);
			ini.saveData();
			
			setPlayerPosition( playerid, -1030.42,1712.74,10.3595 );
			setPlayerHealth( playerid, 1000.0 );
			setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
			setPlayerModel( playerid, 15);
			
			sendPlayerMessage(playerid, "Вас посадили в тюрьму на 10 минут.", 255, 255, 0 );
			triggerClientEvent( playerid, "deshudtimer", "" );
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "wanted_lvl").tointeger() == 2)//посадка в тюрьму если сдох с 2 звездами
		{
			prisontimer = timer(zona, 60000, -1, playerid);
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "prisontimer", 21);
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.setKey("PlayerInfo", "wanted_lvl", 0);
			ini.saveData();
			
			setPlayerPosition( playerid, -1030.42,1712.74,10.3595 );
			setPlayerHealth( playerid, 1000.0 );
			setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
			setPlayerModel( playerid, 15);
			
			sendPlayerMessage(playerid, "Вас посадили в тюрьму на 20 минут.", 255, 255, 0 );
			triggerClientEvent( playerid, "deshudtimer", "" );
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "wanted_lvl").tointeger() == 3)//посадка в тюрьму если сдох с 3 звездами
		{
			prisontimer = timer(zona, 60000, -1, playerid);
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "prisontimer", 31);
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.setKey("PlayerInfo", "wanted_lvl", 0);
			ini.saveData();
			
			setPlayerPosition( playerid, -1030.42,1712.74,10.3595 );
			setPlayerHealth( playerid, 1000.0 );
			setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
			setPlayerModel( playerid, 15);
			
			sendPlayerMessage(playerid, "Вас посадили в тюрьму на 30 минут.", 255, 255, 0 );
			triggerClientEvent( playerid, "deshudtimer", "" );
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "wanted_lvl").tointeger() == 4)//посадка в тюрьму если сдох с 4 звездами
		{
			prisontimer = timer(zona, 60000, -1, playerid);
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "prisontimer", 41);
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.setKey("PlayerInfo", "wanted_lvl", 0);
			ini.saveData();
			
			setPlayerPosition( playerid, -1030.42,1712.74,10.3595 );
			setPlayerHealth( playerid, 1000.0 );
			setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
			setPlayerModel( playerid, 15);
			
			sendPlayerMessage(playerid, "Вас посадили в тюрьму на 40 минут.", 255, 255, 0 );
			triggerClientEvent( playerid, "deshudtimer", "" );
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "prisontimer").tointeger() >= 2)//посадка в тюрьму если здох в тюрьме
		{	
			setPlayerPosition( playerid, -1030.42,1712.74,10.3595 );
			setPlayerHealth( playerid, 1000.0 );
			triggerClientEvent( playerid, "deshudtimer", "" );
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)
		{
			setPlayerPosition( playerid, -1578.96,-323.928,-20.3172 );
			setPlayerHealth( playerid, 1000.0 );
			setPlayerRotation( playerid, 0.0, 0.0, 90.0 );
			
			sendPlayerMessage(playerid, "Вы потеряли сознание.", 255, 255, 0 );
			sendPlayerMessage(playerid, "Вас нашли медики и привели в казарму.", 255, 255, 0);
			triggerClientEvent( playerid, "deshudtimer", "" );
			return;
		}
		
			setPlayerPosition( playerid, -393.265,905.334,-20.0026 );
			setPlayerHealth( playerid, 1000.0 );
			setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
			
			sendPlayerMessage(playerid, "Вы потеряли сознание.", 255, 255, 0 );
			sendPlayerMessage(playerid, "Вас нашли медики и привезли в больницу.", 255, 255, 0);
			triggerClientEvent( playerid, "deshudtimer", "" );
			
		return;
	}
}
addEventHandler( "onPlayerSpawn", playerSpawn );

//смерть
function playerDeath( playerid, killerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		togglePlayerControls(playerid, false);
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		togglePlayerControls(playerid, false);
		return;
	}
	
	togglePlayerControls(playerid, false);
	if( killerid != INVALID_ENTITY_ID )
	{
        sendPlayerMessage(playerid,"Вас убил " + getPlayerName( killerid ), 255, 255, 0 );
		sendPlayerMessage(killerid,"Вы убили " + getPlayerName( playerid ), 255, 255, 0 );
		
		local ini = EasyINI("account/"+getPlayerName(killerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() != 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() != 1)
		{
			sendPlayerMessage(killerid, "На вас завели уголовное дело.", 0, 150, 255);
			local ini = EasyINI("account/"+getPlayerName(killerid)+".ini");
			ini.setKey("PlayerInfo", "wanted", ini.getKey("PlayerInfo", "wanted").tointeger() + 1);
			ini.saveData();
		}
		
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 11 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1000)
			{
				local ini = EasyINI("account/"+getPlayerName(killerid)+".ini");
				if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
				{
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() + 1000);
					ini.saveData();
					
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "job_p", 0);
					ini.saveData();
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsloadgans", "" );
					sendPlayerMessage(playerid, "Вы потеряли патроны езжайте на загрузку заново.", 255, 255, 0);
					
					sendPlayerMessage(killerid, "Вы украли 1000 патронов.", 255, 255, 0);
					return;
				}
				local ini = EasyINI("account/"+getPlayerName(killerid)+".ini");
				if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
				{
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() + 1000);
					ini.saveData();
					
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "job_p", 0);
					ini.saveData();
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsloadgans", "" );
					sendPlayerMessage(playerid, "Вы потеряли патроны езжайте на загрузку заново.", 255, 255, 0);
					
					sendPlayerMessage(killerid, "Вы украли 1000 патронов.", 255, 255, 0);
					return;
				}
			}
	}
}
addEventHandler( "onPlayerDeath", playerDeath );

function zona(playerid)
{
	if(!isPlayerConnected(playerid))
	{
	return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "prisontimer").tointeger() >= 1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "prisontimer", ini.getKey("PlayerInfo", "prisontimer").tointeger() - 1 );
		ini.saveData();
		sendPlayerMessage(playerid, "Вам осталось сидеть " + (ini.getKey("PlayerInfo", "prisontimer").tointeger()-1) + " мин.", 255, 255, 0);

	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "prisontimer").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 || ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "fraction").tointeger() == 5 || ini.getKey("PlayerInfo", "fraction").tointeger() == 6)
		{
			setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger());
		}
		else
		{
			setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "prison", 0);
		ini.setKey("PlayerInfo", "prisontimer", 0);
		ini.setKey("PlayerInfo", "wanted", 0);
		ini.setKey("PlayerInfo", "wanted_lvl", 0);
		ini.saveData();

		setPlayerPosition( playerid, -378.987, 654.699, -11.5013 );
		setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
		sendPlayerMessage(playerid, "Вы откинулись, поздравляем!", 255, 255, 0);
		return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "prisontimer").tointeger() == 0)
	{
		prisontimer.Kill();
		return;
	}
}

//help
addCommandHandler( "help",
function( playerid, id)
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли.", 255, 0, 0);
	}
	if(id == 1)
	{
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpadmin (1-2) - команды администратора", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpplayer (1-2) - команды игрока", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpchat - команды чата", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpmechanic - команды механика", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpcar - команды машины", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpbiznes - команды бизнеса", 255, 255, 0);
	sendPlayerMessage(playerid, "/helppolice (1-2) - команды полицейских", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpmed - команды медиков", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpmafia - команды мафии", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpbands - команды банды", 255, 255, 0);
	sendPlayerMessage(playerid, "/helparmy - команды армии", 255, 255, 0);
	sendPlayerMessage(playerid, "/helptaxi - команды таксиста", 255, 255, 0);
	sendPlayerMessage(playerid, "/helphouse - команды домов", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpbind - клавиши", 255, 255, 0);
	return;
	}
	if(id == 2)
	{
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage(playerid, "/helpmeria - команды мерии", 255, 255, 0);
	return;
	}
});

addCommandHandler( "helpadmin",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не администратор сервера.", 255, 0, 0);
	}
	if(id == 1)
	{
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage(playerid, "/admin (id) - забрать(выдать) админку", 255, 255, 0 );
	sendPlayerMessage(playerid, "/fillcar - заправить машину", 255, 255, 0 );
	sendPlayerMessage(playerid, "/ban (id) - выдать бан", 255, 255, 0 );
	sendPlayerMessage(playerid, "/unban (id) - разбанить(если игрок в сети)", 255, 255, 0 );
	sendPlayerMessage(playerid, "/kick (id) - кикнуть игрока", 255, 255, 0 );
	sendPlayerMessage(playerid, "/goto (x) (y) (z) - тп по координатам", 255, 255, 0 );
	sendPlayerMessage(playerid, "/v (id машины) - зареспавнить тачку (от 0 до 53)", 255, 255, 0 );
	sendPlayerMessage(playerid, "/fix - починить машину", 255, 255, 0 );
	sendPlayerMessage(playerid, "/givemoney (id) (money) - выдать деньги игроку", 255, 255, 0 );
	sendPlayerMessage(playerid, "/removemoney (id) (money) - забрать деньги у игрока", 255, 255, 0 );
	sendPlayerMessage(playerid, "/givekazna (money) - пополнить казну города(В КАЗНЕ НЕ ДОЛЖНО БЫТЬ БОЛЬШЕ 2 мрлд $)", 255, 255, 0 );
	sendPlayerMessage(playerid, "/poz - узнать свои координаты", 255, 255, 0 );
	sendPlayerMessage(playerid, "/del - удалить тс", 255, 255, 0 );
	return;
	}
	if(id == 2)
	{
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage(playerid, "/rot - узнать положение тела", 255, 255, 0 );
	sendPlayerMessage(playerid, "/tpplayer (id) (высота) - телепорт к игроку", 255, 255, 0 );
	sendPlayerMessage(playerid, "/info (id) - информация игрока", 255, 255, 0 );
	sendPlayerMessage(playerid, "/hil (id) - пополнить хп игрока и сытость", 255, 255, 0 );
	sendPlayerMessage(playerid, "/skin (id скина) - установка скина", 255, 255, 0 );
	sendPlayerMessage(playerid, "/die (id) - убить игрока", 255, 255, 0 );
	sendPlayerMessage(playerid, "/frac (id) (f) (r) - назначить игрока во фракцию(f) и выдать ранг(r), (0) (0) уволить с должности", 255, 255, 0 );
	sendPlayerMessage(playerid, "/p (0) (0) (0) (0) (0) (0) - покрасить авто, вместо 0 указать число от 0 до 255", 255, 255, 0 );
	sendPlayerMessage(playerid, "/gans - выдать себе оружие", 255, 255, 0 );
	sendPlayerMessage(playerid, "/tune (от 0 до 3) - затюнить машину", 255, 255, 0 );
	sendPlayerMessage(playerid, "/respawn (номер машины) - зареспавнить машины(/respawn ebpd)", 255, 255, 0 );
	sendPlayerMessage(playerid, "/a (text) - чат админов", 255, 255, 0 );
	sendPlayerMessage(playerid, "/banserial (id) - пожизненный бан", 255, 255, 0 );
	return;
	}
});

addCommandHandler( "helpplayer",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
	if(id == 1)
	{
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage(playerid, "/newpassword (пароль) - изменить пароль", 255, 255, 0 );
	sendPlayerMessage(playerid, "/pay (id) (money) - передать деньги игроку", 255, 255, 0 );
	sendPlayerMessage(playerid, "/pass (id) - показать паспорт игроку", 255, 255, 0 );
	sendPlayerMessage(playerid, "/showlic (id) - показать лицензии игроку", 255, 255, 0 );
	sendPlayerMessage(playerid, "/wallet - достать(убрать) кошелек(защита от воров)", 255, 255, 0 );
	sendPlayerMessage(playerid, "/usedrugs - использовать 1 грамм(+100 хп) наркотиков", 255, 255, 0 );
	sendPlayerMessage(playerid, "/sex - заняться сексом с проститутками(в борделе)", 255, 255, 0 );
	sendPlayerMessage(playerid, "/report (text) - репорт админам", 255, 255, 0 );
	sendPlayerMessage(playerid, "/levelup - прокачаться", 255, 255, 0 );
	sendPlayerMessage(playerid, "/buykit - купить аптечку у EGH", 255, 255, 0 );
	sendPlayerMessage(playerid, "/usekit - использовать аптечку", 255, 255, 0 );
	sendPlayerMessage(playerid, "/inv - показать инвентарь", 255, 255, 0 );
	sendPlayerMessage(playerid, "/stats - показать статистику", 255, 255, 0 );
	sendPlayerMessage(playerid, "/satiety - показать сытость", 255, 255, 0 );
	return;
	}
	if(id == 2)
	{
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage(playerid, "/invite (id) - пригласить игрока во фракцию", 255, 255, 0 );
	sendPlayerMessage(playerid, "/giverang (id) (указать ранг) - выдать ранг", 255, 255, 0 );
	sendPlayerMessage(playerid, "/uval (id) - уволить игрока из фракции", 255, 255, 0 );
	sendPlayerMessage(playerid, "/buyguns (id) - купить оружие", 255, 255, 0 );
	sendPlayerMessage(playerid, "/leader - лидеры онлайн", 255, 255, 0 );
	sendPlayerMessage(playerid, "/course - показать курс", 255, 255, 0 );
	sendPlayerMessage(playerid, "/carrental - аренда машины", 255, 255, 0 );
	sendPlayerMessage(playerid, "/uncarrental - отменить аренду машины", 255, 255, 0 );
	sendPlayerMessage(playerid, "/buyskin (id) - купить скин", 255, 255, 0 );
	sendPlayerMessage(playerid, "/news (text) - объявление цена 1000$", 255, 255, 0 );
	sendPlayerMessage(playerid, "/buycan - купить канистру с топливом", 255, 255, 0 );
	sendPlayerMessage(playerid, "/usecan - использовать канистру с топливом", 255, 255, 0 );
	return;
	}
});

addCommandHandler( "helpchat",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0); 
		sendPlayerMessage(playerid, "/try (text) - отыгровка действия", 255, 255, 0 );
		sendPlayerMessage(playerid, "/do (text) - описание от 3-его лица", 255, 255, 0 );
		sendPlayerMessage(playerid, "/me (text) - описание действия", 255, 255, 0 );
		sendPlayerMessage(playerid, "/b (text) - локальный нонрп чат 10м", 255, 255, 0 );
		sendPlayerMessage(playerid, "/s (text) - крик чат 50м", 255, 255, 0 );
		sendPlayerMessage(playerid, "/w (text) - шепот чат 3м", 255, 255, 0 );
		sendPlayerMessage(playerid, "/let (id) (text) - послать письмо игроку", 255, 255, 0 );
});
addCommandHandler( "helpmeria",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/settax (money) - установить налог(мэр)", 255, 255, 0 );
});
addCommandHandler( "helpmechanic",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/carcolor (0) (0) (0) (0) (0) (0) - покрасить авто, вместо 0 указать число от 0 до 255(предпросмотр)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/savecarcolor (id) (0) (0) (0) (0) (0) (0) (money)- покрасить авто игроку", 255, 255, 0 );
		sendPlayerMessage(playerid, "/tunecar (id) (от 0 до 3) (money)- затюнить машину", 255, 255, 0 );
});
addCommandHandler( "helpcar",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/sellcarplayer (id) (money) - продать машину игроку(доступна на авторынке)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/buycar (id машины) - купить машину(доступна у автомагазина)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/sellcar - продать машину за 50 процентов её стоимости", 255, 255, 0 );
		sendPlayerMessage(playerid, "/refuel (указать кол-во топлива) - заправить машину(доступна на заправках)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/enter (номер) - сесть в машину инкасаторов(от 108 до 109)", 255, 255, 0 );
});
addCommandHandler( "helpbiznes",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/buybiznes - купить бизнес", 255, 255, 0 );
		sendPlayerMessage(playerid, "/sellbiznes - продать бизнес", 255, 255, 0 );
		sendPlayerMessage(playerid, "/sellbizplayer (id) (money) - продать бизнес игроку", 255, 255, 0 );
		sendPlayerMessage(playerid, "/biznesprice (money) - установить цену за товар(продажу топлива)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/biznesbuyfuel (money) - установить цену за покупку топлива", 255, 255, 0 );
		sendPlayerMessage(playerid, "/biznesbuyprod (кол-во) - купить продукты", 255, 255, 0 );
		sendPlayerMessage(playerid, "/biznesbuyalco (кол-во) - купить алкоголь", 255, 255, 0 );
		sendPlayerMessage(playerid, "/biznesbuyparts (кол-во) - купить запчасти", 255, 255, 0 );
});
addCommandHandler( "helppolice",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		if(id == 1)
		{
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/prison (id) (time) - посадить в тюрьму(доступна у EBPD)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/arest (id) - надеть наручники", 255, 255, 0 );
		sendPlayerMessage(playerid, "/unarest (id) - снять наручники", 255, 255, 0 );
		sendPlayerMessage(playerid, "/ticket (id) (money) - выписать штраф", 255, 255, 0 );
		sendPlayerMessage(playerid, "/weaponlic (id) - выдать лицензию на оружие стоимость 1000$", 255, 255, 0 );
		sendPlayerMessage(playerid, "/removeweaponlic (id) - забрать лицензию на оружие", 255, 255, 0 );
		sendPlayerMessage(playerid, "/removedriverlic (id) - забрать права", 255, 255, 0 );
		sendPlayerMessage(playerid, "/accept police (id) - принять вызов игрока", 255, 255, 0 );
		sendPlayerMessage(playerid, "/r (text) - рация полицейских", 255, 255, 0 );
		sendPlayerMessage(playerid, "/respawn ebpd - зареспавнить машины(ранг >= 4)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/searchdrugs (id) - обыскать игрока на наличие наркотиков", 255, 255, 0 );
		sendPlayerMessage(playerid, "/searchguns (id) - обыскать игрока на наличие оружия", 255, 255, 0 );
		sendPlayerMessage(playerid, "/search (id) (lvl) (причина) - выдать звезду", 255, 255, 0 );
		sendPlayerMessage(playerid, "/scan (id) - получить информацию о игроке", 255, 255, 0 );
		return;
		}
		if(id == 2)
		{
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/taizer (id) - оглушить игрока", 255, 255, 0 );
		sendPlayerMessage(playerid, "/excar (id) - прострелить бензобак", 255, 255, 0 );
		return;
		}
});
addCommandHandler( "helparmy",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/r (text) - рация военных", 255, 255, 0 );
		sendPlayerMessage(playerid, "/irp - покушать(нужно находится у казармы)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/respawn aeb - зареспавнить машины(ранг >= 4)", 255, 255, 0 );
});
addCommandHandler( "helpmafia",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/r (text) - рация мафии", 255, 255, 0 );
		sendPlayerMessage(playerid, "/respawn (номер машины) - зареспавнить машины(/respawn triada)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/excar (id) - прострелить бензобак", 255, 255, 0 );
		sendPlayerMessage(playerid, "/infonarko - узнать сколько наркотиков на рыбзаводе", 255, 255, 0 );
		sendPlayerMessage(playerid, "/givedrugs (кол-во) - забрать наркотики со склада рыбзавода", 255, 255, 0 );
		sendPlayerMessage(playerid, "/selldrugs (id) (кол-во) (money) - продать наркотики игроку", 255, 255, 0 );
		sendPlayerMessage(playerid, "/sellguns (id) (id оружия) (money) - продать оружие игроку", 255, 255, 0 );
		sendPlayerMessage(playerid, "/robbery - ограбить ювелирку", 255, 255, 0 );
});
addCommandHandler( "helpbands",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/r (text) - рация банды", 255, 255, 0 );
		sendPlayerMessage(playerid, "/respawn irish - зареспавнить машины(ранг >= 4)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/excar (id) - прострелить бензобак", 255, 255, 0 );
		sendPlayerMessage(playerid, "/selldrugs (id) (кол-во) (money) - продать наркотики игроку", 255, 255, 0 );
		sendPlayerMessage(playerid, "/sellguns (id) (id оружия) (money) - продать оружие игроку", 255, 255, 0 );
		sendPlayerMessage(playerid, "/robbery - ограбить ювелирку", 255, 255, 0 );
});
addCommandHandler( "helpmed",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/heal (id) (money) - вылечить игрока", 255, 255, 0 );
		sendPlayerMessage(playerid, "/addiction (id) (money) - вылечить игрока от наркозависимости", 255, 255, 0 );
		sendPlayerMessage(playerid, "/narkotest (id) - узнать уровень зависимости", 255, 255, 0 );
		sendPlayerMessage(playerid, "/accept med (id) - принять вызов игрока", 255, 255, 0 );
		sendPlayerMessage(playerid, "/r (text) - рация медиков", 255, 255, 0 );
		sendPlayerMessage(playerid, "/respawn egh - зареспавнить машины(ранг >= 3)", 255, 255, 0 );
});
addCommandHandler( "helptaxi",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/jtaxi - устроиться таксистом (у мерии)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/qtaxi - уволиться(у мерии)", 255, 255, 0 );
		sendPlayerMessage(playerid, "/taxi on(off) - начать(завершить) работу таксиста", 255, 255, 0 );
		sendPlayerMessage(playerid, "/taxilight - вкл(выкл) шашку", 255, 255, 0 );
		sendPlayerMessage(playerid, "/accept taxi (id) - принять вызов игрока", 255, 255, 0 );
});
addCommandHandler( "helphouse",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "/buyhouse - купить квартиру", 255, 255, 0 );
		sendPlayerMessage(playerid, "/sellhouse - продать квартиру за 50 процентов её стоимости", 255, 255, 0 );
});
addCommandHandler( "helpbind",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "Клавиша E - многофункциональная клавиша(устроиться на работу)", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша Q - уволиться с работы(выкл двигатель)", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша G - выйти из машины", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша I - узнать статистику бизнесов", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша Z - левый поворотник", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша X - правый поворотник", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша C - аварийки", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша V - вкл(выкл) фары", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша F1 - убрать(вернуть) чат", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша TAB - список игроков", 255, 255, 0 );
		sendPlayerMessage(playerid, "Клавиша Num 0 - мегафон для копов", 255, 255, 0 );
});

//админ
addCommandHandler("pos", function(playerid, ...) 
{
if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    // http://www.cplusplus.com/reference/cstdio/fopen/
    local posfile = file("positions.txt", "a");
    local pos;

    if (isPlayerInVehicle(playerid)) {
        pos = getVehiclePosition( getPlayerVehicle(playerid) );
    } else {
        pos = getPlayerPosition( playerid );
    }

    // read rest of the input string (if there any)
    // concat it, and push to the pos array
    if (vargv.len() > 0) {
        pos.push(vargv.reduce(function(a, b) {
            return a + " " + b;
        }));
    }

    // iterate over px,y,z]
    foreach (idx, value in pos) {

        // convert value to string,
        // and iterate over each char
        local coord = value.tostring();
        for (local i = 0; i < coord.len(); i++) {
            posfile.writen(coord[i], 'b');
        }

        // also write 255, 255, 255space after the number
        posfile.writen(',', 'b');
    }

    // and dont forget push newline before closing
    posfile.writen('\n', 'b');
    posfile.close();

    sendPlayerMessage(playerid, "Позиция сохранена.");
	}
});

function nickNameChanged( playerid, newNickname, oldNickname )
{
    log("");
	log(getPlayerName(playerid)+" kick za NickName");
	log("");
	kickPlayer( playerid );
}
addEventHandler ( "onPlayerChangeNick", nickNameChanged );

addCommandHandler("rcon",
function(playerid, id) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(id.tostring() == "0000")
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "admin", 2);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы стали главным админом.", 130, 255, 0);
	}
});

addCommandHandler( "set",
function(playerid, id, model)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
		local id = id.tointeger();
		local model = model.tointeger();
		setPlayerHandModel(playerid, id, model);
	}
}
);

addCommandHandler( "del",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car_id").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Чтобы удалить надо сесть и выйти из машины.", 255, 0, 0);
	}
	if(isPlayerInVehicle(playerid)) 
	{
		return sendPlayerMessage(playerid, "Выйдите из машины.", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		destroyVehicle(ini.getKey("PlayerInfo", "car_id").tointeger());
		sendPlayerMessage(playerid, "Вы удалили тс.", 130, 255, 0);
		
		ini.setKey("PlayerInfo", "car_id", 0);
		ini.saveData();
	}
}
);

addCommandHandler("info",
function(playerid, id) 
{
		local id = id.tointeger();
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
		if(FileExists("account/"+getPlayerName(id)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(id)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
		local ini = EasyINI("account/"+getPlayerName(id)+".ini");
		sendPlayerMessage(playerid, "==================[PlayerInfo]=================", 130, 255, 0);
		sendPlayerMessage(playerid, "Ник: " +getPlayerName(id) );
		sendPlayerMessage(playerid, "IP: " +getPlayerIP(id) );
		sendPlayerMessage(playerid, "Serial: " +getPlayerSerial(id) );
		sendPlayerMessage(playerid, "Здоровье: " +getPlayerHealth(id) );
		sendPlayerMessage(playerid, "Сытость: " +ini.getKey("PlayerInfo", "satiety").tointeger() );
		sendPlayerMessage(playerid, "Фракция: " +ini.getKey("PlayerInfo", "fraction").tointeger() );
		sendPlayerMessage(playerid, "Ранг: " +ini.getKey("PlayerInfo", "rang").tointeger() );
		sendPlayerMessage(playerid, "Лет в городе: "+ini.getKey("PlayerInfo", "level").tointeger(), 255, 255, 255);
		sendPlayerMessage(playerid, "Деньги: "+ini.getKey("PlayerInfo", "money").tointeger(), 255, 255, 255);
		sendPlayerMessage(playerid, "Банк: "+ini.getKey("PlayerInfo", "bank").tointeger(), 255, 255, 255);
		if(ini.getKey("PlayerInfo", "job").tointeger() == 0)
		{
		sendPlayerMessage(playerid, "Работа: Безработный", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 1)
		{
		sendPlayerMessage(playerid, "Работа: Докер", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 2)
		{
		sendPlayerMessage(playerid, "Работа: Доставщик сигарет", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 3)
		{
		sendPlayerMessage(playerid, "Работа: Водитель автобуса", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 4)
		{
		sendPlayerMessage(playerid, "Работа: Таксист", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
		{
		sendPlayerMessage(playerid, "Работа: Развозчик топлива", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 6)
		{
		sendPlayerMessage(playerid, "Работа: Механик", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		sendPlayerMessage(playerid, "Работа: Металлоломщик", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 8)
		{
		sendPlayerMessage(playerid, "Работа: Водитель", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 9)
		{
		sendPlayerMessage(playerid, "Работа: Обработчик на рыбзаводе", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 10)
		{
		sendPlayerMessage(playerid, "Работа: Доставщик мяса", 255, 255, 255);
		}
		if(ini.getKey("PlayerInfo", "job").tointeger() == 11)
		{
		sendPlayerMessage(playerid, "Работа: Доставщик патронов", 255, 255, 255);
		}
		
		}
});

addCommandHandler("fillcar",
function(playerid) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	
    if ( !isPlayerInVehicle(playerid) ) 
	{
        return;
    }
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local vehicleid = getPlayerVehicle(playerid);
		setVehicleFuel(vehicleid, 50.0);
		sendPlayerMessage(playerid, "Вы заправили машину.", 130, 255, 0);
	}
});

addCommandHandler( "admin",
    function( playerid, id )
    {
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
		if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
		return;
		}
		
		if(getPlayerIdFromName(getPlayerName( playerid )) == getPlayerIdFromName(getPlayerName( id.tointeger() )))
		{
		return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
		{
		return sendPlayerMessage(playerid, "Игрок главный администратор.", 130, 255, 0 );
		}
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "admin", 1);
			ini.saveData();
			
			sendPlayerMessage(playerid, getPlayerName(playerid)+" выдал админку "+getPlayerName(id.tointeger()), 130, 255, 0 );
			sendPlayerMessage(id.tointeger(), getPlayerName(playerid)+" выдал админку "+getPlayerName(id.tointeger()), 130, 255, 0 );
		}
		else
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "admin", 0);
			ini.saveData();
			
			sendPlayerMessage(playerid, getPlayerName(playerid)+" забрал админку "+getPlayerName(id.tointeger()), 130, 255, 0 );
			sendPlayerMessage(id.tointeger(), getPlayerName(playerid)+" выдал админку "+getPlayerName(id.tointeger()), 130, 255, 0 );
		}
    }
);

addCommandHandler( "ban",
    function( playerid, id, reason )
    {
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
		if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
		if (!isPlayerConnected(id.tointeger())) 
		{
        sendPlayerMessage(playerid, "Игрок не в сети.", 255, 0, 0);
        return;
		}
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
		return sendPlayerMessage(playerid, "Игрок админ.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local text = "";
			for(local i = 0; i < vargv.len(); i++)
			{
				text = text + " " + vargv[i];
			}
			
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "ban", 1);
			ini.setKey("PlayerInfo", "banreason", text);
			ini.saveData();
			
			sendPlayerMessageToAll("(SERVER)"+getPlayerName(playerid)+" забанил "+getPlayerName(id.tointeger())+" Причина: "+text, 130, 255, 0 );
			
			log("");
			log("(SERVER)"+getPlayerName(playerid)+" ban by "+getPlayerName(id.tointeger()));
			log("");
			
			kickPlayer( id.tointeger() );
		}
    }
);
addCommandHandler( "unban",
    function( playerid, id)
    {
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
			return;
		}
		if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
			return;
		}
		if (!isPlayerConnected(id.tointeger())) 
		{
        sendPlayerMessage(playerid, "Игрок не в сети.", 255, 0, 0);
        return;
		}
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "ban").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Игрок не забанин.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "ban", 0);
			ini.setKey("PlayerInfo", "reason", 0);
			ini.saveData();
			
			sendPlayerMessageToAll("(SERVER)"+getPlayerName(playerid)+" разбанил "+getPlayerName(id.tointeger()), 130, 255, 0 );
			
			log("");
			log("(SERVER)"+getPlayerName(playerid)+" unban by "+getPlayerName(id.tointeger()));
			log("");
		}
    }
);

addCommandHandler( "banserial",
    function( playerid, id )
    {
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}

		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("banserial/"+getPlayerSerial(id.tointeger())+".ini");
			
			log("");
			log("(SERVER-SERIAL)"+getPlayerName(playerid)+" ban by "+getPlayerName(id.tointeger()));
			log("");
			
			kickPlayer( id.tointeger() );
		}
    }
);

addCommandHandler( "kick",
function( playerid, id )
{
	local randomize = random(1,3);
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	if (!isPlayerConnected(id.tointeger())) 
	{
        sendPlayerMessage(playerid, "Игрок не в сети.", 255, 0, 0);
        return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		if(randomize == 1)
		{
			sendPlayerMessageToAll("(SERVER) Тебе тут не место "+getPlayerName(id.tointeger()), 130, 255, 0 );
			log("");
			log(getPlayerName(playerid)+" kick by "+getPlayerName(id.tointeger()));
			log("");
			kickPlayer( id.tointeger() );
			return;
		}
		if(randomize == 2)
		{
			sendPlayerMessageToAll("(SERVER) Ты не посвященный "+getPlayerName(id.tointeger()), 130, 255, 0 );
			log("");
			log(getPlayerName(playerid)+" kick by "+getPlayerName(id.tointeger()));
			log("");
			kickPlayer( id.tointeger() );
			return;
		}
		if(randomize == 3)
		{
			sendPlayerMessageToAll("(SERVER) Эйва прогнала тебя "+getPlayerName(id.tointeger()), 130, 255, 0 );
			log("");
			log(getPlayerName(playerid)+" kick by "+getPlayerName(id.tointeger()));
			log("");
			kickPlayer( id.tointeger() );
			return;
		}
	}
});

addCommandHandler( "goto",
function( playerid, q, w, e )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
	setPlayerPosition( playerid, q.tofloat(), w.tofloat(), e.tofloat() );
	}
}
);
addCommandHandler( "v",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local pos = getPlayerPosition( playerid );
		local vehicle = createVehicle( id.tointeger(), pos[0] + 2.0, pos[1], pos[2] + 1.0, 0.0, 0.0, 0.0 );
		setVehiclePlateText( vehicle, "admin" );
	}
}
);
addCommandHandler( "fix",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		if( isPlayerInVehicle( playerid ) )
		{
			local vehicleid = getPlayerVehicle( playerid );
			repairVehicle( vehicleid );
		}
	}
});
addCommandHandler( "givemoney",
function ( playerid, id, money )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	if (!isPlayerConnected(id.tointeger())) 
	{
        sendPlayerMessage(playerid, "Игрок не в сети.", 255, 0, 0);
        return;
    }
	if(money.tointeger() > 1000000)
	{
	 return sendPlayerMessage(playerid, "Максимальная сумма перевода 1 000 000$", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money.tointeger());
		ini.saveData();
		sendPlayerMessage(playerid, "Вы выдали "+getPlayerName(id.tointeger())+" "+money.tointeger()+"$", 255, 100, 0 );
		sendPlayerMessage(id.tointeger(), getPlayerName(playerid)+" выдал вам "+money.tointeger()+"$", 0, 255, 0 );
		log("");
		log("(GIVEMONEY)"+"выдал"+getPlayerName(playerid)+" "+getPlayerName(id.tointeger())+" "+money.tointeger()+"$");
		log("");
	}
});
addCommandHandler( "removemoney",
function ( playerid, id, money )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	if (!isPlayerConnected(id.tointeger())) 
	{
        sendPlayerMessage(playerid, "Игрок не в сети.", 255, 0, 0);
        return;
    }
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money.tointeger());
		ini.saveData();
		sendPlayerMessage(playerid, "Вы забрали у "+getPlayerName(id.tointeger())+" "+money.tointeger()+"$", 0, 255, 0 );
		sendPlayerMessage(id.tointeger(), getPlayerName(playerid)+" забрал у вас "+money.tointeger()+"$", 255, 100, 0 );
		log("");
		log("(REMOVEMONEY)"+"забрал"+getPlayerName(playerid)+" "+getPlayerName(id.tointeger())+" "+money.tointeger()+"$");
		log("");
	}
});
addCommandHandler( "givekazna",
function ( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + id.tointeger());
		ini.saveData();
		sendPlayerMessage(playerid, "Казна города пополнилась на "+id.tointeger()+"$", 0, 255, 0 );
		sendPlayerMessage(playerid, "Казна города: "+ini.getKey("CH", "kazna").tointeger()+"$", 0, 255, 0 );
	}
});

addCommandHandler( "poz",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local pos = getPlayerPosition( playerid );
		sendPlayerMessage(playerid, "Ваши координаты " +"x= "+pos[0] + ", " + "y= "+pos[1] + ", " + "z= "+pos[2]);
	}
});
addCommandHandler( "rot",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local pos = getPlayerRotation( playerid );
		sendPlayerMessage(playerid, "Ваши координаты положения тела " + "x= "+pos[0] + ", " + "y= "+pos[1] + ", " + "z= "+pos[2]);
	}
});

addCommandHandler("tpplayer", 
function(playerid, id, id1) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
		
local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
{
    if (!isPlayerConnected(id.tointeger())) 
	{
        sendPlayerMessage(playerid, "Игрок не в сети.", 255, 0, 0);
        return;
    }
    local myPos = getPlayerPosition(id.tointeger());
    setPlayerPosition(playerid, myPos[0], myPos[1], myPos[2]+id1.tointeger());
}
});

addCommandHandler( "hil",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		setPlayerHealth( id.tointeger(), 1000.0 );
		sendPlayerMessage( playerid, "Вы повысили хп "+getPlayerName(id.tointeger())+" на 720 ХП и сытость на 100", 130, 255, 0 );
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		ini.setKey("PlayerInfo", "satiety", 100);
		ini.saveData();
	}
}
);
addCommandHandler( "skin",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		setPlayerModel( playerid, id.tointeger() );
	}
});
addCommandHandler( "die",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		setPlayerHealth( id.tointeger(), 0.0 );
	}
}
);
addCommandHandler( "frac",
function( playerid, id, f, r )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	if(!isPlayerConnected(id.tointeger()))
		{
		return sendPlayerMessage(playerid, "Игрок не в сети.", 255, 0, 0);
		}
	if(isPlayerInVehicle(id.tointeger()))
		{
		return sendPlayerMessage(playerid, "Игрок в машине.", 255, 0, 0);
		}
		
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		if(f.tointeger() == 0 && r.tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "fraction", f.tointeger());
			ini.setKey("PlayerInfo", "rang", r.tointeger());
			ini.setKey("PlayerInfo", "leader", 0);
			ini.setKey("PlayerInfo", "fraction_p", 0);
			ini.setKey("PlayerInfo", "skin_f", 0);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы уволили "+getPlayerName(id.tointeger())+ " с должности.", 130, 255, 0);
			sendPlayerMessage(id.tointeger(), getPlayerName(playerid)+" уволил вас с должности.", 130, 255, 0);
			setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin").tointeger());
			return;
		}
		if(f.tointeger() == 1)
		{
			if(r.tointeger() > 0 && r.tointeger() < 7)
			{
				if(r.tointeger() == 6)
				{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 1);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
				}
				
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Вы можете повысить до 6 ранга или уволить(фракция 0 ранг 0).", 255, 0, 0);
			}
			return;
		}
		if(f.tointeger() == 2)
		{
			if(r.tointeger() > 0 && r.tointeger() < 6)
			{
				if(r.tointeger() == 5)
				{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 2);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
				}
				
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Вы можете повысить до 5 ранга или уволить(фракция 0 ранг 0).", 255, 0, 0);
			}
			return;
		}
		if(f.tointeger() == 3)
		{
			if(r.tointeger() > 0 && r.tointeger() < 11)
			{
				if(r.tointeger() == 10)
				{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 3);
				ini.setKey("PlayerInfo", "skin_f", 17);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
				}
			if(r.tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 16);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 2 || r.tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 19);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 4 || r.tointeger() == 5 || r.tointeger() == 6 || r.tointeger() == 7)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 18);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 8)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 114);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 9)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 113);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			}
			
			sendPlayerMessage(playerid, "Вы можете повысить до 10 ранга или уволить(фракция 0 ранг 0).", 255, 0, 0);
			return;
		}
		if(f.tointeger() == 4)
		{
			if(r.tointeger() > 0 && r.tointeger() < 6)
			{
				if(r.tointeger() == 5)
				{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 4);
				ini.setKey("PlayerInfo", "skin_f", 50);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
				}
			if(r.tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 52);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 2)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 51);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 48);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 4)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 49);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			
			}
			
			sendPlayerMessage(playerid, "Вы можете повысить до 5 ранга или уволить(фракция 0 ранг 0).", 255, 0, 0);
			return;
		}
		if(f.tointeger() == 5)
		{
			if(r.tointeger() > 0 && r.tointeger() < 6)
			{
				if(r.tointeger() == 5)
				{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 5);
				ini.setKey("PlayerInfo", "skin_f", 24);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
				}
			if(r.tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 83);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 2)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 81);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 82);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			if(r.tointeger() == 4)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 84);
				ini.setKey("PlayerInfo", "leader", 0);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
			}
			
			}
			
			sendPlayerMessage(playerid, "Вы можете повысить до 5 ранга или уволить(фракция 0 ранг 0).", 255, 0, 0);
			return;
		}
		if(f.tointeger() == 6)
		{
			if(r.tointeger() > 0 && r.tointeger() < 2)
			{
				if(r.tointeger() == 1)
				{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", f.tointeger());
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "leader", 6);
				ini.setKey("PlayerInfo", "skin_f", 20);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили "+getPlayerName(id.tointeger())+" во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас назначили во фракцию "+f.tointeger()+ " и назначили ранг "+r.tointeger(), 130, 255, 0);
				return;
				}
			
			}
			
			sendPlayerMessage(playerid, "Вы можете повысить до 1 ранга или уволить(фракция 0 ранг 0).", 255, 0, 0);
			return;
		}
	}
}
);

addCommandHandler("p", 
function(playerid, r, g, b, q, w, e) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	if(isPlayerInVehicle(playerid)) 
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
        local vehicle = getPlayerVehicle(playerid);
		setVehicleColour(vehicle, r.tointeger(), g.tointeger(), b.tointeger(), q.tointeger(), w.tointeger(), e.tointeger());
	}
	}
});
addCommandHandler( "gans",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		givePlayerWeapon( playerid, 2, 42 ); //револьвер копов(6)
		givePlayerWeapon( playerid, 3, 60 ); //пистолет с96(10)
		givePlayerWeapon( playerid, 4, 56 ); //кольт 1911(7)
		givePlayerWeapon( playerid, 5, 92 ); //кольт 1911 (23)
		givePlayerWeapon( playerid, 6, 42 ); //магнум (6)
		givePlayerWeapon( playerid, 8, 56 ); //дробовик копов(8)
		givePlayerWeapon( playerid, 9, 120 ); //пп (30)
		givePlayerWeapon( playerid, 10, 128 ); //мп40 (32)
		givePlayerWeapon( playerid, 11, 200 ); //пп томпсон(50)
		givePlayerWeapon( playerid, 20, 6 ); //граната(1)
		givePlayerWeapon( playerid, 21, 6 ); //молотов(1)
		
		givePlayerWeapon( playerid, 12, 120 ); //автомат копов(30)
		givePlayerWeapon( playerid, 13, 120 ); //автомат солдат(30)
		givePlayerWeapon( playerid, 15, 40 ); //винтовка солдат(8)
		givePlayerWeapon( playerid, 17, 35 ); //снапа 5 патронов(5)
		
	}
}
);

//логин
addCommandHandler( "login",
	function( playerid, cmd )
	{
			if(FileExists("account/"+getPlayerName(playerid)+".ini"))
			{	
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
				{
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					if(md5(cmd.tostring()) == ini.getKey("PlayerInfo", "password"))
					{
						if(ini.getKey("PlayerInfo", "ban").tointeger() == 1)
							{
							return sendPlayerMessage(playerid, "Вы забанены. Причина: "+ini.getKey("PlayerInfo", "banreason").tostring(), 255, 0, 0 );
							}
if(leto == true)
{
local ini = EasyINI("biz/kazna.ini");
	if(ini.getKey("time_sever", "pagoda").tointeger() == 0)
	{
		setWeather( "DT_RTRclear_day_night" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 1)
	{
		setWeather( "DTFreerideNight" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 2)
	{
		setWeather( "DT14part11" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 3)
	{
		setWeather( "DT_RTRfoggy_day_night" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 4)
	{
		setWeather( "DT_RTRclear_day_early_morn1" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 5)
	{
		setWeather( "DT_RTRrainy_day_early_morn" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 6)
	{
		setWeather( "DT_RTRclear_day_early_morn2" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 7)
	{
		setWeather( "DT_RTRrainy_day_morning" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 8)
	{
		setWeather( "DT_RTRfoggy_day_morning" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 9)
	{
		setWeather( "DT_RTRclear_day_morning" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 10)
	{
		setWeather( "DT06part03" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 11)
	{
		setWeather( "DT07part01fromprison" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 12)
	{
		setWeather( "DT07part02dereksubquest" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 13)
	{
		setWeather( "DT_RTRclear_day_afternoon" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 14)
	{
		setWeather( "DT09part4MalteseFalcone2" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 15)
	{
		setWeather( "DT08part02cigarettesmill" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 16)
	{
		setWeather( "DT13part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 17)
	{
		setWeather( "DT_RTRrainy_day_late_afternoon" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 18)
	{
		setWeather( "DT08part03crazyhorse" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 19)
	{
		setWeather( "DT_RTRfoggy_day_evening" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 20)
	{
		setWeather( "DT_RTRclear_day_evening" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 21)
	{
		setWeather( "DT_RTRfoggy_day_late_even" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 22)
	{
		setWeather( "DT08part04subquestwarning" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 23)
	{
		setWeather( "DT_RTRclear_day_late_even" );
	}
}
else
{
local ini = EasyINI("biz/kazna.ini");
	if(ini.getKey("time_sever", "pagoda").tointeger() == 0)
	{
		setWeather( "DTFreeRideNightSnow" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 1)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 2)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 3)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 4)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 5)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 6)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 7)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 8)
	{
		setWeather( "DT04part02" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 9)
	{
		setWeather( "DT05part01JoesFlat" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 10)
	{
		setWeather( "DT03part01JoesFlat" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 11)
	{
		setWeather( "DTFreeRideDaySnow" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 12)
	{
		setWeather( "DT05part02FreddysBar" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 13)
	{
		setWeather( "DT05part04Distillery" );//туман
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 14)
	{
		setWeather( "DT04part01JoesFlat" );//туман
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 15)
	{
		setWeather( "DT02part01Railwaystation" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 16)
	{
		setWeather( "DT02part02JoesFlat" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 17)
	{
		setWeather( "DT02part04Giuseppe" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 18)
	{
		setWeather( "DT05Distillery_inside" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 19)
	{
		setWeather( "DT02part03Charlie" );//туман
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 20)
	{
		setWeather( "DT05Distillery_inside" );//туман
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 21)
	{
		setWeather( "DT02part05Derek" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 22)
	{
		setWeather( "DT02NewStart1" );
	}
	if(ini.getKey("time_sever", "pagoda").tointeger() == 23)
	{
		setWeather( "DT03part04PriceOffice" );
	}
}
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						if(ini.getKey("gans", "Model_12_Revolver").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 2, ini.getKey("gans", "Model_12_Revolver").tointeger() ); //револьвер копов(6)
						}
						if(ini.getKey("gans", "Mauser_C96").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 3, ini.getKey("gans", "Mauser_C96").tointeger() ); //пистолет с96(10)
						}
						if(ini.getKey("gans", "Colt_M1911A1").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 4, ini.getKey("gans", "Colt_M1911A1").tointeger() ); //кольт 1911(7)
						}
						if(ini.getKey("gans", "Colt_M1911_Special").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 5, ini.getKey("gans", "Colt_M1911_Special").tointeger() ); //кольт 1911 (23)
						}
						if(ini.getKey("gans", "Model_19_Revolver").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 6, ini.getKey("gans", "Model_19_Revolver").tointeger() ); //магнум (6)
						}
						if(ini.getKey("gans", "Remington_Model_870_Field_gun").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 8, ini.getKey("gans", "Remington_Model_870_Field_gun").tointeger() ); //дробовик копов(8)
						}
						if(ini.getKey("gans", "M3_Grease_Gun").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 9, ini.getKey("gans", "M3_Grease_Gun").tointeger() ); //пп (30)
						}
						if(ini.getKey("gans", "MP40").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 10, ini.getKey("gans", "MP40").tointeger() ); //мп40 (32)
						}
						if(ini.getKey("gans", "Thompson_1928").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 11, ini.getKey("gans", "Thompson_1928").tointeger() ); //пп томпсон(50)
						}
						if(ini.getKey("gans", "Molotov_Cocktail").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 21, ini.getKey("gans", "Molotov_Cocktail").tointeger() ); //молотов(1)
						}
						if(ini.getKey("gans", "MK2_Frag_Grenade").tointeger() > 0)
						{
							givePlayerWeapon( playerid, 20, ini.getKey("gans", "MK2_Frag_Grenade").tointeger() ); //граната(1)
						}
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						if(ini.getKey("PlayerInfo", "prisontimer").tointeger() >= 2)
						{
							prisontimer = timer(zona, 60000, -1, playerid);
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							
							setPlayerPosition( playerid, -1030.42,1712.74,10.3595 );
							setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
							setPlayerModel(playerid, 15);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							togglePlayerControls(playerid, false);
							
							sendPlayerMessage(playerid, "Вы преступник.", 255, 255, 0 );
							sendPlayerMessage(playerid, "Вам осталось сидеть " + (ini.getKey("PlayerInfo", "prisontimer").tointeger()-1) + " мин.", 255, 255, 0);
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						if(ini.getKey("PlayerInfo", "prison").tointeger() == 1)//посадка в тюрьму на 10 мин если вышел из игры в наручниках
						{
							prisontimer = timer(zona, 60000, -1, playerid);
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							ini.setKey("PlayerInfo", "prisontimer", 11);
							ini.setKey("PlayerInfo", "prison", 0);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							
							setPlayerPosition( playerid, -1030.42,1712.74,10.3595 );
							setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
							setPlayerModel(playerid, 15);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							togglePlayerControls(playerid, false);
							
							sendPlayerMessage(playerid, "Вы преступник.", 255, 255, 0 );
							sendPlayerMessage(playerid, "Вам осталось сидеть " + (ini.getKey("PlayerInfo", "prisontimer").tointeger()-1) + " мин.", 255, 255, 0);
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							return;
						}
						if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1 || ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "fraction").tointeger() == 5 || ini.getKey("PlayerInfo", "fraction").tointeger() == 6)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, -1578.96,-323.928,-20.3172 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "job").tointeger() == 1 || ini.getKey("PlayerInfo", "job").tointeger() == 2 || ini.getKey("PlayerInfo", "job").tointeger() == 5 || ini.getKey("PlayerInfo", "job").tointeger() == 6 || ini.getKey("PlayerInfo", "job").tointeger() == 9 || ini.getKey("PlayerInfo", "job").tointeger() == 10)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "job").tointeger() == 3)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger());
							//{
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
							{
								triggerClientEvent( playerid, "gpspd", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
							{
								triggerClientEvent( playerid, "gpsjd", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 2)
							{
								triggerClientEvent( playerid, "gpsrinok", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 3)
							{
								triggerClientEvent( playerid, "gpsed", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
							{
								triggerClientEvent( playerid, "gpsarmy", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 5)
							{
								triggerClientEvent( playerid, "gpsport", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 6)
							{
								triggerClientEvent( playerid, "gpstrago", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 7)
							{
								triggerClientEvent( playerid, "gpsbank", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 8)
							{
								triggerClientEvent( playerid, "gpsmeria", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 9)
							{
								triggerClientEvent( playerid, "gpsdepo", "" );
							}
							//}
							return;
						}
						if(ini.getKey("PlayerInfo", "job").tointeger() == 4)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger());
							//{
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 1)
			{
				triggerClientEvent( playerid, "sm1", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 2)
			{
				triggerClientEvent( playerid, "sm2", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 3)
			{
				triggerClientEvent( playerid, "sm3", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 4)
			{
				triggerClientEvent( playerid, "sm4", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 5)
			{
				triggerClientEvent( playerid, "sm5", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 6)
			{
				triggerClientEvent( playerid, "sm6", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 7)
			{
				triggerClientEvent( playerid, "sm7", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 8)
			{
				triggerClientEvent( playerid, "sm8", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 9)
			{
				triggerClientEvent( playerid, "sm9", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 10)
			{
				triggerClientEvent( playerid, "sm10", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 11)
			{
				triggerClientEvent( playerid, "sm11", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 12)
			{
				triggerClientEvent( playerid, "sm12", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 13)
			{
				triggerClientEvent( playerid, "sm13", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 14)
			{
				triggerClientEvent( playerid, "sm14", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 15)
			{
				triggerClientEvent( playerid, "sm15", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 16)
			{
				triggerClientEvent( playerid, "sm16", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 17)
			{
				triggerClientEvent( playerid, "sm17", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 18)
			{
				triggerClientEvent( playerid, "sm18", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 19)
			{
				triggerClientEvent( playerid, "sm19", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 20)
			{
				triggerClientEvent( playerid, "sm20", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 21)
			{
				triggerClientEvent( playerid, "sm21", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 22)
			{
				triggerClientEvent( playerid, "sm22", "" );
			}
			//}
							return;
						}
						if(ini.getKey("PlayerInfo", "job").tointeger() == 8)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger());
							
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
							{
								triggerClientEvent( playerid, "gpsloadmetal", "" );
								local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
								if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
								{
									triggerClientEvent( playerid, "removegps", "" );
									job_timer = timer( premia, 1000, -1, playerid );//таймер премии
									sendPlayerMessage(playerid, "У тебя есть ещё "+ini.getKey("PlayerInfo", "job_timer").tointeger()/60+" минуты.", 255, 255, 0);
								}
								return;
							}
							
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 2)
							{
								triggerClientEvent( playerid, "port_load", "" );
								
								local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
								if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
								{
									triggerClientEvent( playerid, "removegps", "" );
									triggerClientEvent( playerid, "seagift_unload", "" );
									job_timer = timer( premia, 1000, -1, playerid );//таймер премии
									sendPlayerMessage(playerid, "У тебя есть ещё "+ini.getKey("PlayerInfo", "job_timer").tointeger()/60+" минуты.", 255, 255, 0);
								}
								return;
							}
							
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 3)
							{
								triggerClientEvent( playerid, "seagift_load", "" );
								
								local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
								if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
								{
									triggerClientEvent( playerid, "removegps", "" );
									triggerClientEvent( playerid, "port_load", "" );
									job_timer = timer( premia, 1000, -1, playerid );//таймер премии
									sendPlayerMessage(playerid, "У тебя есть ещё "+ini.getKey("PlayerInfo", "job_timer").tointeger()/60+" минуты.", 255, 255, 0);
								}
								return;
							}
							
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
							{
								local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
								if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
								{
									job_timer = timer( premia, 1000, -1, playerid );//таймер премии
									sendPlayerMessage(playerid, "У тебя есть ещё "+ini.getKey("PlayerInfo", "job_timer").tointeger()/60+" минуты.", 255, 255, 0);
								}
								return;
							}
							return;
						}
						if(ini.getKey("PlayerInfo", "job").tointeger() == 11)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
							{
								triggerClientEvent( playerid, "gpsloadgans", "" );
							}
							if(ini.getKey("PlayerInfo", "job_p").tointeger() == 1000)
							{
								triggerClientEvent( playerid, "gpsunloadgans", "" );
							}
							return;
						}
						if(ini.getKey("PlayerInfo", "house").tointeger() == 1)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, 332.879,-367.105,-20.1636 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "house").tointeger() == 2)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, 463.927,-367.105,-20.1636 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "house").tointeger() == 3)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, 529.554,-367.105,-20.1636 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "house").tointeger() == 4)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, 529.605,-441.29,-20.1636 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "house").tointeger() == 5)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, 463.605,-441.29,-20.1636 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "house").tointeger() == 6)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, 397.605,-441.29,-20.1636 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						if(ini.getKey("PlayerInfo", "house").tointeger() == 7)
						{
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, 331.605,-441.29,-20.1636 );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						}
						
							local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
							sendPlayerMessage(playerid, "Вы удачно зашли!", 0, 255, 255);
							sendPlayerMessage(playerid, "Для управления автомобилем вам необходимо купить права, это можно сделать в мерии (зеленый пятиугольник), добраться до неё можно на метро. Чтобы открыть карту нажмите М.", 255, 255, 0);
							sendPlayerMessage(playerid, "Заработь первые деньги вы можете на свалке у бруски.", 0, 255, 0);
							sendPlayerMessage(playerid, "Пополнить здоровье вы можете купив аптечку у госпиталя.", 255, 100, 100);
							ini.setKey("PlayerInfo", "logged", 1);
							ini.saveData();
							togglePlayerControls(playerid, false);
							setPlayerHealth( playerid, ini.getKey("PlayerInfo", "hp" ).tofloat());
							setPlayerPosition( playerid, ini.getKey("PlayerInfo", "spawnx").tofloat(), ini.getKey("PlayerInfo", "spawny").tofloat(), ini.getKey("PlayerInfo", "spawnz").tofloat() );
							setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
							return;
						
					}
					else
					{
					sendPlayerMessage(playerid, "Неверный пароль!", 0, 255, 255);
					}
				}
				else
				{
				sendPlayerMessage(playerid, "Вы уже вошли!", 0, 255, 255);
				}
			}
			else
			{
			sendPlayerMessage(playerid, "Вы не зарегистрировались!", 0, 255, 255);
			}
	}
);
addCommandHandler( "register",
	function( playerid, cmd )
	{
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "password", md5(cmd.tostring()));
			ini.setKey("PlayerInfo", "can", 0);
			ini.setKey("PlayerInfo", "kit", 0);
			ini.setKey("PlayerInfo", "narko_zavisimost", 0);
			ini.setKey("PlayerInfo", "wanted_lvl", 0);
			ini.setKey("PlayerInfo", "job_timer", 0);
			ini.setKey("PlayerInfo", "prisontimer", 0);
			ini.setKey("PlayerInfo", "car_level", 0);
			ini.setKey("PlayerInfo", "carplayer_id", 0);
			ini.setKey("PlayerInfo", "tie_p", 0);
			ini.setKey("PlayerInfo", "narko", 0);
			ini.setKey("PlayerInfo", "banreason", 0);
			ini.setKey("PlayerInfo", "bizneslic", 0);
			ini.setKey("PlayerInfo", "wallet", 0);
			ini.setKey("PlayerInfo", "logged", 0);
			ini.setKey("PlayerInfo", "hp", 720);
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.setKey("PlayerInfo", "point", 0);
			ini.setKey("PlayerInfo", "house", 0);
			ini.setKey("PlayerInfo", "level", 0);
			ini.setKey("PlayerInfo", "money", 500);
			ini.setKey("PlayerInfo", "driverlic", 0);
			ini.setKey("PlayerInfo", "weaponlic", 0);
			ini.setKey("PlayerInfo", "bank", 0);
			ini.setKey("PlayerInfo", "skin", 153);
			ini.setKey("PlayerInfo", "fraction", 0);
			ini.setKey("PlayerInfo", "leader", 0);
			ini.setKey("PlayerInfo", "rang", 0);
			ini.setKey("PlayerInfo", "skin_f", 0);
			ini.setKey("PlayerInfo", "fraction_p", 0);
			ini.setKey("PlayerInfo", "job", 0);
			ini.setKey("PlayerInfo", "job_p", 0);
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "vehicle_p", 0);
			ini.setKey("PlayerInfo", "prison", 0);
			ini.setKey("PlayerInfo", "wanted", 0);
			ini.setKey("PlayerInfo", "taizer", 0);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.setKey("PlayerInfo", "admin", 0);
			ini.setKey("PlayerInfo", "ban", 0);
			ini.setKey("PlayerInfo", "ticket", 0);
			ini.setKey("PlayerInfo", "spawnx", -575.101);
			ini.setKey("PlayerInfo", "spawny", 1622.8);
			ini.setKey("PlayerInfo", "spawnz", -15.6957);
			ini.setKey("PlayerInfo", "car", 54);
			ini.setKey("PlayerInfo", "carrental", 0);
			ini.setKey("PlayerInfo", "car_p", 0);
			ini.setKey("PlayerInfo", "carnumber", 0);
			ini.setKey("PlayerInfo", "carcolor0", 0);
			ini.setKey("PlayerInfo", "carcolor1", 0);
			ini.setKey("PlayerInfo", "carcolor2", 0);
			ini.setKey("PlayerInfo", "carcolor3", 0);
			ini.setKey("PlayerInfo", "carcolor4", 0);
			ini.setKey("PlayerInfo", "carcolor5", 0);
			ini.setKey("PlayerInfo", "car_id", 0);
			
			ini.setKey("gans", "Model_12_Revolver", 0);
			ini.setKey("gans", "Mauser_C96", 0);
			ini.setKey("gans", "Colt_M1911A1", 0);
			ini.setKey("gans", "Colt_M1911_Special", 0);
			ini.setKey("gans", "Model_19_Revolver", 0);
			ini.setKey("gans", "Remington_Model_870_Field_gun", 0);
			ini.setKey("gans", "M3_Grease_Gun", 0);
			ini.setKey("gans", "MP40", 0);
			ini.setKey("gans", "Thompson_1928", 0);
			ini.setKey("gans", "Molotov_Cocktail", 0);
			ini.setKey("gans", "MK2_Frag_Grenade", 0);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы зарегистрировались!", 0, 255, 255);
			sendPlayerMessage(playerid, "А теперь войдите /login (пароль)", 0, 255, 255);
			log(getPlayerName(playerid)+" has registered his account!");
		}
		else
		{
			sendPlayerMessage(playerid, "Такой ник уже есть, выбери другой!", 0, 255, 255);
		}
	}
);

addCommandHandler( "newpassword",
function( playerid, cmd )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	ini.setKey("PlayerInfo", "password", md5(cmd.tostring()));
	ini.saveData();
	sendPlayerMessage(playerid, "Вы поменяли пароль!", 0, 255, 255);
});

//дома
addCommandHandler( "buyhouse",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
		local myPos = getPlayerPosition(playerid)
		local house1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 332.879,-367.105,-20.1636, 10.0 );
		local house2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 463.927,-367.105,-20.1636, 10.0 );
		local house3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 529.554,-367.105,-20.1636, 10.0 );
		local house4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 529.605,-441.29,-20.1636, 10.0 );
		local house5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 463.605,-441.29,-20.1636, 10.0 );
		local house6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 397.605,-441.29,-20.1636, 10.0 );
		local house7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 331.605,-441.29,-20.1636, 10.0 );
		if(house1)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
			{
			return sendPlayerMessage(playerid, "У вас уже есть дом.", 255, 0, 0 );
			}
			if(ini.getKey("PlayerInfo", "money").tointeger() < 30000)
			{
			return sendPlayerMessage(playerid, "Для покупки квартиры нужно 30000$!", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "house", 1);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили квартиру за 30000$!", 255, 255, 0);
			return;
		}
		if(house2)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
			{
			return sendPlayerMessage(playerid, "У вас уже есть дом.", 255, 0, 0 );
			}
			if(ini.getKey("PlayerInfo", "money").tointeger() < 30000)
			{
			return sendPlayerMessage(playerid, "Для покупки квартиры нужно 30000$!", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "house", 2);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили квартиру за 30000$!", 255, 255, 0);
			return;
		}
		if(house3)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
			{
			return sendPlayerMessage(playerid, "У вас уже есть дом.", 255, 0, 0 );
			}
			if(ini.getKey("PlayerInfo", "money").tointeger() < 30000)
			{
			return sendPlayerMessage(playerid, "Для покупки квартиры нужно 30000$!", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "house", 3);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили квартиру за 30000$!", 255, 255, 0);
			return;
		}
		if(house4)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
			{
			return sendPlayerMessage(playerid, "У вас уже есть дом.", 255, 0, 0 );
			}
			if(ini.getKey("PlayerInfo", "money").tointeger() < 30000)
			{
			return sendPlayerMessage(playerid, "Для покупки квартиры нужно 30000$!", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "house", 4);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили квартиру за 30000$!", 255, 255, 0);
			return;
		}
		if(house5)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
			{
			return sendPlayerMessage(playerid, "У вас уже есть дом.", 255, 0, 0 );
			}
			if(ini.getKey("PlayerInfo", "money").tointeger() < 30000)
			{
			return sendPlayerMessage(playerid, "Для покупки квартиры нужно 30000$!", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "house", 5);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили квартиру за 30000$!", 255, 255, 0);
			return;
		}
		if(house6)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
			{
			return sendPlayerMessage(playerid, "У вас уже есть дом.", 255, 0, 0 );
			}
			if(ini.getKey("PlayerInfo", "money").tointeger() < 30000)
			{
			return sendPlayerMessage(playerid, "Для покупки квартиры нужно 30000$!", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "house", 6);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили квартиру за 30000$!", 255, 255, 0);
			return;
		}
		if(house7)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
			{
			return sendPlayerMessage(playerid, "У вас уже есть дом.", 255, 0, 0 );
			}
			if(ini.getKey("PlayerInfo", "money").tointeger() < 30000)
			{
			return sendPlayerMessage(playerid, "Для покупки квартиры нужно 30000$!", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "house", 7);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили квартиру за 30000$!", 255, 255, 0);
			return;
		}

});
addCommandHandler( "sellhouse",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "house").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет дома.", 255, 0, 0 );
		}
		if(ini.getKey("PlayerInfo", "house").tointeger() > 0 && ini.getKey("PlayerInfo", "house").tointeger() <= 7)
		{
			ini.setKey("PlayerInfo", "house", 0);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 15000);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 15000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали квартиру за 15000$!", 255, 255, 0);
			return;
		}
});

//мерия
addEventHandler( "hmeria",
function ( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return;
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -115.11,-63.1035,-11.041, 10.0 );//мерия
	if(check)
	{
		sendPlayerMessage(playerid, "===================[Мерия]===================", 0, 255, 255 );
		sendPlayerMessage(playerid, "/infokazna - посмотреть казну", 255, 255, 0 );
		sendPlayerMessage(playerid, "/buydriverlic - купить права 500$", 255, 255, 0 );
		sendPlayerMessage(playerid, "/buybizneslic - купить лицензию бизнеса 5000$", 255, 255, 0 );
	}
});
addCommandHandler( "infokazna",
function ( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -115.11,-63.1035,-11.041, 10.0 );//мерия
	if(check)
	{
		local ini = EasyINI("biz/kazna.ini");
		sendPlayerMessage(playerid, "Казна города: "+ini.getKey("CH", "kazna").tointeger()+"$", 0, 255, 0 );
	}
});

addCommandHandler( "settax",
function ( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local id = id.tointeger();
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 6 && ini.getKey("PlayerInfo", "leader").tointeger() == 6)
	{
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "tax", id);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы установили налог в размере: "+id+"$", 100, 100, 255 );
	}
});

addCommandHandler( "buydriverlic",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -115.11,-63.1035,-11.041, 10.0 );//мерия
	if(check)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "driverlic").tointeger() == 0)
		{
			if(ini.getKey("PlayerInfo", "money").tointeger() >= 500)
			{
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 500);
			ini.setKey("PlayerInfo", "driverlic", 1);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили права за 500$.", 255, 100, 0 );
			}
			else
			{
			sendPlayerMessage(playerid, "Недостаточно средств, необходимо 500$.", 255, 0, 0 );
			}
			
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть права.", 255, 0, 0 );
		}
	}
});

addCommandHandler( "buybizneslic",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -115.11,-63.1035,-11.041, 10.0 );//мерия
	if(check)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
			if(ini.getKey("PlayerInfo", "money").tointeger() >= 5000)
			{
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 5000);
			ini.setKey("PlayerInfo", "bizneslic", 1);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 5000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы купили лицензию на владение бизнесом за 5000$.", 255, 100, 0 );
			}
			else
			{
			sendPlayerMessage(playerid, "Недостаточно средств, необходимо 5000$.", 255, 0, 0 );
			}
			
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть лицензия на владение бизнесом.", 255, 0, 0 );
		}
	}
});

addCommandHandler( "pay",
function( playerid, id, money )
{
	local id = id.tointeger();
	local money = money.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
		}

		local myPos = getPlayerPosition( playerid );
		local Pos = getPlayerPosition( id );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 5.0 );
		if(check)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() >= money)
			{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
				ini.saveData();
				
				local ini = EasyINI("account/"+getPlayerName(id)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
				ini.saveData();
				
				sendPlayerMessage(playerid, "Вы передали "+getPlayerName(id)+" "+money+"$", 255, 100, 0);
				sendPlayerMessage(id, getPlayerName(playerid)+" передал вам "+money+"$", 0, 255, 0);
				
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
			}
		}
});

//{банк(начало)
addEventHandler( "bankinfo",
function( playerid )
{
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
		sendPlayerMessage(playerid, "==============[Grand Imperial Bank]===============", 0, 255, 255);
		sendPlayerMessage(playerid, "/balance - узнать баланс", 255, 255, 0);
		sendPlayerMessage(playerid, "/deposit - положить деньги в банк", 255, 255, 0);
		sendPlayerMessage(playerid, "/depositbiznes - положить деньги на счет бизнеса", 255, 255, 0);
		sendPlayerMessage(playerid, "/depositfrac - положить деньги на счет фракции", 255, 255, 0);
		sendPlayerMessage(playerid, "/withdraw - снять деньги с банка", 255, 255, 0);
		sendPlayerMessage(playerid, "/withdrawbiznes - снять деньги со счета бизнеса", 255, 255, 0);
		sendPlayerMessage(playerid, "/withdrawfrac - снять деньги со счета фракции", 255, 255, 0);
	}
});

addCommandHandler( "balance",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
	sendPlayerMessage(playerid, "Лицевой счет банка: "+ini.getKey("PlayerInfo", "bank").tointeger()+"$", 0, 255, 0);
			
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#1: "+ini.getKey("FS#1", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#2: "+ini.getKey("FS#2", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#3: "+ini.getKey("FS#3", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#4: "+ini.getKey("FS#4", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#5: "+ini.getKey("FS#5", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#6: "+ini.getKey("FS#6", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#7: "+ini.getKey("FS#7", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет бизнеса FS#8: "+ini.getKey("FS#8", "fs_money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет сети Empire Diner: "+ini.getKey("ED", "money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет сети Баров: "+ini.getKey("BAR", "money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет сети Автомастерских: "+ini.getKey("REPAIR", "money").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 12)
	{
		local ini = EasyINI("biz/biznes.ini");
		sendPlayerMessage(playerid, "Лицевой счет сети Магазинов оружия: "+ini.getKey("GANS", "money").tointeger()+"$", 0, 255, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
	{
		local ini = EasyINI("biz/kazna.ini");
		sendPlayerMessage(playerid, "Лицевой счет Триады: "+ini.getKey("drugs", "money_triada").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
	{
		local ini = EasyINI("biz/kazna.ini");
		sendPlayerMessage(playerid, "Лицевой счет Ирландцев: "+ini.getKey("irish", "money_irish").tointeger()+"$", 0, 255, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 6)
	{
		local ini = EasyINI("biz/kazna.ini");
		sendPlayerMessage(playerid, "Лицевой счет Мерии: "+ini.getKey("CH", "kazna").tointeger()+"$", 0, 255, 0);
	}
	
	}
});

addCommandHandler( "deposit",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
	local id = id.tointeger();
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "money").tointeger() >= id)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - id);
		ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
		ini.saveData();
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage(playerid, "Вы положили на счет " +id+ "$", 255, 100, 0);
	}
	else
	{
		sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
	}
	}
});

//{depositbiznes
addCommandHandler( "depositbiznes",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
	local id = id.tointeger();
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0 );
	}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "bank").tointeger() >= id)
		{
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("ED", "money", ini.getKey("ED", "money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("BAR", "money", ini.getKey("BAR", "money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("REPAIR", "money", ini.getKey("REPAIR", "money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 12)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + id);
				ini.saveData();
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
				ini.saveData();
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы положили на счет бизнеса " +id+ "$", 255, 100, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств на банковском счете.", 255, 0, 0 );
		}
	}
});
//}

addCommandHandler( "depositfrac",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
	local id = id.tointeger();
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "bank").tointeger() >= id)
		{
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("drugs", "money_triada", ini.getKey("drugs", "money_triada").tointeger() + id);
			ini.saveData();
				
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
			ini.saveData();

			sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
			sendPlayerMessage(playerid, "Вы положили на счет триады " +id+ "$", 255, 100, 0);
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств на банковском счете.", 255, 0, 0 );
		}
		return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "bank").tointeger() >= id)
		{
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("irish", "money_irish", ini.getKey("irish", "money_irish").tointeger() + id);
			ini.saveData();
				
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
			ini.saveData();

			sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
			sendPlayerMessage(playerid, "Вы положили на счет ирландцев " +id+ "$", 255, 100, 0);
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств на банковском счете.", 255, 0, 0 );
		}
		return;
	}

	sendPlayerMessage(playerid, "Вы не состоите во фракции.", 255, 0, 0);
	}
});

addCommandHandler( "withdraw",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
	local id = id.tointeger();
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "bank").tointeger() >= id)
	{
		ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() - id);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + id);
		ini.saveData();
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage(playerid, "Вы сняли со счета " +id+ "$", 0, 255, 0);
	}
	else
	{
		sendPlayerMessage(playerid, "Недостаточно средств на банковском счете.", 255, 0, 0 );
	}
	}
});

//{withdrawbiznes
addCommandHandler( "withdrawbiznes",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
	local id = id.tointeger();
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0 );
	}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#1", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#2", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
				
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#3", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
				
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#4", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
				
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#5", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
				
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#6", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
				
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#7", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
				
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#8", "fs_money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("ED", "money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("ED", "money", ini.getKey("ED", "money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("BAR", "money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("BAR", "money", ini.getKey("BAR", "money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("REPAIR", "money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("REPAIR", "money", ini.getKey("REPAIR", "money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 12)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("GANS", "money").tointeger() >= id)
			{
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() - id);
				ini.saveData();
					
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
				ini.saveData();
					
				sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
				sendPlayerMessage(playerid, "Вы сняли со счета бизнеса " +id+ "$", 0, 255, 0);
			}
			else
			{
				sendPlayerMessage(playerid, "Недостаточно средств на счете бизнеса.", 255, 0, 0 );
			}
			return;
		}
	}
});
//}

addCommandHandler( "withdrawfrac",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 67.2002,-202.94,-19.2324, 10.0 );
	if(check)
	{
	local id = id.tointeger();
local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "rang").tointeger() >= 3)
	{
		local ini = EasyINI("biz/kazna.ini");
		if(ini.getKey("drugs", "money_triada").tointeger() >= id)
		{
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("drugs", "money_triada", ini.getKey("drugs", "money_triada").tointeger() - id);
			ini.saveData();
				
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
			ini.saveData();

			sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
			sendPlayerMessage(playerid, "Вы сняли со счета триады " +id+ "$", 0, 255, 0);
			log("");
			log("[TRIADA] " +getPlayerName(playerid)+ " снял со счета фракции " +id+ "$");
			log("");
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств на счете триады.", 255, 0, 0 );
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Снимать деньги можно с 3 ранга и выше.", 255, 0, 0);
	}
	return;
}

local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "rang").tointeger() >= 3)
	{
		local ini = EasyINI("biz/kazna.ini");
		if(ini.getKey("irish", "money_irish").tointeger() >= id)
		{
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("irish", "money_irish", ini.getKey("irish", "money_irish").tointeger() - id);
			ini.saveData();
				
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
			ini.saveData();

			sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
			sendPlayerMessage(playerid, "Вы сняли со счета ирландцев " +id+ "$", 0, 255, 0);
			log("");
			log("[IRISH] " +getPlayerName(playerid)+ " снял со счета фракции " +id+ "$");
			log("");
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств на счете ирландцев.", 255, 0, 0 );
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Снимать деньги можно с 3 ранга и выше.", 255, 0, 0);
	}
	return;
}

local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
if(ini.getKey("PlayerInfo", "fraction").tointeger() == 6)
{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
		local ini = EasyINI("biz/kazna.ini");
		if(ini.getKey("CH", "kazna").tointeger() >= id)
		{
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - id);
			ini.saveData();
				
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "bank", ini.getKey("PlayerInfo", "bank").tointeger() + id);
			ini.saveData();

			sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
			sendPlayerMessage(playerid, "Вы сняли со счета мерии " +id+ "$", 0, 255, 0);
			log("");
			log("[CH] " +getPlayerName(playerid)+ " снял со счета фракции " +id+ "$");
			log("");
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств на счете мерии.", 255, 0, 0 );
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Снимать деньги можно только меру.", 255, 0, 0);
	}
	return;
}

sendPlayerMessage(playerid, "Вы не состоите во фракции.", 255, 0, 0);
	}
});
//}банк(конец)

//команды игрока(начало)
addCommandHandler( "showlic",
function( playerid, id)
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
		}

	local pos = getPlayerPosition(playerid);
	local myPos= getPlayerPosition(id);
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
	if(check)
	{	
	sendPlayerMessage(playerid, "Вы показали лицензии "+getPlayerName(id), 255, 255, 0);
	sendPlayerMessage(id,getPlayerName(playerid)+" показал вам лицензии.", 255, 255, 0);
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	
	sendPlayerMessage(id, "================[ЛИЦЕНЗИИ]===================", 0, 255, 255);
	if(ini.getKey("PlayerInfo", "weaponlic").tointeger() == 0)
	{
	sendPlayerMessage(id, "Лицензия на оружие: Отсутствует", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "weaponlic").tointeger() == 1)
	{
	sendPlayerMessage(id, "Лицензия на оружие: Имеется", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
	{
	sendPlayerMessage(id, "Лиц. на вед. бизнеса: Отсутствует", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "bizneslic").tointeger() > 0)
	{
	sendPlayerMessage(id, "Лиц. на вед. бизнеса: Имеется", 255, 255, 0);
	}
	
	}
});

addCommandHandler( "pass",
function( playerid, id)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
		}

	local pos = getPlayerPosition(playerid);
	local myPos= getPlayerPosition(id.tointeger());
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
	if(check)
	{
	sendPlayerMessage(playerid, "Вы показали паспорт "+getPlayerName(id.tointeger()), 255, 255, 0);
	sendPlayerMessage(id.tointeger(),getPlayerName(playerid)+" показал вам паспорт.", 255, 255, 0);
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	
	sendPlayerMessage(id.tointeger(), "=================[ПАСПОРТ]===================", 0, 255, 255);
	
	sendPlayerMessage(id.tointeger(), "Лет в городе: "+ini.getKey("PlayerInfo", "level").tointeger(), 255, 255, 0);
	
	if(ini.getKey("PlayerInfo", "job").tointeger() == 0)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Безработный", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Докер", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 2)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Доставщик сигарет", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 3)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Водитель автобуса", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 4)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Таксист", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Развозчик топлива", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 6)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Механик", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Металлоломщик", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Водитель", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 9)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Обработчик на рыбзаводе", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 10)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Доставщик мяса", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 11)
	{
	sendPlayerMessage(id.tointeger(), "Работа: Доставщик патронов", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "rang").tointeger() == 0)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Не состоит Ранг: Не имеет", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Полицейский Ранг: Стажер", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Полицейский Ранг: Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Полицейский Ранг: Ст.Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Полицейский Ранг: Детектив", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Полицейский Ранг: Капитан", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 6)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Полицейский Ранг: Шериф", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Медик Ранг: Стажер", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Медик Ранг: Терапевт", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Медик Ранг: Хирург", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Медик Ранг: Зам глав.врача", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Медик Ранг: Глав.врач", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Рядовой", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Ст.Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Прапорщик", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Лейтенант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 6)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Капитан", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 7)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Майор", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 8)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Подполковник", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 9)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Полковник", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 10)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Армия ЭБ Ранг: Генерал Армии ЭБ", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Триада Ранг: Монах", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Триада Ранг: Красный шест", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Триада Ранг: Веер из белой бумаги", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Триада Ранг: Управитель", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Триада Ранг: Мастер горы", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Ирландцы Ранг: Динни", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Ирландцы Ранг: Мясник младший", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Ирландцы Ранг: Мясник", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Ирландцы Ранг: Дикий", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Ирландцы Ранг: Главарь", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 6 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Фракция: Мерия Ранг: Мэр", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "car").tointeger() == 54)
	{
	sendPlayerMessage(id.tointeger(), "Машина отсутствует", 0, 150, 255);
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() < 54)
	{
		if(ini.getKey("PlayerInfo", "car").tointeger() == 0)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Ascot Bailey", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 1)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Berkley Kingfisher", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 6)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Walter Hot Rod", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 7)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Smith 34 Hot Rod", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 8)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Shubert Pickup Hot Rod", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 9)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Houston Wasp", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 10)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: ISW 508", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 12)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Walter Utility", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 13)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Jefferson Futura", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 14)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Jefferson Provincial", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 15)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Lassister Series 69", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 18)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Lassister Series 75 Hollywood", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 22)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Potomac Indian", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 23)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Quicksilver Windsor", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 25)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Shubert 38", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 28)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Shubert Beverly", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 29)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Shubert Frigate", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 31)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Shubert 38 Panel Truck", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 41)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Smith Custom 200", 0, 150, 255);
		}	
		if(ini.getKey("PlayerInfo", "car").tointeger() == 43)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Smith Coupe", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 44)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Smith Mainline", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 45)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Smith Thunderbolt", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 47)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Smith V8", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 48)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Smith Deluxe Station Wagon", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 50)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Culver Empire", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 52)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Walker Rocket", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 53)
		{
			sendPlayerMessage(id.tointeger(), "Название машины: Walter Coupe", 0, 150, 255);
		}
	}
	
	
	sendPlayerMessage(id.tointeger(), "Номер машины: "+ini.getKey("PlayerInfo", "carnumber").tostring() + " Уровень тюнинга: "+ini.getKey("PlayerInfo", "car_level").tointeger(), 0, 150, 255);

	
	if(ini.getKey("PlayerInfo", "driverlic").tointeger() == 0)
	{
	sendPlayerMessage(id.tointeger(), "Права: Отсутствуют", 0, 150, 255);
	}
	if(ini.getKey("PlayerInfo", "driverlic").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Права: Есть", 0, 150, 255);
	}
	
	
	if(ini.getKey("PlayerInfo", "house").tointeger() == 0)
	{
	sendPlayerMessage(id.tointeger(), "Прописка: Отсутствует", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
	{
	sendPlayerMessage(id.tointeger(), "Прописка: Имеется", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Отсутствует", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #1", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #2", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #3", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #4", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #5", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #6", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #7", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Filling Station #8", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Сеть Empire Diner", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Сеть Баров", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Сеть Автомастерских", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 12)
	{
	sendPlayerMessage(id.tointeger(), "Бизнес: Сеть Магазинов оружия", 255, 255, 0);
	}
	
	}
}
);

addCommandHandler( "stats",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
	sendPlayerMessage(playerid, "================[СТАТИСТИКА]==================", 0, 255, 255);
	
	sendPlayerMessage(playerid, "Лет в городе: "+ini.getKey("PlayerInfo", "level").tointeger()+" EXP: "+ini.getKey("PlayerInfo", "point").tointeger(), 255, 255, 0);
	
	if(ini.getKey("PlayerInfo", "job").tointeger() == 0)
	{
	sendPlayerMessage(playerid, "Работа: Безработный", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Работа: Докер", 255, 255, 0);//пассив
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 2)
	{
	sendPlayerMessage(playerid, "Работа: Доставщик сигарет", 255, 255, 0);//пассив
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 3)
	{
	sendPlayerMessage(playerid, "Работа: Водитель автобуса", 255, 255, 0);//пассив
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 4)
	{
	sendPlayerMessage(playerid, "Работа: Таксист", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
	sendPlayerMessage(playerid, "Работа: Развозчик топлива", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 6)
	{
	sendPlayerMessage(playerid, "Работа: Механик", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
	{
	sendPlayerMessage(playerid, "Работа: Металлоломщик", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8)
	{
	sendPlayerMessage(playerid, "Работа: Водитель", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 9)
	{
	sendPlayerMessage(playerid, "Работа: Обработчик на рыбзаводе", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 10)
	{
	sendPlayerMessage(playerid, "Работа: Доставщик мяса", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 11)
	{
	sendPlayerMessage(playerid, "Работа: Доставщик патронов", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "rang").tointeger() == 0)
	{
	sendPlayerMessage(playerid, "Фракция: Не состоит Ранг: Не имеет", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Фракция: Полицейский Ранг: Стажер", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(playerid, "Фракция: Полицейский Ранг: Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(playerid, "Фракция: Полицейский Ранг: Ст.Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(playerid, "Фракция: Полицейский Ранг: Детектив", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(playerid, "Фракция: Полицейский Ранг: Капитан", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() == 6)
	{
	sendPlayerMessage(playerid, "Фракция: Полицейский Ранг: Шериф", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Фракция: Медик Ранг: Стажер", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(playerid, "Фракция: Медик Ранг: Терапевт", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(playerid, "Фракция: Медик Ранг: Хирург", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(playerid, "Фракция: Медик Ранг: Зам глав.врача", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(playerid, "Фракция: Медик Ранг: Глав.врач", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Рядовой", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Ст.Сержант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Прапорщик", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Лейтенант", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 6)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Капитан", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 7)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Майор", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 8)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Подполковник", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 9)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Полковник", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() == 10)
	{
	sendPlayerMessage(playerid, "Фракция: Армия ЭБ Ранг: Генерал Армии ЭБ", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Фракция: Триада Ранг: Монах", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(playerid, "Фракция: Триада Ранг: Красный шест", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(playerid, "Фракция: Триада Ранг: Веер из белой бумаги", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(playerid, "Фракция: Триада Ранг: Управитель", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(playerid, "Фракция: Триада Ранг: Мастер горы", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Фракция: Ирландцы Ранг: Динни", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 2)
	{
	sendPlayerMessage(playerid, "Фракция: Ирландцы Ранг: Мясник младший", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 3)
	{
	sendPlayerMessage(playerid, "Фракция: Ирландцы Ранг: Мясник", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 4)
	{
	sendPlayerMessage(playerid, "Фракция: Ирландцы Ранг: Дикий", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() == 5)
	{
	sendPlayerMessage(playerid, "Фракция: Ирландцы Ранг: Главарь", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 6 && ini.getKey("PlayerInfo", "rang").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Фракция: Мерия Ранг: Мэр", 255, 255, 0);
	}
	
	
	sendPlayerMessage(playerid, "Уровень зависимости: " +ini.getKey("PlayerInfo", "narko_zavisimost").tointeger(), 255, 100, 100);
	
	sendPlayerMessage(playerid, "Уровень розыска: " +ini.getKey("PlayerInfo", "wanted_lvl").tointeger()+ " Уголовных дел возбуждено: " +ini.getKey("PlayerInfo", "wanted").tointeger()+ " Штраф: " +ini.getKey("PlayerInfo", "ticket").tointeger()+ "$", 0, 150, 255);
	
	
	if(ini.getKey("PlayerInfo", "car").tointeger() == 54)
	{
	sendPlayerMessage(playerid, "Машина отсутствует", 0, 150, 255);
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() < 54)
	{
		if(ini.getKey("PlayerInfo", "car").tointeger() == 0)
		{
			sendPlayerMessage(playerid, "Название машины: Ascot Bailey", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 1)
		{
			sendPlayerMessage(playerid, "Название машины: Berkley Kingfisher", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 6)
		{
			sendPlayerMessage(playerid, "Название машины: Walter Hot Rod", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 7)
		{
			sendPlayerMessage(playerid, "Название машины: Smith 34 Hot Rod", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 8)
		{
			sendPlayerMessage(playerid, "Название машины: Shubert Pickup Hot Rod", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 9)
		{
			sendPlayerMessage(playerid, "Название машины: Houston Wasp", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 10)
		{
			sendPlayerMessage(playerid, "Название машины: ISW 508", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 12)
		{
			sendPlayerMessage(playerid, "Название машины: Walter Utility", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 13)
		{
			sendPlayerMessage(playerid, "Название машины: Jefferson Futura", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 14)
		{
			sendPlayerMessage(playerid, "Название машины: Jefferson Provincial", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 15)
		{
			sendPlayerMessage(playerid, "Название машины: Lassister Series 69", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 18)
		{
			sendPlayerMessage(playerid, "Название машины: Lassister Series 75 Hollywood", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 22)
		{
			sendPlayerMessage(playerid, "Название машины: Potomac Indian", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 23)
		{
			sendPlayerMessage(playerid, "Название машины: Quicksilver Windsor", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 25)
		{
			sendPlayerMessage(playerid, "Название машины: Shubert 38", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 28)
		{
			sendPlayerMessage(playerid, "Название машины: Shubert Beverly", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 29)
		{
			sendPlayerMessage(playerid, "Название машины: Shubert Frigate", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 31)
		{
			sendPlayerMessage(playerid, "Название машины: Shubert 38 Panel Truck", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 41)
		{
			sendPlayerMessage(playerid, "Название машины: Smith Custom 200", 0, 150, 255);
		}	
		if(ini.getKey("PlayerInfo", "car").tointeger() == 43)
		{
			sendPlayerMessage(playerid, "Название машины: Smith Coupe", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 44)
		{
			sendPlayerMessage(playerid, "Название машины: Smith Mainline", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 45)
		{
			sendPlayerMessage(playerid, "Название машины: Smith Thunderbolt", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 47)
		{
			sendPlayerMessage(playerid, "Название машины: Smith V8", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 48)
		{
			sendPlayerMessage(playerid, "Название машины: Smith Deluxe Station Wagon", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 50)
		{
			sendPlayerMessage(playerid, "Название машины: Culver Empire", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 52)
		{
			sendPlayerMessage(playerid, "Название машины: Walker Rocket", 0, 150, 255);
		}
		if(ini.getKey("PlayerInfo", "car").tointeger() == 53)
		{
			sendPlayerMessage(playerid, "Название машины: Walter Coupe", 0, 150, 255);
		}
	}
	
	sendPlayerMessage(playerid, "Номер машины: "+ini.getKey("PlayerInfo", "carnumber").tostring() + " Уровень тюнинга: "+ini.getKey("PlayerInfo", "car_level").tointeger(), 0, 150, 255);

	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "driverlic").tointeger() == 0)
	{
	sendPlayerMessage(playerid, "Права: Отсутствуют", 0, 150, 255);
	}
	if(ini.getKey("PlayerInfo", "driverlic").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Права: Есть", 0, 150, 255);
	}
	
	
	if(ini.getKey("PlayerInfo", "house").tointeger() == 0)
	{
	sendPlayerMessage(playerid, "Прописка: Отсутствует", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "house").tointeger() > 0)
	{
	sendPlayerMessage(playerid, "Прописка: Имеется", 255, 255, 0);
	}
	
	
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
	{
	sendPlayerMessage(playerid, "Бизнес: Отсутствует", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #1", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #2", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #3", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #4", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #5", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #6", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #7", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
	{
	sendPlayerMessage(playerid, "Бизнес: Filling Station #8", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
	{
	sendPlayerMessage(playerid, "Бизнес: Сеть Empire Diner", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
	{
	sendPlayerMessage(playerid, "Бизнес: Сеть Баров", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
	{
	sendPlayerMessage(playerid, "Бизнес: Сеть Автомастерских", 255, 255, 0);
	}
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 12)
	{
	sendPlayerMessage(playerid, "Бизнес: Сеть Магазинов оружия", 255, 255, 0);
	}
}
);

addCommandHandler( "usedrugs",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "narko").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "У вас нет наркотиков.", 255, 0, 0);
	}
	foreach(i, playername in getPlayers()) 
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
		local myPos = getPlayerPosition( i );
		local pos = getPlayerPosition( playerid );
		local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
		if(check)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "narko", ini.getKey("PlayerInfo", "narko").tointeger() - 1 );
			ini.setKey("PlayerInfo", "narko_zavisimost", ini.getKey("PlayerInfo", "narko_zavisimost").tointeger() + 1 );
			ini.saveData();
			triggerClientEvent( playerid, "narko", "" );
			setPlayerHealth( playerid, getPlayerHealth( playerid ) + 100.0);
			sendPlayerMessage( i, "(ME) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]: употребил наркотики.", 255, 50, 255 );
		}
	}
	sendPlayerMessage(playerid, "Вы употребили 1 грамм наркотиков.", 255, 255, 0);
});
addCommandHandler( "inv",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	sendPlayerMessage(playerid, "================[ИНВЕНТАРЬ]==================", 0, 255, 255);
	sendPlayerMessage(playerid, "У вас "+ini.getKey("PlayerInfo", "narko").tointeger()+" граммов наркотиков.", 255, 255, 0);
	sendPlayerMessage(playerid, "У вас "+ini.getKey("PlayerInfo", "kit").tointeger()+" аптечек.", 255, 255, 0);
});

addCommandHandler( "wallet",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
	{
		ini.setKey("PlayerInfo", "wallet", 1);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы достали кошелек.", 255, 255, 0 );
	}
	else
	{
		ini.setKey("PlayerInfo", "wallet", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы убрали кошелек.", 255, 255, 0 );
	}
});

//прокачка уровня
addCommandHandler( "levelup",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "point").tointeger() >= 6 && ini.getKey("PlayerInfo", "money").tointeger() >= 1000)
	{
		ini.setKey("PlayerInfo", "point", ini.getKey("PlayerInfo", "point").tointeger() - 6);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1000);
		ini.setKey("PlayerInfo", "level", ini.getKey("PlayerInfo", "level").tointeger() + 1);
		ini.saveData();
		sendPlayerMessage(playerid, "Поздравляем, вы прокачались!", 255, 255, 0 );
	}
	else
	{
		sendPlayerMessage(playerid, "Для прокачки нужно 6 exp и 1000$", 255, 0, 0 );
	}
});

//subway
addEventHandler( "subway_menu",
function( playerid)
{
	local myPos = getPlayerPosition( playerid );
	local subway1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -554.36,1592.92,-21.8639, 5.0 );
	local subway2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1119.15,1376.71,-19.7724, 5.0 );
	local subway3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1535.55,-231.03,-13.5892, 5.0 );
	local subway4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -511.412,20.1703,-5.7096, 5.0 );
	local subway5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -113.792,-481.71,-8.92243, 5.0 );
	local subway6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 234.395,380.914,-9.41271, 5.0 );
	local subway7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -293.069,568.25,-2.27367, 5.0 );
	
	if( subway1 || subway2 || subway3 || subway4 || subway5 || subway6 || subway7)
	{
		sendPlayerMessage(playerid, "==============[SUBWAY EMPIRE BAY]===============", 0, 255, 255 );
		sendPlayerMessage(playerid, "/subway 1 - ЖД Вокзал", 255, 255, 0 );
		sendPlayerMessage(playerid, "/subway 2 - Авторынок", 255, 255, 0 );
		sendPlayerMessage(playerid, "/subway 3 - Армия ЭБ", 255, 255, 0 );
		sendPlayerMessage(playerid, "/subway 4 - Аркадия", 255, 255, 0 );
		sendPlayerMessage(playerid, "/subway 5 - Городской Порт", 255, 255, 0 );
		sendPlayerMessage(playerid, "/subway 6 - Китайский Квартал", 255, 255, 0 );
		sendPlayerMessage(playerid, "/subway 7 - Полицейский Департамент ЭБ", 255, 255, 0 );
	}
});

addCommandHandler( "subway",
function( playerid, id)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local id = id.tointeger();
	local myPos = getPlayerPosition( playerid );
	local subway1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -554.36,1592.92,-21.8639, 5.0 );
	local subway2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1119.15,1376.71,-19.7724, 5.0 );
	local subway3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1535.55,-231.03,-13.5892, 5.0 );
	local subway4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -511.412,20.1703,-5.7096, 5.0 );
	local subway5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -113.792,-481.71,-8.92243, 5.0 );
	local subway6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 234.395,380.914,-9.41271, 5.0 );
	local subway7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -293.069,568.25,-2.27367, 5.0 );
	
	if( subway1 || subway2 || subway3 || subway4 || subway5 || subway6 || subway7)
	{
	if(!subway1 && id == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10);
			setPlayerPosition(playerid, -554.36,1592.92,-21.8639);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 10);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на станции ЖД Вокзал.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}					
	}
	
	if(!subway2 && id == 2)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10);
			setPlayerPosition(playerid, -1118.99,1376.44,-18.5);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 10);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на станции Авторынок.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}					
	}
	
	if(!subway3 && id == 3)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10);
			setPlayerPosition(playerid, -1535.55,-231.03,-13.5892);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 10);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на станции Армия ЭБ.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}					
	}
	
	if(!subway4 && id == 4)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10);
			setPlayerPosition(playerid, -511.412,20.1703,-5.7096);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 10);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на станции Аркадия.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}					
	}
	
	if(!subway5 && id == 5)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10);
			setPlayerPosition(playerid, -113.792,-481.71,-8.92243);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 10);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на станции Городской Порт.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}					
	}
	
	if(!subway6 && id == 6)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10);
			setPlayerPosition(playerid, 234.395,380.914,-9.41271);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 10);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на станции Китайский Квартал.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}					
	}
	
	if(!subway7 && id == 7)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10);
			setPlayerPosition(playerid, -293.069,568.25,-2.27367);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 10);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на станции Полицейский Департамент ЭБ.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}					
	}
	
	}
});

function carrental(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	if(!isPlayerConnected(playerid))
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "carrental").tointeger() == 0)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 50);
	ini.saveData();
			
	local ini = EasyINI("biz/kazna.ini");
	ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 50);
	ini.saveData();
	
	triggerClientEvent( playerid, "crhudtimer", "" );
	sendPlayerMessage(playerid, "Прошло 10 минут, за аренду машины вы заплатили 50$", 255, 100, 0 );
	
}

//car rental
addCommandHandler( "carrental",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	local vehicleid = getPlayerVehicle(playerid);
	local plate = getVehiclePlateText(vehicleid);
	if(plate == "rental")
	{
		if(ini.getKey("PlayerInfo", "carrental").tointeger() == 1)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 50)
		{
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 50);
			ini.setKey("PlayerInfo", "carrental", 1);
			ini.saveData();
			
			cr = timer( carrental, 600000, -1, playerid );
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 50);
			ini.saveData();
			
			togglePlayerControls( playerid, false );
			triggerClientEvent( playerid, "crhudtimer", "" );
			sendPlayerMessage(playerid, "Вы арендовали машину, с вас взяли предоплату в размере 50$", 255, 100, 0 );
			sendPlayerMessage(playerid, "Чтобы отменить аренду введите /uncarrental", 255, 100, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы находитесь не в подходящей машине.", 255, 0, 0 );
	}
});
addCommandHandler( "uncarrental",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
	if(isPlayerInVehicle(playerid))
	{
	sendPlayerMessage(playerid, "Выйдите из машины.", 255, 0, 0 );
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "carrental").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "У вас нет арендованной машины.", 255, 0, 0 );
	}
	ini.setKey("PlayerInfo", "carrental", 0);
	ini.saveData();
	cr.Kill();
	triggerClientEvent( playerid, "deshudtimer", "" );
	sendPlayerMessage(playerid, "Аренда машины отменена.", 255, 255, 0 );
});

//телефон
addEventHandler( "callphone",
function( playerid)
{
	local myPos = getPlayerPosition( playerid );
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
	if(bydka1 || bydka2 || bydka3 || bydka4 || bydka5 || bydka6 || bydka7 || bydka8 || bydka9 || bydka10 || bydka11 || bydka12 || bydka13 || bydka14 || bydka15 || bydka16)
	{
	sendPlayerMessage(playerid, "==============[ТЕЛЕФОННАЯ БУДКА]==============", 0, 255, 255 );
	sendPlayerMessage(playerid, "/callmech - доставить вашу машину", 255, 255, 0 );
	sendPlayerMessage(playerid, "/callpolice - позвонить в полицию", 255, 255, 0 );
	sendPlayerMessage(playerid, "/callmed - позвонить медикам", 255, 255, 0 );
	sendPlayerMessage(playerid, "/calltaxi - вызвать такси ", 255, 255, 0 );
	}
});

addCommandHandler( "calltaxi",
function( playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
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
	
	if(bydka1 || bydka2 || bydka3 || bydka4 || bydka5 || bydka6 || bydka7 || bydka8 || bydka9 || bydka10 || bydka11 || bydka12 || bydka13 || bydka14 || bydka15 || bydka16)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 4 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
		{
		return sendPlayerMessage(playerid, "Вы таксист.", 255, 0, 0 );
		}
		
		sendPlayerMessage(playerid, "Вы позвонили диспетчеру, пожалуйста оставайтесь на месте и ждите таксиста.", 255, 255, 0 );

		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
			{
			return;
			}
			
			local pos = getPlayerPosition(playerid);
			local mypos = getPlayerPosition(i);
			local dist = getDistanceBetweenPoints3D(pos[0], pos[1], pos[2], mypos[0],  mypos[1],  mypos[2]);
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 4 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				if(bydka1)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Риверсайд", 255, 255, 0 );
				}
				if(bydka2)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Кингстон", 255, 255, 0 );
				}
				if(bydka3)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Гринфилд", 255, 255, 0 );
				}
				if(bydka4)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Хантерс-Пойнт", 255, 255, 0 );
				}
				if(bydka5)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Сэнд-Айленд", 255, 255, 0 );
				}
				if(bydka6)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Сауспорт", 255, 255, 0 );
				}
				if(bydka7)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Ойстер-Бэй", 255, 255, 0 );
				}
				if(bydka8)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Южный Милвилл", 255, 255, 0 );
				}
				if(bydka9)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Мидтаун", 255, 255, 0 );
				}
				if(bydka10)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Вест-Сайд", 255, 255, 0 );
				}
				if(bydka11)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Китайский Квартал", 255, 255, 0 );
				}
				if(bydka12)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Северный Милвилл", 255, 255, 0 );
				}
				if(bydka13)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Маленькая Италия", 255, 255, 0 );
				}
				if(bydka14)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Хилвуд", 255, 255, 0 );
				}
				if(bydka15)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Аптаун", 255, 255, 0 );
				}
				if(bydka16)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" вызвал такси, он находится от вас в "+dist+" метрах. Район: Ист-Сайд", 255, 255, 0 );
				}
			}
		}
	}
});

addCommandHandler( "callmed",
function( playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
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
	
	if(bydka1 || bydka2 || bydka3 || bydka4 || bydka5 || bydka6 || bydka7 || bydka8 || bydka9 || bydka10 || bydka11 || bydka12 || bydka13 || bydka14 || bydka15 || bydka16)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2)
		{
		return sendPlayerMessage(playerid, "Вы медик.", 255, 0, 0 );
		}
		
		sendPlayerMessage(playerid, "Вы позвонили в скорую, пожалуйста оставайтесь на месте и ждите медиков.", 255, 255, 0 );

		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
			{
			return;
			}
			
			local pos = getPlayerPosition(playerid);
			local mypos = getPlayerPosition(i);
			local dist = getDistanceBetweenPoints3D(pos[0], pos[1], pos[2], mypos[0],  mypos[1],  mypos[2]);
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				if(bydka1)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Риверсайд", 255, 100, 100 );
				}
				if(bydka2)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Кингстон", 255, 100, 100 );
				}
				if(bydka3)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Гринфилд", 255, 100, 100 );
				}
				if(bydka4)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Хантерс-Пойнт", 255, 100, 100 );
				}
				if(bydka5)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Сэнд-Айленд", 255, 100, 100 );
				}
				if(bydka6)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Сауспорт", 255, 100, 100 );
				}
				if(bydka7)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Ойстер-Бэй", 255, 100, 100 );
				}
				if(bydka8)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Южный Милвилл", 255, 100, 100 );
				}
				if(bydka9)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Мидтаун", 255, 100, 100 );
				}
				if(bydka10)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Вест-Сайд", 255, 100, 100 );
				}
				if(bydka11)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Китайский Квартал", 255, 100, 100 );
				}
				if(bydka12)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Северный Милвилл", 255, 100, 100 );
				}
				if(bydka13)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Маленькая Италия", 255, 100, 100 );
				}
				if(bydka14)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Хилвуд", 255, 100, 100 );
				}
				if(bydka15)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Аптаун", 255, 100, 100 );
				}
				if(bydka16)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в скорую и просит о помощи, он находится от вас в "+dist+" метрах. Район: Ист-Сайд", 255, 100, 100 );
				}
			}
		}
	}
});

addCommandHandler( "callpolice",
function( playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
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
	
	if(bydka1 || bydka2 || bydka3 || bydka4 || bydka5 || bydka6 || bydka7 || bydka8 || bydka9 || bydka10 || bydka11 || bydka12 || bydka13 || bydka14 || bydka15 || bydka16)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
		return sendPlayerMessage(playerid, "Вы полицейский.", 255, 0, 0 );
		}
		
		sendPlayerMessage(playerid, "Вы позвонили в полицию, пожалуйста оставайтесь на месте и ждите полицейских.", 255, 255, 0 );
		
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
			{
			return;
			}
			
			local pos = getPlayerPosition(playerid);
			local mypos = getPlayerPosition(i);
			local dist = getDistanceBetweenPoints3D(pos[0], pos[1], pos[2], mypos[0],  mypos[1],  mypos[2]);
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				if(bydka1)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Риверсайд", 0, 150, 255 );
				}
				if(bydka2)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Кингстон", 0, 150, 255 );
				}
				if(bydka3)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Гринфилд", 0, 150, 255 );
				}
				if(bydka4)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Хантерс-Пойнт", 0, 150, 255 );
				}
				if(bydka5)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Сэнд-Айленд", 0, 150, 255 );
				}
				if(bydka6)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Сауспорт", 0, 150, 255 );
				}
				if(bydka7)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Ойстер-Бэй", 0, 150, 255 );
				}
				if(bydka8)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Южный Милвилл", 0, 150, 255 );
				}
				if(bydka9)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Мидтаун", 0, 150, 255 );
				}
				if(bydka10)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Вест-Сайд", 0, 150, 255 );
				}
				if(bydka11)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Китайский Квартал", 0, 150, 255 );
				}
				if(bydka12)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Северный Милвилл", 0, 150, 255 );
				}
				if(bydka13)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Маленькая Италия", 0, 150, 255 );
				}
				if(bydka14)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Хилвуд", 0, 150, 255 );
				}
				if(bydka15)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Аптаун", 0, 150, 255 );
				}
				if(bydka16)
				{
					sendPlayerMessage(i,getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" позвонил в полицию и просит о помощи, он находится от вас в "+dist+" метрах. Район: Ист-Сайд", 0, 150, 255 );
				}
			}
		}
	}
});

addCommandHandler( "satiety",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	sendPlayerMessage(playerid, "Уровень сытости: "+ini.getKey("PlayerInfo", "satiety").tointeger(), 70, 255, 100);
});

addEventHandler( "eat",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
	local ed1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -561.204,428.753,1.02075, 5.0 );
	local ed2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -771.518,-377.324,-20.4072, 5.0 );
	local ed3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 142.323,-429.708,-19.429, 5.0 );
	local ed4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 240.014,709.032,-24.0321, 5.0 );
	local ed5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -645.378,1296.42,3.94464, 5.0 );
	local ed6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1582.64,1603.77,-5.22507, 5.0 );
	local ed7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1420.38,961.175,-12.7543, 5.0 );
	local ed8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1588.62,177.321,-12.4393, 5.0 );
	local ed9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1559.15,-165.144,-19.6113, 5.0 );
	
	if(ed1 || ed2 || ed3 || ed4 || ed5 || ed6 || ed7 || ed8 || ed9)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("ED", "owner").tointeger() == 0 || ini.getKey("ED", "prod").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Закусочная не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < ed_p)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - ed_p);
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы пополнили сытость до 100 и заплатили " +ed_p+ "$", 70, 255, 100);
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("ED", "money", ini.getKey("ED", "money").tointeger() + ed_p);
			ini.setKey("ED", "prod", ini.getKey("ED", "prod").tointeger() - 1);
			ini.saveData();
	}
});
addEventHandler( "drink",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
	local bar1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1384.92,470.174,-22.1321, 5.0 );
	local bar2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 627.621,897.018,-12.0138, 2.0 );
	local bar3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -51.0424,737.98,-21.9009, 5.0 );
	local bar4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -639.003,349.621,1.34485, 5.0 );
	local bar5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 21.2379,-76.4079,-15.595, 5.0 );
	local bar6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1148.88,1589.7,6.25566, 5.0 );
	
	if(bar1 || bar2 || bar3 || bar4 || bar5 || bar6)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("BAR", "owner").tointeger() == 0 || ini.getKey("BAR", "prod").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Бар не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < bar_p)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - bar_p);
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы пополнили сытость до 100 и заплатили " +bar_p+ "$", 70, 255, 100);
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("BAR", "money", ini.getKey("BAR", "money").tointeger() + bar_p);
			ini.setKey("BAR", "prod", ini.getKey("BAR", "prod").tointeger() - 1);
			ini.saveData();
	}
});
addCommandHandler( "repair",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
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
	
	if(rep1 || rep2 || rep3 || rep4 || rep5 || rep6 || rep7 || rep8 || rep9 || rep10 || rep11 || rep12)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("REPAIR", "owner").tointeger() == 0 || ini.getKey("REPAIR", "prod").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Автомастерская не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < rep_p)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if( !isPlayerInVehicle( playerid ) )
		{
			return sendPlayerMessage(playerid, "Вы не в машине.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - rep_p);
			ini.saveData();
			
			local vehicleid = getPlayerVehicle( playerid );
			repairVehicle( vehicleid );
			sendPlayerMessage(playerid, "Вы починили автомобиль и заплатили " +rep_p+ "$", 255, 100, 0);
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("REPAIR", "money", ini.getKey("REPAIR", "money").tointeger() + rep_p);
			ini.setKey("REPAIR", "prod", ini.getKey("REPAIR", "prod").tointeger() - 1);
			ini.saveData();
	}
});


addCommandHandler( "sellcarplayer",
function( playerid, id, money )
{
	local id = id.tointeger();
	local money = money.tointeger();
	local carnumber_player = strRand( 6 );
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	if(isPlayerInVehicle(playerid))
		{
		return sendPlayerMessage(playerid, "Выйдите из машины.", 255, 0, 0);
		}
	if(isPlayerInVehicle(id))
		{
		return sendPlayerMessage(id, "Выйдите из машины.", 255, 0, 0);
		}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car").tointeger() == 54)
	{
		return sendPlayerMessage(playerid, "У вас нет машины.", 255, 0, 0 );
	}
		
	if(FileExists("carnumber/"+carnumber_player+".ini"))
	{
		return sendPlayerMessage(playerid, "Этот номер числится в базе автомобилей, пожалуйста повторите попытку снова.", 255, 0, 0 );
	}
		
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "car").tointeger() < 54)
	{
		return sendPlayerMessage(playerid, "У игрока есть машина.", 255, 0, 0 );
	}
	
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "money").tointeger() < money)
	{
		return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
	{
		sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
		sendPlayerMessage(id, "Вы не достали кошелек.", 255, 0, 0);
		return;
	}
	
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id );
	local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1299.31,1328.93,-13.2936, 100.0 );
	local check2 = isPointInCircle3D( Pos[0], Pos[1], Pos[2], -1299.31,1328.93,-13.2936, 100.0 );
if(check1 && check2)
{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	local car_player = ini.getKey("PlayerInfo", "car").tointeger();
	local car_player_tune = ini.getKey("PlayerInfo", "car_level").tointeger();
	
	local car_player_color0 = ini.getKey("PlayerInfo", "carcolor0").tointeger();
	local car_player_color1 = ini.getKey("PlayerInfo", "carcolor1").tointeger();
	local car_player_color2 = ini.getKey("PlayerInfo", "carcolor2").tointeger();
	
	local car_player_color3 = ini.getKey("PlayerInfo", "carcolor3").tointeger();
	local car_player_color4 = ini.getKey("PlayerInfo", "carcolor4").tointeger();
	local car_player_color5 = ini.getKey("PlayerInfo", "carcolor5").tointeger();
	
	local coord = ini.getKey("PlayerInfo", "carnumber").tostring();
	
	local posfile = file("sellcar.txt", "a");
	for (local i = 0; i < coord.len(); i++) 
		{	
			posfile.writen(coord[i], 'b');
		}
	
		posfile.writen('\n', 'b');
		posfile.close();
	
	ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
	ini.setKey("PlayerInfo", "car", 54);
	ini.setKey("PlayerInfo", "car_p", 0);
	ini.setKey("PlayerInfo", "carnumber", 0);
	ini.setKey("PlayerInfo", "carcolor0", 0);
	ini.setKey("PlayerInfo", "carcolor1", 0);
	ini.setKey("PlayerInfo", "carcolor2", 0);
	ini.setKey("PlayerInfo", "carcolor3", 0);
	ini.setKey("PlayerInfo", "carcolor4", 0);
	ini.setKey("PlayerInfo", "carcolor5", 0);
	ini.setKey("PlayerInfo", "car_level", 0);
	ini.setKey("PlayerInfo", "carplayer_id", 0);
	ini.saveData();
	
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	ini.setKey("PlayerInfo", "car", car_player);
	ini.setKey("PlayerInfo", "carnumber", carnumber_player);
	ini.setKey("PlayerInfo", "car_level", car_player_tune);
	ini.setKey("PlayerInfo", "carcolor0", car_player_color0);
	ini.setKey("PlayerInfo", "carcolor1", car_player_color1);
	ini.setKey("PlayerInfo", "carcolor2", car_player_color2);
	ini.setKey("PlayerInfo", "carcolor3", car_player_color3);
	ini.setKey("PlayerInfo", "carcolor4", car_player_color4);
	ini.setKey("PlayerInfo", "carcolor5", car_player_color5);
	ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
	ini.saveData();
	
	local ini = EasyINI("carnumber/"+carnumber_player+".ini");
	ini.setKey("car", "ownername", getPlayerName(id));
	ini.setKey("car", "fuel", 50.0);
	ini.saveData();

	sendPlayerMessage(playerid, "Вы продали свой автомобиль "+getPlayerName(id)+" за "+money+"$", 0, 255, 0);
	sendPlayerMessage(id, "Вы купили автомобиль у "+getPlayerName(playerid)+" за "+money+"$", 255, 100, 0);
	
}
else
{
	sendPlayerMessage(playerid, "Вы оба должны находится на авторынке.", 255, 0, 0);
}

});

function sextime(playerid)
{
	log("");
	log("SEX " +getPlayerName(playerid)+ " " +getPlayerHealth(playerid));
	log("");
}
addCommandHandler( "sex",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 86.2709,897.346,-13.3142, 8.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 500)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 500);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 500);
			ini.saveData();
			
			log("");
			log("SEX " +getPlayerName(playerid)+ " "+getPlayerHealth(playerid));
			log("");
			
			sendPlayerMessage(playerid, "Вы воспользовались интимными услугами и заплатили 500$", 255, 100, 0);
			setPlayerHealth(playerid, 1000.0);
			
			local sex = timer( sextime, 2000, 1, playerid);
		}
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0)
		}
	}
});

addCommandHandler( "report",
function(playerid, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	
	local text = "";
	for(local i = 0; i < vargv.len(); i++)
	{
		text = text + " " + vargv[i];
	}
	foreach(i, playername in getPlayers())
	{
		if(FileExists("account/"+getPlayerName(i)+".ini") == false)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(i)+".ini");
		if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{	
			sendPlayerMessage(i, "(REPORT) От " +getPlayerName(playerid)+ "[" +getPlayerIdFromName(getPlayerName( playerid ))+ "]" + ":" +text, 0, 255, 255);
			sendPlayerMessage(playerid, "Вы отправили репорт. Текст:" +text, 0, 255, 255);
			
			log("");
			log("(REPORT)" +getPlayerName(playerid)+ " " +text);
			log("");
		}
	}
});

//команды игрока(конец)

//автомагазин
addEventHandler("dm", function(playerid) {
 
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -199.473,838.605,-21.2431, 10.0 );
	if(check)
    {
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "Доступные автомобили для покупки, находятся в нашей группе вконтакте vk.com/qrp_m2", 255, 255, 0);
	}
});

//магазин одежды
addEventHandler("clother", function(playerid) {
 
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -252.324,-79.688,-11.458, 5.0 );
	if(check)
    {
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage(playerid, "Доступные скины для покупки, находятся в нашей группе вконтакте vk.com/qrp_m2", 255, 255, 0);
	}
});

addCommandHandler( "buyskin",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -252.324,-79.688,-11.458, 5.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() != 0 )
		{
			return sendPlayerMessage(playerid, "Вы на работе, чтобы купить одежду увольтесь.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1 )
		{
			return sendPlayerMessage(playerid, "Вы на службе.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 )
		{
			return sendPlayerMessage(playerid, "Вы военнослужащий.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
		{
			return sendPlayerMessage(playerid, "Вы состоите в криминальных структурах.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 6)
		{
			return sendPlayerMessage(playerid, "Вы мэр.", 255, 0, 0);
		}
			
		//1
		if(id == 22)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 20000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 20000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 20000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 28)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 20000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 20000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 20000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 159)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 1000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 1000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 162)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 2000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 2000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 163)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 2000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 2000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 164)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 5000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 5000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 5000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 165)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 2000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 2000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 109)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 3000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 3000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 3000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 110)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 111)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 4000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 4000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//2
		if(id == 39)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 40)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 7000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 7000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 7000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 41)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 42)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 4000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 4000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 43)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 4000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 4000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 44)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 3000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 3000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 3000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 45)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 2000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 2000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 102)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 25000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 47)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 4000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 4000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 130)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 2000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 2000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//3
		if(id == 115)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 7000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 7000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 7000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 116)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 8000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 8000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 8000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 117)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 9000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 9000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 9000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 118)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 10000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 10000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 137)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 9000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 9000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 9000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 54)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 138)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 16000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 16000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 16000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 56)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 15000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 15000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 15000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 57)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 14000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 14000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 14000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 58)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 5000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 5000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 5000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//4
		if(id == 119)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 18000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 18000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 18000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 120)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 13000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 13000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 13000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 121)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 3000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 3000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 3000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 122)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 7000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 7000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 7000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 123)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 9000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 9000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 9000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 124)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 8000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 8000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 8000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 125)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 10000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 10000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 126)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 7000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 7000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 7000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 127)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 9000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 9000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 9000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 154)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 2000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 2000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//5
		if(id == 139)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 12000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 12000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 12000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 140)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 20000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 20000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 20000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 141)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 18000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 18000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 18000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 142)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 18000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 18000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 18000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 143)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 16000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 16000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 16000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 150)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 4000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 4000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 145)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 146)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 5000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 5000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 5000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 147)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 7000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 7000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 7000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 148)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//6
		if(id == 70)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 9000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 9000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 9000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 71)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 72)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 73)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 19000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 19000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 19000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 149)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 8000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 8000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 8000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 74)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 25000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 85)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 5000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 5000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 5000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 86)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 87)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 1000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 1000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 88)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//7
		if(id == 59)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 4000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 4000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 80)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 8000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 8000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 8000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 151)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 4000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 4000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 152)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 6000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 6000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 6000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 93)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 19000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 19000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 19000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 94)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 16000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 16000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 16000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 95)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 17000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 17000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 17000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 96)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 18000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 18000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 18000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 97)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 13000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 13000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 13000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 98)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 19000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 19000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 19000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//8
		if(id == 89)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 11000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 11000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 11000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 90)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 15000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 15000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 15000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 91)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 17000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 17000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 17000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 92)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 22000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 22000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 22000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 103)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 21000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 21000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 21000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 104)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 20000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 20000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 20000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 105)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 13000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 13000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 13000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 106)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 14000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 14000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 14000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 107)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 15000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 15000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 15000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 108)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 12000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 12000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 12000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		
		//9
		if(id == 99)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 10000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 10000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 10000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 100)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 15000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 15000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 15000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
		if(id == 101)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < 24000)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 24000);
			ini.setKey("PlayerInfo", "skin", id);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы заплатили 24000$", 255, 100, 0);
			setPlayerModel( playerid, id );
			return;
		}
	}
});

addCommandHandler( "buycar",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local number = strRand( 6 );
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -199.473,838.605,-21.2431, 10.0 );
	if(check)
	{
		if(FileExists("carnumber/"+number+".ini"))
		{
			return sendPlayerMessage(playerid, "Этот номер числится в базе автомобилей, пожалуйста повторите попытку снова.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car").tointeger() == 54)
		{
			if(id.tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 125000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 125000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 125000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 125000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 1)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 65000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 65000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 65000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 65000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 6)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 98000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 98000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 98000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 98000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 7)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 195000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 195000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 195000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 195000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 9)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 35000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 35000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 35000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 35000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 10)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 97000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 97000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 97000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 97000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 12)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 67000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 67000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 67000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 67000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 13)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 200000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 200000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 200000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 200000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 14)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 40000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 40000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 40000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 40000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 15)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 90000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 90000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 90000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 90000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 22)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 30000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 30000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 30000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 30000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 23)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 32000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 32000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 32000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 32000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 25)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 16000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 16000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 16000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 16000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 28)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 40000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 40000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 40000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 40000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 29)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 92000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 92000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 92000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 92000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 31)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 22000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 22000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 22000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 22000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 41)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 42000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 42000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 42000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 42000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 43)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 5000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 5000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 5000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 5000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 44)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 32000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 32000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 32000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 32000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 45)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 137000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 137000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 137000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 137000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 47)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 14000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 14000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 14000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 14000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 48)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 12000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 12000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 12000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 12000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 50)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 22000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 22000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 22000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 22000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 52)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 73000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 73000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 73000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 73000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
			if(id.tointeger() == 53)
			{
				if(ini.getKey("PlayerInfo", "money").tointeger() >= 9000)
				{
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 9000);
				local vehicle = createVehicle( id.tointeger(), -205.534, 835.04, -20.9558, 160.0, 0.0, 0.0 );
				ini.setKey("PlayerInfo", "car", id.tointeger());
				ini.setKey("PlayerInfo", "car_p", 1);
				ini.setKey("PlayerInfo", "carnumber", number);
				setVehiclePlateText( vehicle, ini.getKey("PlayerInfo", "carnumber").tostring() );
				ini.saveData();
				sendPlayerMessage(playerid, "Поздравляем с покупкой машины!", 255, 255, 0);
				sendPlayerMessage(playerid, "С вас списали 9000$!", 255, 100, 0);
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 9000);
				ini.saveData();
				
				local ini = EasyINI("carnumber/"+number+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				
				}
				else
				{
					sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
				}
			}
		
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть машина.", 255, 0, 0 );
		}
	
	}
});

//продажа авто
addCommandHandler( "sellcar",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	if(isPlayerInVehicle(playerid))
	{
		return sendPlayerMessage(playerid, "Выйдите из машины.", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car").tointeger() == 54)
	{
		return sendPlayerMessage(playerid, "У вас нет машины.", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	local coord = ini.getKey("PlayerInfo", "carnumber").tostring();
	
	local posfile = file("sellcar.txt", "a");
	for (local i = 0; i < coord.len(); i++) 
		{	
			posfile.writen(coord[i], 'b');
		}

		posfile.writen('\n', 'b');
		posfile.close();
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car").tointeger() == 0)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 62500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 62500$.", 0, 255, 0);

		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 62500);
		ini.saveData();
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 1)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 32500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 32500$.", 0, 255, 0);

		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 32500);
		ini.saveData();
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 6)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 49000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 49000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 49000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 7)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 97500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 97500$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 97500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 8)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 97500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 97500$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 97500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 9)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 17500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 17500$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 17500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 10)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 48500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 48500$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 48500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 12)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 33500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 33500$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 33500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 13)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 100000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 200000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 14)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 20000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 20000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 20000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 15)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 45000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 45000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 45000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 18)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 55000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 55000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 55000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 22)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 15000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 15000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 15000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 23)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 16000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 16000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 16000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 25)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 8000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 8000$.", 0, 255, 0);	
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 8000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 28)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 20000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 20000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 20000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 29)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 46000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 46000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 46000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 31)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 11000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 11000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 11000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 41)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 21000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 21000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 21000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 43)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 2500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 2500$.", 0, 255, 0);	
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 2500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 44)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 16000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 16000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 16000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 45)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 68500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 68500$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 68500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 47)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 7000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 7000$.", 0, 255, 0);	
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 7000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 48)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 6000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 6000$.", 0, 255, 0);	
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 6000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 50)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 11000);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 11000$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 11000);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 52)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 36500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 36500$.", 0, 255, 0);
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 36500);
		ini.saveData();	
		return;
	}
	if(ini.getKey("PlayerInfo", "car").tointeger() == 53)
	{
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 4500);
		ini.setKey("PlayerInfo", "car", 54);
		ini.setKey("PlayerInfo", "car_p", 0);
		ini.setKey("PlayerInfo", "carnumber", 0);
		ini.setKey("PlayerInfo", "carcolor0", 0);
		ini.setKey("PlayerInfo", "carcolor1", 0);
		ini.setKey("PlayerInfo", "carcolor2", 0);
		ini.setKey("PlayerInfo", "carcolor3", 0);
		ini.setKey("PlayerInfo", "carcolor4", 0);
		ini.setKey("PlayerInfo", "carcolor5", 0);
		ini.setKey("PlayerInfo", "car_level", 0);
		ini.setKey("PlayerInfo", "carplayer_id", 0);
		ini.saveData();
		sendPlayerMessage(playerid, "Вы продали свою машину за 4500$.", 0, 255, 0);	
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 4500);
		ini.saveData();	
		return;
	}
});

//команды авто
addCommandHandler( "callmech",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
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
	
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}

	if(isPlayerInVehicle(playerid))
	{
		return sendPlayerMessage(playerid, "Вы в машине!", 255, 0, 0 );
	}
	
	if(bydka1 || bydka2 || bydka3 || bydka4 || bydka5 || bydka6 || bydka7 || bydka8 || bydka9 || bydka10 || bydka11 || bydka12 || bydka13 || bydka14 || bydka15 || bydka16)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car").tointeger() < 54)
	{
		local vehicle;
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_p").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			local plate = ini.getKey("PlayerInfo", "carnumber").tostring();
			local pos = getPlayerPosition( playerid );
			vehicle = createVehicle( ini.getKey("PlayerInfo", "car").tointeger(), pos[0] + 5.0, pos[1], pos[2] + 1.0, 90.0, 0.0, 0.0 );
			
			setVehiclePlateText( vehicle , ini.getKey("PlayerInfo", "carnumber").tostring() );
			setVehicleColour( vehicle, ini.getKey("PlayerInfo", "carcolor0").tointeger(), ini.getKey("PlayerInfo", "carcolor1").tointeger(), ini.getKey("PlayerInfo", "carcolor2").tointeger(), ini.getKey("PlayerInfo", "carcolor3").tointeger(), ini.getKey("PlayerInfo", "carcolor4").tointeger(), ini.getKey("PlayerInfo", "carcolor5").tointeger());
			setVehicleTuningTable( vehicle, ini.getKey("PlayerInfo", "car_level").tointeger() );
			
			ini.setKey("PlayerInfo", "car_p", 1);
			ini.saveData();
			sendPlayerMessage(playerid, "Вам доставили вашу машину.", 255, 255, 0 );
			
			if(FileExists("carnumber/"+plate+".ini") == false)
			{
				local ini = EasyINI("carnumber/"+plate+".ini");
				ini.setKey("car", "ownername", getPlayerName(playerid));
				ini.setKey("car", "fuel", 50.0);
				ini.saveData();
				setVehicleFuel(vehicle, ini.getKey("car", "fuel").tofloat());
				return;
			}
			
			local ini = EasyINI("carnumber/"+plate+".ini");
			setVehicleFuel(vehicle, ini.getKey("car", "fuel").tofloat());
			return;
			
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "carplayer_id").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Чтобы я пригнал вам вашу машину вам необходимо в неё сесть и выйти.", 255, 0, 0 );
		}
			local pos = getPlayerPosition( playerid );
			sendPlayerMessage(playerid, "Вам доставили вашу машину.", 255, 255, 0 );
			
			local vehicleid = ini.getKey("PlayerInfo", "carplayer_id").tointeger();
			setVehiclePosition(vehicleid, pos[0] + 5.0, pos[1], pos[2] + 1.0);
			setVehicleRotation(vehicleid, 90.0, 0.0, 0.0);
	}
	else
	{
	sendPlayerMessage(playerid, "У вас нет машины.", 255, 0, 0 );
	}
	}
	
});

//бизнесы начало
addCommandHandler( "buybiznes",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );
	if(fuel1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#1", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 1);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#1", "owner", 1);
			ini.setKey("FS#1", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
	if(fuel2)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#2", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 2);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#2", "owner", 1);
			ini.setKey("FS#2", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
	if(fuel3)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#3", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 3);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#3", "owner", 1);
			ini.setKey("FS#3", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
	if(fuel4)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#4", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 4);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#4", "owner", 1);
			ini.setKey("FS#4", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
	if(fuel5)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#5", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 5);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#5", "owner", 1);
			ini.setKey("FS#5", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
	if(fuel6)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#6", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 6);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#6", "owner", 1);
			ini.setKey("FS#6", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
	if(fuel7)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#7", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 7);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#7", "owner", 1);
			ini.setKey("FS#7", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
	if(fuel8)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < 25000)
		{
		return sendPlayerMessage(playerid, "Для покупки этого бизнеса нужно 25000$!", 255, 0, 0);
		}
		if(ini.getKey("PlayerInfo", "bizneslic").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет лицензии на ведение бизнеса!", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#8", "owner").tointeger() == 0)
			{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 25000);
			ini.setKey("PlayerInfo", "biznes", 8);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 25000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Поздравляем, вы купили заправку с автомойкой за 25000$!", 255, 100, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#8", "owner", 1);
			ini.setKey("FS#8", "ownername", getPlayerName(playerid));
			ini.saveData();
			}
			else
			{
			sendPlayerMessage(playerid, "У заправки есть владелец.", 255, 0, 0);
			}
		}
		else
		{
		sendPlayerMessage(playerid, "У вас уже есть бизнес.", 255, 0, 0);
		}
	}
}
);

addCommandHandler( "sellbiznes",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
	}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#1", "owner", 0);
			ini.setKey("FS#1", "ownername", 0);
			ini.saveData();
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#2", "owner", 0);
			ini.setKey("FS#2", "ownername", 0);
			ini.saveData();
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#3", "owner", 0);
			ini.setKey("FS#3", "ownername", 0);
			ini.saveData();
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#4", "owner", 0);
			ini.setKey("FS#4", "ownername", 0);
			ini.saveData();
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#5", "owner", 0);
			ini.setKey("FS#5", "ownername", 0);
			ini.saveData();
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#6", "owner", 0);
			ini.setKey("FS#6", "ownername", 0);
			ini.saveData();
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#7", "owner", 0);
			ini.setKey("FS#7", "ownername", 0);
			ini.saveData();
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 12500);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() - 12500);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой за 12500$!", 0, 255, 0);
		
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#8", "owner", 0);
			ini.setKey("FS#8", "ownername", 0);
			ini.saveData();
		}
});

addCommandHandler( "sellbizplayer",
function( playerid, id, money )
{
	local id = id.tointeger();
	local money = money.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0 );
	}
	
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 10.0 );
	if(check)
	{
		
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "biznes").tointeger() >= 1)
	{
		return sendPlayerMessage(playerid, "У игрока есть бизнес.", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
	{
		sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
		sendPlayerMessage(id, "Вы не достали кошелек.", 255, 0, 0);
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "money").tointeger() < money)
	{
		sendPlayerMessage(playerid, "У игрока недостаточно средств.", 255, 0, 0);
		sendPlayerMessage(id, "У вас недостаточно средств.", 255, 0, 0);
		return;
	}
	if(getPlayerName(playerid) == getPlayerName(id))
	{
		return sendPlayerMessage(playerid, "Самому себе нельзя продать бизнес.", 255, 0, 0 );
	}
	
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 1);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#1", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 2);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#2", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 3);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#3", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 4);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#4", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 5);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#5", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 6);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#6", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 7);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#7", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 8);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#8", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали заправку с автомойкой " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили заправку с автомойкой у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 9);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("ED", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали сеть закусочных " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили сеть закусочных у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 10);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("BAR", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали сеть баров " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили сеть баров у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 11);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("BAR", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали сеть мастерских " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили сеть мастерских у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 12)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.setKey("PlayerInfo", "biznes", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.setKey("PlayerInfo", "biznes", 12);
			ini.saveData();
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("BAR", "ownername", getPlayerName(id));
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали сеть магазинов оружия " +getPlayerName(id)+ " за " +money+ "$", 0, 255, 0);
			sendPlayerMessage(id, "Вы купили сеть магазинов оружия у " +getPlayerName(playerid)+ " за " +money+ "$", 255, 100, 0);
			return;
		}
		
	}
	else
	{
		return sendPlayerMessage(playerid, "Игрок далеко.", 255, 0, 0);
	}
});

addCommandHandler( "biznesprice",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );
	
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
	
	if(fuel1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#1", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel2)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#2", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel3)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#3", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel4)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#4", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel5)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#5", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel6)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#6", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel7)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#7", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel8)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#8", "fs_price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	
	if(ed1 || ed2 || ed3 || ed4 || ed5 || ed6 || ed7 || ed8 || ed9)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("ED", "price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену 1 продукта: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	
	if(bar1 || bar2 || bar3 || bar4 || bar5 || bar6)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("BAR", "price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену 1 бутылки: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	
	if(rep1 || rep2 || rep3 || rep4 || rep5 || rep6 || rep7 || rep8 || rep9 || rep10 || rep11 || rep12)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("REPAIR", "price", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену ремонта: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
});
addCommandHandler( "biznesbuyfuel",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );
	if(fuel1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#1", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel2)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#2", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel3)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#3", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel4)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#4", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel5)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#5", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel6)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#6", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel7)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#7", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
	if(fuel8)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8)
			{
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#8", "buyfuel", id.tointeger());
			ini.saveData();
			sendPlayerMessage(playerid, "Вы установили цену покупки за 1 литр: "+id.tointeger()+"$", 255, 255, 0);
			}
	}
});

addCommandHandler( "biznesbuyprod",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local ed1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -561.204,428.753,1.02075, 5.0 );
	local ed2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -771.518,-377.324,-20.4072, 5.0 );
	local ed3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 142.323,-429.708,-19.429, 5.0 );
	local ed4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 240.014,709.032,-24.0321, 5.0 );
	local ed5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -645.378,1296.42,3.94464, 5.0 );
	local ed6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1582.64,1603.77,-5.22507, 5.0 );
	local ed7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1420.38,961.175,-12.7543, 5.0 );
	local ed8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1588.62,177.321,-12.4393, 5.0 );
	local ed9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1559.15,-165.144,-19.6113, 5.0 );
	
	if(ed1 || ed2 || ed3 || ed4 || ed5 || ed6 || ed7 || ed8 || ed9)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9)
			{
				local ini = EasyINI("biz/biznes.ini");
				if(ini.getKey("ED", "prod").tointeger() >= 50000)
				{
					return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
				}
				
				local ini = EasyINI("biz/kazna.ini");
				local buyprod = ini.getKey("kyrs", "kyrs_prod").tointeger();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "money").tointeger() < id.tointeger()*buyprod)
				{
					return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
				}
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("ED", "prod", ini.getKey("ED", "prod").tointeger() + id.tointeger());
				ini.saveData();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - id.tointeger()*buyprod);
				ini.saveData();
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + id.tointeger()*buyprod);
				ini.saveData();
				
				sendPlayerMessage(playerid, "Вы купили "+id.tointeger()+" продуктов за "+id.tointeger()*buyprod+ "$", 255, 100, 0);
			}
	}
});

addCommandHandler( "biznesbuyalco",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local bar1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1384.92,470.174,-22.1321, 5.0 );
	local bar2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 627.621,897.018,-12.0138, 2.0 );
	local bar3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -51.0424,737.98,-21.9009, 5.0 );
	local bar4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -639.003,349.621,1.34485, 5.0 );
	local bar5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 21.2379,-76.4079,-15.595, 5.0 );
	local bar6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1148.88,1589.7,6.25566, 5.0 );
	
	if(bar1 || bar2 || bar3 || bar4 || bar5 || bar6)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10)
			{
				local ini = EasyINI("biz/biznes.ini");
				if(ini.getKey("BAR", "prod").tointeger() >= 50000)
				{
					return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
				}
				
				local ini = EasyINI("biz/kazna.ini");
				local buyalco = ini.getKey("kyrs", "kyrs_alco").tointeger();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "money").tointeger() < id.tointeger()*buyalco)
				{
					return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
				}
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("BAR", "prod", ini.getKey("BAR", "prod").tointeger() + id.tointeger());
				ini.saveData();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - id.tointeger()*buyalco);
				ini.saveData();
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + id.tointeger()*buyalco);
				ini.saveData();
				
				sendPlayerMessage(playerid, "Вы купили "+id.tointeger()+" бутылок алкоголя за "+id.tointeger()*buyalco+ "$", 255, 100, 0);
			}
	}
});

addCommandHandler( "biznesbuyparts",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
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
	
	if(rep1 || rep2 || rep3 || rep4 || rep5 || rep6 || rep7 || rep8 || rep9 || rep10 || rep11 || rep12)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "У вас нет бизнеса.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11)
			{
				local ini = EasyINI("biz/biznes.ini");
				if(ini.getKey("REPAIR", "prod").tointeger() >= 50000)
				{
					return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
				}
				
				local ini = EasyINI("biz/kazna.ini");
				local buyparts = ini.getKey("kyrs", "kyrs_parts").tointeger();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "money").tointeger() < id.tointeger()*buyparts)
				{
					return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
				}
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("REPAIR", "prod", ini.getKey("REPAIR", "prod").tointeger() + id.tointeger());
				ini.saveData();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - id.tointeger()*buyparts);
				ini.saveData();
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + id.tointeger()*buyparts);
				ini.saveData();
				
				sendPlayerMessage(playerid, "Вы купили "+id.tointeger()+" деталей за "+id.tointeger()*buyparts+ "$", 255, 100, 0);
			}
	}
});
//бизнесы конец

//вход в машину(указывать те тачки чтобы снялся контроль)
function playerEnteredVehicle( playerid, vehicleid, seat )
{
	fuelinfo = timer( carfuel, 10000, -1 );//инфа топлива
	
	local plate = getVehiclePlateText(vehicleid);
	local model = getPlayerModel(playerid);
	local vehicle = getVehicleModel(vehicleid);
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	ini.setKey("PlayerInfo", "vehicle_p", vehicle);
	ini.setKey("PlayerInfo", "car_id", vehicleid);
	ini.saveData();

if(ini.getKey("PlayerInfo", "driverlic").tointeger() == 1)
{
	if(vehicle == 3 || vehicle == 11)//армия
	{
		if(model >= 16 && model <= 19 || model == 113 || model == 114)
		{
			return;
		}
	}
	if(vehicle == 4)
	{
		if(model == 144 )
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "level").tointeger() >= 10)
			{
				return;
			}
			else
			{
				sendPlayerMessage( playerid, "Для управления фурой, необходимо прожить 10 лет.", 255, 0, 0 );
				sendPlayerMessage(playerid, "Нажми G чтобы выйти.", 255, 0, 0);
				togglePlayerControls( playerid, true );
			}
			return;
		}
	}
	if(vehicle == 5)
	{
		if(model == 144)
		{
			return;
		}
	}
	if(vehicle == 24 || vehicle == 33)
	{
		if(ini.getKey("PlayerInfo", "job").tointeger() == 4)
		{
			return;
		}
	}
	if(vehicle == 34)
	{
		if(model == 132)
		{
			return;
		}
	}
	if(vehicle == 42)//копы
	{
		if(model == 75 || model == 76 || model == 68 || model == 69)
		{
			return;
		}
	}
	
	if(vehicle == 51 && ini.getKey("PlayerInfo", "fraction").tointeger() == 2)//медики
	{
		return;
	}
	
	if(vehicle == 36 && model == 62)
	{
		return;
	}
	
	if(vehicle == 20 && model == 171)
	{
		return;
	}
	
	if(vehicleid >= 116 && vehicleid <= 121)//триада
	{
		if(model >= 48 && model <= 52)
		{
			return;
		}
	}
	
	if(vehicleid >= 63 && vehicleid <= 71)//ирландцы
	{
		if(model >= 81 && model <= 84 || model == 24)
		{
			return;
		}
	}
	
	if(vehicleid >= 122 && vehicleid <= 131)
	{
		if(model == 83)
		{
			if(ini.getKey("PlayerInfo", "job_p").tointeger() > 0)
			{
				return;
			}
			sendPlayerMessage(playerid, "Чтобы начать работу, выбери маршрут при помощи команд: /jobbruski, /jobfraction", 255, 255, 0);
			sendPlayerMessage(playerid, "Отменить маршрут /jobcancel", 255, 255, 0);
			return;
		}
	}
	if(vehicle == 38)
	{
		if(model == 83)
		{
			if(ini.getKey("PlayerInfo", "job_p").tointeger() > 0)
			{
				return;
			}
			sendPlayerMessage(playerid, "Чтобы начать работу, выбери маршрут при помощи команд: /jobport_seagift, /jobseagift_port", 255, 255, 0);
			sendPlayerMessage(playerid, "Отменить маршрут /jobcancel", 255, 255, 0);
			return;
		}
	}
	if(vehicleid >= 108 && vehicleid <= 109)
	{
		if(ini.getKey("PlayerInfo", "job").tointeger() == 11)
		{
			return;
		}
	}

//вход в машины игроков
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		if(plate == ini.getKey("PlayerInfo", "carnumber").tostring() && vehicle == ini.getKey("PlayerInfo", "car").tointeger())
		{
		
		local ini = EasyINI("carnumber/"+plate+".ini");
		setVehicleFuel(vehicleid, ini.getKey("car", "fuel").tofloat());
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "carplayer_id", vehicleid);
		ini.saveData();
		setVehicleColour( vehicleid, ini.getKey("PlayerInfo", "carcolor0").tointeger(), ini.getKey("PlayerInfo", "carcolor1").tointeger(), ini.getKey("PlayerInfo", "carcolor2").tointeger(), ini.getKey("PlayerInfo", "carcolor3").tointeger(), ini.getKey("PlayerInfo", "carcolor4").tointeger(), ini.getKey("PlayerInfo", "carcolor5").tointeger());
		setVehicleTuningTable( vehicleid, ini.getKey("PlayerInfo", "car_level").tointeger() );
		return;
		}
		return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(plate == ini.getKey("PlayerInfo", "carnumber").tostring() && vehicle == ini.getKey("PlayerInfo", "car").tointeger())
	{
		
		local ini = EasyINI("carnumber/"+plate+".ini");
		setVehicleFuel(vehicleid, ini.getKey("car", "fuel").tofloat());
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "carplayer_id", vehicleid);
		ini.saveData();
		setVehicleColour( vehicleid, ini.getKey("PlayerInfo", "carcolor0").tointeger(), ini.getKey("PlayerInfo", "carcolor1").tointeger(), ini.getKey("PlayerInfo", "carcolor2").tointeger(), ini.getKey("PlayerInfo", "carcolor3").tointeger(), ini.getKey("PlayerInfo", "carcolor4").tointeger(), ini.getKey("PlayerInfo", "carcolor5").tointeger());
		setVehicleTuningTable( vehicleid, ini.getKey("PlayerInfo", "car_level").tointeger() );
		return;
	}
	
	if(plate == "rental")
	{
		if(ini.getKey("PlayerInfo", "carrental").tointeger() == 1)
		{
		return;
		}
		sendPlayerMessage(playerid, "Чтобы арендовать введите /carrental", 255, 255, 0);
		sendPlayerMessage(playerid, "Это чужая машина. Нажми G чтобы выйти.", 255, 0, 0);
		togglePlayerControls( playerid, true );
		return;
	}
	
	if(plate == "admin")
	{
		sendPlayerMessage(playerid, "Это чужая машина. Нажми G чтобы выйти.", 255, 0, 0);
		togglePlayerControls( playerid, true );
		return;
	}
	
	sendPlayerMessage(playerid, "Это чужая машина.", 255, 0, 0);
	
}
else
	{
		togglePlayerControls( playerid, true );
		sendPlayerMessage(playerid, "У вас нет прав. Купите их в мерии.", 255, 0, 0);
		sendPlayerMessage(playerid, "Нажми G чтобы выйти.", 255, 0, 0);
	}
}
addEventHandler ("onPlayerVehicleEnter", playerEnteredVehicle);

//выход из машины
addEventHandler("onPlayerVehicleExit",
function(playerid, vehicleid, seat) 
{
	local plate = getVehiclePlateText(vehicleid);
	local vehicle = getVehicleModel(vehicleid);
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	ini.setKey("PlayerInfo", "vehicle_p", 0);
	ini.saveData();

	fuelinfo.Kill();
});
addEventHandler( "exit",
function(playerid)
{
	if( !isPlayerInVehicle(playerid) ) {
        return;
    }
	local vehicleid = getPlayerVehicle(playerid);
	local plate = getVehiclePlateText(vehicleid);
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "tie_p").tointeger() == 1)
	{
		return sendPlayerMessage(playerid, "Вы связаны.", 255, 0, 0);
	}
	
	removePlayerFromVehicle( playerid );
});

//принять,уволить,повысить
addCommandHandler( "invite",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "leader").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "rang", 1);
			ini.setKey("PlayerInfo", "fraction", 1);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы пригласили " +getPlayerName(id.tointeger())+" во фракцию.", 0, 150, 255);
			sendPlayerMessage(id.tointeger(), "Вас пригласили во фракцию.", 0, 150, 255);
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок в другой фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "leader").tointeger() == 2)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "rang", 1);
			ini.setKey("PlayerInfo", "fraction", 2);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы пригласили " +getPlayerName(id.tointeger())+" во фракцию.", 255, 100, 100);
			sendPlayerMessage(id.tointeger(), "Вас пригласили во фракцию.", 255, 100, 100);
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок в другой фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "leader").tointeger() == 3)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "rang", 1);
			ini.setKey("PlayerInfo", "fraction", 3);
			ini.setKey("PlayerInfo", "skin_f", 16);
			ini.saveData();
			setPlayerPosition( id.tointeger(), -1578.96,-323.928,-20.3172 );
			setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
			sendPlayerMessage(playerid, "Вы пригласили " +getPlayerName(id.tointeger())+" во фракцию.", 150, 150, 0);
			sendPlayerMessage(id.tointeger(), "Вас пригласили во фракцию.", 150, 150, 0);
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок в другой фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "leader").tointeger() == 4)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "rang", 1);
			ini.setKey("PlayerInfo", "fraction", 4);
			ini.setKey("PlayerInfo", "skin_f", 52);
			ini.saveData();
			setPlayerPosition( id.tointeger(), 353.893,385.469,-19.5472 );
			setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
			sendPlayerMessage(playerid, "Вы пригласили " +getPlayerName(id.tointeger())+" во фракцию.", 200, 0, 0);
			sendPlayerMessage(id.tointeger(), "Вас пригласили во фракцию.", 200, 0, 0);
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок в другой фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "leader").tointeger() == 5)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "rang", 1);
			ini.setKey("PlayerInfo", "fraction", 5);
			ini.setKey("PlayerInfo", "skin_f", 83);
			ini.saveData();
			setPlayerPosition( id.tointeger(), -1162.24,1536.75,6.541 );
			setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
			sendPlayerMessage(playerid, "Вы пригласили " +getPlayerName(id.tointeger())+" во фракцию.", 0, 255, 0);
			sendPlayerMessage(id.tointeger(), "Вас пригласили во фракцию.", 0, 255, 0);
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок в другой фракции.", 255, 0, 0);
		}
		return;
	}
	
	sendPlayerMessage(playerid, "Вы не лидер фракции.", 255, 0, 0);
}
);

//ранги 
addCommandHandler( "giverang",
function( playerid, id, r )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не воше!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "leader").tointeger() == 1 || ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() >= 4)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 1)
			{
			return sendPlayerMessage(playerid, "Игрок лидер.", 255, 0, 0);
			}
			
			if(getPlayerName(playerid) == getPlayerName(id.tointeger()))
			{
			return sendPlayerMessage(playerid, "Самому себе нельзя изменить ранг.", 255, 0, 0);
			}
			
			if(r.tointeger() >= 1 && r.tointeger() < 6)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.saveData();
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 0, 150, 255);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 0, 150, 255);
			}
			else
			{
				sendPlayerMessage(playerid, "Вы можете повысить до 5 ранга или понизить до 1 ранга.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "leader").tointeger() == 2 || ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() >= 3)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 2)
			{
			return sendPlayerMessage(playerid, "Игрок лидер.", 255, 0, 0);
			}
			
			if(getPlayerName(playerid) == getPlayerName(id.tointeger()))
			{
			return sendPlayerMessage(playerid, "Самому себе нельзя изменить ранг.", 255, 0, 0);
			}
			
			if(r.tointeger() >= 1 && r.tointeger() < 5)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.saveData();
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 255, 100, 100);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.",  255, 100, 100);
			}
			else
			{
				sendPlayerMessage(playerid, "Вы можете повысить до 4 ранга или понизить до 1 ранга.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "leader").tointeger() == 3 || ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() >= 4)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 3)
			{
			return sendPlayerMessage(playerid, "Игрок лидер.", 255, 0, 0);
			}
			
			if(getPlayerName(playerid) == getPlayerName(id.tointeger()))
			{
			return sendPlayerMessage(playerid, "Самому себе нельзя изменить ранг.", 255, 0, 0);
			}
			
			if(r.tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 16);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 150, 150, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 150, 150, 0);
				return;
			}
			if(r.tointeger() == 2 || r.tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 19);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 150, 150, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 150, 150, 0);
				return;
			}
			if(r.tointeger() == 4 || r.tointeger() == 5 || r.tointeger() == 6 || r.tointeger() == 7)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 18);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 150, 150, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 150, 150, 0);
				return;
			}
			if(r.tointeger() == 8)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 114);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 150, 150, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 150, 150, 0);
				return;
			}
			if(r.tointeger() == 9)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 113);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 150, 150, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 150, 150, 0);
				return;
			}
			
			sendPlayerMessage(playerid, "Вы можете повысить до 9 ранга или понизить до 1 ранга.", 255, 0, 0);
			
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "leader").tointeger() == 4 || ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() >= 4)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 4)
			{
			return sendPlayerMessage(playerid, "Игрок лидер.", 255, 0, 0);
			}
			
			if(getPlayerName(playerid) == getPlayerName(id.tointeger()))
			{
			return sendPlayerMessage(playerid, "Самому себе нельзя изменить ранг.", 255, 0, 0);
			}
			
			if(r.tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 52);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 200, 0, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 200, 0, 0);
				return;
			}
			if(r.tointeger() == 2)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 51);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 200, 0, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 200, 0, 0);
				return;
			}
			if(r.tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 48);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 200, 0, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 200, 0, 0);
				return;
			}
			if(r.tointeger() == 4)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 49);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 200, 0, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 200, 0, 0);
				return;
			}
			
			sendPlayerMessage(playerid, "Вы можете повысить до 4 ранга или понизить до 1 ранга.", 255, 0, 0);
			
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "leader").tointeger() == 5 || ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() >= 4)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 5)
			{
			return sendPlayerMessage(playerid, "Игрок лидер.", 255, 0, 0);
			}
			
			if(getPlayerName(playerid) == getPlayerName(id.tointeger()))
			{
			return sendPlayerMessage(playerid, "Самому себе нельзя изменить ранг.", 255, 0, 0);
			}
			
			if(r.tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 83);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 0, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 0, 255, 0);
				return;
			}
			if(r.tointeger() == 2)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 81);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 0, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 0, 255, 0);
				return;
			}
			if(r.tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 82);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 0, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 0, 255, 0);
				return;
			}
			if(r.tointeger() == 4)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "rang", r.tointeger());
				ini.setKey("PlayerInfo", "skin_f", 84);
				ini.saveData();
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin_f").tointeger());
				sendPlayerMessage(playerid, "Вы назначили " +getPlayerName(id.tointeger())+ " "+r.tointeger()+ " ранг.", 0, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вам назначили "+r.tointeger()+ " ранг.", 0, 255, 0);
				return;
			}
			
			sendPlayerMessage(playerid, "Вы можете повысить до 4 ранга или понизить до 1 ранга.", 255, 0, 0);
			
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	
	sendPlayerMessage(playerid, "Вы не можете повысить ранг.", 255, 0, 0);
}
);

addCommandHandler( "uval",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "leader").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 1)
			{
			return sendPlayerMessage(playerid, "Самого себя нельзя уволить.", 255, 0, 0);
			}
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", 0);
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.setKey("PlayerInfo", "rang", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы уволили " +getPlayerName(id.tointeger()), 0, 150, 255);
				sendPlayerMessage(id.tointeger(), "Вас уволили.", 0, 150, 255);
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger());
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "leader").tointeger() == 2)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 2)
			{
			return sendPlayerMessage(playerid, "Самого себя нельзя уволить.", 255, 0, 0);
			}
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", 0);
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.setKey("PlayerInfo", "rang", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы уволили " +getPlayerName(id.tointeger()), 255, 100, 100);
				sendPlayerMessage(id.tointeger(), "Вас уволили.", 255, 100, 100);
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "leader").tointeger() == 3)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 3)
			{
			return sendPlayerMessage(playerid, "Самого себя нельзя уволить.", 255, 0, 0);
			}
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", 0);
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.setKey("PlayerInfo", "rang", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы уволили " +getPlayerName(id.tointeger()), 150, 150, 0);
				sendPlayerMessage(id.tointeger(), "Вас уволили.", 150, 150, 0);
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin").tointeger());
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "leader").tointeger() == 4)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 4)
			{
			return sendPlayerMessage(playerid, "Самого себя нельзя уволить.", 255, 0, 0);
			}
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", 0);
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.setKey("PlayerInfo", "rang", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы уволили " +getPlayerName(id.tointeger()), 200, 0, 0);
				sendPlayerMessage(id.tointeger(), "Вас уволили.", 200, 0, 0);
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin").tointeger());
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "leader").tointeger() == 5)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
		{
			if(ini.getKey("PlayerInfo", "leader").tointeger() == 5)
			{
			return sendPlayerMessage(playerid, "Самого себя нельзя уволить.", 255, 0, 0);
			}
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "fraction", 0);
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.setKey("PlayerInfo", "rang", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы уволили " +getPlayerName(id.tointeger()), 0, 255, 0);
				sendPlayerMessage(id.tointeger(), "Вас уволили.", 0, 255, 0);
				setPlayerModel( id.tointeger(), ini.getKey("PlayerInfo", "skin").tointeger());
		}
		else
		{
			sendPlayerMessage(playerid, "Игрок не в вашей фракции.", 255, 0, 0);
		}
		return;
	}
	
	sendPlayerMessage(playerid, "Вы не лидер фракции.", 255, 0, 0);
}
);

//копы
addCommandHandler( "prison",
function(playerid, id, time)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "wanted_lvl").tointeger() == 1)
	{
	return sendPlayerMessage(playerid, "Игрока нельзя посадить, выпишите ему штраф!", 255, 0, 0);
	}
		
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
	{	
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
		return sendPlayerMessage(playerid, "Полицейского нельзя посадить.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
		{
			if(time.tointeger() < 1)
			{
				return sendPlayerMessage(playerid, "Минимум 1 минута.", 255, 0, 0);
			}
			if(isPlayerInVehicle(id.tointeger()))
			{
				return sendPlayerMessage(playerid, "Игрок в машине.", 255, 0, 0);
			}
			
			local myPos = getPlayerPosition( id.tointeger() );
			local pos = getPlayerPosition( playerid );
			local check = isPointInCircle3D( pos[0], pos[1], pos[2], myPos[0], myPos[1], myPos[2], 5.0 );
			if(check)
			{
					local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
					if(ini.getKey("PlayerInfo", "prison").tointeger() == 1)
					{
						prisontimer = timer(zona, 60000, -1, id.tointeger());
						ini.setKey("PlayerInfo", "prisontimer", time.tointeger()+1);
						ini.setKey("PlayerInfo", "prison", 0);
						ini.setKey("PlayerInfo", "satiety", 100);
						ini.saveData();
						
						sendPlayerMessage(playerid, getPlayerName( playerid ) + " посадил " + getPlayerName( id.tointeger() ) + " на " + time.tointeger() + " минут.", 0, 150, 255);
						sendPlayerMessage(id.tointeger(), "Вас посадил " + getPlayerName( playerid ) + " на " + time.tointeger() + " минут.", 0, 150, 255);
						
						setPlayerPosition( id.tointeger(), -1030.42,1712.74,10.3595 );
						setPlayerHealth( id.tointeger(), 1000.0 );
						setPlayerRotation( id.tointeger(), 0.0, 0.0, 180.0 );
						setPlayerModel( id.tointeger(), 15);
						
						togglePlayerControls( id.tointeger(), false );
					}
					else
					{
						sendPlayerMessage(playerid, "Игрок не в наручниках.", 255, 0, 0);
					}
			}
			else
			{
				sendPlayerMessage(playerid, "Игрок далеко.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не на службе.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский.", 255, 0, 0);
	}
}
);

//тайзер
function tzr(playerid)
{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "prison").tointeger() == 0)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "taizer", 0)
		ini.saveData();
		togglePlayerControls( playerid, false );
		sendPlayerMessage(playerid, "Вы можете двигаться.", 255, 255, 0); 
	}
}
addCommandHandler( "taizer",
function(playerid, id)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
		return sendPlayerMessage(playerid, "Полицейского нельзя оглушить.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
		{
				if(isPlayerInVehicle(id.tointeger())) 
				{
					return sendPlayerMessage(playerid, "Игрок в машине.", 255, 0, 0);
				}
				
					local myPos = getPlayerPosition( id.tointeger() );
					local pos = getPlayerPosition( playerid );
					local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
				if(check)
				{
					local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
					if(ini.getKey("PlayerInfo", "prison").tointeger() == 0)
					{
						if(ini.getKey("PlayerInfo", "taizer").tointeger() == 0)
						{
							ini.setKey("PlayerInfo", "taizer", 1)
							ini.saveData();
							togglePlayerControls( id.tointeger(), true );
							local rTimer = timer( tzr, 15000, 1, id.tointeger() );
							sendPlayerMessage( playerid, "(ME) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]: достал пистолет и сделал предупредительный выстрел в воздух.", 255, 50, 255 );
							sendPlayerMessage( id.tointeger(), "(ME) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]: достал пистолет и сделал предупредительный выстрел в воздух.", 255, 50, 255 );
							sendPlayerMessage( id.tointeger(), "Вы в шоке на 15 секунд.", 0, 150, 255);
						}
						else
						{
							sendPlayerMessage(playerid, "Игрок оглушен.", 255, 0, 0);
						}
					}
					else
					{
						sendPlayerMessage(playerid, "Игрок в наручниках.", 255, 0, 0);
					}
				}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не на службе.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский.", 255, 0, 0);
	}
}
);

addCommandHandler( "arest",
function(playerid, id)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
		return sendPlayerMessage(playerid, "Полицейского нельзя арестовать.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
		{
			local myPos = getPlayerPosition( id.tointeger() );
			local pos = getPlayerPosition( playerid );
			local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 5.0 );
			if(check)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				if(ini.getKey("PlayerInfo", "prison").tointeger() == 0)
				{
				ini.setKey("PlayerInfo", "prison", 1);
				ini.saveData();
				togglePlayerControls( id.tointeger(), true );
				sendPlayerMessage(playerid, getPlayerName( playerid ) + " надел наручники на " + getPlayerName( id.tointeger() ), 0, 150, 255);
				sendPlayerMessage(id.tointeger(), "На вас надел наручники " + getPlayerName( playerid ), 0, 150, 255);
				}
				else
				{
					sendPlayerMessage(playerid, "Игрок в наручниках.", 255, 0, 0);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "Игрок далеко.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не на службе.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский.", 255, 0, 0);
	}
}
);
addCommandHandler( "unarest",
function(playerid, id)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
		return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
		{
			local myPos = getPlayerPosition( id.tointeger() );
			local pos = getPlayerPosition( playerid );
			local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 5.0 );
			if(check)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				if(ini.getKey("PlayerInfo", "prison").tointeger() == 1)
				{
				ini.setKey("PlayerInfo", "prison", 0);
				ini.saveData();
				togglePlayerControls( id.tointeger(), false );
				sendPlayerMessage(playerid, getPlayerName( playerid ) + " снял наручники с " + getPlayerName( id.tointeger() ), 0, 150, 255);
				sendPlayerMessage(id.tointeger(), "С вас снял наручники " + getPlayerName( playerid ), 0, 150, 255);
				}
				else
				{
					sendPlayerMessage(playerid, "Игрок не в наручниках.", 255, 0, 0);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "Игрок далеко.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не на службе.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский.", 255, 0, 0);
	}
}
);
addCommandHandler( "ticket",
function(playerid, id, id1)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
		return sendPlayerMessage(playerid, "Полицейскому нельзя выписать штраф.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
		{
			local myPos = getPlayerPosition( id.tointeger() );
			local pos = getPlayerPosition( playerid );
			local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 5.0 );
			if(check)
			{
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				if(ini.getKey("PlayerInfo", "wanted_lvl").tointeger() == 1)
				{
					local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
					ini.setKey("PlayerInfo", "wanted_lvl", 0);
					ini.saveData();
					sendPlayerMessage(playerid, "Вы сняли 1 уровень розыска с " +getPlayerName(id.tointeger()), 0, 150, 255);
					sendPlayerMessage(id.tointeger(), "Вам сняли 1 уровень розыска.", 0, 150, 255);
				}
				local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
				ini.setKey("PlayerInfo", "ticket", ini.getKey("PlayerInfo", "ticket").tointeger() + id1.tointeger());
				ini.saveData();
				sendPlayerMessage(playerid, getPlayerName( playerid ) + " выписал штраф " + getPlayerName(id.tointeger()) + " в размере " + id1.tointeger() + "$", 0, 150, 255);
				sendPlayerMessage(id.tointeger(), getPlayerName( playerid ) + " выписал вам штраф в размере " + id1.tointeger() + "$", 0, 150, 255);
				
			}
			else
			{
				sendPlayerMessage(playerid, "Игрок далеко.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не на службе.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский.", 255, 0, 0);
	}
}
);

addCommandHandler( "weaponlic",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}

	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id.tointeger() );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1] ,Pos[2], 10.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
		{
			sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
			sendPlayerMessage(id.tointeger(), "Вы не достали кошелек.", 255, 0, 0);
			return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "weaponlic").tointeger() == 0)
		{
			if(ini.getKey("PlayerInfo", "money").tointeger() < 1001)
			{
			sendPlayerMessage(id.tointeger(), "Недостаточно средств.", 255, 0, 0 );
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "weaponlic", 1);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1000);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 1000);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы выдали лицензию на оружие " +getPlayerName(id.tointeger()), 0, 150, 255);
			sendPlayerMessage(id.tointeger(), "Вам выдали лицензию на оружие.", 0, 150, 255);
			sendPlayerMessage(id.tointeger(), "Вы заплатили 1000$.", 255, 100, 0);
		}
		else
		{
			sendPlayerMessage(playerid, "У игрока есть лицензия.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский или не на службе.", 255, 0, 0);
	}
	}
}
);
addCommandHandler( "removeweaponlic",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}

	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "weaponlic").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "weaponlic", 0);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы забрали лицензию на оружие у " +getPlayerName(id.tointeger()), 0, 150, 255);
			sendPlayerMessage(id.tointeger(), "У вас забрал лицензию на оружие " +getPlayerName(playerid), 0, 150, 255);
		}
		else
		{
			sendPlayerMessage(playerid, "У игрока нет лицензии.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский или не на службе.", 255, 0, 0);
	}
}
);
addCommandHandler( "removedriverlic",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}

	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "driverlic").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "driverlic", 0);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы забрали права у " +getPlayerName(id.tointeger()), 0, 150, 255);
			sendPlayerMessage(id.tointeger(), "У вас забрал права " +getPlayerName(playerid), 0, 150, 255);
		}
		else
		{
			sendPlayerMessage(playerid, "У игрока нет прав.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский или не на службе.", 255, 0, 0);
	}
}
);

addCommandHandler( "searchdrugs",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}

	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1] ,Pos[2], 10.0 );
	if(check)
    {
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id)+".ini");
		if(ini.getKey("PlayerInfo", "narko").tointeger() > 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			sendPlayerMessage(playerid, "Вы нашли " +ini.getKey("PlayerInfo", "narko").tointeger()+ " граммов наркотиков и забрали их у " +getPlayerName(id), 0, 150, 255);
			ini.setKey("PlayerInfo", "narko", 0);
			ini.saveData();
			sendPlayerMessage(id, "У вас нашли наркотики их забрал " +getPlayerName(playerid), 0, 150, 255);
		}
		else
		{
			sendPlayerMessage(playerid, "У игрока нет наркотиков.", 0, 150, 255);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский или не на службе.", 255, 0, 0);
	}
	
	}
});

addCommandHandler( "searchguns",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}

	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1] ,Pos[2], 10.0 );
	if(check)
    {
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(id)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
		return sendPlayerMessage(playerid, "Полицейского нельзя обыскать.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(id)+".ini");
		if(ini.getKey("gans", "Model_12_Revolver").tointeger() > 0 || ini.getKey("gans", "Mauser_C96").tointeger() > 0 || ini.getKey("gans", "Colt_M1911A1").tointeger() > 0 || ini.getKey("gans", "Colt_M1911_Special").tointeger() > 0 || ini.getKey("gans", "Model_19_Revolver").tointeger() > 0 || ini.getKey("gans", "Remington_Model_870_Field_gun").tointeger() > 0 || ini.getKey("gans", "M3_Grease_Gun").tointeger() > 0 || ini.getKey("gans", "MP40").tointeger() > 0 || ini.getKey("gans", "Thompson_1928").tointeger() > 0 || ini.getKey("gans", "Molotov_Cocktail").tointeger() > 0 || ini.getKey("gans", "MK2_Frag_Grenade").tointeger() > 0)
		{
			sendPlayerMessage(playerid, "Вы нашли оружие и забрали его у " +getPlayerName(id), 0, 150, 255);
			removePlayerWeapon(id, 2, 0);
			removePlayerWeapon(id, 3, 0);
			removePlayerWeapon(id, 4, 0);
			removePlayerWeapon(id, 5, 0);
			removePlayerWeapon(id, 6, 0);
			removePlayerWeapon(id, 8, 0);
			removePlayerWeapon(id, 9, 0);
			removePlayerWeapon(id, 10, 0);
			removePlayerWeapon(id, 11, 0);
			removePlayerWeapon(id, 20, 0);
			removePlayerWeapon(id, 21, 0);
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("gans", "Model_12_Revolver", 0);
			ini.setKey("gans", "Colt_M1911A1", 0);
			ini.setKey("gans", "MP40", 0);
			ini.setKey("gans", "Thompson_1928", 0);
			ini.setKey("gans", "Mauser_C96", 0);
			ini.setKey("gans", "Remington_Model_870_Field_gun", 0);
			ini.setKey("gans", "M3_Grease_Gun", 0);
			ini.setKey("gans", "Colt_M1911_Special", 0);
			ini.setKey("gans", "MK2_Frag_Grenade", 0);
			ini.setKey("gans", "Model_19_Revolver", 0);
			ini.setKey("gans", "Molotov_Cocktail", 0);
			ini.saveData();
			sendPlayerMessage(id, "У вас нашли оружие его забрал " +getPlayerName(playerid), 0, 150, 255);
		}
		else
		{
			sendPlayerMessage(playerid, "У игрока нет оружия.", 0, 150, 255);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский или не на службе.", 255, 0, 0);
	}
	
	}
});

addCommandHandler("search",
function(playerid, id, lvl, ...)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local id = id.tointeger();
	local lvl = lvl.tointeger();
	local text = "";
	for(local i = 0; i < vargv.len(); i++)
	{
		text = text + " " + vargv[i];
	}
	
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
	{
		return sendPlayerMessage(playerid, "Игрок полицейский.", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		if(lvl == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "wanted_lvl", 0);
			ini.setKey("PlayerInfo", "wanted", 0);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы сняли розыск с " +getPlayerName(id)+ " и обнулили кол-во преступлений. Причина:" +text, 0, 150, 255);
			sendPlayerMessage(id, getPlayerName(playerid)+ " снял розыск и обнулил кол-во преступлений. Причина:" +text, 0, 150, 255);
			return;
		}
		if(lvl == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "wanted_lvl", 1);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы выдали " +getPlayerName(id)+ " 1 звезду. Причина:" +text, 0, 150, 255);
			sendPlayerMessage(id, getPlayerName(playerid)+ " выдал 1 звезду. Причина:" +text, 0, 150, 255);
			return;
		}
		if(lvl == 2)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "wanted_lvl", 2);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы выдали " +getPlayerName(id)+ " 2 звезды. Причина:" +text, 0, 150, 255);
			sendPlayerMessage(id, getPlayerName(playerid)+ " выдал 2 звезды. Причина:" +text, 0, 150, 255);
			return;
		}
		if(lvl == 3)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "wanted_lvl", 3);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы выдали " +getPlayerName(id)+ " 3 звезды. Причина:" +text, 0, 150, 255);
			sendPlayerMessage(id, getPlayerName(playerid)+ " выдал 3 звезды. Причина:" +text, 0, 150, 255);
			return;
		}
		if(lvl == 4)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "wanted_lvl", 4);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы выдали " +getPlayerName(id)+ " 4 звезды. Причина:" +text, 0, 150, 255);
			sendPlayerMessage(id, getPlayerName(playerid)+ " выдал 4 звезды. Причина:" +text, 0, 150, 255);
			return;
		}
		sendPlayerMessage(playerid, "Введите число от 0 до 3", 255, 0, 0);
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский или не на службе.", 255, 0, 0);
	}
});

addCommandHandler("scan",
function(playerid, id)
{
	local id = id.tointeger();
	
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 42)
		{
			local myPos = getPlayerPosition( id );
			local pos = getPlayerPosition( playerid );
			local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
			if(check)
			{
				local ini = EasyINI("account/"+getPlayerName(id)+".ini");
				sendPlayerMessage(playerid, "===========================================", 0, 150, 255);
				sendPlayerMessage(playerid, "Диспетчер, проверьте гражданина по имени " +getPlayerName(id), 0, 150, 255);
				sendPlayerMessage(playerid, "(Ответ от Диспетчера) Уровень розыска: " +ini.getKey("PlayerInfo", "wanted_lvl")+ " Возбуждено уголовных дел: "+ini.getKey("PlayerInfo", "wanted") + " Штраф: "+ini.getKey("PlayerInfo", "ticket") +"$", 0, 150, 255);	
			}
			else
			{
				sendPlayerMessage(playerid, "Игрок далеко.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы должны находится в патрульной машине.", 255, 0, 0);
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не полицейский или не на службе.", 255, 0, 0);
	}
	
});

addEventHandler("cops", function(playerid) {
 
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -378.987, 654.699, -10.5013, 2.0 );
	if(check)
    {
		local ini = EasyINI("biz/kazna.ini");
		if(ini.getKey("gans", "ebpd_gans").tointeger() < 298)
		{
		return sendPlayerMessage(playerid, "На складе нет патронов.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 0)
		{
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 1)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "skin_f", 75);
				ini.saveData();
				
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger() );
			}
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 2)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "skin_f", 76);
				ini.saveData();
				
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger() );
			}
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 3)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "skin_f", 76);
				ini.saveData();
				
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger() );
			}
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 4)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "skin_f", 69);
				ini.saveData();
				
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger() );
			}
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 5)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "skin_f", 69);
				ini.saveData();
				
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger() );
			}
			if(ini.getKey("PlayerInfo", "rang").tointeger() == 6)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "skin_f", 68);
				ini.saveData();
				
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin_f").tointeger() );	
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Model_12_Revolver", 42);
			ini.setKey("gans", "Remington_Model_870_Field_gun", 56);
			ini.setKey("gans", "Thompson_1928", 200);
			ini.setKey("PlayerInfo", "fraction_p", 1);
			ini.saveData();
			
			givePlayerWeapon( playerid, 2, 42 );//револьвер копов(6)
			givePlayerWeapon( playerid, 8, 56 );//дробовик копов(8)
			givePlayerWeapon( playerid, 11, 200 );//пп томпсон(50)
			
			sendPlayerMessage(playerid, "Вы заступили на службу.", 0, 150, 255);
			sendPlayerMessage(playerid, "Вам выдали оружие.", 0, 150, 255);
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("gans", "ebpd_gans", ini.getKey("gans", "ebpd_gans").tointeger() - 298);
			ini.saveData();
        }
		else
		{
			sendPlayerMessage(playerid, "Вы не полицейский или уже на службе.", 255, 0, 0);
		}
	}
});
addEventHandler("copsq", function(playerid) {
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -378.987, 654.699, -10.5013, 2.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1)
		{
			if(ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.setKey("gans", "Model_12_Revolver", 0);
				ini.setKey("gans", "Remington_Model_870_Field_gun", 0);
				ini.setKey("gans", "Thompson_1928", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы закончили службу.", 0, 150, 255);
				sendPlayerMessage(playerid, "У вас забрали оружие.", 0, 150, 255);
				removePlayerWeapon( playerid, 2, 0 );
				removePlayerWeapon( playerid, 8, 0 );
				removePlayerWeapon( playerid, 11, 0 );
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не на службе.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не полицейский.", 255, 0, 0);
		}
	}
});

//медики
addEventHandler("egh", function(playerid) {
 
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -393.394,913.983,-20.0026, 2.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "fraction_p", 1);
			ini.saveData();
				
			sendPlayerMessage(playerid, "Вы заступили на дежурство.", 255, 100, 100);
        }
		else
		{
			sendPlayerMessage(playerid, "Вы не медик или уже на дежурстве.", 255, 0, 0);
		}
	}
});
addCommandHandler("buykit", function(playerid) {
 
 if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -393.394,913.983,-20.0026, 2.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 500)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "kit", ini.getKey("PlayerInfo", "kit").tointeger() + 1);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 500);
			ini.saveData();
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 500);
			ini.saveData();
				
			sendPlayerMessage(playerid, "Вы купили аптечку за 500$", 255, 100, 0);
        }
		else
		{
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
	}
});
addCommandHandler("usekit", function(playerid) {
 
 if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "kit").tointeger() >= 1)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "kit", ini.getKey("PlayerInfo", "kit").tointeger() - 1);
			ini.saveData();
			setPlayerHealth(playerid, 1000.0);
				
			sendPlayerMessage(playerid, "Вы пополнили здоровье.", 255, 255, 0);
        }
		else
		{
			sendPlayerMessage(playerid, "Недостаточно аптечек.", 255, 0, 0);
		}
});
addEventHandler("eghq", function(playerid) {
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -393.394,913.983,-20.0026, 2.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2)
		{
			if(ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы закончили дежурство.", 255, 100, 100);
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не на дежурстве.", 255, 0, 0);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не медик.", 255, 0, 0);
		}
	}
});
addCommandHandler("heal", 
function(playerid, id, money) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id.tointeger() );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1] ,Pos[2], 10.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
		{
			sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
			sendPlayerMessage(id.tointeger(), "Вы не достали кошелек.", 255, 0, 0);
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < money.tointeger())
			{
			sendPlayerMessage(id.tointeger(), "Недостаточно средств.", 255, 0, 0 );
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger()-money.tointeger());
			ini.saveData();
			setPlayerHealth(id.tointeger(), 1000.0);
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger()+money.tointeger());
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы выличили "+getPlayerName(id.tointeger())+ " за " +money.tointeger()+ "$", 255, 100, 100);
			sendPlayerMessage(id.tointeger(), "Вас выличили.", 255, 100, 100);
			sendPlayerMessage(id.tointeger(), "Вы заплатили "+money.tointeger()+"$", 255, 100, 0);
        }
		else
		{
			sendPlayerMessage(playerid, "Вы не медик или не на дежурстве.", 255, 0, 0);
		}
	}
});

addCommandHandler("addiction", 
function(playerid, id, money) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id.tointeger() );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1] ,Pos[2], 10.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
		{
			sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
			sendPlayerMessage(id.tointeger(), "Вы не достали кошелек.", 255, 0, 0);
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < money.tointeger())
			{
			sendPlayerMessage(id.tointeger(), "Недостаточно средств.", 255, 0, 0 );
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger()-money.tointeger());
			ini.setKey("PlayerInfo", "narko_zavisimost", 0);
			ini.saveData();
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger()+money.tointeger());
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы выличили "+getPlayerName(id.tointeger())+ " за " +money.tointeger()+ "$ от наркозависимости.", 255, 100, 100);
			sendPlayerMessage(id.tointeger(), "Вас выличили от наркозависимости.", 255, 100, 100);
			sendPlayerMessage(id.tointeger(), "Вы заплатили "+money.tointeger()+"$", 255, 100, 0);
        }
		else
		{
			sendPlayerMessage(playerid, "Вы не медик или не на дежурстве.", 255, 0, 0);
		}
	}
});

addCommandHandler("narkotest", 
function(playerid, id) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id.tointeger())+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id.tointeger() );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1] ,Pos[2], 10.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(id.tointeger())+".ini");
		sendPlayerMessage(playerid, "У " +getPlayerName(id.tointeger())+ " " +ini.getKey("PlayerInfo", "narko_zavisimost").tointeger()+ " уровень зависимости.", 255, 100, 100);
	}
	
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не медик или не на дежурстве.", 255, 0, 0);
	}
});

//армия эб
addEventHandler("aeb_gans", function(playerid) {
 
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1578.96,-323.928,-20.3172, 2.0 );
	if(check)
    {
		local ini = EasyINI("biz/kazna.ini");
		if(ini.getKey("gans", "aeb_gans").tointeger() < 244)
		{
		return sendPlayerMessage(playerid, "На складе нет патронов.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)
		{
			sendPlayerMessage(playerid, "Вам выдали оружие.", 150, 150, 0);
			givePlayerWeapon( playerid, 3, 60 ); //пистолет с96
			givePlayerWeapon( playerid, 8, 56 ); //дробовик копов(8)
			givePlayerWeapon( playerid, 10, 128 ); //мп40 (32)
			
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("gans", "aeb_gans", ini.getKey("gans", "aeb_gans").tointeger() - 244);
			ini.saveData();
		}
		else
		{
		sendPlayerMessage(playerid, "Вы не военнослужащий.", 255, 0, 0);
		}
	}
});

addCommandHandler( "irp",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1578.96,-323.928,-20.3172, 2.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "satiety", 100);
			ini.saveData();
			setPlayerHealth(playerid, 1000.0);
	
			sendPlayerMessage(playerid, "Вы покушали.", 150, 150, 0);
		}
		else
		{
		sendPlayerMessage(playerid, "Вы не военнослужащий.", 255, 0, 0);
		}
	}
});

//армия, триада, доставщик оружия
addEventHandler("load_gans", function(playerid) {

	local vehicleid = getPlayerVehicle(playerid);
	local model = getVehicleModel(vehicleid);
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1542.96,-369.083,-19.3354, 10.0 );
	if(check)
    {
		if(model == 3)
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("gans", "aeb_gans").tointeger() < 1000)
			{
			return sendPlayerMessage(playerid, "На складе нет патронов.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 0)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "fraction_p", 1);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы загрузили патроны.", 150, 150, 0);
			
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("gans", "aeb_gans", ini.getKey("gans", "aeb_gans").tointeger() - 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы уже загрузили патроны.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() == 116)//триада
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("gans", "aeb_gans").tointeger() < 1000)
			{
			return sendPlayerMessage(playerid, "На складе нет патронов.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 0)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "fraction_p", 1);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы загрузили патроны.", 200, 0, 0);
			
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("gans", "aeb_gans", ini.getKey("gans", "aeb_gans").tointeger() - 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы уже загрузили патроны.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 108 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 109)
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("gans", "aeb_gans").tointeger() < 1000)
			{
			return sendPlayerMessage(playerid, "На складе нет патронов.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 11 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p", 1000);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "gpsunloadgans", "" );
				sendPlayerMessage(playerid, "Вы загрузили патроны.", 255, 255, 0);
			
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("gans", "aeb_gans", ini.getKey("gans", "aeb_gans").tointeger() - 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы уже загрузили патроны.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() == 71)//ирландцы
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("gans", "aeb_gans").tointeger() < 1000)
			{
			return sendPlayerMessage(playerid, "На складе нет патронов.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 0)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "fraction_p", 1);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы загрузили патроны.", 0, 255, 0);
			
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("gans", "aeb_gans", ini.getKey("gans", "aeb_gans").tointeger() - 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы уже загрузили патроны.", 255, 0, 0);
			}
			return;
		}
	}
});
addEventHandler("unload_gans", function(playerid) {
	
	local vehicleid = getPlayerVehicle(playerid);
	local model = getVehicleModel(vehicleid);
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -315.909,679.425,-18.6004, 10.0 );//коповский склад
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 353.893,385.469,-19.5472, 10.0 );//триада
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 673.996,127.642,-12.2194, 10.0 );//склад жд
	local check4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1162.24,1536.75,6.541, 10.0 );//ирландцы
	if(check1)
    {
		if(model == 3)
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("gans", "ebpd_gans").tointeger() > 490000)
			{
				return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы разгрузили оружие.", 150, 150, 0);
			
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("gans", "ebpd_gans", ini.getKey("gans", "ebpd_gans").tointeger() + 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не загрузили патроны.", 255, 0, 0);
			}
			return;
		}
	}
	if(check2)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() == 116)
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("gans", "triada_gans").tointeger() > 490000)
			{
				return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы разгрузили оружие.", 200, 0, 0);
			
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() + 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не загрузили патроны.", 255, 0, 0);
			}
			return;
		}
	}
	if(check3)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 108 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 109)
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("GANS", "prod").tointeger() >= 50000)
			{
			return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
			}
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("GANS", "owner").tointeger() == 0)
			{
			return sendPlayerMessage(playerid, "Магазин оружия не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 11 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1000)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "gpsloadgans", "" );
				sendPlayerMessage(playerid, "Вы разгрузили патроны и заработали 500$", 0, 255, 0);
			
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() + 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не загрузили патроны.", 255, 0, 0);
			}
			return;
		}
	}
	if(check4)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() == 71)
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("gans", "irish_gans").tointeger() > 490000)
			{
				return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				ini.setKey("PlayerInfo", "fraction_p", 0);
				ini.saveData();
				sendPlayerMessage(playerid, "Вы разгрузили оружие.", 0, 255, 0);
			
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() + 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не загрузили патроны.", 255, 0, 0);
			}
			return;
		}
	}
});

//оружие на складе
addEventHandler( "gansinfo",
function ( playerid )
{
	local myPos = getPlayerPosition( playerid );
	local gans1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -315.909,679.425,-18.6004, 10.0 );//копы
	local gans2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1542.96,-369.083,-19.3354, 10.0 );//армия
	local gans3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 353.893,385.469,-19.5472, 10.0 );//триада
	local gans4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1162.24,1536.75,6.541, 10.0 );//ирландцы
	if(gans1)//копы
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/kazna.ini");
			sendPlayerMessage(playerid, "На складе "+ini.getKey("gans", "ebpd_gans").tointeger()+" шт патронов.", 0, 150, 255);
		}
	}
	if(gans2)//армия
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/kazna.ini");
			sendPlayerMessage(playerid, "На складе "+ini.getKey("gans", "aeb_gans").tointeger()+" шт патронов.", 150, 150, 0);
		}
	}
	if(gans3)//триада
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/kazna.ini");
			sendPlayerMessage(playerid, "На складе "+ini.getKey("gans", "triada_gans").tointeger()+" шт патронов.", 200, 0, 0);
		}
	}
	if(gans4)//ирландцы
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/kazna.ini");
			sendPlayerMessage(playerid, "На складе "+ini.getKey("gans", "irish_gans").tointeger()+" шт патронов.", 0, 255, 0);
		}
	}
	
});

//триада(мафии)
addCommandHandler( "infonarko",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 389.846,125.266,-19.2027, 2.0 );
	if(check)
    {
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		local ini = EasyINI("biz/kazna.ini");
		sendPlayerMessage(playerid, "На складе "+ini.getKey("drugs", "narko_triada").tointeger()+" грамм наркотиков.", 200, 0, 0);
	}
	else
	{
		sendPlayerMessage(playerid, "Вы не состоите в криминальных структурах.", 255, 0, 0);
	}
	
	}
});

addCommandHandler( "givedrugs",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local id = id.tointeger();
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 389.846,125.266,-19.2027, 2.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
		{
			local ini = EasyINI("biz/kazna.ini");
			if(ini.getKey("drugs", "narko_triada").tointeger() < id)
				{
					return sendPlayerMessage( playerid, "Вы ввели неправильное количество.", 255, 0, 0 );
				}
			local ini = EasyINI("biz/kazna.ini");
			ini.setKey("drugs", "narko_triada", ini.getKey("drugs", "narko_triada").tointeger() - id);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы забрали " +id+ " граммов со склада.", 255, 255, 0);
			log("");
			log("[NARKO] " +getPlayerName(playerid)+ " забрал со склада " +id+ " граммов наркоты");
			log("");
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "narko", ini.getKey("PlayerInfo", "narko").tointeger() + id);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не состоите в криминальных структурах.", 255, 0, 0);
		}
	}
});

//мафия + банды
addCommandHandler( "selldrugs",
function( playerid, id_player, id, money )
{
	local id_player = id_player.tointeger();
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id_player)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local money = money.tointeger();
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id_player );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 5.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
		{			
			local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < money)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
			}
			local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
			if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
			{
				sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
				sendPlayerMessage(id_player, "Вы не достали кошелек.", 255, 0, 0);
				return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "narko", ini.getKey("PlayerInfo", "narko").tointeger() - id);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.saveData();
			
			sendPlayerMessage(playerid, "Вы продали " +id+ " граммов наркоты за " +money+ "$", 255, 255, 0);
			
			local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
			ini.setKey("PlayerInfo", "narko", ini.getKey("PlayerInfo", "narko").tointeger() + id);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не состоите в криминальных структурах.", 255, 0, 0);
		}
	}
});

function grab()
{
	uvelirka = 0;
}

addCommandHandler( "robbery",
function( playerid )
{
	local randomize = random(0,1);
	local randomize1 = random(1,5000);
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -534.975,-42.5656,1.03805, 5.0 );
	if(check)
    {
		if(uvelirka == 1)
		{
			sendPlayerMessage(playerid, "Ограбление доступно один раз в 30 мин.", 255, 0, 0);
			return;
		}
		
		if(randomize == 1)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
			{
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("drugs", "money_triada", ini.getKey("drugs", "money_triada").tointeger() + randomize1);
				ini.saveData();
				
				uvelirka = 1;
				local rTimer = timer( grab, 1800000, 1 );
				
				sendPlayerMessage(playerid, "Вам удалось ограбить ювелирку и унести украшений на сумму " +randomize1+ "$", 0, 255, 0);
				sendPlayerMessage(playerid, "Вы пополнили общак триады.", 255, 255, 0);
				
				foreach(i, playername in getPlayers())
				{
					if(FileExists("account/"+getPlayerName(i)+".ini") == false)
					{
					return;
					}
					local ini = EasyINI("account/"+getPlayerName(i)+".ini");
					if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
					{
					return;
					}
					
					local ini = EasyINI("account/"+getPlayerName(i)+".ini");
					if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
					{
						sendPlayerMessage(i, "(ДИСПЕТЧЕР) Внимание, ограбление в ювелирке, подозреваемый возможно вооружен, всем машинам проследовать на вызов!", 0, 150, 255);
					}
				}
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
			{
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("irish", "money_irish", ini.getKey("irish", "money_irish").tointeger() + randomize1);
				ini.saveData();
				
				uvelirka = 1;
				local rTimer = timer( grab, 1800000, 1 );
				
				sendPlayerMessage(playerid, "Вам удалось ограбить ювелирку и унести украшений на сумму " +randomize1+ "$", 0, 255, 0);
				sendPlayerMessage(playerid, "Вы пополнили общак ирландцев.", 255, 255, 0);
				
				foreach(i, playername in getPlayers())
				{
					if(FileExists("account/"+getPlayerName(i)+".ini") == false)
					{
					return;
					}
					local ini = EasyINI("account/"+getPlayerName(i)+".ini");
					if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
					{
					return;
					}
					
					local ini = EasyINI("account/"+getPlayerName(i)+".ini");
					if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
					{
						sendPlayerMessage(i, "(ДИСПЕТЧЕР) Внимание, ограбление в ювелирке, подозреваемый возможно вооружен, всем машинам проследовать на вызов!", 0, 150, 255);
					}
				}
			return;
			}
		}
		else
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
			{
				sendPlayerMessage(playerid, "Вам не удалось ограбить ювелирку.", 255, 0, 0);
				uvelirka = 1;
				local rTimer = timer( grab, 1800000, 1 );
			}
		}
	}	
});

//мафия + банды
addCommandHandler( "excar",
function( playerid, id )
{
	local id = id.tointeger();
	local randomize = random(0,1);
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1 || ini.getKey("PlayerInfo", "fraction").tointeger() == 4 || ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
	{
        local myPos = getPlayerPosition( playerid );
		local Pos = getPlayerPosition( id );
		local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 10.0 );
		if(check1)
		{
			if (!isPlayerInVehicle(id))
			{
				return sendPlayerMessage(playerid, "Игрок не в машине.", 255, 0, 0);
			}
			foreach(i, playername in getPlayers())
			{
				if(FileExists("account/"+getPlayerName(i)+".ini") == false)
				{
				return;
				}
				local ini = EasyINI("account/"+getPlayerName(i)+".ini");
				if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
				{
				return;
				}
				
				local myPos = getPlayerPosition( i );
				local pos = getPlayerPosition( playerid );
				local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
				if(check2)
				{
					if(randomize == 1)
					{
					sendPlayerMessage( i, "(TRY) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ": Выстрелил в бензобак [Удачно]", 255, 100, 255 );
					sendPlayerMessage( id, "У вас вытекло все топливо.", 255, 255, 0 );
					
					local vehicleid = getPlayerVehicle(id);
					setVehicleFuel(vehicleid, 0.0);
					}
					else
					{
					sendPlayerMessage( i, "(TRY) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ": Выстрелил в бензобак [Неудачно]", 255, 100, 255 );
					}
				}
			}
		}
	}
});

addCommandHandler( "tie",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
	{
        local myPos = getPlayerPosition( playerid );
		local Pos = getPlayerPosition( id );
		local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 5.0 );
		if(check1)
		{
			if (!isPlayerInVehicle(id))
			{
				return sendPlayerMessage(playerid, "Игрок не в машине.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			if (ini.getKey("PlayerInfo", "tie_p").tointeger() == 1)
			{
				return sendPlayerMessage(playerid, "Игрок связан.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "tie_p", 1);
			ini.saveData();
			togglePlayerControls( id, true );
			
			foreach(i, playername in getPlayers())
			{
				local myPos = getPlayerPosition( i );
				local pos = getPlayerPosition( playerid );
				local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
				if(check2)
				{
					sendPlayerMessage( i, "(ME) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ": Связал "+ getPlayerName( id )+ "["+getPlayerIdFromName(getPlayerName( id ))+"]", 255, 50, 255 );	
				}
			}
			
		}
	}
});

addCommandHandler( "untie",
function( playerid, id )
{
	local id = id.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
	{
        local myPos = getPlayerPosition( playerid );
		local Pos = getPlayerPosition( id );
		local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 5.0 );
		if(check1)
		{
			if (!isPlayerInVehicle(id))
			{
				return sendPlayerMessage(playerid, "Игрок не в машине.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			if (ini.getKey("PlayerInfo", "tie_p").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Игрок не связан.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "tie_p", 0);
			ini.saveData();
			togglePlayerControls( id, false );
			
			foreach(i, playername in getPlayers())
			{
				local myPos = getPlayerPosition( i );
				local pos = getPlayerPosition( playerid );
				local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], pos[0], pos[1], pos[2], 10.0 );
				if(check2)
				{
					sendPlayerMessage( i, "(ME) " + getPlayerName( playerid )+ "["+getPlayerIdFromName(getPlayerName( playerid ))+"]" + ": Рязвязал "+ getPlayerName( id )+ "["+getPlayerIdFromName(getPlayerName( id ))+"]", 255, 50, 255 );	
				}
			}
			
		}
	}
});

//мафия + банды
addCommandHandler( "sellguns",
function( playerid, id_player, id_gans, money )
{
	local id_player = id_player.tointeger();
	local id_gans = id_gans.tointeger();
	local money = money.tointeger();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	if(FileExists("account/"+getPlayerName(id_player)+".ini") == false)
	{
	return;
	}
	local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
	return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
	if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
	{
		sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
		sendPlayerMessage(id_player, "Вы не достали кошелек.", 255, 0, 0);
		return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4)
	{
        local myPos = getPlayerPosition( playerid );
		local Pos = getPlayerPosition( id_player );
		local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 353.893,385.469,-19.5472, 10.0 );
		local check2 = isPointInCircle3D( Pos[0], Pos[1], Pos[2], 353.893,385.469,-19.5472, 10.0 );
		if(check1 && check2)
		{
				local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
				if(ini.getKey("PlayerInfo", "money").tointeger() >= money)
				{
					if(id_gans == 2)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 43)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Model_12_Revolver").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Model_12_Revolver", 42);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Model 12 Revolver за 42 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Model 12 Revolver, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 2, 42 ); //револьвер копов(6)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 42);
						ini.saveData();
						return;
					}
					if(id_gans == 3)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 61)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Mauser_C96").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Mauser_C96", 60);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Mauser C96 за 60 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Mauser C96, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 3, 60 ); //пистолет с96(10)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 60);
						ini.saveData();
						return;
					}
					if(id_gans == 4)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 57)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Colt_M1911A1").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Colt_M1911A1", 56);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Colt M1911A1 за 56 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Colt M1911A1, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 4, 56 ); //кольт 1911(7)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 56);
						ini.saveData();
						return;
					}
					if(id_gans == 5)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 93)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Colt_M1911_Special").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Colt_M1911_Special", 92);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Colt M1911 Special за 92 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Colt M1911 Special, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 5, 92 ); //кольт 1911 (23)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 92);
						ini.saveData();
						return;
					}
					if(id_gans == 6)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 43)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Model_19_Revolver").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Model_19_Revolver", 42);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Model 19 Revolver за 42 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Model 19 Revolver, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 6, 42 ); //магнум (6)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 42);
						ini.saveData();
						return;
					}
					if(id_gans == 8)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 57)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Remington_Model_870_Field_gun").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Remington_Model_870_Field_gun", 56);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Remington Model 870 Field gun за 56 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Remington Model 870 Field gun, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 8, 56 ); //дробовик копов(8)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 56);
						ini.saveData();
						return;
					}
					if(id_gans == 9)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 122)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "M3_Grease_Gun").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "M3_Grease_Gun", 120);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали M3 Grease Gun за 121 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали M3 Grease Gun, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 9, 120 ); //пп (30)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 121);
						ini.saveData();
						return;
					}
					if(id_gans == 10)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 129)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "MP40").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "MP40", 128);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали MP40 за 128 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали MP40, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 10, 128 ); //мп40 (32)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 128);
						ini.saveData();
						return;
					}
					if(id_gans == 11)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 201)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Thompson_1928").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Thompson_1928", 200);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Thompson 1928 за 200 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Thompson 1928, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 11, 200 ); //пп томпсон(50)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 200);
						ini.saveData();
						return;
					}
					if(id_gans == 21)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 7)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Molotov_Cocktail").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Molotov_Cocktail", 6);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Molotov Cocktail за 6 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Molotov Cocktail, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 21, 6 ); //молотов(1)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 6);
						ini.saveData();
						return;
					}
					if(id_gans == 20)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "triada_gans").tointeger() < 7)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "MK2_Frag_Grenade").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "MK2_Frag_Grenade", 6);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали MK2 Frag Grenade за 6 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали MK2 Frag Grenade, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 20, 6 ); //граната(1)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "triada_gans", ini.getKey("gans", "triada_gans").tointeger() - 6);
						ini.saveData();
						return;
					}
				}
				else
				{
					sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
				}
		}
		else
		{
			sendPlayerMessage( playerid, "Нужно находится около базы триады.", 255, 0, 0 );
			sendPlayerMessage( id_player, "Нужно находится около базы триады.", 255, 0, 0 );
		}
	return;
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5)
	{
        local myPos = getPlayerPosition( playerid );
		local Pos = getPlayerPosition( id_player );
		local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1162.24,1536.75,6.541, 10.0 );
		local check2 = isPointInCircle3D( Pos[0], Pos[1], Pos[2], -1162.24,1536.75,6.541, 10.0 );
		if(check1 && check2)
		{
				local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
				if(ini.getKey("PlayerInfo", "money").tointeger() >= money)
				{
					if(id_gans == 2)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 43)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Model_12_Revolver").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Model_12_Revolver", 42);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Model 12 Revolver за 42 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Model 12 Revolver, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 2, 42 ); //револьвер копов(6)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 42);
						ini.saveData();
						return;
					}
					if(id_gans == 3)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 61)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Mauser_C96").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Mauser_C96", 60);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Mauser C96 за 60 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Mauser C96, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 3, 60 ); //пистолет с96(10)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 60);
						ini.saveData();
						return;
					}
					if(id_gans == 4)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 57)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Colt_M1911A1").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Colt_M1911A1", 56);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Colt M1911A1 за 56 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Colt M1911A1, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 4, 56 ); //кольт 1911(7)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 56);
						ini.saveData();
						return;
					}
					if(id_gans == 5)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 93)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Colt_M1911_Special").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Colt_M1911_Special", 92);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Colt M1911 Special за 92 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Colt M1911 Special, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 5, 92 ); //кольт 1911 (23)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 92);
						ini.saveData();
						return;
					}
					if(id_gans == 6)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 43)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Model_19_Revolver").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Model_19_Revolver", 42);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Model 19 Revolver за 42 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Model 19 Revolver, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 6, 42 ); //магнум (6)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 42);
						ini.saveData();
						return;
					}
					if(id_gans == 8)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 57)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Remington_Model_870_Field_gun").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Remington_Model_870_Field_gun", 56);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Remington Model 870 Field gun за 56 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Remington Model 870 Field gun, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 8, 56 ); //дробовик копов(8)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 56);
						ini.saveData();
						return;
					}
					if(id_gans == 9)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 122)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "M3_Grease_Gun").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "M3_Grease_Gun", 120);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали M3 Grease Gun за 121 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали M3 Grease Gun, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 9, 120 ); //пп (30)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 121);
						ini.saveData();
						return;
					}
					if(id_gans == 10)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 129)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "MP40").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "MP40", 128);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали MP40 за 128 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали MP40, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 10, 128 ); //мп40 (32)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 128);
						ini.saveData();
						return;
					}
					if(id_gans == 11)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 201)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Thompson_1928").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Thompson_1928", 200);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Thompson 1928 за 200 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Thompson 1928, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 11, 200 ); //пп томпсон(50)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 200);
						ini.saveData();
						return;
					}
					if(id_gans == 21)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 7)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "Molotov_Cocktail").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "Molotov_Cocktail", 6);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали Molotov Cocktail за 6 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали Molotov Cocktail, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 21, 6 ); //молотов(1)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 6);
						ini.saveData();
						return;
					}
					if(id_gans == 20)
					{
						local ini = EasyINI("biz/kazna.ini");
						if(ini.getKey("gans", "irish_gans").tointeger() < 7)
						{
							return sendPlayerMessage( playerid, "Недостаточно патронов на складе.", 255, 0, 0 );
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						if(ini.getKey("gans", "MK2_Frag_Grenade").tointeger() == 1)
						{
							sendPlayerMessage( playerid, "У игрока уже есть это оружие.", 255, 0, 0 );
							sendPlayerMessage( id_player, "У вас уже есть это оружие.", 255, 0, 0 );
							return;
						}
						local ini = EasyINI("account/"+getPlayerName(id_player)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
						ini.setKey("gans", "MK2_Frag_Grenade", 6);
						ini.saveData();
						
						local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
						ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
						ini.saveData();
			
						sendPlayerMessage( playerid, "Вы сделали MK2 Frag Grenade за 6 патрона, вам заплатили " +money+ "$", 0, 255, 0 );
						sendPlayerMessage( id_player, "Вам сделали MK2 Frag Grenade, вы заплатили " +money+ "$", 255, 100, 0 );
						givePlayerWeapon( id_player, 20, 6 ); //граната(1)
			
						local ini = EasyINI("biz/kazna.ini");
						ini.setKey("gans", "irish_gans", ini.getKey("gans", "irish_gans").tointeger() - 6);
						ini.saveData();
						return;
					}
				}
				else
				{
					sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
				}
		}
		else
		{
			sendPlayerMessage( playerid, "Нужно находится около базы триады.", 255, 0, 0 );
			sendPlayerMessage( id_player, "Нужно находится около базы триады.", 255, 0, 0 );
		}
	return;
	}

	sendPlayerMessage( playerid, "Вы не состоите в криминальных структурах.", 255, 0, 0 );
});

//ирландцы(банды)

//{покупка оружия
addCommandHandler( "buyguns", 
function(playerid, id) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local id = id.tointeger();
	local myPos = getPlayerPosition( playerid );
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
	
	if(gans1 || gans2 || gans3 || gans4 || gans5 || gans6 || gans7 || gans8 || gans9 || gans10 || gans11)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "weaponlic").tointeger() == 0)
		{
			return sendPlayerMessage( playerid, "Для покупки необходимо иметь лицензию на оружие.", 255, 0, 0 );
		}
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "owner").tointeger() == 0 || ini.getKey("GANS", "prod").tointeger() == 0)
		{
			return sendPlayerMessage( playerid, "Магазин оружия не работает.", 255, 0, 0 );
		}
		
		if(id == 2)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 42)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 630)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Model_12_Revolver").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Model_12_Revolver", 42);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 630);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Model 12 Revolver за 630$", 255, 100, 0 );
			givePlayerWeapon( playerid, 2, 42 ); //револьвер копов(6)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 630);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 42);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}
		}
		
		if(id == 3)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 60)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 1050)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Mauser_C96").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Mauser_C96", 60);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1050);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Mauser C96 за 1050$", 255, 100, 0 );
			givePlayerWeapon( playerid, 3, 60 ); //пистолет с96(10)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 1050);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 60);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}
		}
		
		if(id == 4)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 56)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 1230)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Colt_M1911A1").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Colt_M1911A1", 56);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1230);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Colt M1911A1 за 1230$", 255, 100, 0 );
			givePlayerWeapon( playerid, 4, 56 ); //кольт 1911(7)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 1230);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 56);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}	
		}
		
		if(id == 5)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 92)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 2700)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Colt_M1911_Special").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Colt_M1911_Special", 92);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2700);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Colt M1911 Special за 2700$", 255, 100, 0 );
			givePlayerWeapon( playerid, 5, 92 ); //кольт 1911 (23)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 2700);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 92);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}
		}
		
		if(id == 6)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 42)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 1500)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Model_19_Revolver").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Model_19_Revolver", 42);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1500);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Model 19 Revolver за 1500$", 255, 100, 0 );
			givePlayerWeapon( playerid, 6, 42 ); //магнум (6)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 1500);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 42);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}	
		}
		
		if(id == 8)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 56)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 4000)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Remington_Model_870_Field_gun").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Remington_Model_870_Field_gun", 56);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4000);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Remington Model 870 Field gun за 4000$", 255, 100, 0 );
			givePlayerWeapon( playerid, 8, 56 ); //дробовик копов(8)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 4000);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 56);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}
		}
		
		if(id == 9)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 120)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 1990)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "M3_Grease_Gun").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "M3_Grease_Gun", 120);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1990);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили M3 Grease Gun за 1990$", 255, 100, 0 );
			givePlayerWeapon( playerid, 9, 120 ); //пп (30)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 1990);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 120);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}	
		}
		
		if(id == 10)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 128)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 2190)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "MP40").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "MP40", 128);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 2190);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили MP40 за 2190$", 255, 100, 0 );
			givePlayerWeapon( playerid, 10, 128 ); //мп40 (32)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 2190);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 128);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}
		}
		
		if(id == 11)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 200)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 4700)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Thompson_1928").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Thompson_1928", 200);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 4700);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Thompson 1928 за 4700$", 255, 100, 0 );
			givePlayerWeapon( playerid, 11, 200 ); //пп томпсон(50)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 4700);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 200);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}	
		}
		
		if(id == 21)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 6)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 200)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "Molotov_Cocktail").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "Molotov_Cocktail", 6);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 200);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили Molotov Cocktail за 200$", 255, 100, 0 );
			givePlayerWeapon( playerid, 21, 6 ); //молотов(1)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 200);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 6);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}
		}
		
		if(id == 20)
		{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "prod").tointeger() < 6)
		{
			sendPlayerMessage( playerid, "На складе закончились патроны.", 255, 0, 0 );
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() >= 380)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("gans", "MK2_Frag_Grenade").tointeger() > 0)
			{
				return sendPlayerMessage( playerid, "У вас уже купленно это оружие.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("gans", "MK2_Frag_Grenade", 6);
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 380);
			ini.saveData();
			
			sendPlayerMessage( playerid, "Вы купили MK2 Frag Grenade за 380$", 255, 100, 0 );
			givePlayerWeapon( playerid, 20, 6 ); //молотов(1)
			
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("GANS", "money", ini.getKey("GANS", "money").tointeger() + 380);
			ini.setKey("GANS", "prod", ini.getKey("GANS", "prod").tointeger() - 6);
			ini.saveData();
		}
		else
		{
			sendPlayerMessage( playerid, "Недостаточно средств.", 255, 0, 0 );
		}
		}
	}
});

//{работы начало
addEventHandler( "docker", 
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -350.47,-726.813,-15.4206, 2.0 );
	if(check)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "level").tointeger() <= 2)
			{
				return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 3 года.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0 )
			{
				ini.setKey("PlayerInfo", "job", 1);
				ini.setKey("PlayerInfo", "skin_f", 63);
				ini.saveData();
				setPlayerModel( playerid, 63 );
				sendPlayerMessage( playerid, "Вы устроились Докером.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Идите и возьмите ящик.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0 );
			}
        }
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -334.709,-683.489,-21.737, 2.0 );
	if(check2)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 1 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
			{
				ini.setKey("PlayerInfo", "job_p", 1);
				ini.saveData();
				sendPlayerMessage( playerid, "Вы взяли ящик, теперь несите его к машине.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Чтобы положить нажмите Е.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не докер или уже взяли ящик.", 255, 0, 0 );
			}
        }
	
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -331.506,-712.956,-20.7489, 2.0 );
	if(check3)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 1 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "job_p1", ini.getKey("PlayerInfo", "job_p1").tointeger() + 1);
				ini.saveData();
				sendPlayerMessage( playerid, "Вы положили ящик.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Вы перенесли " + ini.getKey("PlayerInfo", "job_p1").tointeger() + " ящиков.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не докер или вы не взяли ящик.", 255, 0, 0 );
			}
        }
});
addEventHandler( "dockerq", 
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -350.47,-726.813,-15.4206, 2.0 );
	if(check)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 1 )
			{
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + (ini.getKey("PlayerInfo", "job_p1").tointeger()*20));
				sendPlayerMessage( playerid, "За смену вы заработали " + ini.getKey("PlayerInfo", "job_p1").tointeger()*20 + "$", 0, 255, 0 );
				ini.setKey("PlayerInfo", "job_p1", 0);
				ini.saveData();
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
				sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не докер.", 255, 0, 0 );
			}
        }
});

function bb2(playerid)
{
	togglePlayerControls( playerid, false );
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage( playerid, "Вы погрузили сигареты.", 255, 255, 0);
	sendPlayerMessage( playerid, "Езжайте в порт на склад Р1 15.", 255, 255, 0 );
}
function bb3(playerid)
{
	togglePlayerControls( playerid, false );
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage( playerid, "Вы разгрузили сигареты.", 255, 255, 0 );
	sendPlayerMessage( playerid, "За один рейс вы получули 250$.", 0, 255, 0 );
	sendPlayerMessage( playerid, "Можете поставить машину на парковку", 255, 255, 0 );
	sendPlayerMessage( playerid, "или продолжать работать.", 255, 255, 0 );
}
addEventHandler( "bb", 
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -396.188,-692.02,-21.7457, 2.0 );
	if(check1)
        {
			if ( isPlayerInVehicle(playerid) ) 
			{
				return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );;
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "level").tointeger() <= 2)
			{
				return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 3 года.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0 )
			{
				ini.setKey("PlayerInfo", "job", 2);
				ini.setKey("PlayerInfo", "skin_f", 62);
				ini.saveData();
				setPlayerModel( playerid, 62 );
				triggerClientEvent( playerid, "gpsloadcig", "" );
				sendPlayerMessage( playerid, "Вы устроились доставщиком сигарет.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Езжайте по маршруту на загрузку сигарет.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
			}
        }
		
    local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2],-632.282,955.495,-17.7324, 10.0 );
		if(check2)
        {
			if ( !isPlayerInVehicle(playerid) ) 
			{
				return;
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job_p").tointeger() == 1) 
				{
				return sendPlayerMessage( playerid, "Вы погрузили сигареты.", 255, 0, 0);
				}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 2 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0) 
			{
				if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 36)
				{
				ini.setKey("PlayerInfo", "job_p", 1);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( bb2, 30000, 1, playerid );
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "gpsunloadcig", "" );
				sendPlayerMessage( playerid, "Вы сможете поехать через 30 сек.", 255, 255, 0);
				}
				
			}
			else
			{
			sendPlayerMessage( playerid, "Вы не доставщик сигарет.", 255, 0, 0 );
			}
    }

    local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -403.607,-833.451,-20.4267, 10.0 );
		if(check3)
        {
			if ( !isPlayerInVehicle(playerid) ) 
			{
				return;
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 2 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 36)
				{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 250);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( bb3, 30000, 1, playerid );
				sendPlayerMessage( playerid, "Вы сможете поехать через 30 сек.", 255, 255, 0);
				triggerClientEvent( playerid, "gpsloadcig", "" );
				}
				
			}
			else
			{
			sendPlayerMessage( playerid, "Вы не погрузили сигареты.", 255, 0, 0 );
			}
        }
});
addEventHandler( "bbq", 
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -396.188,-692.02,-21.7457, 2.0 );
	{
		if(check)
        {
			if ( isPlayerInVehicle(playerid) ) 
			{
				return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );;
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 2 )
			{
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
				triggerClientEvent( playerid, "removegps", "" );
				sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не доставщик сигарет.", 255, 0, 0 );
			}
        }
	}
});

function bus(playerid)
{
	togglePlayerControls( playerid, false );
	sendPlayerMessage(playerid, "Вы можете ехать дальше.", 255, 255, 0); 
}
addEventHandler( "bus",
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -422.731,479.451,0.109211, 2.0 );
	if(check)
        {
			if ( isPlayerInVehicle(playerid) ) 
			{
				return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
			}
		
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "level").tointeger() <= 1)
			{
				return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 2 года.", 255, 0, 0 );
			}
		
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0)
			{
				ini.setKey("PlayerInfo", "job", 3);
				ini.setKey("PlayerInfo", "skin_f", 171);
				ini.saveData();
				setPlayerModel( playerid, 171 );
				triggerClientEvent( playerid, "gpspd", "" );
				sendPlayerMessage( playerid, "Вы устроились водителем автобуса.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Садитесь в автобус и езжайте по маршруту.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Следующая остановка EBPD.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
			}
		}
	local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -388.956,653.65,-11.6006, 5.0 );
	if(check1)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
				{
					ini.setKey("PlayerInfo", "job_p", 1);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsjd", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка ЖД Вокзал.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -574.482,1599.0,-16.1776, 5.0 );
	if(check2)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
				{
					ini.setKey("PlayerInfo", "job_p", 2);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsrinok", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Авторынок.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1299.31,1328.93,-13.2936, 5.0 );
	if(check3)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 2)
				{
					ini.setKey("PlayerInfo", "job_p", 3);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsed", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Empire Diner.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1409.38,961.825,-13.3144, 5.0 );
	if(check4)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 3)
				{
					ini.setKey("PlayerInfo", "job_p", 4);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsarmy", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Пост КПП 1.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1544.55,-306.271,-19.9141, 5.0 );
	if(check5)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
				{
					ini.setKey("PlayerInfo", "job_p", 5);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsport", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Городской Порт.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -468.734,-474.159,-19.8834, 5.0 );
	if(check6)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 5)
				{
					ini.setKey("PlayerInfo", "job_p", 6);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpstrago", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Траго.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 571.847,-309.336,-19.8841, 5.0 );
	if(check7)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 6)
				{
					ini.setKey("PlayerInfo", "job_p", 7);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsbank", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Банк.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 49.6432,-281.879,-19.8851, 5.0 );
	if(check8)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 7)
				{
					ini.setKey("PlayerInfo", "job_p", 8);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsmeria", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Мерия.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -90.7553,-16.6645,-13.8749, 5.0 );
	if(check9)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 8)
				{
					ini.setKey("PlayerInfo", "job_p", 9);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 35);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpsdepo", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage( playerid, "Следующая остановка Конечная.", 255, 255, 0 );
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	local check10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -377.594,468.22,-0.945088, 5.0 );
	if(check10)
        {
		if ( !isPlayerInVehicle(playerid) ) 
		{
			return;
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 20)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job").tointeger() == 3 && ini.getKey("PlayerInfo", "job_p").tointeger() == 9)
				{
					ini.setKey("PlayerInfo", "job_p", 0);
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 135);
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "hudtimer", "" );
					local rTimer = timer( bus, 10000, 1, playerid );
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "gpspd", "" );
					sendPlayerMessage(playerid, "Вы сможете поехать через 10 сек.", 255, 255, 0);
					sendPlayerMessage(playerid, "За весь рейс вы заработали 450$.", 0, 255, 0);
					sendPlayerMessage(playerid, "Вы можете продолжить или уволиться.", 255, 255, 0);
				}
				else
				{
					sendPlayerMessage(playerid, "Вы здесь уже останавливались, езжайте по маршруту.", 255, 0, 0);
				}
			}
			
		}
	
});
addEventHandler( "busq",
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -422.731,479.451,0.109211, 2.0 );
	if(check)
        {
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 3 )
			{
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
				triggerClientEvent( playerid, "removegps", "" );
				sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не водитель автобуса.", 255, 0, 0 );
			}
		}
});

//такси
addCommandHandler( "jtaxi",
function ( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition(playerid)
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2],-115.11,-63.1035,-12.041, 10.0 );
	if(check)
	{
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "level").tointeger() <= 0)
		{
			return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 1 год.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "job", 4);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы устроились таксистом.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
		}
	}
});
addCommandHandler( "qtaxi",
function ( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local myPos = getPlayerPosition(playerid)
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2],-115.11,-63.1035,-12.041, 10.0 );
	if(check)
	{
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 4)
		{
			ini.setKey("PlayerInfo", "job", 0);
			ini.setKey("PlayerInfo", "job_p", 0);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы уволились.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Вы не таксист.", 255, 0, 0);
		}
	}
});

addCommandHandler( "taxilight", 
function(playerid)
{
 if ( !isPlayerInVehicle(playerid) ) 
	{
        return;
    }
local vehicleid = getPlayerVehicle(playerid);
local prevState = getTaxiLightState(vehicleid);
setTaxiLightState(vehicleid, !prevState);
});

addCommandHandler( "taxi", 
function(playerid, id)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
    if ( !isPlayerInVehicle(playerid) ) {
        return;
    }
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 4)
	{
		if(id.tostring() == "on")
		{
			if(ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
			return sendPlayerMessage(playerid, "Вы уже на работе.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "job_p", 1);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы вышли на работу.", 255, 255, 0);
			return;
		}
		if(id.tostring() == "off")
		{
			if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
			{
			return sendPlayerMessage(playerid, "Вы не выходили на работу.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "job_p", 0);
			ini.saveData();
			sendPlayerMessage(playerid, "Вы закончили работу.", 255, 255, 0);
		}
	}
});

addCommandHandler( "accept", 
function(playerid, name, id)
{
local id = id.tointeger();
local name = name.tostring();
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
		}
	if(FileExists("account/"+getPlayerName(id)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(id)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Игрок не вошел!", 255, 0, 0);
		}
		
local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
if(ini.getKey("PlayerInfo", "logged").tointeger() == 1)
{
	if(name == "taxi")
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 4 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
	{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 4 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				if(getPlayerName(playerid) == getPlayerName(id))
				{
				return sendPlayerMessage(playerid, "Вы таксист.", 255, 0, 0 );
				}
				sendPlayerMessage(i, getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" принял вызов "+getPlayerName(id)+"["+id+"]", 255, 255, 0);
				
			}
		}
		sendPlayerMessage(id, getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" принял ваш вызов.", 255, 255, 0);
	}
	return;
	}
	if(name == "police")
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				sendPlayerMessage(i, getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" принял вызов "+getPlayerName(id)+"["+id+"]", 0, 150, 255);
				
			}
		}
		sendPlayerMessage(id, getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" принял ваш вызов.", 255, 255, 0);
	}
	return;
	}
	if(name == "med")
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
	{
		foreach(i, playername in getPlayers())
		{
			if(FileExists("account/"+getPlayerName(i)+".ini") == false)
			{
			return;
			}
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
			{
			return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(i)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "fraction_p").tointeger() == 1)
			{
				sendPlayerMessage(i, getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" принял вызов "+getPlayerName(id)+"["+id+"]", 255, 100, 100);
			
			}
		}
		sendPlayerMessage(id, getPlayerName(playerid)+"["+getPlayerIdFromName(getPlayerName( playerid ))+"]"+" принял ваш вызов.", 255, 255, 0);
	}
	return;
	}
}
});

//доставщик оружия
addCommandHandler( "enter",
function( playerid, id )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local id = id.tointeger();
	if(isPlayerInVehicle(playerid))
	{
		return sendPlayerMessage(playerid, "Вы в машине.", 255, 0, 0 );
	}
	local myPos = getPlayerPosition(playerid)
	local Pos = getVehiclePosition(id)
	local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 5.0 );
	if(check)
	{
		if(id == 108 || id == 109)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() != 11)
			{
				return sendPlayerMessage(playerid, "Вы не доставщик патронов.", 255, 0, 0);
			}
			putPlayerInVehicle( playerid, id, 0 );
			sendPlayerMessage(playerid, "Выйдите из машины нажав F и зайдите обратно нажав F, это же ради вашей безопастности!", 255, 0, 0);
			sendPlayerMessage(playerid, "Выйдите из машины нажав F и зайдите обратно нажав F, это же ради вашей безопастности!", 255, 0, 0);
		}
	}
}
);

addEventHandler( "jobgans",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 117.791,-58.7411,-19.9784, 2.0 );
	if(check1)
    {
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "level").tointeger() <= 4)
		{
			return sendPlayerMessage( playerid, "Для трудоустройства необходимо прожить 5 лет.", 255, 0, 0 );
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "weaponlic").tointeger() == 0)
		{
			return sendPlayerMessage( playerid, "Для трудоустройства необходимо иметь лицензию на оружие.", 255, 0, 0 );
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job", 11);
				ini.saveData();
				triggerClientEvent( playerid, "gpsloadgans", "" );
				givePlayerWeapon( playerid, 2, 42 ); //револьвер копов(6)
				givePlayerWeapon( playerid, 8, 56 ); //дробовик копов(8)
				sendPlayerMessage( playerid, "Вы устроились доставщиком патронов, вам выдали пистолет и дробовик.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Езжайте по маршруту на погрузку патронов.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
			}
	}
});
addEventHandler( "jobgansq",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 117.791,-58.7411,-19.9784, 2.0 );
	if(check1)
    {
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 11)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("gans", "Model_12_Revolver", 0);
				ini.setKey("gans", "Remington_Model_870_Field_gun", 0);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				removePlayerWeapon( playerid, 2, 0 );
				removePlayerWeapon( playerid, 8, 0 );
				sendPlayerMessage( playerid, "Вы уволились и у вас забрали оружие.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не доставщик патронов.", 255, 0, 0);
			}
	}
});

function cfuel(playerid)
{
	togglePlayerControls( playerid, false );
	sendPlayerMessage( playerid, "Вы погрузили топливо.", 255, 255, 0 );
}
function unfuel(playerid)
{
	togglePlayerControls( playerid, false );
	sendPlayerMessage( playerid, "Вы разгрузили топливо.", 255, 255, 0 );
}
//развозчик топлива
addEventHandler( "carrierfuel",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 528.999,-249.552,-20.1636, 2.0 );
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 788.273,-77.9903,-20.1349, 10.0 );
	if(check1)
    {
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "level").tointeger() <= 4)
		{
			return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 5 лет.", 255, 0, 0 );
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0)
			{
				ini.setKey("PlayerInfo", "job", 5);
				ini.setKey("PlayerInfo", "skin_f", 144);
				ini.saveData();
				setPlayerModel( playerid, 144 );
				triggerClientEvent( playerid, "gpsloadfuel", "" );
				sendPlayerMessage( playerid, "Вы устроились развозчиком топлива.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Езжайте по маршруту на погрузку топлива.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
			}
	}
	if(check2)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			if(ini.getKey("PlayerInfo", "money").tointeger() < 200)
			{
			return sendPlayerMessage(playerid, "Для погрузки топлива нужно 200$!", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
			{
				ini.setKey("PlayerInfo", "job_p", 100);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 200);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( cfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За топливо с вас списали 200$", 255, 100, 0 );
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 200);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы уже погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			if(ini.getKey("PlayerInfo", "money").tointeger() < 1000)
			{
			return sendPlayerMessage(playerid, "Для погрузки топлива нужно 1000$!", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
			{
				ini.setKey("PlayerInfo", "job_p", 500);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 1000);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( cfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За топливо с вас списали 1000$", 255, 100, 0 );
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("CH", "kazna", ini.getKey("CH", "kazna").tointeger() + 1000);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы уже погрузили топливо.", 255, 0, 0);
			}
			return;
		}
	}
});
addEventHandler( "unloadfuel",
function( playerid)
{
	local myPos = getPlayerPosition( playerid );
	local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );
	if(fuel1)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#1", "owner").tointeger() == 0 || ini.getKey("FS#1", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#1", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#1", "fs_money").tointeger() <= 100*fs1_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs1_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs1_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() - 100*fs1_bf);
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#1", "fs_money").tointeger() <= 500*fs1_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs1_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs1_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() - 500*fs1_bf);
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
	}
	}
	if(fuel2)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#2", "owner").tointeger() == 0 || ini.getKey("FS#2", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#2", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#2", "fs_money").tointeger() <= 100*fs2_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs2_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs2_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() - 100*fs2_bf);
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#2", "fs_money").tointeger() <= 500*fs2_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs2_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs2_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() - 500*fs2_bf);
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		
	}
	}
	if(fuel3)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#3", "owner").tointeger() == 0 || ini.getKey("FS#3", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#3", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#3", "fs_money").tointeger() <= 100*fs3_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs3_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs3_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() - 100*fs3_bf);
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#3", "fs_money").tointeger() <= 500*fs3_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs3_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs3_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() - 500*fs3_bf);
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		
	}
	}
	if(fuel4)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#4", "owner").tointeger() == 0 || ini.getKey("FS#4", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#4", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#4", "fs_money").tointeger() <= 100*fs4_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs4_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs4_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() - 100*fs4_bf);
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#4", "fs_money").tointeger() <= 500*fs4_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs4_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs4_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() - 500*fs4_bf);
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		
	}
	}
	if(fuel5)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#5", "owner").tointeger() == 0 || ini.getKey("FS#5", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#5", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#5", "fs_money").tointeger() <= 100*fs5_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs5_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs5_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() - 100*fs5_bf);
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#5", "fs_money").tointeger() <= 500*fs5_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs5_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs5_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() - 500*fs5_bf);
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		
	}
	}
	if(fuel6)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#6", "owner").tointeger() == 0 || ini.getKey("FS#6", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#6", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#6", "fs_money").tointeger() <= 100*fs6_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs6_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs6_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() - 100*fs6_bf);
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#6", "fs_money").tointeger() <= 500*fs6_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs6_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs6_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() - 500*fs6_bf);
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		
	}
	}
	if(fuel7)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#7", "owner").tointeger() == 0 || ini.getKey("FS#7", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#7", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#7", "fs_money").tointeger() <= 100*fs7_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs7_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs7_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() - 100*fs7_bf);
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#7", "fs_money").tointeger() <= 500*fs7_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs7_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs7_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() - 500*fs7_bf);
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		
	}
	}
	if(fuel8)
	{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#8", "owner").tointeger() == 0 || ini.getKey("FS#8", "fs_tanker").tointeger() >= 1000000)
		{
			return sendPlayerMessage(playerid, "У заправки нет владельца или её хранилище заполнено.", 255, 0, 0);
		}
		if(ini.getKey("FS#8", "buyfuel").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Цена покупки топлива не установлена.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 5 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#8", "fs_money").tointeger() <= 100*fs8_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 100)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 100*fs8_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+100*fs8_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() - 100*fs8_bf);
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() + 100);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if ( ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 4 ) 
		{
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#8", "fs_money").tointeger() <= 500*fs8_bf)
			{
				return sendPlayerMessage(playerid, "На счету бизнеса недостаточно средств.", 255, 0, 0);
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 && ini.getKey("PlayerInfo", "job_p").tointeger() == 500)
			{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500*fs8_bf);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( unfuel, 30000, 1, playerid );
				sendPlayerMessage( playerid, "За доставку топлива вы получили "+500*fs8_bf+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() - 500*fs8_bf);
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() + 500);
				ini.saveData();
			}
			else
			{
				sendPlayerMessage(playerid, "Вы не погрузили топливо.", 255, 0, 0);
			}
			return;
		}
		
	}
	}
});
addEventHandler( "carrierfuelq",
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 528.999,-249.552,-20.1636, 2.0 );
	if(check)
        {
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 5 )
			{
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
				sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
				triggerClientEvent( playerid, "removegps", "" );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не развозчик топлива.", 255, 0, 0 );
			}
		}
});

//механик
addEventHandler( "mechanic",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 32.7456,-411.533,-20.1725, 2.0 );
	if(check1)
    {
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "level").tointeger() <= 3)
		{
			return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 4 года.", 255, 0, 0 );
		}
		
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0)
			{
				ini.setKey("PlayerInfo", "job", 6);
				ini.setKey("PlayerInfo", "skin_f", 134);
				ini.saveData();
				setPlayerModel( playerid, 134 );
				sendPlayerMessage( playerid, "Вы устроились механиком.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
			}
	}
});
addEventHandler( "mechanicq",
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 32.7456,-411.533,-20.1725, 2.0 );
	if(check)
        {
		if ( isPlayerInVehicle(playerid) ) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 6 )
			{
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
				sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не механик.", 255, 0, 0 );
			}
		}
});
addCommandHandler("carcolor", 
function(playerid, r, g, b, q, w, e) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	if(isPlayerInVehicle(playerid)) 
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 6)
		{
			local vehicle = getPlayerVehicle(playerid);
			setVehicleColour(vehicle, r.tointeger(), g.tointeger(), b.tointeger(), q.tointeger(), w.tointeger(), e.tointeger());
		}
	}
	else
	{
		sendPlayerMessage( playerid, "Вы не в машине.", 255, 0, 0 );
	}
});
addCommandHandler("savecarcolor", 
function(playerid, id, r, g, b, q, w, e, money) 
{
	local id = id.tointeger();
	local money = money.tointeger();
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
		if(FileExists("account/"+getPlayerName(id)+".ini") == false)
		{
		return;
		}
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 5.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 6)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
			{
				sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
				sendPlayerMessage(id, "Вы не достали кошелек.", 255, 0, 0);
				return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < money)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
			}
			if(getPlayerName(playerid) == getPlayerName(id))
			{
				return sendPlayerMessage(playerid, "Самому себе нельзя покрасить машину.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			ini.setKey("PlayerInfo", "carcolor0", r.tointeger());
			ini.setKey("PlayerInfo", "carcolor1", g.tointeger());
			ini.setKey("PlayerInfo", "carcolor2", b.tointeger());
			ini.setKey("PlayerInfo", "carcolor3", q.tointeger());
			ini.setKey("PlayerInfo", "carcolor4", w.tointeger());
			ini.setKey("PlayerInfo", "carcolor5", e.tointeger());
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
			ini.saveData();
			sendPlayerMessage( playerid, "Вы покрасили машину игрока за " +money+ "$", 0, 255, 0 );
			sendPlayerMessage( id, "Вам покрасили машину за " +money+ "$", 255, 100, 0 );
			sendPlayerMessage( id, "Чтобы изменения вступили в силу, перезайдите в авто.", 255, 255, 0 );
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
			ini.saveData();
		}
	}
});
addCommandHandler("tunecar", 
function(playerid, id, r, money) 
{
	local id = id.tointeger();
	local money = money.tointeger();
		if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
		if(FileExists("account/"+getPlayerName(id)+".ini") == false)
		{
		return;
		}
	local myPos = getPlayerPosition( playerid );
	local Pos = getPlayerPosition( id );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], Pos[0], Pos[1], Pos[2], 5.0 );
	if(check)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 6)
		{
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			if(ini.getKey("PlayerInfo", "wallet").tointeger() == 0)
			{
				sendPlayerMessage(playerid, "Игрок не достал кошелек.", 255, 0, 0);
				sendPlayerMessage(id, "Вы не достали кошелек.", 255, 0, 0);
				return;
			}
			
			local ini = EasyINI("account/"+getPlayerName(id)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < money)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0 );
			}
			if(getPlayerName(playerid) == getPlayerName(id))
			{
				return sendPlayerMessage(playerid, "Самому себе нельзя затюнить машину.", 255, 0, 0 );
			}
			
			if(r.tointeger() >= 0 && r.tointeger() <= 3)
			{
				local ini = EasyINI("account/"+getPlayerName(id)+".ini");
				ini.setKey("PlayerInfo", "car_level", r.tointeger());
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - money);
				ini.saveData();
				sendPlayerMessage( playerid, "Вы поставили " +r.tointeger()+ " уровень тюнинига за "+money+"$", 0, 255, 0 );
				sendPlayerMessage( id, "Вам поставили " +r.tointeger()+ " уровень тюнинига за "+money+"$", 255, 100, 0 );
				sendPlayerMessage( id, "Чтобы изменения вступили в силу, перезайдите в авто.", 255, 255, 0 );
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + money);
				ini.saveData();
				return;
			}
			sendPlayerMessage( playerid, "Укажите число от 0 до 3", 255, 0, 0 );
		}
	}
});

//металлоломщик
addEventHandler( "scrapmetal",
function(playerid)
{
	local randomize = random(1,22);
	local randomize1 = random(1,10);
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -82.6162,1739.23,-18.7167, 2.0 );
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -83.0683,1767.58,-18.4006, 2.0 );
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -79.025,1766.14,-15.8721, 2.0 );
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
	
	if(check1)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0)
		{
			ini.setKey("PlayerInfo", "job", 7);
			ini.setKey("PlayerInfo", "job_p1", randomize);
			ini.setKey("PlayerInfo", "skin_f", 131);
			ini.saveData();
			setPlayerModel( playerid, 131 );
			sendPlayerMessage( playerid, "Вы устроились металлоломщиком.", 255, 255, 0 );
			//{
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 1)
			{
				triggerClientEvent( playerid, "sm1", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 2)
			{
				triggerClientEvent( playerid, "sm2", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 3)
			{
				triggerClientEvent( playerid, "sm3", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 4)
			{
				triggerClientEvent( playerid, "sm4", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 5)
			{
				triggerClientEvent( playerid, "sm5", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 6)
			{
				triggerClientEvent( playerid, "sm6", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 7)
			{
				triggerClientEvent( playerid, "sm7", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 8)
			{
				triggerClientEvent( playerid, "sm8", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 9)
			{
				triggerClientEvent( playerid, "sm9", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 10)
			{
				triggerClientEvent( playerid, "sm10", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 11)
			{
				triggerClientEvent( playerid, "sm11", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 12)
			{
				triggerClientEvent( playerid, "sm12", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 13)
			{
				triggerClientEvent( playerid, "sm13", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 14)
			{
				triggerClientEvent( playerid, "sm14", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 15)
			{
				triggerClientEvent( playerid, "sm15", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 16)
			{
				triggerClientEvent( playerid, "sm16", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 17)
			{
				triggerClientEvent( playerid, "sm17", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 18)
			{
				triggerClientEvent( playerid, "sm18", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 19)
			{
				triggerClientEvent( playerid, "sm19", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 20)
			{
				triggerClientEvent( playerid, "sm20", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 21)
			{
				triggerClientEvent( playerid, "sm21", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 22)
			{
				triggerClientEvent( playerid, "sm22", "" );
			}
			//}
		}
		else
		{
			sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
		}
	}
	if(check2)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("biz/kazna.ini");
		if(ini.getKey("bryski", "scrapm_o").tointeger() >= 500000)
		{
			return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
		}
		if(ini.getKey("bryski", "scrapm_n").tointeger() >= 1000)
		{
			return sendPlayerMessage(playerid, "Пресс полон, идите наверх и спресуйте металлолом.", 255, 0, 0);
		}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job_p").tointeger() > 0)
			{
				local ini = EasyINI("biz/kazna.ini");
				local kyrs_metallolom = ini.getKey("kyrs", "kyrs_metallolom").tointeger();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				local job_p = ini.getKey("PlayerInfo", "job_p").tointeger();
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + ini.getKey("PlayerInfo", "job_p").tointeger()*kyrs_metallolom);
				ini.saveData();
				sendPlayerMessage( playerid, "Вы получили "+ini.getKey("PlayerInfo", "job_p").tointeger()*kyrs_metallolom+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("bryski", "scrapm_n", ini.getKey("bryski", "scrapm_n").tointeger() + job_p);
				ini.saveData();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p1", randomize);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.saveData();
				//{
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 1)
			{
				triggerClientEvent( playerid, "sm1", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 2)
			{
				triggerClientEvent( playerid, "sm2", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 3)
			{
				triggerClientEvent( playerid, "sm3", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 4)
			{
				triggerClientEvent( playerid, "sm4", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 5)
			{
				triggerClientEvent( playerid, "sm5", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 6)
			{
				triggerClientEvent( playerid, "sm6", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 7)
			{
				triggerClientEvent( playerid, "sm7", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 8)
			{
				triggerClientEvent( playerid, "sm8", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 9)
			{
				triggerClientEvent( playerid, "sm9", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 10)
			{
				triggerClientEvent( playerid, "sm10", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 11)
			{
				triggerClientEvent( playerid, "sm11", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 12)
			{
				triggerClientEvent( playerid, "sm12", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 13)
			{
				triggerClientEvent( playerid, "sm13", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 14)
			{
				triggerClientEvent( playerid, "sm14", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 15)
			{
				triggerClientEvent( playerid, "sm15", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 16)
			{
				triggerClientEvent( playerid, "sm16", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 17)
			{
				triggerClientEvent( playerid, "sm17", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 18)
			{
				triggerClientEvent( playerid, "sm18", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 19)
			{
				triggerClientEvent( playerid, "sm19", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 20)
			{
				triggerClientEvent( playerid, "sm20", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 21)
			{
				triggerClientEvent( playerid, "sm21", "" );
			}
			if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 22)
			{
				triggerClientEvent( playerid, "sm22", "" );
			}
			//}
			}
			else
			{
				sendPlayerMessage( playerid, "У вас нет металлолома.", 255, 0, 0 );
			}
		}
	}
	if(check3)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("biz/kazna.ini");
		if(ini.getKey("bryski", "scrapm_o").tointeger() >= 500000)
		{
			return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
		}
		if(ini.getKey("bryski", "scrapm_n").tointeger() < 1000)
		{
			return sendPlayerMessage(playerid, "Пресс пуст.", 255, 0, 0);
		}
		
		local ini = EasyINI("biz/kazna.ini");
		ini.setKey("bryski", "scrapm_o", ini.getKey("bryski", "scrapm_o").tointeger() + ini.getKey("bryski", "scrapm_n").tointeger());
		ini.setKey("bryski", "scrapm_n", ini.getKey("bryski", "scrapm_n").tointeger() - ini.getKey("bryski", "scrapm_n").tointeger());
		sendPlayerMessage(playerid, "Вы спрессовали металлолом.", 255, 255, 0);
		ini.saveData();
		}
	}
	//{
	if(sm1)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 1)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm2)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 2)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm3)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 3)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm4)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 4)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm5)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 5)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm6)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 6)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm7)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 7)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm8)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 8)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm9)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 9)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm10)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 10)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm11)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 11)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm12)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 12)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm13)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 13)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm14)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 14)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm15)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 15)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm16)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 16)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm17)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 17)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm18)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 18)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm19)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 19)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm20)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 20)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm21)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 21)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	if(sm22)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job").tointeger() == 7)
		{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_p").tointeger() == 0 && ini.getKey("PlayerInfo", "job_p1").tointeger() == 22)
		{
			ini.setKey("PlayerInfo", "job_p1", 0);
			ini.setKey("PlayerInfo", "job_p", randomize1);
			ini.saveData();
			triggerClientEvent( playerid, "removegps", "" );
			sendPlayerMessage( playerid, "Вы взяли "+ini.getKey("PlayerInfo", "job_p").tointeger()+" шт металлолома, отнесите их в пресс.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "У вас уже есть металлолом или у вас другой чек поинт.", 255, 0, 0);
		}
		}
	}
	//}
});

addEventHandler( "scrapmetalq",
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -82.6162,1739.23,-18.7167, 2.0 );
	if(check)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 7 )
			{
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "job_p1", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
				sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не металлоломщик.", 255, 0, 0 );
			}
		}
});

//водитель
function premia(playerid)
{
	if(!isPlayerConnected( playerid ))
    {
		return;
	}
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "job_timer").tointeger() == 0)
		{
			job_timer.Kill();
			return;
		}
		ini.setKey("PlayerInfo", "job_timer", ini.getKey("PlayerInfo", "job_timer").tointeger() - 1);
		ini.saveData();
	}
}
function driverload(playerid)
{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage( playerid, "Если хотите получить премию в размере 500$, то вы должны успеть привезти груз за 5 минут.", 255, 255, 0 );
		sendPlayerMessage( playerid, "Вы загрузили 100 шт металла, теперь езжайте на склад(два желтых маркера)", 255, 255, 0 );
		sendPlayerMessage( playerid, "Теперь у тебя два путя, на левый склад поедешь, считай что пропало, а если на правый, то у тебя два путя, закончить работу или продолжить :-)", 255, 255, 0 );
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 2)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage( playerid, "Если хотите получить премию в размере 500$, то вы должны успеть привезти груз за 5 минут.", 255, 255, 0 );
		sendPlayerMessage( playerid, "Вы загрузили 100 кг рыбы, теперь езжайте на рыбзавод.", 255, 255, 0 );
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 3)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage( playerid, "Если хотите получить премию в размере 500$, то вы должны успеть привезти груз за 5 минут.", 255, 255, 0 );
		sendPlayerMessage( playerid, "Вы загрузили 100 кг рыбы, теперь езжайте в порт.", 255, 255, 0 );
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
		sendPlayerMessage( playerid, "Если хотите получить премию в размере 500$, то вы должны успеть привезти груз за 5 минут.", 255, 255, 0 );
		sendPlayerMessage( playerid, "Вы загрузили 100 шт канцтоваров, теперь езжайте в одну из гос.организаций(EBPD, EGH, Мерия).", 255, 255, 0 );
		return;
	}
}
function driverunload(playerid)
{
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage( playerid, "Вы разгрузили грузовик с металлом.", 255, 255, 0 );
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 2)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage( playerid, "Вы разгрузили грузовик с рыбой.", 255, 255, 0 );
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 3)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage( playerid, "Вы разгрузили грузовик с рыбой.", 255, 255, 0 );
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
	{
		togglePlayerControls( playerid, false );
		sendPlayerMessage( playerid, "Вы разгрузили грузовик с канцтоварами.", 255, 255, 0 );
		return;
	}
}

addEventHandler( "driver",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
	local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 763.599,802.275,-12.0161, 2.0 );
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -108.482,1743.72,-18.458, 10.0 );//свалка
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 1281.56,1290.69,-0.173949, 10.0 );//летейка
	local check4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 673.996,127.642,-12.2194, 10.0 );//жд склад
	local check5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -305.419,-733.279,-21.5746, 10.0 );//погрузка и разгрузка рыбы в порту
	local check6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 373.792,115.759,-20.9331, 5.0 );//разгрузка рыбы на рыбзаводе
	local check7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 396.283,97.4237,-20.9347, 5.0 );//погрузка рыбы на рыбзаводе
	local check8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -309.005,891.418,-19.9632, 10.0 );//больница
	local check9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -315.909,679.425,-18.6004, 30.0 );//копы
	local check10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -92.1166,-62.6148,-13.9892, 10.0 );//мерия
	
	if(check1)
    {
		if(isPlayerInVehicle(playerid)) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "level").tointeger() <= 5)
		{
			return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 6 лет.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0)
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			ini.setKey("PlayerInfo", "job", 8);
			ini.setKey("PlayerInfo", "skin_f", 83);
			ini.saveData();
			setPlayerModel( playerid, 83 );
			sendPlayerMessage( playerid, "Вы устроились водителем, теперь садитесь в грузовик.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
		}
	}
	
	if(check2)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 122 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 131) 
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				local ini = EasyINI("biz/kazna.ini");
				if(ini.getKey("bryski", "scrapm_o").tointeger() < 100)
				{
					return sendPlayerMessage(playerid, "Склад пуст.", 255, 0, 0);
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
				{
					return sendPlayerMessage( playerid, "Вы загрузили грузовик металлом.", 255, 0, 0 );
				}
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "job_p1", 100);
					ini.setKey("PlayerInfo", "job_timer", 300);
					job_timer = timer( premia, 1000, -1, playerid );//таймер премии
					ini.saveData();
					
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "bbtimer", "" );
					local rTimer = timer( driverload, 30000, 1, playerid );
				
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("bryski", "scrapm_o", ini.getKey("bryski", "scrapm_o").tointeger() - 100);
					ini.saveData();
					triggerClientEvent( playerid, "removegps", "" );
			}
		}
	}
	
	if(check3)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 122 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 131)  
		{
			//разгрузка литейка
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				local ini = EasyINI("biz/kazna.ini");
				local kyrs_metal = ini.getKey("kyrs", "kyrs_metal").tointeger();
				if(ini.getKey("sklad", "metal_lit").tointeger() >= 500000)
				{
					return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 0)
				{
					return sendPlayerMessage( playerid, "Вы не загрузили грузовик.", 255, 0, 0 );
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_timer").tointeger() > 0)
				{
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500);
					ini.saveData();
					sendPlayerMessage( playerid, "Вы получили премию в размере 500$", 0, 255, 0 );
					job_timer.Kill();
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p1", 0);
				ini.setKey("PlayerInfo", "job_timer", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + kyrs_metal*100);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( driverunload, 30000, 1, playerid );
				sendPlayerMessage( playerid, "Вы получили "+kyrs_metal*100+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("sklad", "metal_lit", ini.getKey("sklad", "metal_lit").tointeger() + 100);
				ini.saveData();
				
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "gpsloadmetal", "" );
				sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
				return;
			}
			
			//погрузка литейка
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
			{
				local ini = EasyINI("biz/kazna.ini");
				if(ini.getKey("sklad", "metal_lit").tointeger() < 100)
				{
					return sendPlayerMessage(playerid, "Склад пуст.", 255, 0, 0);
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
				{
					return sendPlayerMessage( playerid, "Вы загрузили грузовик металлом.", 255, 0, 0 );
				}
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "job_p1", 100);
					ini.setKey("PlayerInfo", "job_timer", 300);
					job_timer = timer( premia, 1000, -1, playerid );//таймер премии
					ini.saveData();
					
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "bbtimer", "" );
					local rTimer = timer( driverload, 30000, 1, playerid );
				
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("sklad", "metal_lit", ini.getKey("sklad", "metal_lit").tointeger() - 100);
					ini.saveData();
					return;
			}
		}
	}	

	if(check4)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 122 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 131) 
		{
			//разгрузка жд склад
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				local ini = EasyINI("biz/kazna.ini");
				local kyrs_metal = ini.getKey("kyrs", "kyrs_metal").tointeger();
				if(ini.getKey("sklad", "metal_jd").tointeger() >= 500000)
				{
					return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 0)
				{
					return sendPlayerMessage( playerid, "Вы не загрузили грузовик.", 255, 0, 0 );
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_timer").tointeger() > 0)
				{
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500);
					ini.saveData();
					sendPlayerMessage( playerid, "Вы получили премию в размере 500$", 0, 255, 0 );
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p1", 0);
				ini.setKey("PlayerInfo", "job_timer", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + kyrs_metal*100);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( driverunload, 30000, 1, playerid );
				sendPlayerMessage( playerid, "Вы получили "+kyrs_metal*100+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("sklad", "metal_jd", ini.getKey("sklad", "metal_jd").tointeger() + 100);
				ini.saveData();
				
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "gpsloadmetal", "" );
				sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
				return;
			}
			
			//погрузка жд склад
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
			{
				local ini = EasyINI("biz/kazna.ini");
				if(ini.getKey("sklad", "metal_jd").tointeger() < 100)
				{
					return sendPlayerMessage(playerid, "Склад пуст.", 255, 0, 0);
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
				{
					return sendPlayerMessage( playerid, "Вы загрузили грузовик металлом.", 255, 0, 0 );
				}
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "job_p1", 100);
					ini.setKey("PlayerInfo", "job_timer", 300);
					job_timer = timer( premia, 1000, -1, playerid );//таймер премии
					ini.saveData();
					
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "bbtimer", "" );
					local rTimer = timer( driverload, 30000, 1, playerid );
				
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("sklad", "metal_jd", ini.getKey("sklad", "metal_jd").tointeger() - 100);
					ini.saveData();
					return;
			}
		}
	}
	
	if(check5)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 38) 
		{
			//погрузка в порту
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 2)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
				{
					return sendPlayerMessage( playerid, "Вы загрузили грузовик рыбой.", 255, 0, 0 );
				}
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "job_p1", 100);
					ini.setKey("PlayerInfo", "job_timer", 300);
					job_timer = timer( premia, 1000, -1, playerid );//таймер премии
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "bbtimer", "" );
					local rTimer = timer( driverload, 30000, 1, playerid );
				
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "seagift_unload", "" );
					sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
					return;
			}
			
			//разгрузка в порту
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 3)
			{
				local ini = EasyINI("biz/kazna.ini");
				local kyrs_fish = ini.getKey("kyrs", "kyrs_fish").tointeger();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 0)
				{
					return sendPlayerMessage( playerid, "Вы не загрузили грузовик.", 255, 0, 0 );
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_timer").tointeger() > 0)
				{
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500);
					ini.saveData();
					sendPlayerMessage( playerid, "Вы получили премию в размере 500$", 0, 255, 0 );
				}

				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p1", 0);
				ini.setKey("PlayerInfo", "job_timer", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + kyrs_fish*100);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( driverunload, 30000, 1, playerid );
				sendPlayerMessage( playerid, "Вы получили "+kyrs_fish*100+"$", 0, 255, 0 );	
				
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "seagift_load", "" );
				sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
				return;
			}
		}
	}
	
	if(check6)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 38) 
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 2)
			{
				local ini = EasyINI("biz/kazna.ini");
				local kyrs_fish = ini.getKey("kyrs", "kyrs_fish").tointeger();
				
				local ini = EasyINI("biz/kazna.ini");
				if(ini.getKey("drugs", "no_fish").tointeger() >= 500000)
				{
					return sendPlayerMessage(playerid, "Склад полон.", 255, 0, 0);
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 0)
				{
					return sendPlayerMessage( playerid, "Вы не загрузили грузовик.", 255, 0, 0 );
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_timer").tointeger() > 0)
				{
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500);
					ini.saveData();
					sendPlayerMessage( playerid, "Вы получили премию в размере 500$", 0, 255, 0 );
				}

				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p1", 0);
				ini.setKey("PlayerInfo", "job_timer", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + kyrs_fish*100);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( driverunload, 30000, 1, playerid );
				sendPlayerMessage( playerid, "Вы получили "+kyrs_fish*100+"$", 0, 255, 0 );
				
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("drugs", "no_fish", ini.getKey("drugs", "no_fish").tointeger() + 100);
				ini.saveData();
				
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "port_load", "" );
				sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
			}
		}
	}
	
	if(check7)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 38) 
		{
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 3)
			{
				local ini = EasyINI("biz/kazna.ini");
				if(ini.getKey("drugs", "ob_fish").tointeger() < 100)
				{
					return sendPlayerMessage(playerid, "Склад пуст.", 255, 0, 0);
				}
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 100)
				{
					return sendPlayerMessage( playerid, "Вы загрузили грузовик рыбой.", 255, 0, 0 );
				}
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "job_p1", 100);
					ini.setKey("PlayerInfo", "job_timer", 300);
					job_timer = timer( premia, 1000, -1, playerid );//таймер премии
					ini.saveData();
					togglePlayerControls( playerid, true );
					triggerClientEvent( playerid, "bbtimer", "" );
					local rTimer = timer( driverload, 30000, 1, playerid );
				
					local ini = EasyINI("biz/kazna.ini");
					ini.setKey("drugs", "ob_fish", ini.getKey("drugs", "ob_fish").tointeger() - 100);
					ini.saveData();
				
					triggerClientEvent( playerid, "removegps", "" );
					triggerClientEvent( playerid, "port_load", "" );//разгрузка в порту
					sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
			}
		}
	}
	
	if(check8 || check9 || check10)
    {
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 122 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 131) 
		{
			//разгрузка больница копы мерия
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 4)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_p1").tointeger() == 0)
				{
					return sendPlayerMessage( playerid, "Вы не загрузили грузовик.", 255, 0, 0 );
				}
				
				local ini = EasyINI("biz/kazna.ini");
				local kyrs_tovar = ini.getKey("kyrs", "kyrs_tovar").tointeger();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				if(ini.getKey("PlayerInfo", "job_timer").tointeger() > 0)
				{
					local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
					ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 500);
					ini.saveData();
					sendPlayerMessage( playerid, "Вы получили премию в размере 500$", 0, 255, 0 );
				}
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p1", 0);
				ini.setKey("PlayerInfo", "job_timer", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + kyrs_tovar*100);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( driverunload, 30000, 1, playerid );
				sendPlayerMessage( playerid, "Вы получили "+kyrs_tovar*100+"$", 0, 255, 0 );
				
				sendPlayerMessage( playerid, "Езжайте на один из складов(желтые круги)", 255, 255, 0 );
				return;
			}
		}
	}
});

addCommandHandler( "jobbruski",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 122 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 131) 
	{
		if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
		{
			ini.setKey("PlayerInfo", "job_p", 1);
			ini.saveData();
			triggerClientEvent( playerid, "gpsloadmetal", "" );
			sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
			sendPlayerMessage( playerid, "Вы взяли маршрут: Бруски - Склад", 255, 255, 0 );
			sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage( playerid, "Вы не водитель или у вас уже выбран маршрут.", 255, 0, 0 );
		}
	}
});
addCommandHandler( "jobport_seagift",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 38) 
	{
		if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
		{
			ini.setKey("PlayerInfo", "job_p", 2);
			ini.saveData();
			triggerClientEvent( playerid, "port_load", "" );
			sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
			sendPlayerMessage( playerid, "Вы взяли маршрут: Порт - Рыбзавод", 255, 255, 0 );
			sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage( playerid, "Вы не водитель или у вас уже выбран маршрут.", 255, 0, 0 );
		}
	}
});
addCommandHandler( "jobseagift_port",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 38) 
	{
		if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
		{
			ini.setKey("PlayerInfo", "job_p", 3);
			ini.saveData();
			triggerClientEvent( playerid, "seagift_load", "" );
			sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
			sendPlayerMessage( playerid, "Вы взяли маршрут: Рыбзавод - Порт", 255, 255, 0 );
			sendPlayerMessage( playerid, "Езжайте по маршруту.", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage( playerid, "Вы не водитель или у вас уже выбран маршрут.", 255, 0, 0 );
		}
	}
});
addCommandHandler( "jobfraction",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car_id").tointeger() >= 122 && ini.getKey("PlayerInfo", "car_id").tointeger() <= 131) 
	{
		if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
		{
			ini.setKey("PlayerInfo", "job_p", 4);
			ini.saveData();
			sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
			sendPlayerMessage( playerid, "Вы взяли маршрут: Склад - Гос.организации", 255, 255, 0 );
			sendPlayerMessage( playerid, "Езжайте на один из складов(желтые круги)", 255, 255, 0 );
		}
		else
		{
			sendPlayerMessage( playerid, "Вы не водитель или у вас уже выбран маршрут.", 255, 0, 0 );
		}
	}
});
addCommandHandler( "jobcancel",
function(playerid)
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8 && ini.getKey("PlayerInfo", "job_p").tointeger() > 0)
	{
		ini.setKey("PlayerInfo", "job_p", 0);
		ini.setKey("PlayerInfo", "job_p1", 0);
		ini.setKey("PlayerInfo", "job_timer", 0);
		ini.saveData();
		triggerClientEvent( playerid, "removegps", "" );
		sendPlayerMessage( playerid, "Вы отменили маршрут.", 255, 255, 0 );
	}
	else
	{
		sendPlayerMessage( playerid, "Вы не водитель или у вас не выбран маршрут.", 255, 0, 0 );
	}
});

addEventHandler( "driverq",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 763.599,802.275,-12.0161, 2.0 );
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(check)
    {
		if(isPlayerInVehicle(playerid)) 
		{
			return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );
		}
	if(ini.getKey("PlayerInfo", "job").tointeger() == 8)
	{
		ini.setKey("PlayerInfo", "job", 0);
		ini.setKey("PlayerInfo", "job_p", 0);
		ini.setKey("PlayerInfo", "job_p1", 0);
		ini.setKey("PlayerInfo", "skin_f", 0);
		ini.setKey("PlayerInfo", "job_timer", 0);
		ini.saveData();
		triggerClientEvent( playerid, "removegps", "" );
		setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
		sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
	}
	else
	{
		sendPlayerMessage( playerid, "Вы не водитель.", 255, 0, 0 );
	}
	}
});

//обработчик на рыбзаводе
addEventHandler( "seagift",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 389.846,125.266,-20.2027, 1.5 );
	if(check1)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0 )
			{
				ini.setKey("PlayerInfo", "job", 9);
				ini.setKey("PlayerInfo", "skin_f", 133);
				ini.saveData();
				setPlayerModel( playerid, 133 );
				triggerClientEvent( playerid, "seagift_check1", "" );
				sendPlayerMessage( playerid, "Вы устроились Обработчиком на рыбзаводе.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Идите и возьмите рыбу в конце склада.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0 );
			}
        }
});

addEventHandler( "seagift_jobs",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
	local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 356.187,135.612,-20.2027, 2.0 );
	local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 375.036,132.285,-20.2027, 2.0 );
	if(check2)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 9 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0)
			{
				local ini = EasyINI("biz/kazna.ini");
				if(ini.getKey("drugs", "no_fish").tointeger() < 20)
				{
					return sendPlayerMessage( playerid, "Склад пуст.", 255, 0, 0 );
				}
				ini.setKey("drugs", "no_fish", ini.getKey("drugs", "no_fish").tointeger() - 20);
				ini.saveData();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p", 1);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "seagift_check2", "" );
				sendPlayerMessage( playerid, "Вы взяли рыбу, теперь обработайте её на столе.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не обработчик или уже взяли рыбу.", 255, 0, 0 );
			}
        }
	if(check3)
        {
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 9 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				local ini = EasyINI("biz/kazna.ini");
				if(ini.getKey("drugs", "ob_fish").tointeger() > 500000 || ini.getKey("drugs", "narko_triada").tointeger() > 500000)
				{
					return sendPlayerMessage( playerid, "Склад полон.", 255, 0, 0 );
				}
				local ini = EasyINI("biz/kazna.ini");
				ini.setKey("drugs", "ob_fish", ini.getKey("drugs", "ob_fish").tointeger() + 20);
				ini.setKey("drugs", "narko_triada", ini.getKey("drugs", "narko_triada").tointeger() + 20);
				ini.saveData();
				
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 10);
				ini.saveData();
				
				sendPlayerMessage( playerid, "Вы обработали рыбу.", 255, 255, 0 );
			
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "seagift_check1", "" );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не обработчик или вы не взяли рыбу.", 255, 0, 0 );
			}
        }
});
addEventHandler( "seagiftq",
function(playerid)
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 389.846,125.266,-20.2027, 2.0 );
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(check1)
    {

	if(ini.getKey("PlayerInfo", "job").tointeger() == 9)
	{
		ini.setKey("PlayerInfo", "job", 0);
		ini.setKey("PlayerInfo", "job_p", 0);
		ini.setKey("PlayerInfo", "skin_f", 0);
		ini.saveData();
		triggerClientEvent( playerid, "removegps", "" );
		setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
		sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
	}
	else
	{
		sendPlayerMessage( playerid, "Вы не обработчик.", 255, 0, 0 );
	}
	}
});

//доставщик мяса
function meat2(playerid)
{
	togglePlayerControls( playerid, false );
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage( playerid, "Вы погрузили 50 тушек свиней.", 255, 255, 0);
	sendPlayerMessage( playerid, "Езжайте на мясокомбинат.", 255, 255, 0 );
}
function meat3(playerid)
{
	togglePlayerControls( playerid, false );
	sendPlayerMessage(playerid, "===========================================", 255, 255, 0);
	sendPlayerMessage( playerid, "Вы разгрузили тушки свиней.", 255, 255, 0 );
	sendPlayerMessage( playerid, "Езжайте в порт.", 255, 255, 0 );
}
addEventHandler( "meat", 
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 14.0464,1809.85,-16.9628, 2.0 );
	if(check1)
        {
			if ( isPlayerInVehicle(playerid) ) 
			{
				return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );;
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "level").tointeger() <= 1)
			{
				return sendPlayerMessage( playerid, "Для трудоустройства, необходимо прожить 2 года.", 255, 0, 0 );
			}
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "fraction").tointeger() == 0 && ini.getKey("PlayerInfo", "job").tointeger() == 0 )
			{
				ini.setKey("PlayerInfo", "job", 10);
				ini.setKey("PlayerInfo", "skin_f", 132);
				ini.saveData();
				setPlayerModel( playerid, 132 );
				triggerClientEvent( playerid, "gpsloadmeat", "" );
				sendPlayerMessage( playerid, "Вы устроились доставщиком мяса.", 255, 255, 0 );
				sendPlayerMessage( playerid, "Езжайте в порт на погрузку тушек свиней.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage(playerid, "Вы состоите во фракции или уже где-то работаете.", 255, 0, 0);
			}
        }
		
    local check2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -440.931,-710.141,-21.4133, 10.0 );
		if(check2)
        {
			if ( !isPlayerInVehicle(playerid) ) 
			{
				return;
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job_p").tointeger() == 1) 
				{
				return sendPlayerMessage( playerid, "Вы погрузили тушки свиней.", 255, 0, 0);
				}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 10 && ini.getKey("PlayerInfo", "job_p").tointeger() == 0) 
			{
				if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 34)
				{
				ini.setKey("PlayerInfo", "job_p", 1);
				ini.saveData();
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( meat2, 30000, 1, playerid );
				triggerClientEvent( playerid, "removegps", "" );
				triggerClientEvent( playerid, "gpsunloadmeat", "" );
				sendPlayerMessage( playerid, "Вы сможете поехать через 30 сек.", 255, 255, 0);
				}
				
			}
			else
			{
			sendPlayerMessage( playerid, "Вы не доставщик мяса.", 255, 0, 0 );
			}
    }

    local check3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 29.0389,1750.3,-17.8668, 10.0 );
		if(check3)
        {
			if ( !isPlayerInVehicle(playerid) ) 
			{
				return;
			}
			local ini = EasyINI("biz/kazna.ini");
			local kyrs_meat = ini.getKey("kyrs", "kyrs_meat").tointeger();
			
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 10 && ini.getKey("PlayerInfo", "job_p").tointeger() == 1)
			{
				if(ini.getKey("PlayerInfo", "vehicle_p").tointeger() == 34)
				{
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 50*kyrs_meat);
				ini.saveData();
				triggerClientEvent( playerid, "removegps", "" );
				togglePlayerControls( playerid, true );
				triggerClientEvent( playerid, "bbtimer", "" );
				local rTimer = timer( meat3, 30000, 1, playerid );
				sendPlayerMessage( playerid, "Вы сможете поехать через 30 сек.", 255, 255, 0);
				triggerClientEvent( playerid, "gpsloadmeat", "" );
				sendPlayerMessage( playerid, "За рейс вы заработали " +50*kyrs_meat+ "$", 0, 255, 0);
				}
				
			}
			else
			{
			sendPlayerMessage( playerid, "Вы не погрузили тушки свиней.", 255, 0, 0 );
			}
        }
});
addEventHandler( "meatq", 
function(playerid) 
{
	local myPos = getPlayerPosition( playerid );
    local check = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 14.0464,1809.85,-16.9628, 2.0 );
	{
		if(check)
        {
			if ( isPlayerInVehicle(playerid) ) 
			{
				return sendPlayerMessage( playerid, "Вы находитесь в машине.", 255, 0, 0 );;
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "job").tointeger() == 10 )
			{
				ini.setKey("PlayerInfo", "job", 0);
				ini.setKey("PlayerInfo", "job_p", 0);
				ini.setKey("PlayerInfo", "skin_f", 0);
				ini.saveData();
				setPlayerModel( playerid, ini.getKey("PlayerInfo", "skin").tointeger() );
				triggerClientEvent( playerid, "removegps", "" );
				sendPlayerMessage( playerid, "Вы уволились.", 255, 255, 0 );
			}
			else
			{
				sendPlayerMessage( playerid, "Вы не доставщик мяса.", 255, 0, 0 );
			}
        }
	}
});
//}работы конец

//канистра 
addCommandHandler("buycan", 
function(playerid) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	
	local myPos = getPlayerPosition( playerid );
    local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );

	if(fuel1)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#1", "owner").tointeger() == 0 || ini.getKey("FS#1", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs1_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + fs1_p*20);
		ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
	
	if(fuel2)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#2", "owner").tointeger() == 0 || ini.getKey("FS#2", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs2_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + fs2_p*20);
		ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
	
	if(fuel3)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#3", "owner").tointeger() == 0 || ini.getKey("FS#3", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs3_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + fs3_p*20);
		ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
	
	if(fuel4)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#4", "owner").tointeger() == 0 || ini.getKey("FS#4", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs4_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + fs4_p*20);
		ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
	
	if(fuel5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#5", "owner").tointeger() == 0 || ini.getKey("FS#5", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs5_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + fs5_p*20);
		ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
	
	if(fuel6)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#6", "owner").tointeger() == 0 || ini.getKey("FS#6", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs6_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + fs6_p*20);
		ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
	
	if(fuel7)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#7", "owner").tointeger() == 0 || ini.getKey("FS#7", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs7_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + fs7_p*20);
		ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
	
	if(fuel8)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#8", "owner").tointeger() == 0 || ini.getKey("FS#8", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs8_p*20)
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "can").tointeger() == 1)
		{
			return sendPlayerMessage(playerid, "У вас куплена канистра с топливом.", 255, 0, 0 );
		}
		
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 1);
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*20);
		ini.saveData();
		
		sendPlayerMessage(playerid, "Вы купили канистру на 20 литров и заправили её.", 255, 255, 0);
		sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*20 + "$", 255, 100, 0);
		
		local ini = EasyINI("biz/biznes.ini");
		ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + fs8_p*20);
		ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - 20);
		ini.saveData();
	}
});

addCommandHandler("usecan",
function(playerid) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
	if( isPlayerInVehicle(playerid) ) 
	{
        return sendPlayerMessage(playerid, "Выйдите из машины.", 255, 0, 0 );
    }
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "can").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "У вас не куплена канистра с топливом.", 255, 0, 0 );
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "car_id").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Чтобы заправить машину из канистры вам надо сесть и выйти из неё, а потом заправлять.", 255, 0, 0 );
	}
	
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	local myPos = getPlayerPosition( playerid );
	local vehicleid = ini.getKey("PlayerInfo", "car_id").tointeger();
	local car = getVehiclePosition(vehicleid);
	local dist = getDistanceBetweenPoints3D(myPos[0], myPos[1], myPos[2], car[0], car[1], car[2]);
	local gas = getVehicleFuel(vehicleid);
	local number = getVehiclePlateText( vehicleid );
	
	if(dist < 5)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "can", 0);
		ini.saveData();
		setVehicleFuel(vehicleid, gas+20);
		sendPlayerMessage(playerid, "Вы заправили машину на 20 литров.", 255, 255, 0 );
		
		if(FileExists("carnumber/"+number+".ini"))
		{
			local ini = EasyINI("carnumber/"+number+".ini");
			ini.setKey("car", "fuel", ini.getKey("car", "fuel").tofloat()+20 );
			ini.saveData();
		}
	}
	else
	{
		sendPlayerMessage(playerid, "Вы находитесь далеко от машины.", 255, 0, 0 );
	}
});

//заправки начало
addCommandHandler("refuel", 
function(playerid, id) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0 );
	}
    if( !isPlayerInVehicle(playerid) ) 
	{
        return;
    }
	local myPos = getPlayerPosition( playerid );
    local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );
    local vehicleid = getPlayerVehicle( playerid );
	local vm = getVehicleModel(vehicleid);
	local gas = getVehicleFuel(vehicleid);
	if(fuel1)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#1", "owner").tointeger() == 0 || ini.getKey("FS#1", "fs_tanker").tointeger() == 0)
		{
		return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs1_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 )
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs1_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#1", "fs_tanker", ini.getKey("FS#1", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
	if(fuel2)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#2", "owner").tointeger() == 0 || ini.getKey("FS#2", "fs_tanker").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs2_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 ) 
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs2_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#2", "fs_tanker", ini.getKey("FS#2", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
	if(fuel3)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#3", "owner").tointeger() == 0 || ini.getKey("FS#3", "fs_tanker").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs3_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 ) 
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs3_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#3", "fs_tanker", ini.getKey("FS#3", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
	if(fuel4)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#4", "owner").tointeger() == 0 || ini.getKey("FS#4", "fs_tanker").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs4_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 ) 
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs4_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#4", "fs_tanker", ini.getKey("FS#4", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
	if(fuel5)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#5", "owner").tointeger() == 0 || ini.getKey("FS#5", "fs_tanker").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs5_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 ) 
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs5_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#5", "fs_tanker", ini.getKey("FS#5", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
	if(fuel6)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#6", "owner").tointeger() == 0 || ini.getKey("FS#6", "fs_tanker").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs6_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 ) 
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs6_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#6", "fs_tanker", ini.getKey("FS#6", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
	if(fuel7)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#7", "owner").tointeger() == 0 || ini.getKey("FS#7", "fs_tanker").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs7_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 ) 
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs7_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#7", "fs_tanker", ini.getKey("FS#7", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
	if(fuel8)
	{
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#8", "owner").tointeger() == 0 || ini.getKey("FS#8", "fs_tanker").tointeger() == 0)
		{
			return sendPlayerMessage(playerid, "Заправка не работает.", 255, 0, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "money").tointeger() < fs8_p*id.tofloat())
		{
			return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
		}
		if ( id.tofloat() < 1 ) 
		{
			return sendPlayerMessage(playerid, "Введите целое число.", 255, 0, 0);
		}
		if(vm == 0 || vm == 23 || vm == 24 )
        {
			
			if(gas+id.tofloat() <= 60)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 60 литров.", 255, 0, 0);
			}
		}
		if(vm == 1 || vm == 13 || vm == 15 || vm == 18)
        {
			
			if(gas+id.tofloat() <= 90)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 90 литров.", 255, 0, 0);
			}
		}
		if(vm == 4 || vm == 3 || vm == 5)
        {
			
			if(gas+id.tofloat() <= 200)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 200 литров.", 255, 0, 0);
			}
		}
		if(vm == 51 || vm == 6 || vm == 7 || vm == 8|| vm == 9|| vm == 10|| vm == 14|| vm == 22|| vm == 29|| vm == 45|| vm == 50)
        {
			
			if(gas+id.tofloat() <= 70)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 70 литров.", 255, 0, 0);
			}
		}
		if(vm == 11 || vm == 12)
        {
			
			if(gas+id.tofloat() <= 58)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 58 литров.", 255, 0, 0);
			}
		}
		if(vm == 32 || vm == 33 || vm == 25|| vm == 30|| vm == 31|| vm == 44|| vm == 47)
        {
			
			if(gas+id.tofloat() <= 65)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 65 литров.", 255, 0, 0);
			}
		}
		if(vm == 42 || vm == 19 || vm == 46|| vm == 28|| vm == 41|| vm == 52)
        {
			
			if(gas+id.tofloat() <= 80)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 80 литров.", 255, 0, 0);
			}
		}
		if(vm == 43 || vm == 48)
        {
			
			if(gas+id.tofloat() <= 50)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 50 литров.", 255, 0, 0);
			}
		}
		if(vm == 53)
        {
			
			if(gas+id.tofloat() <= 40)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 40 литров.", 255, 0, 0);
			}
		}
		if(vm == 20 || vm == 21)
        {
			
			if(gas+id.tofloat() <= 150)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 150 литров.", 255, 0, 0);
			}
		}
		if(vm == 27 || vm == 34 || vm == 35 || vm == 36 || vm == 37 || vm == 38 || vm == 39)
        {
			
			if(gas+id.tofloat() <= 100)
			{
				local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
				ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p*id.tofloat());
				ini.saveData();
				sendPlayerMessage(playerid, "Машина заправлена на "+id.tofloat()+" литров(а).", 255, 255, 0);
				sendPlayerMessage(playerid, "Вы заплатили " + fs8_p*id.tofloat() + "$", 255, 100, 0);
				local ini = EasyINI("biz/biznes.ini");
				ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger()*id.tofloat());
				ini.setKey("FS#8", "fs_tanker", ini.getKey("FS#8", "fs_tanker").tointeger() - id.tofloat());
				ini.saveData();
				setVehicleFuel(vehicleid, gas+id.tofloat());
			}
			else
			{
			sendPlayerMessage(playerid, "Максимальная вместимость бака 100 литров.", 255, 0, 0);
			}
		}
	}
});
addEventHandler( "bizinfo",
function ( playerid )
{
	local ini = EasyINI("biz/biznes.ini");
	local myPos = getPlayerPosition( playerid );
	local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 338.758, 875.07,-20.1312, 10.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -710.287,1762.62,-14.8309, 10.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1592.31,942.639,-4.02328, 10.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1679.5,-232.035,-19.1619, 10.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -629.5,-48.7479,2.22843, 10.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -150.096,610.258,-18.9558, 10.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 112.687,181.302,-18.7977, 10.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 547.921,2.62598,-17.0294, 10.0 );

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
	
	local gans1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -592.593,500.991,1.02277, 5.0 );
	local gans2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -567.724,310.701,0.16808, 5.0 );
	local gans3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -10.54,739.379,-22.0582, 5.0 );
	local gans4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 404.657,603.754,-24.9746, 5.0 );
	local gans5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 68.0516,139.778,-14.4583, 5.0 );
	local gans6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 279.78,-118.507,-12.2741, 5.0 );
	local gans7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 273.826,-454.45,-20.1636, 5.0 );
	local gans8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -323.407,-589.106,-20.1043, 5.0 );
	local gans9 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1394.73,-32.7772,-17.8468, 5.0 );
	local gans10 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1183.09,1706.26,11.0941, 5.0 );
	local gans11 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -288.036,1627.6,-23.0758, 5.0 );
	
	if(fuel1)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#1", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#1", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#1", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#1", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 1 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#1", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#1", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(fuel2)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#2", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#2", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#2", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#2", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 2 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#2", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#2", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(fuel3)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#3", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#3", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#3", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#3", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 3 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#3", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#3", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(fuel4)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#4", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#4", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#4", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#4", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 4 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#4", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#4", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(fuel5)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#5", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#5", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#5", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#5", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 5 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#5", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#5", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(fuel6)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#6", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#6", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#6", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#6", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 6 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#6", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#6", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(fuel7)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#7", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#7", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#7", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#7", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 7 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#7", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#7", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(fuel8)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 литра: " + ini.getKey("FS#8", "fs_price") + "$", 255, 255, 0);
		sendPlayerMessage( playerid, "Стоимость закупки 1 литра: " + ini.getKey("FS#8", "buyfuel").tointeger() + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("FS#8", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Стоимость покупки 25000$", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("FS#8", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 8 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "В танкере: "+ini.getKey("FS#8", "fs_tanker").tointeger()+" литров(а).", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("FS#8", "fs_money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(ed1 || ed2 || ed3 || ed4 || ed5 || ed6 || ed7 || ed8 || ed9)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 продукта: " + ini.getKey("ED", "price") + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("ED", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Отсутствует", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("ED", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 9 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "На складе: "+ini.getKey("ED", "prod").tointeger()+" продуктов.", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("ED", "money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(bar1 || bar2 || bar3 || bar4 || bar5 || bar6)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость 1 бутылки: " + ini.getKey("BAR", "price") + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("BAR", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Отсутствует", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("BAR", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 10 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "На складе: "+ini.getKey("BAR", "prod").tointeger()+" бутылок алкоголя.", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("BAR", "money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(rep1 || rep2 || rep3 || rep4 || rep5 || rep6 || rep7 || rep8 || rep9 || rep10 || rep11 || rep12)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		sendPlayerMessage( playerid, "Стоимость ремонта: " + ini.getKey("REPAIR", "price") + "$", 255, 255, 0);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("REPAIR", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Отсутствует", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("REPAIR", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "На складе: "+ini.getKey("REPAIR", "prod").tointeger()+" запчастей.", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("REPAIR", "money").tointeger()+"$", 255, 255, 0);
		}
	}
	if(gans1 || gans2 || gans3 || gans4 || gans5 || gans6 || gans7 || gans8 || gans9 || gans10 || gans11)
	{
		sendPlayerMessage(playerid, "===========================================", 0, 255, 255);
		local ini = EasyINI("biz/biznes.ini");
		if(ini.getKey("GANS", "owner").tointeger() == 0)
		{
			sendPlayerMessage( playerid, "Владелец: Отсутствует", 255, 255, 0);
		}
		else
		{
			sendPlayerMessage( playerid, "Владелец: "+ini.getKey("GANS", "ownername").tostring(), 255, 255, 0);
		}
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		if(ini.getKey("PlayerInfo", "biznes").tointeger() == 11 || ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
		{
			local ini = EasyINI("biz/biznes.ini");
			sendPlayerMessage( playerid, "На складе: "+ini.getKey("GANS", "prod").tointeger()+" патронов.", 255, 255, 0);
			sendPlayerMessage( playerid, "Деньги бизнеса: "+ini.getKey("GANS", "money").tointeger()+"$", 255, 255, 0);
		}
	}
});
//заправки конец

//автомойки начало
addEventHandler("wash", function(playerid) {
    if ( !isPlayerInVehicle(playerid) ) 
	{
		return;
    }
	local myPos = getPlayerPosition( playerid );
    local fuel1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 318.402,873.896,-19.9921, 5.0 );
	local fuel2 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -690.013,1764.19,-13.6658, 5.0 );
	local fuel3 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1593.44,962.555,-3.91477, 5.0 );
	local fuel4 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -1678.54,-251.992,-19.047, 5.0 );
	local fuel5 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -650.684,-50.1497,2.27309, 5.0 );
	local fuel6 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -129.771,611.867,-18.7783, 5.0 );
	local fuel7 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 113.574,161.19,-18.6694, 5.0 );
	local fuel8 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], 549.56,-17.7086,-17.9338, 5.0 );
    local vehicleid = getPlayerVehicle( playerid );
	if(fuel1)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#1", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs1_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs1_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs1_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#1", "fs_money", ini.getKey("FS#1", "fs_money").tointeger() + ini.getKey("FS#1", "fs_price").tointeger());
			ini.saveData();
        }
	if(fuel2)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#2", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs2_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs2_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs2_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#2", "fs_money", ini.getKey("FS#2", "fs_money").tointeger() + ini.getKey("FS#2", "fs_price").tointeger());
			ini.saveData();
        }
	if(fuel3)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#3", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs3_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs3_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs3_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#3", "fs_money", ini.getKey("FS#3", "fs_money").tointeger() + ini.getKey("FS#3", "fs_price").tointeger());
			ini.saveData();
        }
	if(fuel4)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#4", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs4_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs4_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs4_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#4", "fs_money", ini.getKey("FS#4", "fs_money").tointeger() + ini.getKey("FS#4", "fs_price").tointeger());
			ini.saveData();
        }
	if(fuel5)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#5", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs5_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs5_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs5_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#5", "fs_money", ini.getKey("FS#5", "fs_money").tointeger() + ini.getKey("FS#5", "fs_price").tointeger());
			ini.saveData();
        }
	if(fuel6)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#6", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs6_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs6_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs6_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#6", "fs_money", ini.getKey("FS#6", "fs_money").tointeger() + ini.getKey("FS#6", "fs_price").tointeger());
			ini.saveData();
        }
	if(fuel7)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#7", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs7_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs7_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs7_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#7", "fs_money", ini.getKey("FS#7", "fs_money").tointeger() + ini.getKey("FS#7", "fs_price").tointeger());
			ini.saveData();
        }
	if(fuel8)
        {
			local ini = EasyINI("biz/biznes.ini");
			if(ini.getKey("FS#8", "owner").tointeger() == 0)
			{
				return sendPlayerMessage(playerid, "Автомойка не работает.", 255, 0, 0);
			}
			local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
			if(ini.getKey("PlayerInfo", "money").tointeger() < fs8_p)
			{
				return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
			}
			ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - fs8_p);
			ini.saveData();
			setVehicleDirtLevel( vehicleid, 0.0 );
			sendPlayerMessage(playerid, "Машина чистая.", 255, 255, 0);
			sendPlayerMessage(playerid, "Вы заплатили " + fs8_p + "$", 255, 100, 0);
			local ini = EasyINI("biz/biznes.ini");
			ini.setKey("FS#8", "fs_money", ini.getKey("FS#8", "fs_money").tointeger() + ini.getKey("FS#8", "fs_price").tointeger());
			ini.saveData();
        }
});
//автомойки конец

addEventHandler("en", 
function(playerid)
{
 if ( !isPlayerInVehicle(playerid) ) {
        return;
    }
	local vehicleid = getPlayerVehicle(playerid);
	setVehicleEngineState( vehicleid, false );
}
);
addEventHandler( "avar",
    function( playerid )
    {
    if ( !isPlayerInVehicle(playerid) ) {
        return;
    }
 
    local vehicleid = getPlayerVehicle(playerid);
    local prevState = getIndicatorLightState(vehicleid, INDICATOR_LEFT);
	local prevState = getIndicatorLightState(vehicleid, INDICATOR_RIGHT);
 
    setIndicatorLightState(vehicleid, INDICATOR_LEFT, !prevState);
	setIndicatorLightState(vehicleid, INDICATOR_RIGHT, !prevState);
    }
);
addEventHandler("left", 
function(playerid) 
	{
    if ( !isPlayerInVehicle(playerid) ) {
        return;
    }
 
    local vehicleid = getPlayerVehicle(playerid);
    local prevState = getIndicatorLightState(vehicleid, INDICATOR_LEFT);
 
    setIndicatorLightState(vehicleid, INDICATOR_LEFT, !prevState);
});
addEventHandler("right", 
function(playerid) 
	{
    if ( !isPlayerInVehicle(playerid) ) {
        return;
    }
 
    local vehicleid = getPlayerVehicle(playerid);
    local prevState = getIndicatorLightState(vehicleid, INDICATOR_RIGHT);
 
    setIndicatorLightState(vehicleid, INDICATOR_RIGHT, !prevState);
});
addEventHandler("light",
function(playerid) 
{
	if ( !isPlayerInVehicle(playerid) ) 
	{
		return;
	}
	local vehicleid = getPlayerVehicle(playerid);
	local prevState = getVehicleLightState(vehicleid);
	setVehicleLightState(vehicleid, !prevState);
});

//тюнинг
addCommandHandler( "tune",
function( playerid, r )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		if( isPlayerInVehicle( playerid ) )
		{
			if( r.tointeger() >= 0 && r.tointeger() <= 3 )
			{
				if( r.tointeger() == 0 )
				{
					local vehicleid = getPlayerVehicle( playerid );
					setVehicleTuningTable( vehicleid, 0 );
					sendPlayerMessage(playerid, "Машина в заводском состоянии.", 255, 255, 255);
					return;
				}
				local vehicleid = getPlayerVehicle( playerid );
				setVehicleTuningTable( vehicleid, r.tointeger() );
				sendPlayerMessage(playerid, "У машины " +r.tointeger()+ " уровень тюнинга.", 255, 255, 255);
			}
			else
			{
				sendPlayerMessage(playerid, "От 0 до 3", 255, 255, 255);
			}
		}
	}
});

addCommandHandler( "wheel",
function( playerid, p, z )
{
	local p = p.tointeger();
	local z = z.tointeger();
if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
		{
		return;
		}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() >= 1)
	{
		if( isPlayerInVehicle( playerid ) )
		{
			if( p >= 0 && p <= 15 && z >= 0 && z <= 15)
			{
				local vehicleid = getPlayerVehicle( playerid );
				setVehicleWheelTexture( vehicleid, 0, p );
				setVehicleWheelTexture( vehicleid, 1, z );
			}
			else
			{
				sendPlayerMessage(playerid, "От 0 до 15", 255, 255, 255);
			}
		}
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "job").tointeger() == 66)
	{
		if( isPlayerInVehicle( playerid ) )
		{
			if( p >= 0 && p <= 11 && z >= 0 && z <= 11)
			{
				local vehicleid = getPlayerVehicle( playerid );
				setVehicleWheelTexture( vehicleid, 0, p );
				setVehicleWheelTexture( vehicleid, 1, z );
			}
			else
			{
				sendPlayerMessage(playerid, "От 0 до 11", 255, 255, 0);
			}
		}
		return;
	}
});

//количество игроков
addCommandHandler( "list",
function( playerid )
{
    local list = "";
 
    foreach(i, playername in getPlayers())
	{
        list += " " +playername+ "[" +i+ "], ";
    }
 
    sendPlayerMessageToAll("Онлайн:" + list);
});

//казино
addEventHandler( "banditgame",
function( playerid)
{
	local randomize1 = random(1,6);
	local randomize2 = random(1,6);
	local randomize3 = random(1,6);
	local myPos = getPlayerPosition( playerid );
    local check1 = isPointInCircle3D( myPos[0], myPos[1], myPos[2], -254.01,-129.645,-10.5254, 10.0 );
	if(check1)
    {
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "money").tointeger() < 200)
	{
		return sendPlayerMessage(playerid, "Недостаточно средств.", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() - 200 );
	ini.saveData();
	if(randomize1 == 1 && randomize2 == 1 && randomize3 == 1 || randomize1 == 2 && randomize2 == 2 && randomize3 == 2 || randomize1 == 3 && randomize2 == 3 && randomize3 == 3 || randomize1 == 4 && randomize2 == 4 && randomize3 == 4 || randomize1 == 5 && randomize2 == 5 && randomize3 == 5 || randomize1 == 6 && randomize2 == 6 && randomize3 == 6)
	{
		local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
		ini.setKey("PlayerInfo", "money", ini.getKey("PlayerInfo", "money").tointeger() + 5000 );
		ini.saveData();
		sendPlayerMessage(playerid, "Вы выиграли 5000$", 0, 255, 0);
		sendPlayerMessage(playerid, "Выпало: " +randomize1+ " - " +randomize2+ " - " +randomize3, 255, 255, 0);
		return;
	}
	
	sendPlayerMessage(playerid, "Вы потратили 200$", 255, 100, 0);
	sendPlayerMessage(playerid, "Выпало: " +randomize1+ " - " +randomize2+ " - " +randomize3, 255, 255, 0);
	}
});

addCommandHandler( "anim1",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "default");
	   sendPlayerMessage(playerid, "anim1");
    }
);
addCommandHandler( "anim2",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "Injury");
	   sendPlayerMessage(playerid, "anim2");
    }
);
addCommandHandler( "anim3",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManColdWeapon");
	   sendPlayerMessage(playerid, "anim3");
    }
);
addCommandHandler( "anim4",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "Camelot");
	   sendPlayerMessage(playerid, "anim4");
    }
);
addCommandHandler( "anim9",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WalkNoggingRightHand");
	   sendPlayerMessage(playerid, "anim9");
    }
);
addCommandHandler( "anim11",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "GalanteSneaking");
	   sendPlayerMessage(playerid, "anim11");
    }
);
addCommandHandler( "anim12",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManHandsFolded");
	   sendPlayerMessage(playerid, "anim12");
    }
);
addCommandHandler( "anim13",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "FatMan");
	   sendPlayerMessage(playerid, "anim13");
    }
);
addCommandHandler( "anim14",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManNewspaperSubaxillary");
	   sendPlayerMessage(playerid, "anim14");
    }
);
addCommandHandler( "anim15",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManHandsInPockets");
	   sendPlayerMessage(playerid, "anim15");
    }
);
addCommandHandler( "anim16",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManOneHandInPocket");
	   sendPlayerMessage(playerid, "anim16");
    }
);
addCommandHandler( "anim17",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManSlowWalk");
	   sendPlayerMessage(playerid, "anim17");
    }
);
addCommandHandler( "anim18",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "Homeless");
	   sendPlayerMessage(playerid, "anim18");
    }
);
addCommandHandler( "anim19",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "OldMan");
	   sendPlayerMessage(playerid, "anim19");
    }
);
addCommandHandler( "anim20",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManQuickWalk");
	   sendPlayerMessage(playerid, "anim20");
    }
);
addCommandHandler( "anim21",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManBigSuitcase");
	   sendPlayerMessage(playerid, "anim21");
    }
);
addCommandHandler( "anim22",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WomanHeel");
	   sendPlayerMessage(playerid, "anim22");
    }
);
addCommandHandler( "anim23",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WomanHeelQuick");
	   sendPlayerMessage(playerid, "anim23");
    }
);
addCommandHandler( "anim24",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WomanHeelSlow");
	   sendPlayerMessage(playerid, "anim24");
    }
);
addCommandHandler( "anim25",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WomanHeelHandbag");
	   sendPlayerMessage(playerid, "anim25");
    }
);
addCommandHandler( "anim26",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "OldWoman");
	   sendPlayerMessage(playerid, "anim26");
    }
);
addCommandHandler( "anim31",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManUmbrellaOpen");
	   sendPlayerMessage(playerid, "anim31");
    }
);
addCommandHandler( "anim32",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManUmbrellaClosed");
	   sendPlayerMessage(playerid, "anim32");
    }
);
addCommandHandler( "anim33",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManBigBag");
	   sendPlayerMessage(playerid, "anim33");
    }
);
addCommandHandler( "anim34",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManWalkHotdog");//несет хотдог в руках
	   sendPlayerMessage(playerid, "anim34");
    }
);
addCommandHandler( "anim36",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WomanUmbrellaOpen");
	   sendPlayerMessage(playerid, "anim36");
    }
);
addCommandHandler( "anim37",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WomanUmbrellaClosed");
	   sendPlayerMessage(playerid, "anim37");
    }
);
addCommandHandler( "anim39",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "VitoCleaningWindow");
	   sendPlayerMessage(playerid, "anim39");
    }
);
addCommandHandler( "anim57",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "DrunkHomeless");
	   sendPlayerMessage(playerid, "anim57");
    }
);
addCommandHandler( "anim58",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "Drunk");
	   sendPlayerMessage(playerid, "anim58");
    }
);
addCommandHandler( "anim60",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "ManHandsUp");
	   sendPlayerMessage(playerid, "anim60");
    }
);
addCommandHandler( "anim61",
    function( playerid )
    {
       setPlayerAnimStyle(playerid, "common", "WomanHandsUp");
	   sendPlayerMessage(playerid, "anim61");
    }
);

addCommandHandler( "fs1",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
	setPlayerPosition( playerid, 338.758,875.07, -21.0312 );
    }
});
addCommandHandler( "dm",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
	setPlayerPosition( playerid, -199.473,838.605,-21.2431 );
    }
});
addCommandHandler( "shop",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
	setPlayerPosition( playerid, -252.324,-79.688,-11.458 );
    }
});
addCommandHandler( "pd",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
	setPlayerPosition( playerid, -391.166,652.268,-11.9494 );
    }
});
addCommandHandler( "meria",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, -115.11,-63.1035,-12.041 );
    }
});
addCommandHandler( "bus",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, -422.731,479.451,0.109211 );
    }
});
addCommandHandler( "egh",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, -418.793, 881.286, -20.1426. );
    }
});
addCommandHandler( "resp",
function( playerid ) 
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, -575.101, 1622.8, -15.6957 );
	setPlayerRotation( playerid, 0.0, 0.0, 180.0 );
    }
});
addCommandHandler( "port",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, -396.188,-692.02,-21.7457 );
    }
});
addCommandHandler( "trago",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, 528.999,-249.552,-20.1636 );
    }
});
addCommandHandler( "gib",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, 67.2002,-202.94,-20.2324 );
    }
});
addCommandHandler( "aeb",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, -1542.96,-369.083,-19.3354 );
    }
});
addCommandHandler( "triada",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, 341.525,346.108,-18.8108 );
    }
});
addCommandHandler( "irish",
function( playerid )
{
	if(FileExists("account/"+getPlayerName(playerid)+".ini") == false)
	{
		return;
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "logged").tointeger() == 0)
	{
		return sendPlayerMessage(playerid, "Вы не вошли!", 255, 0, 0);
	}
	local ini = EasyINI("account/"+getPlayerName(playerid)+".ini");
	if(ini.getKey("PlayerInfo", "admin").tointeger() == 2)
	{
    setPlayerPosition( playerid, -1162.24,1536.75,6.541 );
    }
});

//изи-ини
class
EasyINI
{
	lastsec = null;
	sections = {};
	filename = "";
	constructor(fname)
	{
		filename = fname;
		fileCreate(fname);
		local tf = eFile(fname, "r");
		sections.clear();
		lastsec = null;
		while(!tf.eos())
		{
			local
				line = tf.readline(),
				res = regexp(@"\[[\C]+]").search(line);
			
			if(!line.len() || line[0] == ';')
			{
				continue;
			}
				
			if(res != null)
			{
				local
					secname = line.slice(res.begin+1, res.end-1);
				if(findSection(secname) == null)
				{
					createSection(secname);
				}				
				lastsec = secname;
				continue;
			}
			
			if(lastsec == null)
			{
				continue;
			}
			
			res = regexp(" = ").search(line);
			if(res != null)
			{
				setKey(lastsec, line.slice(0, res.begin), line.slice(res.end));
			}			
		}
	}
	/*
	 * Internal Methods
	 */
	 
	function createSection(name)
	{
		return (sections[name] <- {});
	}
	function findSection(name)
	{
		if(sections.rawin(name))
		{
			return sections[name];
		}
		return null;
	}
	function createKey(section, key, val)
	{
		if(findSection(section) != null)
		{
			sections[section][key] <- val;
			return true;
		}
		else
		{
			createSection(section);
			local s = findSection(section);
			if(s == null)
			{
				log("Some serious shit happened. Tell the scripter about that.");
				return false;
			}
			s[key] <- val;
			return true;
		}
		return false;
	}
	/*
	 * Public Methods
	 */
	 
	function keyExists(section, key)
	{
		local
			s = findSection(section);
		if(s == null)
		{
			return false;
		}
		return (s.rawin(key));
	}
	function setKey(section, key, val)
	{
		if(val == null)
		{
			throw "EasyINI Exception: Value must not be null!";
		}
		if(!keyExists(section, key))
		{
			createKey(section, key, val.tostring());
		}
		else
		{
			findSection(section)[key] <- val.tostring();
		}
	}
	function getKey(section, key)
	{
		if(!keyExists(section, key))
		{
			return null;
		}
		return sections[section][key];		
	}
	function deleteKey(section, key)
	{
		if(!keyExists(section, key))
		{
			return false;
		}
		return delete sections[section][key];
	}
	function deleteSection(name)
	{
		if(findSection(name) == null)
		{
			return false;
		}
		return delete sections[name];
	}
	function logData()
	{
		foreach(i,s in sections)
		{
			log("[" + i + "]");
			foreach(j,k in s)
			{
				log(j + " = " + k);
			}
		}
	}
	function reloadData()
	{
		sections.clear();
		lastsec = null;
		local tf = eFile(fname, "r");
		while(!tf.eos())
		{
			local line = tf.readline();
			res = regexp(@"\[[\C]+]").secReg.search(line);
			
			if(!line.len() || line[0] == ';')
			{
				continue;
			}
				
			if(res != null)
			{
				local secname = line.slice(res.begin+1, res.end-1);
				if(findSection(secname) == null)
				{
					createSection(secname);
				}				
				lastsec = secname;
				continue;
			}
			if(lastsec == null)
			{
				continue;
			}
			res = regexp(" = ").secReg.search(line);
			if(res != null)
			{
				setKey(lastsec, line.slice(0, res.begin), line.slice(res.end));
			}
		}		
	}
	function saveData()
	{
		local tf = eFile(filename, "w");
		tf.writeline(";File generated by EasyINI");
		foreach(i,s in sections)
		{
			tf.writeline("[" + i + "]");
			foreach(j,k in s)
			{
				tf.writeline(j + " = " + k);
			}
		}		
	}
}
function fileCreate(filename)
{
	local tf = file(filename, "a+");
	tf = null;
	return true;
}
class eFile extends file
{
	function readline()
	{
		local result = "";
		while(!this.eos())
		{
			local c = this.readn('c');
			if(c == '\n' || !c)
			{
				return result;
			}
			if(c == '\r')
			{
				continue;
			}
			result += c.tochar();
		}
		return result;
	}
	function writeline(line)
	{
		foreach(char in line)
		{
			this.writen(char, 'c');
		}
		this.writen('\n', 'c');
	}
}

function FileExists(fpath)//функция из изи ини
{
  try
  {
    file(fpath, "r");
  }
  catch(e)
  {
    return false;
  }
  return true;
}
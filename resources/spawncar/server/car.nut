local script = "SPAWNCAR RESOURCES";

addCommandHandler( "respawn",
function( vehicle, id )
{
foreach(i, playername in getPlayers()) 
	{
		if(!FileExists("account/"+getPlayerName(i)+".ini"))
		{
			return;
		}
	local ini = EasyINI("account/"+getPlayerName(i)+".ini");
	
	if(id.tostring() == "ebpd")
	{
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 1 && ini.getKey("PlayerInfo", "rang").tointeger() >= 4 || ini.getKey("PlayerInfo", "admin").tointeger() > 0)
	{
	respawnVehicle(0);
	setVehicleColour( 0, 255, 255, 255, 0, 0, 50 );
	setVehiclePlateText( 0, "EBPD-0" );
	respawnVehicle(1);
	setVehicleColour( 1, 255, 255, 255, 0, 0, 50 );
	setVehiclePlateText( 1, "EBPD-1" );
	respawnVehicle(2);
	setVehicleColour( 2, 255, 255, 255, 0, 0, 50 );
	setVehiclePlateText( 2, "EBPD-2" );
	respawnVehicle(3);
	setVehicleColour( 3, 255, 255, 255, 0, 0, 50 );
	setVehiclePlateText( 3, "EBPD-3" );
	respawnVehicle(4);
	setVehicleColour( 4, 255, 255, 255, 0, 0, 50 );
	setVehiclePlateText( 4, "EBPD-4" );
	respawnVehicle(5);
	setVehicleColour( 5, 255, 255, 255, 0, 0, 50 );
	setVehiclePlateText( 5, "EBPD-5" );
	respawnVehicle(6);
	setVehicleColour( 6, 255, 255, 255, 0, 0, 50 );
	setVehiclePlateText( 6, "EBPD-6" );
	log( "Respawn EBPD vehicle" );
	}
	}
	if(id.tostring() == "egh")
	{
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 2 && ini.getKey("PlayerInfo", "rang").tointeger() >= 3 || ini.getKey("PlayerInfo", "admin").tointeger() > 0)
	{
	respawnVehicle(7);
	setVehicleColour( 7, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 7, "EGH-07" );
	respawnVehicle(8);
	setVehicleColour( 8, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 8, "EGH-08" );
	respawnVehicle(9);
	setVehicleColour( 9, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 9, "EGH-09" );
	respawnVehicle(10);
	setVehicleColour( 10, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 10, "EGH-10" );
	respawnVehicle(11);
	setVehicleColour( 11, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 11, "EGH-11" );
	respawnVehicle(12);
	setVehicleColour( 12, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 12, "EGH-12" );
	respawnVehicle(13);
	setVehicleColour( 13, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 13, "EGH-13" );
	respawnVehicle(14);
	setVehicleColour( 14, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 14, "EGH-14" );
	respawnVehicle(15);
	setVehicleColour( 15, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 15, "EGH-15" );
	respawnVehicle(16);
	setVehicleColour( 16, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 16, "EGH-16" );
	respawnVehicle(17);
	setVehicleColour( 17, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 17, "EGH-17" );
	respawnVehicle(18);
	setVehicleColour( 18, 150, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 18, "EGH-18" );
	log( "Respawn MED vehicle" );
	}
	}
	if(id.tostring() == "bb")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(25);
	setVehicleColour( 25, 40, 49, 66, 169, 122, 44 );
	setVehiclePlateText( 25, "BB-025" );
	respawnVehicle(26);
	setVehicleColour( 26, 40, 49, 66, 169, 122, 44 );
	setVehiclePlateText( 26, "BB-026" );
	respawnVehicle(27);
	setVehicleColour( 27, 255, 255, 255, 76, 112, 108 );
	setVehiclePlateText( 27, "BB-027" );
	respawnVehicle(28);
	setVehicleColour( 28, 255, 255, 255, 76, 112, 108 );
	setVehiclePlateText( 28, "BB-028" );
	respawnVehicle(29);
	setVehicleColour( 29, 100, 14, 22, 14, 22, 24 );
	setVehiclePlateText( 29, "BB-029" );
	respawnVehicle(30);
	setVehicleColour( 30, 100, 14, 22, 14, 22, 24 );
	setVehiclePlateText( 30, "BB-030" );
	log( "Respawn BB vehicle" );
	}
	if(id.tostring() == "bus")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(32);
	respawnVehicle(33);
	respawnVehicle(34);
	respawnVehicle(35);
	respawnVehicle(36);
	respawnVehicle(37);
	respawnVehicle(38);
	log( "Respawn BUS vehicle" );
	}
	if(id.tostring() == "aeb")
	{
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 3 && ini.getKey("PlayerInfo", "rang").tointeger() >= 4 || ini.getKey("PlayerInfo", "admin").tointeger() > 0)
	{
	respawnVehicle(39);
	respawnVehicle(40);
	respawnVehicle(41);
	respawnVehicle(42);
	respawnVehicle(43);
	respawnVehicle(44);
	respawnVehicle(45);
	respawnVehicle(46);
	respawnVehicle(47);
	respawnVehicle(48);
	respawnVehicle(49);
	respawnVehicle(50);
	
	respawnVehicle(51);
	setVehiclePlateText( 51, "AEB-51" );
	respawnVehicle(52);
	setVehiclePlateText( 52, "AEB-52" );
	respawnVehicle(53);
	setVehiclePlateText( 53, "AEB-53" );
	respawnVehicle(54);
	setVehiclePlateText( 54, "AEB-54" );
	respawnVehicle(55);
	setVehiclePlateText( 55, "AEB-55" );
	respawnVehicle(56);
	setVehiclePlateText( 56, "AEB-56" );
	respawnVehicle(57);
	setVehiclePlateText( 57, "AEB-57" );
	respawnVehicle(58);
	setVehiclePlateText( 58, "AEB-58" );
	respawnVehicle(59);
	setVehiclePlateText( 59, "AEB-59" );
	respawnVehicle(60);
	setVehiclePlateText( 60, "AEB-60" );
	respawnVehicle(61);
	setVehiclePlateText( 61, "AEB-61" );
	respawnVehicle(62);
	setVehiclePlateText( 62, "AEB-62" );
	log( "Respawn AEB vehicle" );
	}
	}
	if(id.tostring() == "irish")
	{
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 5 && ini.getKey("PlayerInfo", "rang").tointeger() >= 4 || ini.getKey("PlayerInfo", "admin").tointeger() > 0)
		{
	respawnVehicle(63);
	setVehicleColour( 63, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 63, "IRISH" );
	respawnVehicle(64);
	setVehicleColour( 64, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 64, "IRISH" );
	respawnVehicle(65);
	setVehicleColour( 65, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 65, "IRISH" );
	respawnVehicle(66);
	setVehicleColour( 66, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 66, "IRISH" );
	respawnVehicle(67);
	setVehicleColour( 67, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 67, "IRISH" );
	respawnVehicle(68);
	setVehicleColour( 68, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 68, "IRISH" );
	respawnVehicle(69);
	setVehicleColour( 69, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 69, "IRISH" );
	respawnVehicle(70);
	setVehicleColour( 70, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 70, "IRISH" );
	respawnVehicle(71);
	setVehicleColour( 71, 0, 100, 0, 0, 100, 0 );
	setVehiclePlateText( 71, "IRISH" );
	log( "Respawn IRISH vehicle" );
	}
	}
	if(id.tostring() == "rental")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(72);
	setVehicleColour( 72, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 72, "rental" );
	respawnVehicle(73);
	setVehicleColour( 73, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 73, "rental" );
	respawnVehicle(74);
	setVehicleColour( 74, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 74, "rental" );
	respawnVehicle(75);
	setVehicleColour( 75, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 75, "rental" );
	respawnVehicle(76);
	setVehicleColour( 76, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 76, "rental" );
	respawnVehicle(77);
	setVehicleColour( 77, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 77, "rental" );
	respawnVehicle(78);
	setVehicleColour( 78,  50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 78, "rental" );
	respawnVehicle(79);
	setVehicleColour( 79, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 79, "rental" );
	respawnVehicle(80);
	setVehicleColour( 80, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 80, "rental" );
	respawnVehicle(81);
	setVehicleColour( 81, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 81, "rental" );
	respawnVehicle(82);
	setVehicleColour( 82, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 82, "rental" );
	respawnVehicle(83);
	setVehicleColour( 83, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 83, "rental" );
	respawnVehicle(84);
	setVehicleColour( 84, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 84, "rental" );
	respawnVehicle(85);
	setVehicleColour( 85, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 85, "rental" );
	
	respawnVehicle(152);
	setVehicleColour( 152, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 152, "rental" );
	respawnVehicle(153);
	setVehicleColour( 153, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 153, "rental" );
	respawnVehicle(154);
	setVehicleColour( 154, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 154, "rental" );
	respawnVehicle(155);
	setVehicleColour( 155, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 155, "rental" );
	respawnVehicle(156);
	setVehicleColour( 156, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 156, "rental" );
	respawnVehicle(157);
	setVehicleColour( 157, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 157, "rental" );
	respawnVehicle(158);
	setVehicleColour( 158, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 158, "rental" );
	respawnVehicle(159);
	setVehicleColour( 159, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 159, "rental" );
	respawnVehicle(160);
	setVehicleColour( 160, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 160, "rental" );
	respawnVehicle(161);
	setVehicleColour( 161, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 161, "rental" );
	respawnVehicle(162);
	setVehicleColour( 162, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 162, "rental" );
	respawnVehicle(163);
	setVehicleColour( 163, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 163, "rental" );
	respawnVehicle(164);
	setVehicleColour( 164, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 164, "rental" );
	log( "Respawn RENTAL vehicle" );
	}
	if(id.tostring() == "taxi")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(86);
	setVehiclePlateText( 86, "taxi" );
	respawnVehicle(87);
	setVehiclePlateText( 87, "taxi" );
	respawnVehicle(88);
	setVehiclePlateText( 88, "taxi" );
	respawnVehicle(89);
	setVehiclePlateText( 89, "taxi" );
	respawnVehicle(90);
	setVehiclePlateText( 90, "taxi" );
	respawnVehicle(91);
	setVehiclePlateText( 91, "taxi" );
	respawnVehicle(92);
	setVehiclePlateText( 92, "taxi" );
	respawnVehicle(93);
	setVehiclePlateText( 93, "taxi" );
	respawnVehicle(94);
	setVehiclePlateText( 94, "taxi" );
	respawnVehicle(95);
	setVehiclePlateText( 95, "taxi" );
	respawnVehicle(96);
	setVehiclePlateText( 96, "taxi" );
	respawnVehicle(97);
	setVehiclePlateText( 97, "taxi" );
	respawnVehicle(98);
	setVehiclePlateText( 98, "taxi" );
	respawnVehicle(99);
	setVehiclePlateText( 99, "taxi" );
	respawnVehicle(100);
	setVehiclePlateText( 100, "taxi" );
	respawnVehicle(101);
	setVehiclePlateText( 101, "taxi" );
	respawnVehicle(102);
	setVehiclePlateText( 102, "taxi" );
	respawnVehicle(103);
	setVehiclePlateText( 103, "taxi" );
	respawnVehicle(104);
	setVehiclePlateText( 104, "taxi" );
	respawnVehicle(105);
	setVehiclePlateText( 105, "taxi" );
	respawnVehicle(106);
	setVehiclePlateText( 106, "taxi" );
	respawnVehicle(107);
	setVehiclePlateText( 107, "taxi" );
	log( "Respawn TAXI vehicle" );
	}
	if(id.tostring() == "ec")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(108);
	setVehiclePlateText( 108, "EC-108" );
	respawnVehicle(109);
	setVehiclePlateText( 109, "EC-109" );
	log( "Respawn ENCASH vehicle" );
	}
	if(id.tostring() == "tgo")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(19);
	setVehiclePlateText( 19, "TGO-19" );
	respawnVehicle(20);
	setVehiclePlateText( 20, "TGO-20" );
	respawnVehicle(21);
	setVehiclePlateText( 21, "TGO-21" );
	respawnVehicle(22);
	setVehiclePlateText( 22, "TGO-22" );
	respawnVehicle(23);
	setVehiclePlateText( 23, "TGO-23" );
	respawnVehicle(24);
	setVehiclePlateText( 24, "TGO-24" );
	
	respawnVehicle(110);
	setVehicleColour( 110, 50, 0, 0, 50, 50, 50 );
	setVehiclePlateText( 110, "tr-110" );
	respawnVehicle(111);
	setVehicleColour( 111, 50, 0, 0, 50, 50, 50 );
	setVehiclePlateText( 111, "tr-111" );
	respawnVehicle(112);
	setVehicleColour( 112, 50, 0, 0, 50, 50, 50 );
	setVehiclePlateText( 112, "tr-112" );
	respawnVehicle(113);
	setVehicleColour( 113, 50, 0, 0, 50, 50, 50 );
	setVehiclePlateText( 113, "tr-113" );
	respawnVehicle(114);
	setVehicleColour( 114, 50, 0, 0, 50, 50, 50 );
	setVehiclePlateText( 114, "tr-114" );
	respawnVehicle(115);
	setVehicleColour( 115, 50, 0, 0, 50, 50, 50 );
	setVehiclePlateText( 115, "tr-115" );
	log( "Respawn TRAGO vehicle" );
	}
	if(id.tostring() == "triada")
	{
		if(ini.getKey("PlayerInfo", "fraction").tointeger() == 4 && ini.getKey("PlayerInfo", "rang").tointeger() >= 3 || ini.getKey("PlayerInfo", "admin").tointeger() > 0)
	{
	respawnVehicle(116);
	setVehicleColour( 116, 0, 0, 0, 0, 0, 0 );
	setVehiclePlateText( 116, "triada" );
	respawnVehicle(117);
	setVehicleColour( 117, 0, 0, 0, 0, 0, 0 );
	setVehiclePlateText( 117, "triada" );
	respawnVehicle(118);
	setVehicleColour( 118, 0, 0, 0, 0, 0, 0 );
	setVehiclePlateText( 118, "triada" );
	respawnVehicle(119);
	setVehicleColour( 119, 0, 0, 0, 0, 0, 0 );
	setVehiclePlateText( 119, "triada" );
	respawnVehicle(120);
	setVehicleColour( 120, 0, 0, 0, 0, 0, 0 );
	setVehiclePlateText( 120, "triada" );
	respawnVehicle(121);
	setVehicleColour( 121, 0, 0, 0, 0, 0, 0 );
	setVehiclePlateText( 121, "triada" );
	log( "Respawn TRIADA vehicle" );
	}
	}
	if(id.tostring() == "driver")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
	{
		return;
	}
	respawnVehicle(122);
	setVehicleColour( 122, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 122, "driver" );
	respawnVehicle(123);
	setVehicleColour( 123, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 123, "driver" );
	respawnVehicle(124);
	setVehicleColour( 124, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 124, "driver" );
	respawnVehicle(125);
	setVehicleColour( 125, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 125, "driver" );
	respawnVehicle(126);
	setVehicleColour( 126, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 126, "driver" );
	respawnVehicle(127);
	setVehicleColour( 127, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 127, "driver" );
	respawnVehicle(128);
	setVehicleColour( 128, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 128, "driver" );
	respawnVehicle(129);
	setVehicleColour( 129, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 129, "driver" );
	respawnVehicle(130);
	setVehicleColour( 130, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 130, "driver" );
	respawnVehicle(131);
	setVehicleColour( 131, 180, 0, 0, 255, 255, 255 );
	setVehiclePlateText( 131, "driver" );
	log( "Respawn driver vehicle" );
	}
	if(id.tostring() == "sg")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(132);
	setVehicleColour( 132, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 132, "sg-132" );
	respawnVehicle(133);
	setVehicleColour( 133, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 133, "sg-133" );
	respawnVehicle(134);
	setVehicleColour( 134, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 134, "sg-134" );
	respawnVehicle(135);
	setVehicleColour( 135, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 135, "sg-135" );
	respawnVehicle(136);
	setVehicleColour( 136, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 136, "sg-136" );
	respawnVehicle(137);
	setVehicleColour( 137, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 137, "sg-137" );
	respawnVehicle(138);
	setVehicleColour( 138, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 138, "sg-138" );
	respawnVehicle(139);
	setVehicleColour( 139, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 139, "sg-139" );
	respawnVehicle(140);
	setVehicleColour( 140, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 140, "sg-140" );
	respawnVehicle(141);
	setVehicleColour( 141, 0, 25, 10, 100, 100, 100 );
	setVehiclePlateText( 141, "sg-141" );
	log( "Respawn seagift vehicle" );
	}
	if(id.tostring() == "meat")
	{
		if(ini.getKey("PlayerInfo", "admin").tointeger() == 0)
		{
			return;
		}
	respawnVehicle(142);
	setVehicleColour( 142, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 142, "meat" );
	respawnVehicle(143);
	setVehicleColour( 143, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 143, "meat" );
	respawnVehicle(144);
	setVehicleColour( 144, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 144, "meat" );
	respawnVehicle(145);
	setVehicleColour( 145, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 145, "meat" );
	respawnVehicle(146);
	setVehicleColour( 146, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 146, "meat" );
	respawnVehicle(147);
	setVehicleColour( 147, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 147, "meat" );
	respawnVehicle(148);
	setVehicleColour( 148, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 148, "meat" );
	respawnVehicle(149);
	setVehicleColour( 149, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 149, "meat" );
	respawnVehicle(150);
	setVehicleColour( 150, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 150, "meat" );
	respawnVehicle(151);
	setVehicleColour( 151, 50, 50, 50, 50, 50, 50 );
	setVehiclePlateText( 151, "meat" );
	log( "Respawn meat vehicle" );
	}
}
});

function scriptInit()
{
	log( script + " Loaded!" );
	log("");
	
//машины полиции	
local vehicle = createVehicle( 42, -327.97, 658.503, -16.4766, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 0, 0, 50 );
setVehiclePlateText( vehicle, "EBPD-0" );
log("Vehicle EBPD spawn " + vehicle);
local vehicle = createVehicle( 42, -327.884, 663.352, -16.4625, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 0, 0, 50 );
setVehiclePlateText( vehicle, "EBPD-1" );
log("Vehicle EBPD spawn " + vehicle);
local vehicle = createVehicle( 42, -327.498, 677.818, -16.4413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 0, 0, 50 );
setVehiclePlateText( vehicle, "EBPD-2" );
log("Vehicle EBPD spawn " + vehicle);
local vehicle = createVehicle( 42, -327.63, 682.401, -16.4276, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 0, 0, 50 );
setVehiclePlateText( vehicle, "EBPD-3" );
log("Vehicle EBPD spawn " + vehicle);
local vehicle = createVehicle( 42, -324.665, 694.554, -16.6119, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 0, 0, 50 );
setVehiclePlateText( vehicle, "EBPD-4" );
log("Vehicle EBPD spawn " + vehicle);
local vehicle = createVehicle( 42, -313.959, 697.876, -17.8466, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 0, 0, 50 );
setVehiclePlateText( vehicle, "EBPD-5" );
log("Vehicle EBPD spawn " + vehicle);
local vehicle = createVehicle( 42,-303.09, 698.162, -18.4681, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 0, 0, 50 );
setVehiclePlateText( vehicle, "EBPD-6" );
log("Vehicle EBPD spawn " + vehicle);
log("");

//машины медиков
local vehicle = createVehicle( 51, -441.702, 869.521, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-07" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -439.058, 872.241, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-08" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -436.414, 874.961, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-09" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -433.77, 877.681, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-10" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -431.126, 880.401, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-11" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -428.482, 883.121, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-12" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -425.838, 885.841, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-13" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -423.194, 888.561, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-14" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -420.55, 891.281, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-15" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -417.906, 894.001, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-16" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -415.262, 896.721, -19.0, 136.0, 0.0, 0.0 ); 
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-17" );
log("Vehicle MED spawn " + vehicle);
local vehicle =	createVehicle( 51, -412.618, 899.441, -19.0, 136.0, 0.0, 0.0 );
setVehicleColour( vehicle, 150, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "EGH-18" );
log("Vehicle MED spawn " + vehicle);
log("");

//машины траго
local vehicle =	createVehicle( 5, 524.41,-242.684,-19.1858, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "TGO-19" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 5, 524.41,-232.183,-19.1858, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "TGO-20" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 5, 524.41,-214.888,-19.1858, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "TGO-21" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 5, 524.41,-205.228,-19.1858, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "TGO-22" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 5, 532.634,-194.101,-19.1858, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "TGO-23" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 5, 532.634,-184.664,-19.1858, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "TGO-24" );
log("Vehicle Trago spawn " + vehicle);
log("");

//машины сигарет
local vehicle =	createVehicle( 36, -429.276,-690.405,-20.4245, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 40, 49, 66, 169, 122, 44 );
setVehiclePlateText( vehicle, "BB-025" );
log("Vehicle BB spawn " + vehicle);
local vehicle =	createVehicle( 36, -425.376,-690.405,-20.4245, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 40, 49, 66, 169, 122, 44 );
setVehiclePlateText( vehicle, "BB-026" );
log("Vehicle BB spawn " + vehicle);
local vehicle =	createVehicle( 36, -421.376,-690.405,-20.4245, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 76, 112, 108 );
setVehiclePlateText( vehicle, "BB-027" );
log("Vehicle BB spawn " + vehicle);
local vehicle =	createVehicle( 36, -417.376,-690.405,-20.4245, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 255, 255, 255, 76, 112, 108 );
setVehiclePlateText( vehicle, "BB-028" );
log("Vehicle BB spawn " + vehicle);
local vehicle =	createVehicle( 36, -413.376,-690.405,-20.4245, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 100, 14, 22, 14, 22, 24 );
setVehiclePlateText( vehicle, "BB-029" );
log("Vehicle BB spawn " + vehicle);
local vehicle =	createVehicle( 36, -409.376,-690.405,-20.4245, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 100, 14, 22, 14, 22, 24 );
setVehiclePlateText( vehicle, "BB-030" );
log("Vehicle BB spawn " + vehicle);
log("");

local vehicle = createVehicle( 35, -330.907,-717.563,-21.4143, 180.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "docker" );
log("Vehicle docker spawn " + vehicle);
log("");

//автобусы
local vehicle = createVehicle( 20, -436.424,438.58,1.906816, 45.0, 0.0, 0.0 );
log("Vehicle BUS spawn " + vehicle);
local vehicle = createVehicle( 20, -436.352,427.84,1.907611, 45.0, 0.0, 0.0 );
log("Vehicle BUS spawn " + vehicle);
local vehicle = createVehicle( 20, -436.352,416.84,1.907611, 45.0, 0.0, 0.0 );
log("Vehicle BUS spawn " + vehicle);
local vehicle = createVehicle( 20, -416.04,442.644,1.129123, 0.0, 0.0, 0.0 );
log("Vehicle BUS spawn " + vehicle);
local vehicle = createVehicle( 20, -416.04,427.644,1.129123, 0.0, 0.0, 0.0 );
log("Vehicle BUS spawn " + vehicle);
local vehicle = createVehicle( 20, -423.04,442.644,1.129123, 0.0, 0.0, 0.0 );
log("Vehicle BUS spawn " + vehicle);
local vehicle = createVehicle( 20, -423.04,427.644,1.129123, 0.0, 0.0, 0.0 );
log("Vehicle BUS spawn " + vehicle);
log("");

//армия маты
local vehicle = createVehicle( 3, -1370.76,-353.165,-19.2294, 0.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 3, -1389.76,-353.165,-19.2294, 0.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 3, -1408.76,-353.165,-19.2294, 0.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);

//армия забор 1
local vehicle = createVehicle( 3, -1340.7,-246.55,-19.2295, 90.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 3, -1348.34,-246.55,-19.2295, 90.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 3, -1356.34,-246.55,-19.2295, 90.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);

//армия забор 2
local vehicle = createVehicle( 3, -1399.15,-275.925,-19.2243, 180.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);

//армия забор 3
local vehicle = createVehicle( 3, -1536.34,-316.411,-19.234, 90.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 3, -1544.34,-316.411,-19.234, 90.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 3, -1552.34,-316.411,-19.234, 90.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);

//армия забор 4
local vehicle = createVehicle( 3, -1588.4,-335.755,-19.2305, 180.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 3, -1588.4,-343.755,-19.2305, 180.0, 0.0, 0.0 );
log("Vehicle AEB spawn " + vehicle);
log("");

//армия джипы
local vehicle = createVehicle( 11, -1512.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-51" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1515.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-52" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1518.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-53" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1521.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-54" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1524.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-55" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1527.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-56" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1530.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-57" );
log("Vehicle AEB spawn " + vehicle);

local vehicle = createVehicle( 11, -1573.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-58" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1576.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-59" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1579.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-60" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1582.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-61" );
log("Vehicle AEB spawn " + vehicle);
local vehicle = createVehicle( 11, -1585.3,-363.436,-18.941, 0.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "aeb-62" );
log("Vehicle AEB spawn " + vehicle);
log("");

//ирландцы
local vehicle =	createVehicle( 9, -1139.82,1540.3,8.0155, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 9, -1139.82,1537.3,8.0155, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 9, -1139.82,1534.3,8.0155, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 9, -1139.82,1531.3,8.0155, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 9, -1139.82,1528.3,8.0155, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 9, -1168.22,1535.66,7.70799, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 9, -1168.22,1532.66,7.70799, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 9, -1168.22,1529.66,7.70799, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
local vehicle =	createVehicle( 32, -1157.87,1526.81,7.70552, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 100, 0, 0, 100, 0 );
setVehiclePlateText( vehicle, "irish" );
log("Vehicle IRISH spawn " + vehicle);
log("");

//car rental
local vehicle =	createVehicle( 53, 547.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 550.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 553.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 556.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 559.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 562.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 565.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 568.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 571.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 574.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 577.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 580.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, 583.236,804.326,-11.4039, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);

local vehicle =	createVehicle( 53, -550.887,1600.03,-16.3664, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
log("");

//такси
local vehicle =	createVehicle( 24, -127.851,412.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,409.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,406.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,403.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,400.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,397.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,394.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,391.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,388.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,385.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 24, -127.851,382.449,-12.9892, -90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
log("");

local vehicle =	createVehicle( 33, -140.851,412.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,409.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,406.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,403.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,400.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,397.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,394.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,391.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,388.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,385.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
local vehicle =	createVehicle( 33, -140.851,382.449,-12.9892, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "taxi" );
log("Vehicle TAXI spawn " + vehicle);
log("");

//инкасаторы
local vehicle =	createVehicle( 27, 121.915,-77.4103,-18.9262, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "EC-108" );
log("Vehicle ENCASH spawn " + vehicle);
local vehicle =	createVehicle( 27, 122.32,-55.7448,-18.0253, 90.0, 0.0, 0.0 );
setVehiclePlateText( vehicle, "EC-109" );
log("Vehicle ENCASH spawn " + vehicle);
log("");

//траго дальнобои
local vehicle =	createVehicle( 4, 497.461,-239.813,-19.1454, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 0, 0, 50, 50, 50 );
setVehiclePlateText( vehicle, "tr-113" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 4, 497.461,-232.813,-19.1454, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 0, 0, 50, 50, 50 );
setVehiclePlateText( vehicle, "tr-114" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 4, 497.461,-212.813,-19.1454, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 0, 0, 50, 50, 50 );
setVehiclePlateText( vehicle, "tr-115" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 4, 497.461,-205.813,-19.1454, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 0, 0, 50, 50, 50 );
setVehiclePlateText( vehicle, "tr-116" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 4, 497.461,-184.813,-19.1454, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 0, 0, 50, 50, 50 );
setVehiclePlateText( vehicle, "tr-117" );
log("Vehicle Trago spawn " + vehicle);
local vehicle =	createVehicle( 4, 497.461,-177.813,-19.1454, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 0, 0, 50, 50, 50 );
setVehiclePlateText( vehicle, "tr-118" );
log("Vehicle Trago spawn " + vehicle);
log("");

//триада
local vehicle =	createVehicle( 32, 361.664,390.968,-18.42, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 0, 0, 0, 0, 0 );
setVehiclePlateText( vehicle, "triada" );
log("Vehicle Triada spawn " + vehicle);
local vehicle =	createVehicle( 18, 354.376,382.912,-18.4233, 85.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 0, 0, 0, 0, 0 );
setVehiclePlateText( vehicle, "triada" );
log("Vehicle Triada spawn " + vehicle);
local vehicle =	createVehicle( 15, 347.573,382.414,-18.3844, 85.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 0, 0, 0, 0, 0 );
setVehiclePlateText( vehicle, "triada" );
log("Vehicle Triada spawn " + vehicle);
local vehicle =	createVehicle( 15, 340.573,381.900,-18.3844, 85.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 0, 0, 0, 0, 0 );
setVehiclePlateText( vehicle, "triada" );
log("Vehicle Triada spawn " + vehicle);
local vehicle =	createVehicle( 23, 333.573,381.406,-18.3844, 85.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 0, 0, 0, 0, 0 );
setVehiclePlateText( vehicle, "triada" );
log("Vehicle Triada spawn " + vehicle);
local vehicle =	createVehicle( 23, 327.534,380.842,-18.3844, 85.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 0, 0, 0, 0, 0 );
setVehiclePlateText( vehicle, "triada" );
log("Vehicle Triada spawn " + vehicle);
log("");

//водители
local vehicle =	createVehicle( 35, 757.426,833.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,828.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,823.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,818.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,813.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,808.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,803.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,798.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,793.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
local vehicle =	createVehicle( 35, 757.426,788.644,-10.7697, -90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 180, 0, 0, 255, 255, 255 );
setVehiclePlateText( vehicle, "driver" );
log("Vehicle driver spawn " + vehicle);
log("");

//рыбзавод
local vehicle =	createVehicle( 38, 731.426,833.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-132" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,828.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-133" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,823.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-134" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,818.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-135" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,813.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-136" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,808.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-137" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,803.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-138" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,798.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-139" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,793.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-140" );
log("Vehicle seagift spawn " + vehicle);
local vehicle =	createVehicle( 38, 731.426,788.644,-10.7697, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 0, 25, 10, 100, 100, 100 );
setVehiclePlateText( vehicle, "SG-141" );
log("Vehicle seagift spawn " + vehicle);
log("");

//мясо
local vehicle =	createVehicle( 34, 747.469,833.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,828.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,823.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,818.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,813.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,808.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,803.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,798.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,793.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
local vehicle =	createVehicle( 34, 747.469,788.814,-10.8413, 90.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "meat" );
log("Vehicle meat spawn " + vehicle);
log("");

//аренда около жд 2 парк
local vehicle =	createVehicle( 53, -551.166,1583.85,-15.3585, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -548.166,1583.85,-15.3585, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -545.166,1583.85,-15.3585, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -542.166,1583.85,-15.3585, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -539.166,1583.85,-15.3585, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -536.166,1583.85,-15.3585, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -533.166,1583.85,-15.3585, 0.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);

//аренда около жд 1 парк
local vehicle =	createVehicle( 53, -547.887,1600.03,-15.3664, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -544.887,1600.03,-15.3664, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -541.887,1600.03,-15.3664, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -538.887,1600.03,-15.3664, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -535.887,1600.03,-15.3664, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
local vehicle =	createVehicle( 53, -532.887,1600.03,-15.3664, 180.0, 0.0, 0.0 );
setVehicleColour( vehicle, 50, 50, 50, 50, 50, 50 );
setVehiclePlateText( vehicle, "rental" );
log("Vehicle RENTAL spawn " + vehicle);
log("");
}
addEventHandler( "onScriptInit", scriptInit );

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
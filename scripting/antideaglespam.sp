#include <sourcemod>
#include <cstrike>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name				=	"Anti Deagle Spray",
	author				=	"DiogoOnAir",
	description			=	"AntiDeagleSpray",
	version				=	"1.5",
};

public void OnPluginStart()
{
	HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Post);
}

public void Event_WeaponFire(Event event, const char[] sEventName, bool bDontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));

	char sWeapon[65];
	event.GetString("weapon", sWeapon, sizeof(sWeapon));

	if(StrEqual(sWeapon, "weapon_deagle"))
	{
		CreateTimer(0.05, RemoveDeagle, client);
	}
}

public Action RemoveDeagle(Handle timer, any client)
{
	if(IsClientInGame(client) && IsPlayerAlive(client))
	{
		RemovePlayerItem(client, GetPlayerWeaponSlot(client, CS_SLOT_SECONDARY));
		CreateTimer(0.15, GiveDeagle, client);
	}
}

public Action GiveDeagle(Handle timer, any client)
{
	if(IsClientInGame(client) && IsPlayerAlive(client))
	{
		GivePlayerItem(client, "weapon_deagle");
		SetActiveWeapon(client, GetPlayerWeaponSlot(client, CS_SLOT_SECONDARY));
	}
}

stock void SetActiveWeapon(int client, int weapon)
{
	SetEntPropEnt(client, Prop_Data, "m_hActiveWeapon", weapon);
	ChangeEdictState(client, FindDataMapInfo(client, "m_hActiveWeapon"));
}

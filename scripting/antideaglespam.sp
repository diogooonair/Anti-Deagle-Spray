#include <sourcemod> 
#include <sdkhooks> 
#include <sdktools>
#include <smlib>

#pragma semicolon 1 
#pragma tabsize 0;

#define PLUGIN_NAME 			"AntiDeagle Spray"
#define PLUGIN_AUTHOR 			"DiogoOnAir"
#define PLUGIN_DESCRIPTION		"AntiDeagleSpray"
#define PLUGIN_VERSION 			"1.4vFix"

public Plugin myinfo =
{
    name				=    PLUGIN_NAME,
    author				=    PLUGIN_AUTHOR,
    description			=    PLUGIN_DESCRIPTION,
    version				=    PLUGIN_VERSION,
};

public OnPluginStart()
{ 
    HookEvent("weapon_fire", Event_WeaponFire, EventHookMode_Post); 
} 

public void Event_WeaponFire(Event event, const char[] sEventName, bool bDontBroadcast)
{ 
    int client = GetClientOfUserId(GetEventInt(event, "userid")); 

    char sWeapon[65];
    event.GetString("weapon", sWeapon, sizeof(sWeapon));
    
    if (StrEqual(sWeapon, "weapon_deagle")) 
    {
    	    CreateTimer(0.05, RemoveDeagle, client);
    } 
}  

public Action RemoveDeagle(Handle timer, any client)
{
	if (IsValidClient(client) && (IsPlayerAlive(client))) {
		RemovePlayerItem(client, GetPlayerWeaponSlot(client, 1));
		CreateTimer(0.15, GiveDeagle, client);
	}
}


public Action GiveDeagle(Handle timer, any client)
{
	if (IsValidClient(client) && (IsPlayerAlive(client))) 
		GivePlayerItem(client, "weapon_deagle");
		Client_SetActiveWeapon(client, GetPlayerWeaponSlot(client, 1)); 
}

stock bool IsValidClient(int client)
{
	if(client <= 0 ) return false;
	if(client > MaxClients) return false;
	if(!IsClientConnected(client)) return false;
	return IsClientInGame(client);
}

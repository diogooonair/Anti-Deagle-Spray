#include <sourcemod> 
#include <sdkhooks> 
#include <sdktools>
#include <smlib>

#pragma semicolon 1 
#pragma tabsize 0;

#define PLUGIN_NAME 			"AntiDeagle Spray"
#define PLUGIN_AUTHOR 			"DiogoOnAir"
#define PLUGIN_DESCRIPTION		"AntiDeagleSpray"
#define PLUGIN_VERSION 			"1.3vFix"

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
		    CreateTimer(0.11, ChangeKnife, GetClientSerial(client));
    } 
}  

public Action ChangeKnife(Handle timer, any serial)
{
	int client = GetClientFromSerial(serial);
    Client_SetActiveWeapon(client, GetPlayerWeaponSlot(client, 2)); 
    CreateTimer(1.5, ChangeDeagle, GetClientSerial(client));
}

public Action ChangeDeagle(Handle timer, any serial)
{
    int client = GetClientFromSerial(serial);
    Client_SetActiveWeapon(client, GetPlayerWeaponSlot(client, 1)); 
}
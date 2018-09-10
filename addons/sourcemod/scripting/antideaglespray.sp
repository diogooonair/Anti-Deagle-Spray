#include <sourcemod> 
#include <sdkhooks> 
#include <sdktools>
#include <smlib>

#pragma semicolon 1 

#define PLUGIN_NAME 			"AntiDeagle Spray"
#define PLUGIN_AUTHOR 			"DiogoOnAir"
#define PLUGIN_DESCRIPTION		"AntiDeagleSpray"
#define PLUGIN_VERSION 			"1.0"

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
    new client = GetClientOfUserId(GetEventInt(event, "userid")); 

    char[] sWeapon = new char[32]; 
    GetClientWeapon(client, sWeapon, 32); 
         
    if (StrEqual(sWeapon, "weapon_deagle")) 
    { 
		    CreateTimer(0.5, ChangeKnife);
    } 
}  

public Action ChangeKnife(Handle timer, Event event)
{
    new client = GetClientOfUserId(GetEventInt(event, "userid"));
    Client_SetActiveWeapon(client, GetPlayerWeaponSlot(client, 3)); 
}
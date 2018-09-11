#include <sourcemod> 
#include <sdkhooks> 
#include <sdktools> 
#include <smlib> 

#pragma semicolon 1 

#define PLUGIN_NAME             "AntiDeagle Spray" 
#define PLUGIN_AUTHOR             "DiogoOnAir" 
#define PLUGIN_DESCRIPTION        "AntiDeagleSpray" 
#define PLUGIN_VERSION             "1.1" 

public Plugin myinfo = 
{ 
    name                =    PLUGIN_NAME, 
    author                =    PLUGIN_AUTHOR, 
    description            =    PLUGIN_DESCRIPTION, 
    version                =    PLUGIN_VERSION, 
}; 

public OnPluginStart() 
{ 
    HookEvent("weapon_fire", Event_WeaponFire); 
} 

public void Event_WeaponFire(Event event, const char[] sEventName, bool bDontBroadcast) 
{ 
    // Get the client 
    int client = GetClientOfUserId(event.GetInt("userid")); 
     
    // Check if our sir is valid 
    if (IsClientInGame(client)) 
    { 
        // Array to store the client's weapon in 
        char sWeapon[32]; 
        // Get the client's weapon and store it in the array 
        GetClientWeapon(client, sWeapon, sizeof(sWeapon)); 
         
        // If the client has a deagle 
        if (StrEqual(sWeapon, "weapon_deagle")) 
            // Trigger this timer, pass the client's userid to the callback, it's safer 
            CreateTimer(0.5, ChangeKnife, GetClientUserId(client)); 
    } 
} 

public Action ChangeKnife(Handle timer, int data) 
{ 
    // since we've got the client's userid stored in the "data" var, we somehow have to get the actual client from that userid 
    int client = GetClientOfUserId(data); 
     
    if (IsClientInGame(client)) 
        // set the client's weapon to a grenade, because counting starts at 0, for knife; simply change 3 with 2 
        Client_SetActiveWeapon(client, GetPlayerWeaponSlot(client, 3)); 
}  
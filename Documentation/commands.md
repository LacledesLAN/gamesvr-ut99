\# Server Administration Console Commands

\## General Commands

| Action                                  | Type this in the Console                        |
|----------------------------------------|-------------------------------------------------|
| Login as an Administrator              | `adminlogin adminpass`                         |
| Kick a player from server              | `admin kick playername`                        |
| Kick and ban a player from server      | `admin kickban playername`                     |
| Broadcast message in middle of screen | `say #message`                                 |
| Give up administrator rights           | `adminlogout`                                  |



\##  Change Maps and Gametypes



| Action                                         | Type this in the Console                                         |
|------------------------------------------------|------------------------------------------------------------------|
| Restart current map                            | `admin servertravel?restart`                                    |
| Change map but not gametype                    | `admin servertravel map name`                                   |
| Change map and/or gametype to CTF              | `admin servertravel map name?game=botpack.ctfgame`              |
| Change map and/or gametype to DOM              | `admin servertravel map name?game=botpack.domination`           |
| Change map and/or gametype to ASSAULT          | `admin servertravel map name?game=botpack.assault`              |
| Change map and/or gametype to DM               | `admin servertravel map name?game=botpack.deathmatchplus`       |
| Change map and/or gametype to DM-TEAMGAME      | `admin servertravel map name?game=botpack.teamgameplus`         |



\##  Mutators



| Action                                                   | Type this in the Console                                                                 |

|----------------------------------------------------------|--------------------------------------------------------------------------------------------|
| Restart map with a mutator                               | `admin servertravel?restart?game=botpack.ctfgame?mutator=mutator`                        |
| Start Face without redeemer                              | `admin servertravel ctf-face?game=botpack.ctfgame?mutator=botpack.noredeemer`            |
| Start Codex without powerups                             | `admin servertravel dm-codex?game=botpack.deathmatchplus?mutator=botpack.nopowerups`     |
| Start November with rocket launcher only                 | `admin servertravel ctf-november?game=botpack.ctfgame?mutator=botpack.rocketarena`       |
| Start Leadworks with Shock Rifle only                    | `admin servertravel dom-leadworks?game=botpack.domination?mutator=botpack.shockarena`    |
| Start Lava Giant with only pulseguns, no redeemer or powerups | `admin servertravel ctf-lavagiant?game=botpack.ctfgame?mutator=botpack.noredeemer,botpack.nopowerups,botpack.pulsearena` |
| Start Niven with Instagib                                | `admin servertravel ctf-niven?game=botpack.ctfgame?mutator=botpack.instagibdm`           |
| Restart map without mutators                             | `admin servertravel?restart?mutator=`                                                    |



\##  Limits



| Setting                              | Command                                               |

|--------------------------------------|--------------------------------------------------------|
| See current timelimit                | `admin get botpack.ctfgame timelimit`                |
| Set timelimit to 20 minutes          | `admin set botpack.ctfgame timelimit 20`             |
| See current fraglimit                | `admin get botpack.deathmatchplus fraglimit`         |
| Set fraglimit to 30                  | `admin set botpack.deathmatchplus fraglimit 30`      |
| See current cap limit                | `admin get botpack.ctfgame goalteamscore`            |
| Set cap limit to 10                  | `admin set botpack.ctfgame goalteamscore 10`         |
| See current maxplayers               | `admin get engine.gameinfo maxplayers`               |
| Set maxplayers to 10                 | `admin set engine.gameinfo maxplayers 10`            |
| See current max spectators           | `admin get engine.gameinfo maxspectators`            |
| Set spectators to 0                  | `admin set engine.gameinfo maxspectators 0`          |
| See max team size                    | `admin get botpack.ctfgame maxteamsize`              |
| Set max team size to 6               | `admin set botpack.ctfgame maxteamsize 6`            |



\##  Tournament Mode

| Setting                             | Command                                                   |
|-------------------------------------|------------------------------------------------------------|
| Check if tournament mode is on (CTF) | `admin get botpack.ctfgame btournament`                  |
| Check if tournament mode is on (DM)  | `admin get botpack.deathmatchplus btournament`           |
| Set tournament mode on/off (CTF)     | `admin set botpack.ctfgame btournament true/false`       |
| Set tournament mode on/off (DM)      | `admin set botpack.deathmatchplus btournament true/false`|



\##  Server Physics

| Setting                                  | Command                                                       |
|------------------------------------------|----------------------------------------------------------------|
| Set new game password                    | `admin set engine.gameinfo gamepassword password`            |
| Set friendly fire scale                  | `admin set botpack.ctfgame friendlyfirescale 0.00-1.00`      |
| Toggle weaponstay                        | `admin set botpack.ctfgame bmultiweaponstay true/false`      |
| Toggle translocator                      | `admin set botpack.ctfgame busetranslocator true/false`      |
| Toggle force respawn                     | `admin set botpack.ctfgame bforcerespawn true/false`         |
| Toggle team balance                      | `admin set botpack.ctfgame bplayersbalanceteams true/false`  |
| Set aircontrol to 35%                    | `admin set botpack.deathmatchplus aircontrol 0.35`           |
| Set gamespeed to 110%                    | `admin set engine.gameinfo gamespeed 1.1`                    |


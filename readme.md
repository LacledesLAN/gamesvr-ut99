# Unreal Tournament (aka `UT99`) Dedicated Server in Docker

Unreal Tournament is an arena first-person shooter first published in 1999, retrospectively the game is known as `UT99` to differentiate it from its sequels. UT is an arena first-person shooter, with head-to-head multiplayer deathmatches being the primary focus of the game. "Mutators" are available which drastically alter gameplay aspects, such as "InstaGib", the use of which makes players compete with instant-kill weapons instead of the normal ones.

In 2019, community group [OldUnreal](https://www.oldunreal.com/) got the approval from creator [Epic Games](https://www.epicgames.com) to developer new community patches.

![Unreal Tournament (1999)](.misc/ut99.jpg)

This repository is maintained by [Laclede's LAN](https://lacledeslan.com). Its contents are intended to be bare-bones and used as a stock server. For an example of building a customized server from this Docker image browse the related child-project [gamesvr-ut99-freeplay](https://github.com/LacledesLAN/gamesvr-ut99-freeplay). If any documentation is unclear or it has any issues please see [CONTRIBUTING.md](./CONTRIBUTING.md)

This UT99 server was built from the following content:

1. Official Unreal Tournament 99 Server - Version 436.
2. Epic Bonus Pack (a.k.a. Bonus Pack 1): Includes three new models (Skaarj Hybrid, Nali and Nali Warcow), the Relics and 11 new maps: CTF-Cybrosis][, CTF-Darji16, CTF-Hydro16, CTF-Noxion16, DM-Agony, DM-ArcaneTemple, DM-CybrosisII, DM-HealPodII, DM-Malevolence, DM-MojoII and DM-ShrapnelII.
3. DE Bonus Pack (a.k.a. Bonus Pack 2): Contains three new mutators (Team Beacon, Volatile Ammo and Volatile Weapon) and two new maps: CTF-HallOfGiants and CTF-Orbital.
4. Inoxx Bonus Pack (a.k.a. Bonus Pack 3): Contains six new maps: CTF-Face][, CTF-High, CTF-Kosov, CTF-Nucleus, DM-Crane and DM-SpaceNoxx.
5. Christmas Bonus Pack (a.k.a. Bonus Pack 4): Includes two new models (Warboss and Xan Mk. II) and 12 new maps: CTF-Beatitude, CTF-EpicBoy, CTF-Face-SE, CTF-Ratchet, DM-Bishop, DM-Closer, DM-Grit-TOURNEY, DM-Viridian-TOURNEY, DOM-Bullet, DOM-CiDom, DOM-Lament][ and DOM-WolfsBay.
6. [OldUnreal Community Patch - version 469e-rc9](https://github.com/OldUnreal/UnrealTournamentPatches)

## Linux

[![linux/amd64](https://github.com/LacledesLAN/gamesvr-ut99/actions/workflows/build-linux-image.yml/badge.svg?branch=master)](https://github.com/LacledesLAN/gamesvr-ut99/actions/workflows/build-linux-image.yml)

### Download

```shell
docker pull lacledeslan/gamesvr-ut99;
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if any tests fail.

```shell
docker run -it --rm lacledeslan/gamesvr-ut99:latest /app/ll-tests/gamesvr-ut99.sh;
```

### Run simple interactive server

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-ut99 /app/ucc server DM-Deck16][.unr?Game=Botpack.DeathMatchPlus -nohomedir -lanplay;
```

## Custom configuration and Online Server Hosting.

Due to the shutdown of Gamespy in 2014 and the shutdown of the official master server by Epic in December 2022, a custom server config has been prepared. This [custom server config](https://github.com/LacledesLAN/gamesvr-ut99/blob/master/dist.linux/System/UnrealTournament-Online.ini) includes community servers to allow for listing on updated and community clients. Included is listings and settings provided by [OldUnreal](https://www.oldunreal.com/wiki/index.php?title=Masterserver_Guide) and [333networks](https://333networks.com/instructions/ut/s). Also this server file can be used as a base for a custom config while preserving the [original default](https://github.com/LacledesLAN/gamesvr-ut99/blob/master/dist.linux/System/UnrealTournament.ini) config as a fall back.

### Run online server with custom config

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-ut99 /app/ucc server dm-Turbine?game=Botpack.DeathMatchPlus ini=UnrealTournament-Online.ini log=logfile.log -nohomedir
```

### Run with specific mutator enabled

Unreal Tournament 99 includes mutators to alter the game play and functionality of the server. However they are not enabled by default. You can simply add "?mutator=mutatorname" to the command string. In this example a mapvoting plugin (?mutator=MapVoteLAv2.BDBMapVote) was added and enabled. Mutators must be nabled and added to the server config file being used.

On the command line it will look like this.

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-ut99 /app/ucc server dm-Turbine?game=Botpack.DeathMatchPlus?mutator=MapVoteLAv2.BDBMapVote ini=UnrealTournament-Online.ini log=logfile.log -nohomedir -adminconsole -http
```


### Run interactive server with custom config and web interface

Unreal Tournament 99 includes a admin web interface to make it easy to change maps, game options, playlists, ban players, etc. By default this option is not enabled and can be turned on with adding "-adminconsole" and "-http" to the command line and enable via the [config file](https://github.com/LacledesLAN/gamesvr-ut99/blob/master/dist.linux/System/UnrealTournament.ini).

On the command line it will look like this.

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-ut99 /app/ucc server dm-Turbine?game=Botpack.DeathMatchPlus ini=UnrealTournament-Online.ini log=logfile.log -nohomedir -adminconsole -http
```

In the UnrealTournament.ini file just set bEnabled to true, remember the port number, userid, and password. You will be able to login to the server with a web browser. Just go to http://ipaddress:port on your browser. Currently putting in the AdminPassword field into the launchstring does not work. 

```shell
[UTServerAdmin.UTServerAdmin]
AdminUsername=username
AdminPassword=password


[UWeb.WebServer]
Applications[0]=UTServerAdmin.UTServerAdmin
ApplicationPaths[0]=/ServerAdmin
Applications[1]=UTServerAdmin.UTImageServer
ApplicationPaths[1]=/images
DefaultApplication=0
bEnabled=True
ListenPort=5080

```

### Other Varibles that can be entered into the launch string.

| Varible | Puropse |
|-------|-----|
| game=Yourgametype.Classname | Selects game type |
| difficulty=1-7 | Bot Diffucluty |
| lanplay | Optimizes for Local Network play |
| log=logfile.log | creates a log file|
| multihome=127.0.0.1 | Binds the server to a specific IP on a multi-homed system—handy if your system has multiple interfaces or IPs.|
| maxplayers=16 | Defines max number of players allowed on the server. |


## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks, and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can also browse all of our other Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).

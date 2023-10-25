// Generic Communicator Agent
/* Initial beliefs */


/* Initial goals */
!infoWhere.
!connect.

/* Plans */
+!infoWhere: whereIam(OurMAS) <- .print("OurMAS is ",OurMAS); .broadcast(tell,whereIam(OurMAS)).

-!infoWhere: not whereIam(OurMAS).

+!connect: myIotAddress(UUID) & ioTGateway(Server,Port) <-
    .print("Connecting at ",Server," with the UUID ",UUID);
    .connectCN(Server,Port,UUID);
    +connected.

+!connect: not myIotAddress(UUID) <- .randomUUID(UUID); +myIotAddress(UUID); .random(R); .wait(2000*R); !connect.

+!connect: not ioTGateway(Server,Port) <- +ioTGateway("skynet.chon.group",5500); .random(R); .wait(2000*R); !connect.

/* Sending a message to an agent into other MAS */
+!sendExternalMessage(MAS,Receiver,Force,Message)[source(Source)]: connected <-
    .print("Forwarding message from:",Source," to:",Receiver," in ",MAS);
    .sendOut(MAS, achieve, 
        internalUnicastMessage(Receiver,Force,Message[source(Source)])).

-!sendExternalMessage(MAS,Receiver,Force,Message)[source(Source)] <- .print("Waiting for connection...").

+!internalUnicastMessage(Destination,Force,Message)[source(X)] <-
    .print("Forwarding message from:",X," to:",Destination);
	.send(Destination,Force,Message[source(X)]).

/* Sending a message to all agents into all known MAS */
+!sendExternalMessageForAllKnown(Force,Message)[source(Source)] <-
    for((masDirectory(OtherMAS,UUID))){
        .print("Forwarding message for any agent into ",OtherMAS);
        .sendOut(UUID, achieve, 
            internalBroadcastMessage(Force,Message[source(Source)]));
    }.

-!sendExternalMessageForAllKnown(Force,Message)[source(Source)] <- .print("Waiting for connection...").

+!internalBroadcastMessage(Force,Message)[source(X)]: connected <-
    .print("Broadcasting message from ",X);
	.broadcast(Force,Message[source(X)]).

+!mas2masMessage(UUID,Force,Message)[source(X)]: connected <-
    .print("Sending message from:",X, " toMAS:",UUID);
    .sendOut(UUID,Force,Message).

-!mas2masMessage(UUID,Force,Message)[source(X)] <- .print("Waiting for connection...").
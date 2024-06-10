// Agent telephonist in new Coalition Multiagent System
{ include("./_onFly.asl") }

/* Initial beliefs */
tryingCallBack(10).

/* Initial goals */
!start.

/* Plans */
+!start: onFlyBeliefs(Content) <-
	!loadOnFlyBeliefs(set(Content));
    !connect.

-!start <- !abortCoalition.  

+!loadOnFlyBeliefs(set([Head|Tail])) <- 
    .print("Loading belief: ",Head);
    +Head; 
    !loadOnFlyBeliefs(set(Tail)).

+!loadOnFlyBeliefs(set([   ])) <- -onFlyBeliefs(_).

+!connect: 
coalitionAddress(UUID) & 
gatewayIoT(Server,Port) <-
    .print("Connecting at ",Server," with the UUID ",UUID);
    .connectCN(Server,Port,UUID);
    !callBack.

-!connect <- !abortCoalition.

+!callBack: 
coalitionAddress(MyUUID) & 
callBack(UUID) & 
tryingCallBack(N) <-
    .sendOut(UUID, tell, newMasSuccessfullyCreated(MyUUID));
    .print("Sending message for the Communicator agent into ",UUID," - attempt(",N,")");
    -+tryingCallBack(N-1);
    .random(R); .wait(5000*R);
    !callBack.

+tryingCallBack(0)[source(self)] <- !abortCoalition.

+stopCallBack <- 
    .print("CallBack Successfully..."); 
    .drop_desire(callBack).

+!abortCoalition <-
    .print("Something is wrong! \n CONSULT INSTRUCTIONS AT: https://github.com/chon-group/newCoalitionMAS");
    .wait(5000);
    .stopMAS.
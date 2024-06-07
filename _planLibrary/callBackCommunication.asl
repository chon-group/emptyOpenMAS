tryingCallBack(10).

!callBack.

+!callBack: myIotAddress(MyUUID) & tryingCallBack(N) & connected <-
    for((callBack(UUID))){
        .print("Forwarding message for communicator agent into ",UUID);
        .sendOut(UUID, tell, newMasSuccessfullyCreated(MyUUID));
    };
    .random(R); .wait(5000*R);
    -+tryingCallBack(N-1);
    !callBack;
.

+!callBack: onFlyBeliefs(Content) <-
    ?onFlyBeliefs(Content);
	!loadOnFlyBeliefs(set(Content));
    !callBack;
.

-!callBack <- .random(R);  .wait(2000*R); !callBack.  

+!loadOnFlyBeliefs(set([Head|Tail])) <- +Head; !loadOnFlyBeliefs(set(Tail)).
-!loadOnFlyBeliefs(set([   ])) <- -loadOnFlyBeliefs(_).


+tryingCallBack(0)[source(self)] <- .print("CallBack Failure..."); .stopMAS.

+stopCallBack <- .print("CallBack Successfully..."); .drop_desire(callBack).
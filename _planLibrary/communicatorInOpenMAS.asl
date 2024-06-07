// Generic Communicator Agent
{ include("communicatorAgent.asl") }

/* Plans about how sends an agent to other MAS */
+!tranportAnAgentTo(Agent,Destination)[source(X)]: whereIam(OurMAS)
<-
    .print("Transporting ",Agent," to ",Destination);
    .send(Agent,untell,whereIam(OurMAS));
    +transportRequest(Destination,Agent).

+transportRequest(UUID,Agent)[source(self)]
<-
    .random(R); .wait(3000*R);
    .moveOut(UUID,mutualism,Agent);
    .wait(5000*R);
    .sendOut(UUID, achieve, welcome(Agent));
.

+!welcome(Agent)[source(X)]
: where(OurMAS)
<-
    .print("Wellcome ",Agent," to ",OurMAS);
    .send(Agent,tell,where(OurMAS)).
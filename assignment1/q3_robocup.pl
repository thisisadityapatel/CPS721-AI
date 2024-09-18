
% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Patel, Aditya Kamleshkumar
%%%%% NAME: Bhandal, Arjun
%%%%% NAME: Osadebe, Osanyem
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%
%%%%% Below you can find the KB given in the assignment. You may edit it as you wish for testing
%%%%% It will be ignored in the tests
%%%%% However, the queries you give in part b should be tested on this original KB
robot(r1). robot(r2). robot(r3).
robot(r4). robot(r5). robot(r6).

hasBall(r3).

pathClear(r1, net).
pathClear(r2, r1).
pathClear(r3, r2).
pathClear(r3, net).
pathClear(r3, r1).
pathClear(r3, r4).
pathClear(r4, net).
pathClear(r1, r5).
pathClear(r5, r6).

%%%%% SECTION: q3_rules
%%%%% Put statements for canPass and canScore below. 
%%%%% You may also define helper predicates in this section
%%%%% DO NOT PUT ATOMIC FACTS for robot, hasBall, or pathClear below.

canKick(R1, R2) :- pathClear(R1, R2).

canKick(R1, R2) :- pathClear(R2, R1).

canPass(R1, R2, M) :-
    M > 0,
    canKick(R1, R2),
    not R1 = net,
    not R2 = net.

canPass(R1, R2, M) :-
    M > 1,
    canKick(R1, R3),
    not R3 = R1,
    not R3 = R2,
    M2 is M - 1,
    canPass(R3, R2, M2).

canScore(R, M) :- 
    hasBall(R), 
    M > 0,
    canKick(R, net).

canScore(R, M) :-
    M > 1,
    hasBall(RStart),
    not R = RStart,
    Mpass is M - 1,
    canPass(RStart, R, Mpass),
    canKick(R, net).

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW

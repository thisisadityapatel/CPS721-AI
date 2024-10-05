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
%%%%% Below you can find the KB given in the assignment PDF. You may edit it as you wish for testing
%%%%% It will be ignored in the tests
%%%%% Do not put any part of the KB in the robocup section below. That section, should only
%%%%% have statements for the canPass, canScore, and any helper predicates needed for computing those
robot(r1).     robot(r2).     robot(r3).
robot(r4).     robot(r5).     robot(r6).
hasBall(r3).
pathClear(r1, net).    pathClear(r2, r1).    pathClear(r3, r2).
pathClear(r3, net).    pathClear(r3, r1).    pathClear(r3, r4).
pathClear(r4, net).    pathClear(r1, r5).    pathClear(r5, r6).

%%%%% SECTION: robocup
%%%%% Put your rules for canPass, canScore, and any helper predicates below

canKick(R1, R2) :- pathClear(R1, R2).
canKick(R1, R2) :- pathClear(R2, R1).

canPass(R1, R2, M, Path) :-
    canPassAccumulator(R1, R2, M, [R1], SubPath),
    appendelement(R2, SubPath, Path).

canPassAccumulator(R1, R2, M, Accumulator, Path) :-
    M > 1,
    M2 is M - 1,
    canKick(R1, R3),
    appendelement(R3, Accumulator, NewAccumulator),
    canPassAccumulator(R3, R2, M2, NewAccumulator, Path),
    not R1 = R3,
    not R2 = R3,
    not R3 = net,
    not memberlist(Accumulator, R3).

canPassAccumulator(R1, R2, 1, Path, Path) :-
    canKick(R1, R2),
    not R1 = net,
    not R2 = net.

canPassAccumulator(R1, R2, M, Path, Path) :-
    M > 1,
    canKick(R1, R2),
    not R1 = net,
    not R2 = net.

memberlist([Item|_T], Item).
memberlist([H|T], Item) :- not H = Item, memberlist(T, Item).

appendelement(Item, [], [Item]).
appendelement(Item, [H|T1], [H|T2]) :-
    appendelement(Item, T1, T2).
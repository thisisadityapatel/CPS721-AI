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
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: minAndMaxList
%%%%% Below, you should define rules for the predicate "minList(List, M)", 
%%%%% which takes in an input List and finds the minimal element there.
%%%%%
%%%%% You should also define rules for the predicate "maxList(List, M)", 
%%%%% which takes in an input List and finds the maximal element there.
%%%%%
%%%%% If you introduce any other helper predicates for implementing minList
%%%%% and maxList, they should be included in this section.

maxList([H | T], M) :- maxList(T, H, M).
maxList([], A, A).
maxList([H | T], A, M) :- H > A, maxList(T, H, M).
maxList([H | T], A, M) :- H =< A, maxList(T, A, M).

minList([H | T], M) :- minList(T, H, M).
minList([], A, A).
minList([H | T], A, M) :- H < A, minList(T, H, M).
minList([H | T], A, M) :- H >= A, minList(T, A, M).


%%%%% SECTION: fertilizersSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than minList, maxList, and their helpers) that you choose to introduce.

solve(List) :-
    % Variables for plants: [Plant1, Plant2, Plant3, Plant4, Plant5]
    % Format for each plant: plant(Fertilizer, Height, Tomatoes, Weight)
    List = [plant(F1, H1, T1, W1), plant(F2, H2, T2, W2), plant(F3, H3, T3, W3),
            plant(F4, H4, T4, W4), plant(F5, H5, T5, W5)],

    % Possible values for fertilizers, heights, tomato counts, and weights
    Fertilizers = [bone_meal, compost, egg_shells, manure, seaweed],
    Heights = [1, 2, 4, 5, 7],
    TomatoCounts = [4, 6, 9, 12, 21],
    Weights = [3, 9, 10, 14, 19],

    % Assign values for Plant 1 and check constraints
    my_select(F1, Fertilizers, FRest1),
    my_select(H1, Heights, HRest1),
    my_select(T1, TomatoCounts, TRest1),
    my_select(W1, Weights, WRest1),
    interleave([plant(F1, H1, T1, W1)]),

    % Assign values for Plant 2 and check constraints
    my_select(F2, FRest1, FRest2),
    my_select(H2, HRest1, HRest2),
    my_select(T2, TRest1, TRest2),
    my_select(W2, WRest1, WRest2),
    interleave([plant(F1, H1, T1, W1), plant(F2, H2, T2, W2)]),

    % Assign values for Plant 3 and check constraints
    my_select(F3, FRest2, FRest3),
    my_select(H3, HRest2, HRest3),
    my_select(T3, TRest2, TRest3),
    my_select(W3, WRest2, WRest3),
    interleave([plant(F1, H1, T1, W1), plant(F2, H2, T2, W2), plant(F3, H3, T3, W3)]),

    % Assign values for Plant 4 and check constraints
    my_select(F4, FRest3, FRest4),
    my_select(H4, HRest3, HRest4),
    my_select(T4, TRest3, TRest4),
    my_select(W4, WRest3, WRest4),
    interleave([plant(F1, H1, T1, W1), plant(F2, H2, T2, W2), plant(F3, H3, T3, W3), plant(F4, H4, T4, W4)]),

    % Assign values for Plant 5 and check constraints
    my_select(F5, FRest4, _),
    my_select(H5, HRest4, _),
    my_select(T5, TRest4, _),
    my_select(W5, WRest4, _),
    interleave([plant(F1, H1, T1, W1), plant(F2, H2, T2, W2), plant(F3, H3, T3, W3), plant(F4, H4, T4, W4), plant(F5, H5, T5, W5)]).

% Predicate to check partial constraints for the current list of plants
interleave(Plants) :-
    check_third(Plants),
    check_fourth(Plants),
    true.

% Constraint: Plants 3, 4, and 5 were not fertilized with either seaweed or bone-meal
check_third(Plants) :-
    check_no_seaweed_or_bone_meal(3, Plants),
    check_no_seaweed_or_bone_meal(4, Plants),
    check_no_seaweed_or_bone_meal(5, Plants).

% Helper predicate to check if a specific plant is not fertilized with seaweed or bone-meal
check_no_seaweed_or_bone_meal(N, Plants) :-
    my_nth1(N, Plants, plant(F, _, _, _)),
    not(my_member(F, [seaweed, bone_meal])).
check_no_seaweed_or_bone_meal(_, _).

% Constraint: The tallest and shortest plants did not produce either the most tomatoes or the heaviest yields
check_fourth(Plants) :-
    my_findall(H, my_member(plant(_, H, _, _), Plants), Heights),
    maxList(Heights, MaxHeight),
    minList(Heights, MinHeight),
    not(my_member(plant(_, MaxHeight, 21, _), Plants)),
    not(my_member(plant(_, MinHeight, 21, _), Plants)),
    not(my_member(plant(_, MaxHeight, _, 19), Plants)),
    not(my_member(plant(_, MinHeight, _, 19), Plants)).

% Custom implementation of my_select
my_select(X, [X | T], T).
my_select(X, [H | T], [H | R]) :- my_select(X, T, R).

% Custom nth1 predicate
my_nth1(1, [H | _], H).
my_nth1(N, [_ | T], Element) :-
    N > 1,
    N1 is N - 1,
    my_nth1(N1, T, Element).

% Custom findall predicate
my_findall(Element, Goal, List) :-
    my_collect_all(Element, Goal, [], List).

my_collect_all(Element, Goal, Acc, List) :-
    my_call(Goal),
    \+ my_member(Element, Acc),
    my_append(Acc, [Element], NewAcc),
    my_collect_all(Element, Goal, NewAcc, List).
my_collect_all(_, _, List, List).

% Custom append
my_append([], List, List).
my_append([Head | Tail], List, [Head | Result]) :-
    my_append(Tail, List, Result).

% Custom member
my_member(Element, [Element | _]).
my_member(Element, [_ | Tail]) :-
    my_member(Element, Tail).

% Custom call
my_call(Goal) :-
    (Goal = my_member(Element, List) -> my_member(Element, List);
     Goal = my_append(List1, List2, Result) -> my_append(List1, List2, Result);
     Goal = my_nth1(Index, List, Element) -> my_nth1(Index, List, Element);
     false).

% solve_and_print predicate
solve_and_print :-
    solve(List),
    write('Solution:'), nl,
    print_plants(List).

% Helper predicate to print the plants
print_plants([]).
print_plants([plant(F, H, T, W) | Rest]) :-
    format('Plant: Fertilizer = ~w, Height = ~w ft, Tomatoes = ~w, Weight = ~w lbs~n', [F, H, T, W]),
    print_plants(Rest).

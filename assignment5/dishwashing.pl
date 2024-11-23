% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Patel, Aditya Kamleshkumar
%%%%% NAME: Osadebe, Osanyem
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: dishwashing_setup
%%%%%
%%%%% These lines allow you to write statements for a predicate that are not consecutive in your program
%%%%% Doing so enables the specification of an initial state in another file
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
:- dynamic holding/2.
:- dynamic numHolding/2.
:- dynamic faucetOn/1.
:- dynamic loc/3.
:- dynamic wet/2.
:- dynamic dirty/2.
:- dynamic soapy/2.
:- dynamic plate/1.
:- dynamic glassware/1.

%%%%% This line loads the generic planner code from the file "planner.pl"
%%%%% Just ensure that that the planner.pl file is in the same directory as this one
:- [planner].

%%%%% SECTION: init_dishwashing
%%%%% Loads the initial state from either dishwashingInit1.pl or dishwashingInit2.pl
%%%%% Just leave whichever one uncommented that you want to test on
%%%%% NOTE, you can only uncomment one at a time
%%%%% HINT: You can create other files with other initial states to more easily test individual actions
%%%%%       To do so, just replace the line below with one loading in the file with your initial state
%:- [dishwashingInit1].
%:- [dishwashingInit2].
:- [dishwashingInit3].

%%%%% SECTION: goal_states_dishwashing
%%%%% Below we define different goal states, each with a different ID
%%%%% HINT: It may be useful to define "easier" goals when starting your program or when debugging
%%%%%       You can do so by adding more goal states below

%% Goal states for dishwashingInit1
goal_state(11, S) :- holding(brush, S), soapy(brush, S).
goal_state(12, S) :- loc(brush, dish_rack, S), loc(sponge, counter, S).
goal_state(13, S) :- not dirty(g1, S), not soapy(g1, S).
goal_state(14, S) :- not dirty(g1, S), not soapy(g1, S), loc(g1, dish_rack, S), not faucetOn(S). 
goal_state(15, S) :- not dirty(g1, S), not soapy(g1, S), loc(g1, dish_rack, S), not soapy(brush, S),
                        loc(brush, dish_rack, S), not faucetOn(S). 

%% Goal states for dishwashingInit2
goal_state(21, S) :- not dirty(p1, S), not soapy(p1, S). 
goal_state(22, S) :- not dirty(p1, S), not soapy(p1, S), loc(p1, dish_rack, S), 
                        not dirty(p2, S), not soapy(p2, S), loc(p2, dish_rack, S).  

%% Goal states for dishwashingInit3
goal_state(31, S) :- not dirty(p1, S), not soapy(p1, S), not dirty(g1, S), not soapy(g1, S),
                        loc(p1, dish_rack, S), loc(g1, dish_rack, S).

%%%%% SECTION: aux_dishwashing
%%%%% Add any additional helpers here, including any additional rules needed for the auxiliary predicates
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
place(counter).
place(dish_rack).

scrubber(sponge).
scrubber(brush).

dish(X) :- glassware(X).
dish(X) :- plate(X).

item(X) :- glassware(X).
item(X) :- plate(X).
item(X) :- scrubber(X).

%%%%% SECTION: precondition_axioms_dishwashing
%%%%% Write precondition axioms for all actions in your domain. Recall that to avoid
%%%%% potential problems with negation in Prolog, you should not start bodies of your
%%%%% rules with negated predicates. Make sure that all variables in a predicate 
%%%%% are instantiated by constants before you apply negation to the predicate that 
%%%%% mentions these variables.

poss(pickUp(X, P), S) :- 
    item(X), 
    numHolding(C, S), C < 2, 
    place(P), loc(X, P, S), 
    not holding(X, S).

poss(putDown(X, P), S) :- 
    item(X), 
    holding(X, S), 
    place(P).

poss(turnOnFaucet, S) :- 
    numHolding(C, S), C < 2, 
    not faucetOn(S).

poss(turnOffFaucet, S) :- 
    numHolding(C, S), C < 2, 
    faucetOn(S).

poss(addSoap(X), S) :- 
    scrubber(X), 
    holding(X, S), 
    numHolding(1, S),
    not soapy(X, S).

poss(scrub(X, Y), S) :- 
    glassware(X), Y = brush, 
    holding(X, S), holding(Y, S), 
    numHolding(2, S),
    dirty(X, S),
    soapy(Y, S), not soapy(X, S).

poss(scrub(X, Y), S) :- 
    plate(X), Y = sponge, 
    holding(X, S), holding(Y, S), 
    numHolding(2, S),
    dirty(X, S),
    soapy(Y, S), not soapy(X, S).

poss(rinse(X), S) :-
    dish(X),
    holding(X, S),
    faucetOn(S),
    soapy(X, S),
    dirty(X, S).

poss(rinse(X), S) :-
    scrubber(X),
    holding(X, S),
    faucetOn(S),
    soapy(X, S).


%%%%% SECTION: successor_state_axioms_dishwashing
%%%%% Write successor-state axioms that characterize how the truth value of all 
%%%%% fluents change from the current situation S to the next situation [A | S]. 
%%%%% You will need two types of rules for each fluent: 
%%%%% 	(a) rules that characterize when a fluent becomes true in the next situation 
%%%%%	as a result of the last action, and
%%%%%	(b) rules that characterize when a fluent remains true in the next situation,
%%%%%	unless the most recent action changes it to false.
%%%%% When you write successor state axioms, you can sometimes start bodies of rules 
%%%%% with negation of a predicate, e.g., with negation of equality. This can help 
%%%%% to make them a bit more efficient.
%%%%%
%%%%% Write your successor state rules here: you have to write brief comments %

holding(X, [pickUp(X, P) | S]).
holding(X, [M | S]) :- not M = putDown(X, P), holding(X, S).

faucetOn([turnOnFaucet | _S]).
faucetOn([M | S]) :- not M = turnOffFaucet, faucetOn(S).

loc(X, P, [putDown(X, P) | _S]).
loc(X, P, [M|S]) :- not M = pickUp(X, P), loc(X, P, S).

wet(X, [rinse(X) | S]).
wet(X, [M | S]) :- dish(X), not M = scrub(X, Y), wet(X, S).
wet(X, [M | S]) :- scrubber(X), not M = addSoap(X), wet(X, S).

dirty(X, [scrub(X, Y) |S]) :- dish(X).
dirty(X, [M |S]) :- dish(X), not M = rinse(X), dirty(X, S).

soapy(X, [scrub(X, Y) | S]) :- dish(X), scrubber(Y).
soapy(X, [addSoap(X) | S]) :- scrubber(X).
soapy(X, [M | S]) :- not M = rinse(X), soapy(X, S).

numHolding(C, [pickUp(_X, _P) | S]) :- numHolding(C2, S), C is C2 + 1.
numHolding(C, [putDown(_X, _P) | S]) :- numHolding(C2, S), C is C2 - 1.
numHolding(C, [M | S]) :- not M = pickUp(_X, _P), not M = putDown(_X, _P), numHolding(C, S).

%%%%% SECTION: declarative_heuristics_dishwashing
%%%%% The predicate useless(A,ListOfPastActions) is true if an action A is useless
%%%%% given the list of previously performed actions. The predicate useless(A,ListOfPastActions)
%%%%% helps to solve the planning problem by providing declarative heuristics to 
%%%%% the planner. If this predicate is correctly defined using a few rules, then it 
%%%%% helps to speed-up the search that your program is doing to find a list of actions
%%%%% that solves a planning problem. Write as many rules that define this predicate
%%%%% as you can: think about useless repetitions you would like to avoid, and about 
%%%%% order of execution (i.e., use common sense properties of the application domain). 
%%%%% Your rules have to be general enough to be applicable to any problem in your domain,
%%%%% in other words, they have to help in solving a planning problem for any instance
%%%%% (i.e., any initial and goal states).
%%%%%	
%%%%% write your rules implementing the predicate  useless(Action, History) here. %

% Picking up an item from a place and immediately placing it back at any place.
useless(putDown(X, P), [pickUp(X, P) | _S]).

% Turning on the faucet and immediately turning it off.
useless(turnOffFaucet, [turnOnFaucet | _S]).

% Adding soap to a scrubber when already soapy.
useless(addSoap(X), S) :- soapy(X, S).

% Picking up a scrubber when already holding another scrubber.
useless(pickUp(X, _P), S) :- scrubber(X), scrubber(Y), holding(Y, S), not X = Y.

% Picking up a dish when already holding another dish.
useless(pickUp(X, _P), S) :- dish(X), dish(Y), holding(Y, S), not X = Y.

% Rinsing already clean items.
useless(rinse(X), S) :- wet(X, S).

% Scrubbing already soapy items.
useless(scrub(X, _Y), S) :- dish(X), soapy(X, S).

% Moving/Picking up items that are already clean i.e. wet.
useless(pickUp(X, _P), S) :- wet(X, S).

% Placing down a soapy, dirty dish down while still holding it.
useless(putDown(X, _P), S) :- dish(X), dirty(X, S), holding(X, S).

% Turning off the faucet too early i.e turning off the faucet when the dish is still dirty.
% useless(turnOffFaucet, S) :- dish(X), dirty(X, S).

% Turning off the faucet too early i.e turning off the faucet when the scrubber is still soapy.
% useless(turnOffFaucet, S) :- scrubber(X), soapy(X, S).

% Picking up a scrubber when no dish is dirty.
useless(pickUp(X, _P), S) :- scrubber(X), not (dish(Y), dirty(Y, S)).
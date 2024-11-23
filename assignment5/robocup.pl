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

%%%%% SECTION: robocup_setup
%%%%%
%%%%% These lines allow you to write statements for a predicate that are not consecutive in your program
%%%%% Doing so enables the specification of an initial state in another file
%%%%% DO NOT MODIFY THE CODE IN THIS SECTION
:- dynamic hasBall/2.
:- dynamic robotLoc/4.
:- dynamic scored/1.

%%%%% This line loads the generic planner code from the file "planner.pl"
%%%%% Just ensure that that the planner.pl file is in the same directory as this one
:- [planner].

%%%%% SECTION: init_robocup
%%%%% Loads the initial state from either robocupInit1.pl or robocupInit2.pl
%%%%% Just leave whichever one uncommented that you want to test on
%%%%% NOTE, you can only uncomment one at a time
%%%%% HINT: You can create other files with other initial states to more easily test individual actions
%%%%%       To do so, just replace the line below with one loading in the file with your initial state
% :- [robocupInit1].
:- [robocupInit2].

%%%%% SECTION: goal_states_robocup
%%%%% Below we define different goal states, each with a different ID
%%%%% HINT: It may be useful to define "easier" goals when starting your program or when debugging
%%%%%       You can do so by adding more goal states below
%%%%% Goal XY should be read as goal Y for problem X

%% Goal states for robocupInit1
goal_state(11, S) :- robotLoc(r1, 0, 1, S).
goal_state(12, S) :- hasBall(r2, S).
goal_state(13, S) :- hasBall(r3, S).
goal_state(14, S) :- scored(S). 
goal_state(15, S) :- robotLoc(r1, 2, 2, S).
goal_state(16, S) :- robotLoc(r1, 3, 2, S).

%% Goal states for robocupInit1
goal_state(21, S) :- scored(S). 
goal_state(22, S) :- robotLoc(r1, 2, 4, S).

%%%%% SECTION: precondition_axioms_robocup
%%%%% Write precondition axioms for all actions in your domain. Recall that to avoid
%%%%% potential problems with negation in Prolog, you should not start bodies of your
%%%%% rules with negated predicates. Make sure that all variables in a predicate 
%%%%% are instantiated by constants before you apply negation to the predicate that 
%%%%% mentions these variables. 

% inBounds(Row, Col) - succeeds if a cell is in bounds (inside the field)
inBounds(Row, Col) :-   numRows(NumOfRows), numCols(NumOfCols), 
                        MaxRow is NumOfRows - 1, MaxCol is NumOfCols - 1,  
                        Row >= 0, Row =< MaxRow, 
                        Col >= 0, Col =< MaxCol.

% adjacent(Row1, Col1, Row2, Col2) - succeeds if 2 cells (Row1, Col1) & (Row2, Col2) are adjacent
adjacent(Row1, Col, Row2, Col) :- Row2 is Row1 + 1, inBounds(Row2, Col).
adjacent(Row1, Col, Row2, Col) :- Row2 is Row1 - 1, inBounds(Row2, Col).
adjacent(Row, Col1, Row, Col2) :- Col2 is Col1 + 1, inBounds(Row, Col2).
adjacent(Row, Col1, Row, Col2) :- Col2 is Col1 - 1, inBounds(Row, Col2).

% validPass(Row1, Col1, Row2, Col2) - succeeds if the path for passing is valid (in the horizontal or vertical direction)
validPass(Row1, Col, Row2, Col) :- inBounds(Row1, Col), inBounds(Row2, Col), clearPath(Row1, Col, Row2, Col).
validPass(Row, Col1, Row, Col2) :- inBounds(Row, Col1), inBounds(Row, Col2), clearPath(Row, Col1, Row, Col2).

% next(Current, Target, Next) - determines the next step in the direction toward Target
next(Current, Target, Next) :- Current < Target, Next is Current + 1. % Moving forward
next(Current, Target, Next) :- Current > Target, Next is Current - 1. % Moving backward

% clearPath(Row1, Col1, Row2, Col2) - succeeds if there are no opponents in a path
clearPath(Row, Col1, Row, Col2) :- Col1 = Col2, not opponentAt(Row, Col1).
clearPath(Row, Col1, Row, Col2) :- not Col1 = Col2, not opponentAt(Row, Col1), next(Col1, Col2, NextCol), clearPath(Row, NextCol, Row, Col2).

clearPath(Row1, Col, Row2, Col) :- Row1 = Row2, not opponentAt(Row1, Col).
clearPath(Row1, Col, Row2, Col) :- not Row1 = Row2, not opponentAt(Row1, Col), next(Row1, Row2, NextRow), clearPath(NextRow, Col, Row2, Col).


poss(move(Robot, Row1, Col1, Row2, Col2), S) :- 
    robot(Robot), % check that Robot is a valid robot
    robotLoc(Robot, Row1, Col1, S), % check that Robot is actually at Row1, Col1
    not opponentAt(Row2, Col2), % check that there's not opponent at the target (Row2, Col2)
    not robotLoc(_, Row2, Col2, S), % check that there's no robot at the target (Row2, Col2)
    adjacent(Row1, Col1, Row2, Col2). % check that the target (Row2, Col2) is adjacent to the starting location (Row1, Col1)

poss(pass(Robot1, Robot2)) :- 
    robot(Robot1), % check that Robot1 is a valid robot
    robot(Robot2), % check that Robot2 is a valid robot
    hasBall(Robot1, S), % check that Robot1 has the ball
    robotLoc(Robot1, Row1, Col1, S), % get the position of Robot1
    robotLoc(Robot2, Row2, Col2, S), % get the position of Robot2
    validPass(Row1, Col1, Row2, Col2). % check that the pass is valid 

poss(shoot(Robot)) :- robot(Robot), hasBall(Robot, S), robotLoc(Robot, Row, Col, S), goalCol(Col), numRows(NumOfRows), MaxRow is NumOfRows - 1, clearPath(Row, Col, MaxRow, Col).




%%%%% SECTION: successor_state_axioms_robocup
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




%%%%% SECTION: declarative_heuristics_robocup
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
%%%%% write your rules implementing the predicate  useless(Action,History) here. %




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
:- [robocupInit1].
% :- [robocupInit2].

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

% inBounds(Row, Col): Succeeds if the given Row and Col are within the field boundaries
inBounds(Row, Col) :-   
    numRows(NumRows), 
    numCols(NumCols),
    LimitR is NumRows - 1,
    LimitC is NumCols - 1,
    Row >= 0, 
    Col >= 0,
    Row =< LimitR,
    Col =< LimitC.

% adjacent(Row1, Col1, Row2, Col2): Succeeds if two cells are adjacent (one step away)
% Four rules for four possible directions: up, down, left, right
adjacent(Row1, Col1, Row2, Col1) :-    % Move up
    Row2 is Row1 + 1,
    inBounds(Row1, Col1),
    inBounds(Row2, Col1).
adjacent(Row1, Col1, Row2, Col1) :-    % Move down
    Row2 is Row1 - 1,
    inBounds(Row1, Col1),
    inBounds(Row2, Col1).
adjacent(Row, Col1, Row, Col2) :-      % Move right
    Col2 is Col1 + 1,
    inBounds(Row, Col1),
    inBounds(Row, Col2).
adjacent(Row, Col1, Row, Col2) :-      % Move left
    Col2 is Col1 - 1,
    inBounds(Row, Col1),
    inBounds(Row, Col2).

% clearPath(Row1, Col1, Row2, Col2): Checks if there's a clear path between two positions
% Base case: same position
clearPath(Row, Col, Row, Col).
% Horizontal movement cases
clearPath(Row, Col1, Row, Col2) :-     % Moving right
    Col1 < Col2,
    not opponentAt(Row, Col1),
    NextCol is Col1 + 1,
    clearPath(Row, NextCol, Row, Col2).
clearPath(Row, Col1, Row, Col2) :-     % Moving left
    Col1 > Col2,
    not opponentAt(Row, Col1),
    NextCol is Col1 - 1,
    clearPath(Row, NextCol, Row, Col2).
% Vertical movement cases
clearPath(Row1, Col, Row2, Col) :-     % Moving up
    Row1 < Row2,
    not opponentAt(Row1, Col),
    NextRow is Row1 + 1,
    clearPath(NextRow, Col, Row2, Col).
clearPath(Row1, Col, Row2, Col) :-     % Moving down
    Row1 > Row2,
    not opponentAt(Row1, Col),
    NextRow is Row1 - 1,
    clearPath(NextRow, Col, Row2, Col).

% validPass(Row1, Col1, Row2, Col2): Checks if a pass is valid between two positions
validPass(Row1, Col1, Row2, Col2) :-   % Horizontal pass
    inBounds(Row1, Col1),
    inBounds(Row2, Col2),
    Row1 = Row2,
    clearPath(Row1, Col1, Row2, Col2).
validPass(Row1, Col1, Row2, Col2) :-   % Vertical pass
    inBounds(Row1, Col1),
    inBounds(Row2, Col2),
    Col1 = Col2,
    clearPath(Row1, Col1, Row2, Col2).

poss(move(Robot, Row1, Col1, Row2, Col2), S) :- 
    robot(Robot),                          % Robot must be valid
    robotLoc(Robot, Row1, Col1, S),        % Robot must be at starting position
    adjacent(Row1, Col1, Row2, Col2),      % Target must be adjacent
    not opponentAt(Row2, Col2),            % Target must not have opponent
    not robotLoc(_, Row2, Col2, S).        % Target must not have another robot
    
% poss(pass(Robot1, Robot2), S): Robot1 can pass ball to Robot2
poss(pass(Robot1, Robot2), S) :- 
    robot(Robot1),                         % Robot1 must be valid 
    robot(Robot2),                         % Robot2 must be valid
    not Robot1 = Robot2,                   % Robots must be different
    hasBall(Robot1, S),                    % Robot1 must have the ball
    robotLoc(Robot1, Row1, Col1, S),       % Get Robot1's position
    robotLoc(Robot2, Row2, Col2, S),       % Get Robot2's position
    validPass(Row1, Col1, Row2, Col2).     % Pass path must be valid
    
% poss(shoot(Robot), S): Robot can shoot at goal
poss(shoot(Robot), S) :- 
    robot(Robot),                          % Robot must be valid
    hasBall(Robot, S),                     % Robot must have the ball
    robotLoc(Robot, Row, Col, S),          % Get robot's position
    goalCol(Col),                          % Must be in goal column
    numRows(NumRows),
    MaxRow is NumRows - 1,                 % Calculate goal row
    clearPath(Row, Col, MaxRow, Col).      % Path to goal must be clear


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

% robotLoc: Updates robot locations after actions
robotLoc(Robot, Row2, Col2, [move(Robot, _, _, Row2, Col2) | _]).   % Robot moves to new location
robotLoc(Robot, Row, Col, [A | S]) :-                               % Robot stays in same location
    not A = move(Robot, Row, Col, _, _),
    robotLoc(Robot, Row, Col, S).

% hasBall: Updates ball possession after actions
hasBall(Robot, [pass(_, Robot) | _]).                               % Robot receives ball
hasBall(Robot, [A | S]) :-                                          % Robot keeps ball
    not A = pass(Robot, _),
    not A = shoot(Robot),
    hasBall(Robot, S).

% scored: Updates goal status after actions
scored([shoot(Robot) | S]) :-                                       % Ball is shot into goal
    hasBall(Robot, S).
scored([_ | S]) :-                                                  % Goal remains scored
    scored(S).                      



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

% Prevent moving back and forth between the same locations
useless(move(Robot, Row1, Col1, Row2, Col2), [move(Robot, Row2, Col2, Row1, Col1) | _]).

% Don't move right after receiving a pass
useless(move(Robot, _, _, _, _), [pass(_, Robot) | _]).

% Don't pass back and forth between the same robots
useless(pass(Robot1, Robot2), [pass(Robot2, Robot1) | _]).

% Don't move to positions with opponents
useless(move(Robot, _, _, Row2, Col2), _) :-
    opponentAt(Row2, Col2).

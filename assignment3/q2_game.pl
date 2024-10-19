% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: 
%%%%% NAME:
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: fourExactly
%%%%% Below, you should define rules for the predicate "fourExactly(X,List)", 
%%%%% which takes in an input List and checks whether there are exactly 4 
%%%%% occurrences of a given element X in the list.
%%%%%
%%%%% If you introduce any other helper predicates for implementing fourExactly,
%%%%% they should be included in this section.
fourExactly(Elem, List) :- count(Elem, List, Count), Count is 4.

count(X, [], 0).
count(X, [H | T], C) :- not X = H, count(X, T, C).
count(X, [X | T], C) :- count(X, T, SubC), C is 1 + SubC.

%%%%% SECTION: gameSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than fourExactly and its helpers) that you choose to introduce.

myMember(X, [X | T]).
myMember(X, [H | T]) :- not X = H, myMember(X, T).

result(n). result(w). result(l). result(d). % n (did not participate), w (win), l (loss), d (draw)

solve(List) :- 
    List = [
        O1, P1, R1, S1, T1,   % Round 1: Oakville (O1), Pickering (P1), Richmond Hill (R1), Scarborough (S1), Toronto (T1)
        O2, P2, R2, S2, T2,   % Round 2: Oakville (O2), Pickering (P2), Richmond Hill (R2), Scarborough (S2), Toronto (T2)
        O3, P3, R3, S3, T3,   % Round 3: Oakville (O3), Pickering (P3), Richmond Hill (R3), Scarborough (S3), Toronto (T3)
        O4, P4, R4, S4, T4,   % Round 4: Oakville (O4), Pickering (P4), Richmond Hill (R4), Scarborough (S4), Toronto (T4)
        O5, P5, R5, S5, T5    % Round 5: Oakville (O5), Pickering (P5), Richmond Hill (R5), Scarborough (S5), Toronto (T5)
    ],

    P1 = l, S1 = w, P2 = w, O2 = l, % Check constraint #1

    % Set variables before checking constraint 2.
    T3 = n, result(T1), result(T2), 
    myMember(w, [T1, T2]), myMember(l, [T1, T2]), % Check constraint #2
    not myMember(d, [T1, T2]),

    % Set variables before checking constraint 3.
    O4 = n, result(O1), result(O3), 
    count(w, [O1, O2, O3], 2), % Check constraint #3
    not myMember(d, [O1, O2, O3]),

    % Set variables before checking constraint 4.
    result(P4), result(R4), result(S4), result(T4), result(O5), result(P5), result(R5), result(S5), result(T5), 
    fourExactly(d, [O4, P4, R4, S4, T4]), fourExactly(d, [O5, P5, R5, S5, T5]), % Check constraint #4
    
    % Set variables before checking constraint 5.
    result(R1), result(R2), result(R3),
    count(w, [R1, R2, R3], 1), count(l, [R1, R2, R3], 1), % Check constraint #5

    % Set variables before checking constraint 6.
    result(S2), result(P3), result(S3),
    not myMember(d, [O1, P1, R1, S1, T1]), not myMember(d, [O2, P2, R2, S2, T2]), not myMember(d, [O3, P3, R3, S3, T3]). % Check constraint #6

solve_and_print :-
    solve([
        O1, P1, R1, S1, T1,   % Round 1: Oakville (O1), Pickering (P1), Richmond Hill (R1), Scarborough (S1), Toronto (T1)
        O2, P2, R2, S2, T2,   % Round 2: Oakville (O2), Pickering (P2), Richmond Hill (R2), Scarborough (S2), Toronto (T2)
        O3, P3, R3, S3, T3,   % Round 3: Oakville (O3), Pickering (P3), Richmond Hill (R3), Scarborough (S3), Toronto (T3)
        O4, P4, R4, S4, T4,   % Round 4: Oakville (O4), Pickering (P4), Richmond Hill (R4), Scarborough (S4), Toronto (T4)
        O5, P5, R5, S5, T5    % Round 5: Oakville (O5), Pickering (P5), Richmond Hill (R5), Scarborough (S5), Toronto (T5)
    ]),
    
    % Print results for each round
    nl, write('Round 1:'), nl,
    write('Oakville: '), write(O1), nl,
    write('Pickering: '), write(P1), nl,
    write('Richmond Hill: '), write(R1), nl,
    write('Scarborough: '), write(S1), nl,
    write('Toronto: '), write(T1), nl,
    
    nl, write('Round 2:'), nl,
    write('Oakville: '), write(O2), nl,
    write('Pickering: '), write(P2), nl,
    write('Richmond Hill: '), write(R2), nl,
    write('Scarborough: '), write(S2), nl,
    write('Toronto: '), write(T2), nl,
    
    nl, write('Round 3:'), nl,
    write('Oakville: '), write(O3), nl,
    write('Pickering: '), write(P3), nl,
    write('Richmond Hill: '), write(R3), nl,
    write('Scarborough: '), write(S3), nl,
    write('Toronto: '), write(T3), nl,
    
    nl, write('Round 4:'), nl,
    write('Oakville: '), write(O4), nl,
    write('Pickering: '), write(P4), nl,
    write('Richmond Hill: '), write(R4), nl,
    write('Scarborough: '), write(S4), nl,
    write('Toronto: '), write(T4), nl,
    
    nl, write('Round 5:'), nl,
    write('Oakville: '), write(O5), nl,
    write('Pickering: '), write(P5), nl,
    write('Richmond Hill: '), write(R5), nl,
    write('Scarborough: '), write(S5), nl,
    write('Toronto: '), write(T5), nl.



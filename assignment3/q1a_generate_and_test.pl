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

%%%%% SECTION: puzzleGenerateAndTest
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%% 
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates that you choose to introduce


myMember(X, [X|T]).
myMember(X, [H | T]) :- not X = H, myMember(X, T).

allDiff([]).
allDiff([H | T]) :- not myMember(H, T), allDiff(T).

dig(0). dig(1). dig(2). dig(3). dig(4). dig(5). dig(6). dig(7). dig(8). dig(9). % domain (digits 0 - 9 inclusive)

solve([J, E, T, A, X, L, O, V]) :-
    dig(J), dig(E), dig(T), dig(A), dig(X), dig(L), dig(O), dig(V),
    not J = 0, not A = 0,
    % Initial Multiplication
    E is (T * X) mod 10,  C1 is (T * X) // 10,
    L is ((E * X) + C1) mod 10, C2 is ((E * X) + C1) // 10,
    X is ((J * X) + C2) mod 10, C3 is ((J * X) + C2) // 10,
    A is C3,
    T is (T * A) mod 10, C4 is (A * T) // 10,
    E is ((E * A) + C4) mod 10, C5 is ((A * E) + C4) // 10,
    J is ((J * A) + C5) mod 10,
    % Addition of the values
    V is (L + T) mod 10, C6 is (L + T) // 10,
    O is (X + E + C6) mod 10, C7 is (X + E + C6) // 10,
    L is (A + J + C7),
    allDiff([J, E, T, A, X, L, O, V]).

solve_and_print :-
    solve([J, E, T, A, X, L, O, V]),
    write('J = '), write(J), nl,
    write('E = '), write(E), nl,
    write('T = '), write(T), nl,
    write('A = '), write(A), nl,
    write('X = '), write(X), nl,
    write('L = '), write(L), nl,
    write('O = '), write(O), nl,
    write('V = '), write(V), nl.
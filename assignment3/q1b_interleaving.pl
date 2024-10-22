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

%%%%% SECTION: puzzleInterleaving
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

solve(List) :-
    List = [J, E, T, A, X, L, O, V],
    % First, we assign values to the digits X and T
    % The choice of X and T first allows us to reduce the solution space early
    dig(X), dig(T),

    % Calculate the result of the first multiplication operation between T and X
    % This limits the possible values for E and carries (CX1)
    E is (X * T) mod 10, CX1 is (X * T) // 10,

    % Now, assign values for E and L, with the multiplication result of E and X
    % Doing this step after calculating E reduces ambiguity by focusing on one multiplication result at a time
    dig(E), dig(L),
    L is ((X * E) + CX1) mod 10, CX2 is ((X * E) + CX1) // 10,

    % Next, assign J and A and proceed with further multiplications
    % This continues to reduce the search space for valid digit assignments
    dig(J), dig(A),
    X is ((X * J) + CX2) mod 10, CX3 is ((X * J) + CX2) // 10,
    A is CX3,  % A is directly determined by the carry CX3

    % Perform further multiplications involving A and T
    % This is essential to build up the product terms used in the final steps
    T is (A * T) mod 10, CY1 is (A * T) // 10,
    E is ((A * E) + CY1) mod 10, CY2 is ((A * E) + CY1) // 10,
    J is ((A * J) + CY2) mod 10, CY3 is ((A * J) + CY2) // 10,

    % Enforce that neither A nor J can be zero since leading digits can't be zero
    A > 0, J > 0,

    % Digits for V and the addition constraints come next
    % This is crucial for narrowing down possibilities using the carry logic
    dig(V),
    C1 is E // 10,
    V is (L + T + C1) mod 10, C2 is (L + T + C1) // 10,

    % Finally, handle the last digit O and complete the addition constraints
    dig(O),
    O is (X + E + C2) mod 10, C3 is (X + E + C2) // 10,

    % The final constraint calculates the last carry addition for L
    L is (A + J + C3),

    % Enforce that all digits are distinct to ensure a valid cryptarithmetic solution
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
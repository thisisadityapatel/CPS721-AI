solve_problem(L) :- reachable(S, L), goal_state(S).
reachable(S, []) :- initial_state(S).
reachable(S1, [M|L]) :- reachable(S, L), legal_move(S1, M, S).

initial_state([x3, x4, x1, f, f]).
goal_state([P, P, P, t, t]).

position(x1). position(x2). position(x3). position(x4).

legal_move([B,L,L,t,f], climb_on,[B,L,L,f,f]).
legal_move(S1,climb_off,S) :- legal_move(S,climb_on,S1).
legal_move([L,L,L,t,t], grab,[L,L,L,t,f]).
legal_move([B,X,L,f,f], go(X),[B,M,L,f,f]) :- position(X), not X=M.
legal_move([B,X,X,f,f], move_box(X),[B,M,M,f,f]) :- position(X), not(X=M).

max_length([],N).
max_length([_|L],N1) :- N1 > 0, N is N1-1, max_length(L,N).


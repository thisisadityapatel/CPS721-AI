initial_state([h, h, t]).
final_state([X, X, X]).

solve_problem(P) :- reachable(S, P), final_state(S).
reachable(S, []) :- initial_state(S).
reachable(S, [M|Rest]) :- reachable(SSub, Rest), legal_move(S, M, SSub).

flip(h, t). flip(t, h).

legal_move([Fnew, S, T], flip_first, [F, S, T]) :- flip(Fnew, F).
legal_move([F, Snew, T], flip_second, [F, S, T]) :- flip(Snew, S).
legal_move([F, S, Tnew], flip_three, [F, S, T]) :- flip(Tnew, T).

max_length([], 0).
max_length([_|T], L) :- max_length(T, SubL), L is SubL + 1.
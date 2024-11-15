solve_problem(L) :- reachable(S, L), goal_state(S).
reachable(S, []) :- goal_state(S).
reachable(S1, [M|L]) :- reachable(S, L), legal_move(S1, M, S).

initial_state([h, h, t]).
goal_state([t, t, t]).
goal_state([h, h, h]).

flip_coin(t, h). flip_coin(h, t).

legal_move([C1new, C2, C3], flip_first_coin, [C1, C2, C3]) :- flip_coin(C1, C1new).
legal_move([C1, C2new, C3], flip_second_coin, [C1, C2, C3]) :- flip_coin(C2, C2new).
legal_move([C1, C2, C3new], flip_third_coin, [C1, C2, C3]) :- flip_coin(C3, C3new).
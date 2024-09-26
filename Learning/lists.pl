members(X, [X|T]).
members(X, [Y|T]) :- not X = Y, members(X, T).

multiple(X, [X|T]).
multiple(X, [Y|T]) :- multiple(X, T).

appendlist([], L, L).
appendlist(L, [], L).
appendlist([H1|T1], L2, [H1|T3]) :- appendlist(T1, L2, T3).

last(X, [X|[]]).
last(X, [H|X]).
last(X, [H|T]) :- last(X, T).

prefix([], L).
prefix([H1|T1], [H2|T2]) :- H1 = H2, prefix(T1, T2).

replaceAll(X, Y, [], []).
replaceAll(X, Y, [X|T1], [Y|T2]) :- replaceAll(X, Y, T1, T2).
replaceAll(X, Y, [H|T1], [H|T2]) :- replaceAll(X, Y, T1, T2).

replaceFirst(X, Y, [], []).
replaceFirst(X, Y, [X|T1], [Y|T1]).
replaceFirst(X, Y, [H|T1], [H|T2]) :- not X = H, replaceFirst(X, Y, T1, T2).

sumlist([], 0).
sumlist([H|T], Sum) :- sumlist(T, NewSum), Sum is NewSum + H.

lengthlist([], 0).
lengthlist([_H|T], Length) :- lengthlist(T, NewLength), Length is NewLength + 1.

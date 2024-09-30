memberlist([Item|_T], Item).
memberlist([H|T], Item) :- not H = Item, memberlist(T, Item).


multiplemember([Item|_T], Item).
multiplemember([H|T], Item) :- multiplemember(T, Item).


appendlist(L, [], L).
appendlist([], L, L).
appendlist([H|T], L2, [H|Tail]) :- appendlist(T, L2, Tail).


lastmember(Item, [Item|[]]).
lastmember(Item, [H|T]) :- lastmember(Item, T).


prefix([], L).
prefix([H|T1], [H|T2]) :- prefix(T1, T2).


replaceFirst(X, Y, [], []).
replaceFirst(X, Y, [X|T], [Y|T]).
replaceFirst(X, Y, [H|T1], [H|T2]) :- replaceFirst(X, Y, T1, T2).


replaceAll(X, Y, [], []).
replaceAll(X, Y, [X|T1], [Y|T2]) :- replaceAll(X, Y, T1, T2).
replaceAll(X, Y, [H|T1], [H|T2]) :- not H = X, replaceAll(X, Y, T1, T2).


sumRecursion([], 0).
sumRecursion([H|T], S) :- sumRecursion(T, SubS), S is SubS + H.


sumCounter(L, S) :- sumAccumulator(L, 0, S).
sumAccumulator([], Acc, Acc).
sumAccumulator([H|T], Acc, S) :- NewAcc is Acc + H, sumAccumulator(T, NewAcc, S).


lengthRecursion([], 0).
lengthRecursion([H|T], L) :- lengthRecursion(T, SubL), L is SubL + 1.


lengthCounter(L, Length) :- lengthAccumulator(L, 0, Length).
lengthAccumulator([], Acc, Acc).
lengthAccumulator([H|T], Acc, Length) :- NewAcc is Acc + 1, lengthAccumulator(T, NewAcc, Length).
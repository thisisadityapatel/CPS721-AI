% using recursion

equalEntries([], [], []).
equalEntries([H|T1], [H|T2], [true|T]) :- equalEntries(T1, T2, T).
equalEntries([H1|T1], [H2|T2], [false|T]) :- not H1 = H2, equalEntries(T1, T2, T).

% using accumulator method

equalacc(L1, L2, List) :- acc(L1, L2, [], List).

acc([], [], List, List).
acc([H|T1], [H|T2], Acc, List) :-
    appendlist(Acc, [true], NewAcc),
    acc(T1, T2, NewAcc, List).
acc([H1|T1], [H2|T2], Acc, List) :-
    not H1 = H2,
    appendlist(Acc, [false], NewAcc),
    acc(T1, T2, NewAcc, List).

% append two lists

appendlist([], L, L).
appendlist(L, [], L).
appendlist([H|T], L, [H|Tail]) :- appendlist(T, L, Tail).

% alt + - using recursion

alternatePlusMinusRec([H|T], S) :-
    alternatePlusRec(T, SubS),
    S is SubS + H.

alternatePlusRec([], 0).
alternatePlusRec([H|T], S) :-
    alternateMinusRec(T, SubSum),
    S is SubSum - H.

alternateMinusRec([], 0).
alternateMinusRec([H|T], S) :-
    alternatePlusRec(T, SubSum),
    S is SubSum - H.

alternateMinus([], 0).

% alt + - using accumulator

alternatePlusMinus([H|T], S) :-
    alternatePlus(T, H, S).

alternatePlus([], S, S).
alternatePlus([H|T], Acc, S) :-
    NewAcc is Acc + H,
    alternateMinus(T, NewAcc, S).

alternateMinus([], S, S).
alternateMinus([H|T], Acc, S) :-
    NewAcc is Acc - H,
    alternatePlus(T, NewAcc, S).

% find the nested depth of the item

nestedFindDepth([Item|_T], Item, 0).
nestedFindDepth([H|_T], Item, D) :-
    not H = Item,
    is_list(H),
    nestedFindDepth(H, Item, SubD),
    D is SubD + 1.
nestedFindDepth([H|T], Item, D) :-
    not H = Item,
    nestedFindDepth(T, Item, D).
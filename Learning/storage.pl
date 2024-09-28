containsItem([Item|_], Item).
containsItem([H|T], Item) :- not H = Item, is_list(H), containsItem(H, Item).
containsItem([H|T], Item) :- not H = Item, containsItem(T, Item).

findIndex([Item|_], Item, Acc, Acc).
findIndex([H|T], Item, Acc, Acc) :- not H = Item, containsItem(H, Item).
findIndex([H|T], Item, Acc, Index) :- not H = Item, not containsItem(H, Item), NewAcc is Acc + 1, findIndex(T, Item, NewAcc, Index).

nestedFindIndex(List, Item, Depth, Index) :-
    nestedFindDepth(List, Item, Depth),
    findIndex(List, Item, 0, Index).

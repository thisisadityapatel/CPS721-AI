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
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%

%%%%% SECTION: nestedLists
%%%%% Put your rules for nestedFindDepth, nestedFindIndex, and any helper predicates below

nestedFindDepth([Item|T], Item, 0).
nestedFindDepth([H|T], Item, D) :- 
    not H = Item, 
    is_list(H), 
    nestedFindDepth(H, Item, SubD), 
    D is SubD + 1.

nestedFindDepth([H|T], Item, D) :- 
    not H = Item, 
    nestedFindDepth(T, Item, D).

nestedFindIndex(List, Item, Depth, Index) :- 
    nestedFindIndexAccumulator(List, Item, 0, Depth, 0, Index).

nestedFindIndexAccumulator([Item|_], Item, DepthAcc, DepthAcc, IndexAcc, IndexAcc).
nestedFindIndexAccumulator([H|T], Item, DepthAcc, Depth, IndexAcc, Index) :-
    not H = Item,
    is_list(H),
    NewDepthAcc is DepthAcc + 1,
    nestedFindIndexAccumulator(H, Item, NewDepthAcc, Depth, IndexAcc, Index).

nestedFindIndexAccumulator([H|T], Item, DepthAcc, Depth, IndexAcc, Index) :-
    not H = Item,
    not is_list(H),
    nestedFindIndexAccumulator(T, Item, DepthAcc, Depth, IndexAcc, Index).

nestedFindIndexAccumulator([H|T], Item, 0, Depth, IndexAcc, Index) :-
    NewIndexAcc is IndexAcc + 1,
    nestedFindIndexAccumulator(T, Item, 0, Depth, NewIndexAcc, Index).
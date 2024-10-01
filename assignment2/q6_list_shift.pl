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

%%%%% SECTION: listShift
%%%%% Put your rules for listShift and any helper predicates below

listShift(List, 0, List).
listShift(List, ShiftLength, List) :-
    listLength(List, Length),
    ShiftLength >= Length.
    
listShift(next(H, T), ShiftLength, Result) :-
    ShiftLength > 0,
    listLength(next(H, T), Length),
    not ShiftLength >= Length,
    SubShiftLength is ShiftLength - 1,
    appendRight(T, H, SubList),
    listShift(SubList, SubShiftLength, Result).

appendRight(nil, Element, next(Element, nil)).
appendRight(next(Head, T1), Element, next(Head, T2)) :-
    appendRight(T1, Element, T2).

listLength(nil, 0).
listLength(next(_H, T), L) :-
    listLength(T, SubL),
    L is SubL + 1.
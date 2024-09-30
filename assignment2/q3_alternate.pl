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

%%%%% SECTION: alternatePlusMinus
%%%%% Put your rules for alternatePlusMinus and any helper predicates below

alternatePlusMinus([], 0).
alternatePlusMinus([H|T], O) :- alternatePlus(T, Output), O is Output + H. 

alternatePlus([], 0).
alternatePlus([H|T], Sum) :- alternateMinus(T, Diff), Sum is Diff + H.

alternateMinus([], 0).
alternateMinus([H|T], Diff) :- alternatePlus(T, Sum), Diff is Sum - H.
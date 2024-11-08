
% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Patel, Aditya Kamleshkumar 
%%%%% NAME: Osadebe, Osanyem
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%


%%%%% SECTION: database
%%%%% Put statements for account, created, lives, location and gender below

account(12, ann, metro_credit_union, 4505).
account(13, robert, royal_bank_of_canada, 10910).
account(14, philip, cibc, 900).
account(18, philip, cibc, 1500).
account(15, sarah, cibc, 32000).
account(16, john, bank_of_montreal, 800).
account(17, downy, morgan_stanley, 20000).

created(12, ann, metro_credit_union, 8, 2023).
created(13, robert, royal_bank_of_canada, 6, 2024).
created(14, philip, cibc, 4, 2024).
created(18, philip, cibc, 11, 2002).
created(15, sarah, cibc, 5, 2022).
created(16, john, bank_of_montreal, 3, 2024).
created(17, downy, morgan_stanley, 2, 2002).

location(scarborough, canada).
location(markham, canada).
location(toronto, canada).
location(richmond_hill, canada).
location(new_york, usa).
location(san_francisco, usa).
location(boston, usa).

location(bank_of_montreal, toronto).
location(royal_bank_of_canada, toronto).
location(cibc, toronto).
location(metro_credit_union, markham).
location(morgan_stanley, new_york).
location(chase, boston).

lives(philip, richmond_hill).
lives(ann, markham).
lives(john, scarborough).
lives(sarah, toronto).
lives(robert, richmond_hill).
lives(downy, new_york).

gender(philip, man).
gender(ann, woman).
gender(robert, man).
gender(sarah, woman).
gender(john, man).
gender(downy, man).

%%%%% SECTION: lexicon
%%%%% Put the rules/statements defining articles, adjectives, proper nouns, common nouns,
%%%%% and prepositions in this section.
%%%%% You should also put your lexicon helpers in this section
%%%%% Your helpers should include at least the following:
%%%%%       bank(X), person(X), man(X), woman(X), city(X), country(X)
%%%%% You may introduce others as you see fit
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section

country(Country) :- location(_, City), location(City, Country).
bank(Bank) :- location(Bank, City), location(City, Country).
city(City) :- location(City, Country), not bank(City).
person(Person) :- account(_, X, _, _).
person(Person) :- lives(Person, _).
man(Man) :- gender(Man, man).
woman(Woman) :- gender(Woman, woman).

%%%%% SECTION: parser
%%%%% For testing your lexicon for question 3, we will use the default parser initially given to you.
%%%%% ALL QUERIES IN QUESTION 3 and 4 SHOULD WORK WHEN USING THE DEFAULT PARSER
%%%%% For testing your answers for question 5, we will use your parser below
%%%%% You may include helper predicates for Question 5 here, but they
%%%%% should not be needed for Question 3
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section

article(a).
article(an).
article(the).
article(any).

common_noun(bank, X) :- bank(X).
common_noun(city, X) :- city(X).
common_noun(country, X) :- country(X).
common_noun(man, X) :- man(X).
common_noun(woman, X) :- woman(X).
common_noun(owner, X) :- account(_AccID, X, _Bank, _Amount).
common_noun(person, X) :- person(X).
common_noun(account, X) :- account(X, _Name, _Bank, _Amount).
common_noun(balance, X) :- account(_AccountID, _Name, _Bank, X).

proper_noun(X) :- person(X).
proper_noun(X) :- bank(X).
proper_noun(X) :- country(X).
proper_noun(X) :- city(X).
proper_noun(X) :- account(X, _Name, _Bank, _Amount).

%% Adjective
%% ---------

adjective(male, Person) :- man(Person).
adjective(female, Person) :- woman(Person).

adjective(small, X) :- account(X, _Name, _Bank, Amount), Amount < 1000.
adjective(large, X) :- account(X, _Name, _Bank, Amount), Amount > 10000.
adjective(medium, X) :- account(X, _Name, _Bank, Amount), Amount > 1000, Amount < 10000.

adjective(new, X) :- created(X, _Name, _Bank, _Month, 2024).
adjective(old, X) :- created(X, _Name, _Bank, _Month, Year), Year < 2024.

adjective(canadian, City) :- location(City, canada).
adjective(canadian, Bank) :- location(Bank, City), location(City, canada).
adjective(canadian, Person) :- lives(Person, City), location(City, canada).
adjective(canadian, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, canada).

adjective(american, City) :- location(City, usa).
adjective(american, Bank) :- location(Bank, City), location(City, usa).
adjective(american, Person) :- lives(Person, City), location(City, usa).
adjective(american, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, usa).

adjective(local, Bank) :- location(Bank, City), location(City, canada).
adjective(local, Person) :- lives(Person, City), location(City, canada).
adjective(local, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, canada).
adjective(local, City) :- location(City, canada).

adjective(foreign, Bank) :- location(Bank, City), location(City, Country), not Country = canada.
adjective(foreign, Person) :- lives(Person, City), location(City, Country), not Country = canada.
adjective(foreign, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, Country), not Country = canada.
adjective(foreign, City) :- location(City, Country), not Country = canada.

%% Preposition
%% -----------

preposition(of, Person, Account) :- account(Account, Person, _Bank, _Amount).

preposition(from, Person, City) :- lives(Person, City).
preposition(from, Person, Country) :- lives(Person, City), location(City, Country), country(Country).
preposition(from, Bank, City) :- location(Bank, City).
preposition(from, Bank, Country) :- location(Bank, City), location(City, Country), country(Country).

preposition(in, Person, City) :- lives(Person, City).
preposition(in, Person, Country) :- lives(X, City), location(City, Country), country(Country).
preposition(in, Person, Bank) :- account(_Account, Person, Bank, _Amount).
preposition(in, Bank, City) :- location(Bank, City).
preposition(in, Bank, Country) :- location(Bank, City), location(City, Country), country(Country).
preposition(in, City, Country) :- location(X, Country), country(Country).
preposition(in, Account, Bank) :- account(Account, _Name, Bank, _Amount).
preposition(in, Amount, Account) :- account(Account, _Person, _Bank, Amount).
preposition(in, Year, Account) :- created(Account, _Name, _Bank, _Month, Year).
preposition(in, Month, Account) :- created(Account, _Name, _Bank, Month, _Year).


what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], What) :- article(Art), np2(Rest, What).


/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

np2([Adj|Rest],What) :- adjective(Adj, What), np2(Rest, What).
np2([Noun|Rest], What) :- common_noun(Noun, What), mods(Rest,What).

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, What) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, What), mods(End, What).

prepPhrase([Prep | Rest], What) :-
	preposition(Prep, What, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H | L1], L2, [H | L3]) :-  appendLists(L1, L2, L3).
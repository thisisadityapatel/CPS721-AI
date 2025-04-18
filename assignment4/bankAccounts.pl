
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
account(13, robert, rbc, 10910).
account(14, philip, cibc, 900).
account(15, sarah, cibc, 32000).
account(16, john, bmo, 800).
account(17, downy, morgan_stanley, 20000).
account(18, philip, cibc, 1500).
account(19, thor, chase, 50000).
account(20, david, rbc, 800).
account(21, ann, chase, 200).
account(22, david, bmo, 8000).
account(23, jarvis, squarepoint, 80000).
account(24, sam, squarepoint, 100000).
account(25, ann, cibc, 34000).

created(12, ann, metro_credit_union, 8, 2023).
created(13, robert, rbc, 6, 2024).
created(14, philip, cibc, 4, 2024).
created(15, sarah, cibc, 5, 2022).
created(16, john, bmo, 3, 2024).
created(17, downy, morgan_stanley, 2, 2002).
created(18, philip, cibc, 11, 2002).
created(19, thor, chase, 2, 2006).
created(20, david, rbc, 5, 1990).
created(21, ann, chase, 7, 2020).
created(22, david, bmo, 4, 2002).
created(23, jarvis, squarepoint, 4, 2020).
created(24, sam, squarepoint, 4, 2020).
created(25, ann, cibc, 12, 2008).

location(scarborough, canada).
location(markham, canada).
location(toronto, canada).
location(richmond_hill, canada).
location(new_york, usa).
location(san_francisco, usa).
location(boston, usa).
location(losAngeles, usa).
location(london, britain).

location(bmo, toronto).
location(rbc, toronto).
location(cibc, toronto).
location(metro_credit_union, markham).
location(morgan_stanley, new_york).
location(chase, boston).
location(squarepoint, london).

lives(philip, richmond_hill).
lives(ann, markham).
lives(john, scarborough).
lives(sarah, toronto).
lives(robert, richmond_hill).
lives(downy, new_york).
lives(thor, san_francisco).
lives(david, losAngeles).
lives(jarvis, london).
lives(sam, london).

gender(philip, man).
gender(ann, woman).
gender(robert, man).
gender(sarah, woman).
gender(john, man).
gender(downy, woman).
gender(thor, man).
gender(david, man).
gender(jarvis, man).
gender(sam, man).

%%%%% SECTION: lexicon
%%%%% Put the rules/statements defining articles, adjectives, proper nouns, common nouns,
%%%%% and prepositions in this section.
%%%%% You should also put your lexicon helpers in this section
%%%%% Your helpers should include at least the following:
%%%%%       bank(X), person(X), man(X), woman(X), city(X), country(X)
%%%%% You may introduce others as you see fit
%%%%% DO NOT INCLUDE ANY statements for account, created, lives, location and gender 
%%%%%     in this section

bank(Bank) :- location(Bank, City), location(City, _).
city(City) :- location(City, _), not bank(City).
country(Country) :- location(City, Country), not bank(City).
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

%% Articles
%% ---------

article(a).
article(an).
article(the).
article(any).

%% Common Nouns
%% ------------

common_noun(bank, X) :- bank(X).
common_noun(city, X) :- city(X).
common_noun(country, X) :- country(X).
common_noun(man, X) :- man(X).
common_noun(woman, X) :- woman(X).
common_noun(owner, X) :- account(_AccID, X, _Bank, _Amount).
common_noun(person, X) :- person(X).
common_noun(account, X) :- account(X, _Name, _Bank, _Amount).
common_noun(balance, X) :- account(_AccountID, _Name, _Bank, X).
common_noun(american, X) :- lives(X, City), location(City, usa).
common_noun(canadian, X) :- lives(X, City), location(City, canada).
common_noun(british, X) :- lives(X, City), location(City, britain).

%% Proper Nouns
%% ------------

proper_noun(Person) :- person(Person).
proper_noun(Bank) :- bank(Bank).
proper_noun(Country) :- country(Country).
proper_noun(City) :- city(City).
proper_noun(Account) :- account(Account, _Name, _Bank, _Amount).

%% Adjectives
%% ----------

adjective(male, Person) :- man(Person).
adjective(female, Person) :- woman(Person).

adjective(small, Account) :- account(Account, _Name, _Bank, Amount), Amount < 1000.
adjective(large, Account) :- account(Account, _Name, _Bank, Amount), Amount > 10000.
adjective(medium, Account) :- account(Account, _Name, _Bank, Amount), Amount >= 1000, Amount =< 10000.
adjective(new, Account) :- created(Account, _Name, _Bank, _Month, Year), Year = 2024.
adjective(old, Account) :- created(Account, _Name, _Bank, _Month, Year), Year < 2024.

adjective(canadian, City) :- city(City), location(City, canada).
adjective(canadian, Bank) :- bank(Bank), location(Bank, City), location(City, canada).
adjective(canadian, Person) :- lives(Person, City), location(City, canada), city(City).
adjective(canadian, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, canada).

adjective(american, City) :- city(City), location(City, usa).
adjective(american, Bank) :- bank(Bank), location(Bank, City), location(City, usa).
adjective(american, Person) :- lives(Person, City), location(City, usa), city(City).
adjective(american, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, usa).

adjective(british, City) :- city(City), location(City, britain).
adjective(british, Bank) :- bank(Bank), location(Bank, City), location(City, britain).
adjective(british, Person) :- lives(Person, City), location(City, britain), city(City).
adjective(british, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, britain).

adjective(local, City) :- city(City), location(City, canada).
adjective(local, Bank) :- bank(Bank), location(Bank, City), location(City, canada).
adjective(local, Person) :- lives(Person, City), location(City, canada), city(City).
adjective(local, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, canada).

adjective(foreign, City) :- city(City), location(City, Country), not Country = canada.
adjective(foreign, Bank) :- bank(Bank), location(Bank, City), location(City, Country), not Country = canada.
adjective(foreign, Person) :- lives(Person, City), location(City, Country), city(City), not Country = canada.
adjective(foreign, Account) :- account(Account, _Name, Bank, _Amount), location(Bank, City), location(City, Country), not Country = canada.

%% Prepositions
%% ------------

preposition(of, Account, Person) :- account(Account, Person, _Bank, _Amount).
preposition(of, Owner, Account) :- account(Account, Owner, _Bank, _Amount).
preposition(of, Balance, Account) :- account(Account, _Person, _Bank, Balance).

preposition(from, Person, City) :- lives(Person, City).
preposition(from, Person, Country) :- lives(Person, City), location(City, Country).
% city from country or bank from city.
preposition(from, X, Y) :- location(X, Y).
preposition(from, Bank, Country) :- location(Bank, City), location(City, Country).

preposition(in, Person, City) :- lives(Person, City).
preposition(in, Person, Country) :- lives(Person, City), location(City, Country).
preposition(in, Person, Bank) :- account(_Account, Person, Bank, _Amount).
% bank in city or city in country
preposition(in, X, Y) :- location(X, Y).
preposition(in, Bank, Country) :- location(Bank, City), location(City, Country).
preposition(in, Account, Bank) :- account(Account, _Name, Bank, _Amount).
preposition(in, Account, Year) :- created(Account, _Name, _Bank, _Month, Year).
preposition(in, Account, Month) :- created(Account, _Name, _Bank, Month, _Year).
preposition(in, Amount, Account) :- account(Account, _Person, _Bank, Amount).

preposition(with, Person, Bank) :- account(_AccountID, Person, Bank, _Amount).
preposition(with, Account, Bank) :- account(Account, _Person, Bank, _Amount).
preposition(with, Bank, Account) :- account(Account, _Person, Bank, _Amount).
preposition(with, Person, Account) :- account(Account, Person, _Bank, _Amount).
preposition(with, Account, Person) :- account(Account, Person, _Bank, _Amount).

what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art | Rest], What) :- article(Art), not Art = the, np2(Rest, What).
np([the | Rest], What) :- np3(Rest, What).

/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

np2([Adj | Rest], What) :- adjective(Adj, What), np2(Rest, What).
np2([Noun | Rest], What) :- common_noun(Noun, What), mods(Rest, What).

np3([largest | Rest], What) :-
   findall(What, np2(Rest, What), List),
   largest_account_by_balance(List, What).

np3([oldest | Rest], What) :-
   findall(What, np2(Rest, What), List),
   oldest_account_by_date(List, What).

np3(Words, What) :-
   findall(What, np2(Words, What), List),
   length(List, 1),
   List = [What].

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).

mods(Words, What) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, What), mods(End, What).

mods([between, Min, and, Max | Rest], Balance) :-
   number(Min), number(Max),
   Min =< Max,
   Balance >= Min, Balance =< Max,
   mods(Rest, Balance).

prepPhrase([Prep | Rest], What) :-
	preposition(Prep, What, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H | L1], L2, [H | L3]) :-  appendLists(L1, L2, L3).


%% Program Utility Functions
%% -------------------------

older(_Month1, Year1, _Month2, Year2) :- Year1 < Year2.

older(Month1, Year1, Month2, Year2) :- Year1 = Year2, Month1 < Month2.

largest_account_by_balance([AccountID], AccountID).

largest_account_by_balance([AccountID1, AccountID2 | Tail], Result) :-
   account(AccountID1, _, _, Amount1),
   account(AccountID2, _, _, Amount2),
   Amount1 > Amount2,
   largest_account_by_balance([AccountID1 | Tail], Result).

largest_account_by_balance([AccountID1, AccountID2 | Tail], Result) :-
   account(AccountID1, _, _, Amount1),
   account(AccountID2, _, _, Amount2),
   Amount1 =< Amount2,
   largest_account_by_balance([AccountID2 | Tail], Result).

oldest_account_by_date([AccountID], AccountID).

oldest_account_by_date([AccountID1, AccountID2 | Tail], Result) :-
   created(AccountID1, _, _, Month1, Year1),
   created(AccountID2, _, _, Month2, Year2),
   older(Month1, Year1, Month2, Year2),
   oldest_account_by_date([AccountID1 | Tail], Result).

oldest_account_by_date([AccountID1, AccountID2 | Tail], Result) :-
   created(AccountID1, _, _, Month1, Year1),
   created(AccountID2, _, _, Month2, Year2),
   not older(Month1, Year1, Month2, Year2),
   oldest_account_by_date([AccountID2 | Tail], Result).
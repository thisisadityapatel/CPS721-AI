
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

%%%%% SECTION: q2_kb
%%%%% You should put the atomic statements in your KB below in this section

hasAccount(barry, cibc, 1500).
hasAccount(barry, bmo, 800).
hasAccount(eren, cibc, 2000).
hasAccount(eren, bmo, 300).

totalDeposits(barry, cibc, 500).
totalDeposits(barry, bmo, 200).
totalDeposits(eren, cibc, 100).
totalDeposits(eren, bmo, 50).

totalWithdrawals(barry, cibc, 100).
totalWithdrawals(barry, bmo, 150).
totalWithdrawals(eren, cibc, 300).
totalWithdrawals(eren, bmo, 200).

monthlyRate(cibc, 0.005).
monthlyRate(bmo, 0.003).

interestLevel(cibc, 1000).
interestLevel(bmo, 1500).

penalty(cibc, 50).
penalty(bmo, 75).

%%%%% SECTION: q2_rules
%%%%% Put statements for subtotal, accruedInterest, accruedPenalty, and endOfMonthBalance below.
%%%%% You may also put helper predicates here
%%%%% DO NOT PUT ATOMIC FACTS FOR hasAccount, totalDeposits, totalWithdrawals, monthlyRate, interestRate, or penalty below.

subtotal(Name, Bank, Subtotal) :- 
    hasAccount(Name, Bank, Balance),
    totalDeposits(Name, Bank, Deposits),
    totalWithdrawals(Name, Bank, Withdrawals),
    Subtotal is Balance + Deposits - Withdrawals.

accruedInterest(Name, Bank, Interest) :-
    subtotal(Name, Bank, Subtotal),
    interestLevel(Bank, MinLevel),
    monthlyRate(Bank, Rate),
    Subtotal >= MinLevel,
    Interest is Subtotal * Rate.

accruedInterest(Name, Bank, 0) :-
    subtotal(Name, Bank, Subtotal),
    interestLevel(Bank, MinLevel),
    Subtotal < MinLevel.

accruedPenalty(Name, Bank, Penalty) :-
    subtotal(Name, Bank, Subtotal),
    Subtotal < 0,
    penalty(Bank, Penalty).

accruedPenalty(Name, Bank, 0) :-
    subtotal(Name, Bank, Subtotal),
    Subtotal >= 0.

endOfMonthBalance(Name, Bank, Balance) :-
    subtotal(Name, Bank, Subtotal),
    accruedInterest(Name, Bank, I),
    accruedPenalty(Name, Bank, P),
    Balance is Subtotal + I - P.

endOfMonthBalance(Name, Balance) :- 
    endOfMonthBalance(Name, cibc, TotalCIBC),
    endOfMonthBalance(Name, bmo, TotalBMO),
    Balance is TotalCIBC + TotalBMO.

    
%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW

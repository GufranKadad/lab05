
% ---------- MALE FACTS ----------

male(abraham).
male(clancy).
male(herb).
male(homer).
male(bart).

% ---------- FEMALE FACTS ----------

female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).

% ---------- PARENT FACTS ----------
% parent(Parent, Child).

parent(abraham, herb).
parent(abraham, homer).
parent(mona, herb).
parent(mona, homer).

parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).

parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).

parent(selma, ling).

% ---------- RULES ----------
% Each relation describes the FIRST person
% in relation to the SECOND person.

father(X, Y) :-
    male(X),
    parent(X, Y).

mother(X, Y) :-
    female(X),
    parent(X, Y).

son(X, Y) :-
    male(X),
    parent(Y, X).

daughter(X, Y) :-
    female(X),
    parent(Y, X).

% Helper: siblings share at least one parent.
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    dif(X, Y).

brother(X, Y) :-
    male(X),
    sibling(X, Y).

sister(X, Y) :-
    female(X),
    sibling(X, Y).

grandfather(X, Y) :-
    male(X),
    parent(X, P),
    parent(P, Y).

% Aunt and uncle through a parent's sibling.
aunt(X, Y) :-
    sister(X, P),
    parent(P, Y).

uncle(X, Y) :-
    brother(X, P),
    parent(P, Y).

cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2).

% Base case: a parent is an ancestor.
ancestor(X, Y) :-
    parent(X, Y).

% Recursive case: follow successive parent links.
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

/*

TEST QUERIES AND OUTPUT


30 ?- father(homer, bart).
true.

31 ?- father(clancy, marge).
true.

32 ?- mother(marge, lisa).
true.

33 ?- mother(selma, ling).
true.

34 ?- son(bart, homer).
true.

35 ?- son(homer, abraham).
true.

36 ?- daughter(lisa, marge).
true.

37 ?- daughter(ling, selma).
true.

38 ?- brother(bart, lisa).
true 
% Break level 1
[1] 39 ?- rother(herb, homer).
Correct to: "brother(herb,homer)"? 
Please answer 'y' or 'n'? yes
true .

[1] 40 ?- sister(lisa, bart).
true .

[1] 41 ?- sister(patty, marge).
true .

[1] 42 ?- grandfather(abraham, bart).
true.

[1] 43 ?- grandfather(clancy, ling).
true.

[1] 44 ?- aunt(patty, bart).
true .
[1] 45 ?- aunt(marge, ling).
true .

[1] 46 ?- uncle(herb, bart).
true .

[1] 47 ?- uncle(herb, maggie).
true .

[1] 48 ?- cousin(bart, ling).
true .

[1] 49 ?- cousin(lisa, ling).
true .

[1] 50 ?- ancestor(abraham, homer).
true .

[1] 51 ?- ancestor(jackie, maggie).
true 
*/

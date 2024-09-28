# Team
- Patel, Aditya Kamleshkumar
- Bhandal, Arjun
- Osadebe, Osanyem

## Answer A.
[X, Y | Z] and [a, b, c | [d, e, Y]]

Yes, they match with:-  
Y = b  
X = a  
Z = [c, d, e, b]

Explaination :-  
[a, b, c | [d, e, Y]]  
-> [a, b, c, d, e, Y]  
-> [a, b | [c, d, e, Y]] = [X, Y | Z]

## Answer B.
[q, [A | [r, s] ], t] and [q, [r, [r, s] ] | B]

No, they would not match.  

Explaination :-  
[q, [A | [r, s] ], t]  
 -> [q, [A, r, s], t]  
 -> [q, [A, r, s] | [t]]
 which is not equal to [q, [r, [r, s] ] | B]

## Answer C.
[ [Cow | [cat, dog] ], bird, bug, chicken ] and [ [ant, [cat, dog] ] | Horse]

Explaination :-  
Simplifying [[Cow|[cat, dog] ], bird, bug, chicken]  
-> [[Cow, cat, dog], bird, bug, chicken]  
-> [[Cow, cat, dog]|[bird, bug, chicken]]  

Hence since the first array has does not have [cat, dog] element, its not equal.

## Answer D.
[1, A, 2 | [A, 3, 4] ] and [B | [2, C | [D | E ] ] ]

Yes they are equal.
A = 2
B = 1
C = 2
D = 2
E = [3, 4]

Explaination :-  
[1, A, 2 | [A, 3, 4] ]  
-> [1, A, 2, A, 3, 4 ]  
-> [1, A, 2, A | [3, 4]]  
-> [1, A, 2, [ A | [3, 4]]]  
-> [1 | [A, 2, [ A | [3, 4]]]]  

Hence it compares to the form of [B | [2, C | [D | E ] ] ]

## Answer E.
[A | [ A | [ [ A | [ [A] ] ] ] ] ] and [b | C]

Yes, they are equal.
A = b
C = [b, [b, [b]]]

## Answer F.
[X | [Y | [ Z | [X] ] ] ] and [all, around, the, world, Y]  

No, they are not equal.

Explaination :-  
Simplifying [X | [Y | [ Z | [X] ] ] ]  
-> [X | [Y | [Z, X]]]  
-> [X | [Y , Z, X]].
-> [X, Y, Z, X].

Comparing it with [all, around, the world, Y], clearly signifies that they are not equal.


## Answer G.

Yes, this would work with the following variable bindings:

- X = []
- Y = []
- Z = [[[]]]
- Q = 1
- R = 2
- S = []

Simplifying the lists:  

1. Simplifying `[1, 2 | [ X | [ Y, Z | X] ] ]`:
    -> [1, 2 | [ [] | [ [], [[[]]] | []] ] ]  
    -> [1, 2, [] | [ [], [[[]]] | []] ]  
    -> [1, 2, [], [] | [ [[[]]] | []] ]  
    -> [1, 2, [], [], [[[]]] | [] ]  
    -> [1, 2, [], [], [[[]]], []]  

2. Simplifying `[Q | [R, S, [], [[Y]]]]`:
    -> [1 | [2, [], [], [[[]]]]]  
    -> [1, 2 | [[], [], [[[]]]]]  
    -> [1, 2, [] | [[], [[[]]]]]  
    -> [1, 2, [], [] | [[[[]]]]]  
    -> [1, 2, [], [], [[[]]]]  

## Answer H.

[Lions, [[and], tigers], [and], bears, oh | [[my]] ] and [[I, have], [[A], Bad], Feeling | [About | This] ]

Yes, they would be equal.
Lions = [I, have]
I = I
A = and
Bad = tigers
Feeling = [and]
About = bears
This = [oh, [my]]

Simplifying the lists:  

1. Simplifying `[Lions, [[and], tigers], [and], bears, oh | [[my]]]`:
    -> [Lions | [[[and], tigers], [and], bears, oh | [[my]]]]  
    -> [Lions, [[and], tigers] | [[and], bears, oh | [[my]]]]  
    -> [Lions, [[and], tigers], [and] | [bears, oh | [[my]]]]  
    -> [Lions, [[and], tigers], [and], bears | [oh | [[my]]]]  
    -> [Lions, [[and], tigers], [and], bears, oh | [[my]]]  

2. Simplifying `[[I, have], [[A], Bad], Feeling | [About | This]]`:
    -> [[I, have] | [[[A], Bad], Feeling | [About | This]]]  
    -> [[I, have], [[A], Bad] | [Feeling, About | [This]]]  
    -> [[I, have], [[A], Bad], Feeling | [About | [This]]]  
    -> [[I, have], [[A], Bad], Feeling, About | [This]]  
    -> [[I, have], [[A], Bad], Feeling, About, This]  

Hence the two forms are equal.


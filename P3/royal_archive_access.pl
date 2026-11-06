:- initialization(prove).

% Step 1: Predicate logic representation

% Predicates:
% archivist(X)       - X is an archivist
% verifies(X,R)      - X verifies record R
% trusted(X)         - X is trusted
% access(X,R)        - X has access to record R
% permitted(X,R)     - X is permitted to inspect record R
% inspects(X,R)      - X inspects record R
% finds_mark(X,R)    - X finds a hidden mark in record R
% stored(R)          - R is stored in the royal archive
% sealed(R)          - R is a sealed record

% Constants:
% mira, scroll_7

% Variables:
% X = Person
% R = Record

% Rule 1:
% Every archivist who verifies a record is trusted.
% forall X,R ((archivist(X) AND verifies(X,R)) -> trusted(X))

trusted(X) :- archivist(X), verifies(X,R).

% Rule 2:
% Every trusted person who has access to a sealed record is permitted to inspect that record.
% forall X,R ((trusted(X) AND access(X,R) AND sealed(R)) -> permitted(X,R))

permitted(X,R) :- trusted(X), access(X,R), sealed(R).

% Rule 3:
% Anyone who inspects a record and finds a hidden mark in it verifies that record.
% forall X,R ((inspects(X,R) AND finds_mark(X,R)) -> verifies(X,R))

verifies(X,R) :- inspects(X,R), finds_mark(X,R).

% Rule 4:
% Every record stored in the royal archive is sealed.
% forall R (stored(R) -> sealed(R))

sealed(R) :- stored(R).

% Fact 5:
% scroll_7 is stored in the royal archive.

stored(scroll_7).

% Fact 6:
% Mira has access to scroll_7.

access(mira, scroll_7).

% Fact 7:
% Mira inspects scroll_7 and finds a hidden mark in it.

inspects(mira, scroll_7).
finds_mark(mira, scroll_7).

% Fact 8:
% Mira is an archivist.

archivist(mira).

% Goal:
% trusted(mira).


% Step 2: Negation of goal

% Original Goal: trusted(mira)

% Negation of Goal: not(trusted(mira))


% Step 3: Implication removal

% Rule 1:
% (archivist(X) AND verifies(X,R)) -> trusted(X)

remove_implications(
    implies(and(archivist(X), verifies(X,R)), trusted(X)),
    or(not(archivist(X)), or(not(verifies(X,R)), trusted(X)))
).

% Rule 2:
% (trusted(X) AND access(X,R) AND sealed(R)) -> permitted(X,R)

remove_implications(
    implies(and(trusted(X), and(access(X,R), sealed(R))),
            permitted(X,R)),
    or(not(trusted(X)),
       or(not(access(X,R)),
          or(not(sealed(R)), permitted(X,R))))
).

% Rule 3:
% (inspects(X,R) AND finds_mark(X,R)) -> verifies(X,R)

remove_implications(
    implies(and(inspects(X,R), finds_mark(X,R)),
            verifies(X,R)),
    or(not(inspects(X,R)),
       or(not(finds_mark(X,R)), verifies(X,R)))
).

% Rule 4:
% stored(R) -> sealed(R)

remove_implications(
    implies(stored(R), sealed(R)),
    or(not(stored(R)), sealed(R))
).


% Step 4: Negation movement

% No further changes are required.
% De Morgans laws and double negation elimination
% have been considered.


% Step 5: Standardization

% Variables are standardized apart to avoid conflicts.

standardized_clauses([
    [not(archivist(X1)), not(verifies(X1,R1)), trusted(X1)],
    [not(trusted(X2)), not(access(X2,R2)),
     not(sealed(R2)), permitted(X2,R2)],
    [not(inspects(X3,R3)), not(finds_mark(X3,R3)),
     verifies(X3,R3)],
    [not(stored(R4)), sealed(R4)]
]).


% Step 6: Skolemization

% There are no existentially quantified variables.
% Therefore, no Skolem constants or functions are required.


% Step 7: CNF clauses

% C1 = ~archivist(X) v ~verifies(X,R) v trusted(X)
% C2 = ~trusted(X) v ~access(X,R) v ~sealed(R) v permitted(X,R)
% C3 = ~inspects(X,R) v ~finds_mark(X,R) v verifies(X,R)
% C4 = ~stored(R) v sealed(R)
% C5 = stored(scroll_7)
% C6 = access(mira,scroll_7)
% C7 = inspects(mira,scroll_7)
% C8 = finds_mark(mira,scroll_7)
% C9 = archivist(mira)
% C10 = ~trusted(mira) (Negated Goal)


% Step 8: Resolution

% Complementary literals

complementary(not(P),P).
complementary(P,not(P)) :-
    nonvar(P),
    P \= not(_).

% Resolution procedure

resolve(C1,C2,Resolvent) :-
    select(L1,C1,R1),
    select(L2,C2,R2),
    complementary(L1,L2),
    append(R1,R2,Temp),
    sort(Temp,Resolvent).

% Resolution Refutation Proof

prove :-
    C1=[not(archivist(mira)),
        not(verifies(mira,scroll_7)),
        trusted(mira)],

    C2=[not(trusted(mira)),
        not(access(mira,scroll_7)),
        not(sealed(scroll_7)),
        permitted(mira,scroll_7)],

    C3=[not(inspects(mira,scroll_7)),
        not(finds_mark(mira,scroll_7)),
        verifies(mira,scroll_7)],

    C4=[not(stored(scroll_7)),sealed(scroll_7)],
    C5=[stored(scroll_7)],
    C6=[access(mira,scroll_7)],
    C7=[inspects(mira,scroll_7)],
    C8=[finds_mark(mira,scroll_7)],
    C9=[archivist(mira)],
    C10=[not(trusted(mira))],


    writeln('ROYAL ARCHIVE ACCESS VERIFICATION'),

    write('Clause 1: '), writeln(C1),
    write('Clause 2: '), writeln(C2),
    write('Clause 3: '), writeln(C3),
    write('Clause 4: '), writeln(C4),
    write('Clause 5: '), writeln(C5),
    write('Clause 6: '), writeln(C6),
    write('Clause 7: '), writeln(C7),
    write('Clause 8: '), writeln(C8),
    write('Clause 9: '), writeln(C9),
    write('Negated Goal: '), writeln(C10),

    nl,

    % Resolution 1:
    % Resolve C3 with C7.
    % Eliminate inspects(mira,scroll_7).

    resolve(C3,C7,R1),
    write('Resolution 1: '), writeln(R1),

    % Resolution 2:
    % Resolve R1 with C8.
    % Eliminate finds_mark(mira,scroll_7).

    resolve(R1,C8,R2),
    write('Resolution 2: '), writeln(R2),

    % Resolution 3:
    % Resolve C1 with C9.
    % Eliminate archivist(mira).

    resolve(C1,C9,R3),
    write('Resolution 3: '), writeln(R3),

    % Resolution 4:
    % Resolve R3 with R2.
    % Eliminate verifies(mira,scroll_7).

    resolve(R3,R2,R4),
    write('Resolution 4: '), writeln(R4),

    % Resolution 5:
    % Resolve R4 with C10.
    % Eliminate trusted(mira) and not(trusted(mira)).

    resolve(R4,C10,R5),
    write('Resolution 5: '), writeln(R5),

    % Check for empty clause

    write('Empty clause: '), writeln(R5),

    ( R5 = [] ->
        nl,
        writeln('Contradiction found!'),
        writeln('Empty clause [] successfully derived.'),
        writeln('Therefore, Mira is trusted.')
    ;
        nl,
        writeln('Resolution failed.')
    ).

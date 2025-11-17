% Предикат удаления
remove(X, [X|T], T).
remove(X, [Y|T], [Y|Z]) :- remove(X, T, Z).

% Предикат перестановок
permute([], []).
permute(L, [X|T]) :- 
    remove(X, L, R), 
    permute(R, T).

solve(Result) :-
    Result = [
        [1, P1], [2, P2], [3, P3], [4, P4]
    ],
    
    Players = [peshkin, ladeynikov, korolev, slonov],
    permute(Players, [P1, P2, P3, P4]),
    
    % Условие 1: Пешкин=1 ∨ Королев=4
    (member([1, peshkin], Result); member([4, korolev], Result)),
    
    % Условие 2: (Королев!=3 ∨ Пешкин=4) ∧ Пешкин>Слонова
    (\+ member([3, korolev], Result); member([4, peshkin], Result)),
    better_position_condition(Result),
    
    % Условие 3: (Ладейников=1 ∨ Пешкин=3) ∧ (Королев!=2 ∨ Слонов!=4)
    (member([1, ladeynikov], Result); member([3, peshkin], Result)),
    (\+ member([2, korolev], Result); \+ member([4, slonov], Result)),
    
    % Условие 4: (Королев!=1 ∨ Слонов=2) ∧ (Слонов=2 ∨ Ладейников!=2)
    (\+ member([1, korolev], Result); member([2, slonov], Result)),
    (member([2, slonov], Result); \+ member([2, ladeynikov], Result)).

better_position_condition(Result) :-
    member([Ppos, peshkin], Result),
    member([Spos, slonov], Result),
    better_position(Ppos, Spos).

better_position(1, 2).
better_position(1, 3).
better_position(1, 4).
better_position(2, 3).
better_position(2, 4).
better_position(3, 4).
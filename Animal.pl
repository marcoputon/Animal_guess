jogar :- assertz(contador(1)),  assertz(nodo(0, 'macaco', -1, -2)), percorre_arvore(0), write('Cabô\n'), !.



percorre_arvore(Index) :-   write(Index),
                            nodo(Index, P, S, N),
                            testa_folha(Index, P, S, N).


testa_folha(I, P, -1, -2) :- write('É '), write(P), write('? '),
                             get_single_char(X), nl,
                             ganhou(I, X, P), !.


 testa_folha(I, P, -1, N) :-     write(P), write('? '),
                                 get_single_char(X),
                                 sim_nao(X, S, N), !.


testa_folha(I, P, S, N) :-      write(P), write('? '),
                                get_single_char(X),
                                sim_nao(X, S, N), !.


sim_nao(115, S, _) :- percorre_arvore(S), !.

sim_nao(110, _, N) :- percorre_arvore(N), !.


ganhou(_, 115, _) :-            write('Ganhei.\n\n\n'), !.

ganhou(I, 110, P) :-            write('Perdi. Qual era o animal? '),
                                read(X),
                                write('\nDigite uma característica que diferencia '), write(X), write(' de '), write(P), write(': '),
                                read(Y),
                                insere(I, P, X, Y), !.
                                % write('Iniciando novo jogo.\n\n\n'),
                                % percorre_arvore(0).


insere(I, P, X, Y) :-   contador(C),
                        assertz(nodo(C, X, -1, -2)),

                        C3 is C + 1,
                        retract(contador(C)),
                        assertz(contador(C3)),

                        assertz(nodo(C3, P, -1, -2)),
                        write(I), write(' - '), write(P),
                        retract(nodo(I, P, -1, -2)),
                        assert(nodo(I, Y, C, C3)), !.

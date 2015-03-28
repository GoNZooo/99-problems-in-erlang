-module('99-problems').
-compile(export_all).

%%%%%%%%%%%%%%%%%%%%%%
% From: http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html
%%%%%%%%%%%%%%%%%%%%%%
%%% Working with lists
%%%%%%%%%%%%%%%%%%%%%%
%% P01 (*) Find the last box of a list.
%% Example:
%% * (my-last '(a b c d))
%% (D)
my_last([H]) ->
    H;
my_last([H|T]) ->
    my_last(T).

%% P02 (*) Find the last but one box of a list.
%% Example:
%% * (my-but-last '(a b c d))
%% (C D)
my_but_last([]) ->
    [];
my_but_last([NTL, L]) ->
    [NTL, L];
my_but_last([H|T]) ->
    my_but_last(T).

%% P03 (*) Find the K'th element of a list.
%% The first element in the list is number 1.
%% Example:
%% * (element-at '(a b c d e) 3)
%% C
element_at([H|T], 1) ->
    H;
element_at([], _) ->
    [];
element_at([H|T], N) ->
    element_at(T, N - 1).

%% P04 (*) Find the number of elements of a list.
listlength([]) ->
    0;
listlength([H|T]) ->
    1 + listlength(T).

%% P05 (*) Reverse a list.
reverselist(List) ->
    reverselist(List, []). 
reverselist([], Acc) -> 
    Acc;
reverselist([H|T], Acc) -> 
    reverselist(T, [H|Acc]).

%% P06 (*) Find out whether a list is a palindrome.
%% A palindrome can be read forward or backward; e.g. (x a m a x).
is_palindrome([H|T]) ->
    [H|T] == reverselist([H|T]).


%% P07 (**) Flatten a nested list structure.
%% Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).
%% Example:
%% * (my-flatten '(a (b (c d) e)))
%% (A B C D E)
%% Hint: Use the predefined functions list and append.
my_flatten([]) ->
    [];
my_flatten([[X|Xs]|Ys]) ->
    [X] ++ my_flatten(Xs) ++ my_flatten(Ys);
my_flatten([X|Xs]) ->
    [X] ++ my_flatten(Xs).

%% P08 (**) Eliminate consecutive duplicates of list elements.
%% If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.
%% Example:
%% * (compress '(a a a a b c c a a d e e e e))
%% (A B C A D E)
compress([]) ->
    [];
compress([H|[H|T]]) ->
    compress([H|T]);
compress([H|T]) ->
    [H|compress(T)].

%% P09 (**) Pack consecutive duplicates of list elements into sublists.
%% If a list contains repeated elements they should be placed in separate sublists.
%% Example:
%% * (pack '(a a a a b c c a a d e e e e))
%% ((A A A A) (B) (C C) (A A) (D) (E E E E))
pack([H|T]) ->    
    pack(T, [H]).
pack([H|T], [H|AT]) ->
    pack(T, [H,H|AT]);
pack([H|T], [AH|AT]) ->
    [[AH|AT]] ++ pack([H|T]);
pack([], [AH|AT]) ->
    [[AH|AT]].

%% P10 (*) Run-length encoding of a list.
%% Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.
%% Example:
%% * (encode '(a a a a b c c a a d e e e e))
%% ((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))
encode([]) ->
    [];
encode(([[X|Xs]|Ys]) ->
    [{listlength([X|Xs]),X} | encode((Ys)].

%% P11 (*) Modified run-length encoding.
%% Modify the result of problem P10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as (N E) lists.
%% Example:
%% * (encode-modified '(a a a a b c c a a d e e e e))
%% ((4 A) B (2 C) (2 A) D (4 E))
encode_modified([]) ->
    [];
encode_modified([[X]|Ys]) ->
    [{X} | encode_modified(Ys)];
encode_modified([[X|Xs]|Ys]) ->
    [{listlength([X|Xs]),X} | encode_modified(Ys)].

%% P12 (**) Decode a run-length encoded list.
%% Given a run-length code list generated as specified in problem P11. Construct its uncompressed version.
n_of(0, X) ->
    [];
n_of(N, X) ->
    [X | n_of(N - 1, X)].

decode([]) ->    
    [];
decode([{N,X} | Ys]) -> 
    n_of(N,X) ++ decode(Ys);
decode([{X} | Ys]) -> 
    [X] ++ decode(Ys).

%% P13 (**) Run-length encoding of a list (direct solution).
%% Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in problem P09, but only count them. As in problem P11, simplify the result list by replacing the singleton lists (1 X) by X.
%% Example:
%% * (encode-direct '(a a a a b c c a a d e e e e))
%% ((4 A) B (2 C) (2 A) D (4 E))
encode_direct([H|T]) ->    
    encode_direct(T, H, 1).
encode_direct([H|T], H, X) ->
    encode_direct(T, H, X + 1);
encode_direct([H|T], AH, 1) ->
    [AH] ++ encode_direct([H|T]);
encode_direct([H|T], AH, X) ->
    [{X,AH}] ++ encode_direct([H|T]);
encode_direct([], AH, X) ->
    [{X, AH}].

%% P14 (*) Duplicate the elements of a list.
%% Example:
%% * (dupli '(a b c c d))
%% (A A B B C C C C D D)
dupli([]) ->
    [];
dupli([H|T]) ->
    [H,H | dupli(T)].

%% P15 (**) Replicate the elements of a list a given number of times.
%% Example:
%% * (repli '(a b c) 3)
%% (A A A B B B C C C)
repli([], N) ->
    [];
repli([H|T], N) ->
    n_of(N, H) ++ repli(T, N).

%% P16 (**) Drop every N'th element from a list.
%% Example:
%% * (drop '(a b c d e f g h i k) 3)
%% (A B D E G H K)
drop([H|T], N) ->
    drop([H|T], N, N).
drop([], N, X) ->
    [];
drop([H|T], N, 1) ->
    drop(T, N, N);
drop([H|T], N, X) ->
    [H|drop(T, N, X - 1)].

%% P17 (*) Split a list into two parts; the length of the first part is given.
%% Do not use any predefined predicates.
%% Example:
%% * (split '(a b c d e f g h i k) 3)
%% ( (A B C) (D E F G H I K))
split([H|T], 1) ->
    [[H]] ++ [T];
split([H|T], N) ->
    split(T, N - 1, [H]).
split([H|T], 1, [AH|AT]) ->
    [[AH|AT] ++ [H]] ++ [T];
split([H|T], N, [AH|AT]) ->
    split(T, N - 1, [AH|AT] ++ [H]).

%% P18 (**) Extract a slice from a list.
%% Given two indices, I and K, the slice is the list containing the elements between the I'th and K'th element of the original list (both limits included). Start counting the elements with 1.
%% Example:
%% * (slice '(a b c d e f g h i k) 3 7)
%% (C D E F G)
tail([H|T]) ->
    T.
head([H|T]) ->
    H.

second([H|T]) ->
    head(tail([H|T])).

slice([H|T], I, K) ->
    head(split(second(split([H|T], (I - 1))), (K - 1))).

%% P19 (**) Rotate a list N places to the left.
%% Examples:
%% * (rotate '(a b c d e f g h) 3)
%% (D E F G H A B C)
%% * (rotate '(a b c d e f g h) -2)
%% (G H A B C D E F)
%% Hint: Use the predefined functions length and append, as well as the result of problem P17.
rotate([H|T], N) when N < 0 ->
    rotate([H|T], listlength([H|T]) + N);
rotate([H|T], N) ->
    second(split([H|T], N)) ++ head(split([H|T], N)).

%% P20 (*) Remove the K'th element from a list.
%% Example:
%% * (remove-at '(a b c d) 2)
%% (A C D)
remove_at([], N) ->
    [];
remove_at([H|T], 1) ->
    T;
remove_at([H|T], N) ->
    [H | remove_at(T, N - 1)].

%% P21 (*) Insert an element at a given position into a list.
%% Example:
%% * (insert-at 'alfa '(a b c d) 2)
%% (A ALFA B C D)
insert_at(X, [H|T], N) ->
    head(split([H|T], (N - 1))) ++ [X] ++ second(split([H|T], (N - 1))).

%% P22 (*) Create a list containing all integers within a given range.
%% If first argument is smaller than second, produce a list in decreasing order.
%% Example:
%% * (range 4 9)
%% (4 5 6 7 8 9)
range(X, X) ->
    [X];
range(X, Y) when X < Y ->
    [X | range(X + 1, Y)];
range(X, Y) ->
    [X | range(X - 1, Y)].



%------------------------------------------------------------------------------%
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
%$$$$$$$$$$$$$$$$Zusammenfassung verschiedener Prolog-Programme$$$$$$$$$$$$$$$$%
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%
%------------------------------------------------------------------------------%

/**
Inhalt: 
        1. Arithmetische Operationen
                - add (Addition/Subtraktion mit Zahlen symbolischer Darstellung)
                - mult (Multiplikation mit Zahlen symbolischer Darstellung) 
                - convertSymb (Konvertiert Zahlen symbolischer Darstellung in
                                           eine arithmetische Darstellung um)
                - convertNat  (Konvertiert Zahlen arithmetischr Darstellung in
                                           eine symbolische Darstellung um) 
                - vielfaches 
        2. Listen- Operationen
                - elementAusgeben
                - elementAusArithmet
                - invAusgabe (Ausgabe eines Elements �ber einen Indes aus einer invertierten
                                          Liste) 
                - geordnet
                - delFirst
                - delLast
                - myRev (invertiert eine Liste) / reverse in Prolog vorhanden 
                - appnd
                - attach
                - vorhaengen
                - firstElement
                - lastElement
                - memb
                - prafix
                - postfix
                - infix
                - palindrom
                - range
                - twice
                - maximum
                - teile (Teile eine Liste in zwei H�lften)
                - rd (l�sche Duplikate)
                - fibList (Fibonacci Zahlen)
                - anz (Anzahl eines Elements in der Liste)
                - leng(L�nge einer Liste)
        3. Bin�rbaum- Operationen
                - isEmpty
                - binBaum
                - wurzel
                - getLinks
                - getRechts
                - getWert
                - praorder
                - inBaum (Findet einen Knoten in einem Bin�ren- Baum)
                - einfuegen (F�gt einen Knoten in einen Bin�ren- Suchbaum ein)
                - binEintragen (Tr�gt eine Listenfolge in einen Bin�ren- Suchbaum ein)
                - mirror (Spiegelt einen Bin�ren- Baum)
        4. Gramatiken und Graphen
                - Typ 3 Gramatik (Beispiel)
                - Wegstrecke �ber Kanten (Beispiel)
        I. Einige Tricks in Prolog
                - Cut- Operator
                - if/else in Prolog
                
**/










%------------------------------------------------------------------------------%
/*1. Arithmetische Operationen */
%------------------------------------------------------------------------------%

% Addition/Subtraktion
add(o,Y,Y).
add(s(X),Y,s(R)):- add(X,Y,R).

add2(X,Y,Loesung):- convertNat(X,X1),convertNat(Y,Y1), mult(X1,Y1,L),
                    convertSymb(L,Loesung),!.

% Multiplikation

mult(X, o, o).
mult(X, s(Y), R):- mult(X, Y, U), add(X, U, R).


mult2(X,Y,Loesung):- convertNat(X,X1),convertNat(Y,Y1), mult(X1,Y1,L),
                     convertSymb(L,Loesung),!.


quadrat(X,X,Zahl):- X >= 0,Zahl is X *X,!.
quadrat(X,X,Zahl):- X >= 0,H is X - 1, quadrat(H,H,Zahl).

isSquare(Zahl):- quadrat(Zahl,Zahl,Zahl).

% Konvertiert Zahlen symbolischer Darstellung in Zahlen arithmetischer
% Darstellung um.
convertSymb(o,Z) :- Z is 0.
convertSymb(s(X),Z):- convertSymb(X,H), Z is H+1.

% Konvertiert Zahlen Arithmetischer Darstellung in Zahlen symbolischer
% Darstellung um.
convertNat(0,Z):- add(o,o,Z),!.
convertNat(X,Z):- H is X-1, convertNat(H,H2), add(H2,s(o),Z).

%Pr�ft, ob X ein Vielfaches von Y ist.
vielfaches(X,0):-!.
vielfaches(X,Y):- Y>=0, HY is Y - X, vielfaches(X,HY).





































%------------------------------------------------------------------------------%
/* 2.Operationen mit Listen*/
%------------------------------------------------------------------------------%

% Ein Programm schreiben, das eine Liste invertiert und das n'te Element ausgibt.

% Gibt ein Element �ber einen Index aus.
% F�r Zahlen symbolischer Darstellung.
elementAusgeben([X|Xs],o,X).
elementAusgeben([_|Xs],s(Y),Z):- elementAusgeben(Xs,Y,Z).


% F�r Zahlen arithmetischer Darstellung.
elementAusArithmet([X|Xs],0,X).
elementAusArithmet([_|Xs],Y,Z):- H is Y-1, elementAusArithmet(Xs,H,Z).


% Invertiert die Liste, und gibt das Element �ber einen Index aus. 
invAusgabe(Liste,Index,Element):- reverse(Liste,InvListe),
elementAusArithmet(InvListe,Index,Element),!.


% Pr�ft, ob eine Liste geordnet ist. [1,2,3,4]-> true ; [1,4,2,3] -> false
geordnet([X]).
geordnet([X,Y|Rs]):-
   X=<Y,
   geordnet([Y|Rs]).



% Loesche das erste Element aus der Liste.
delFirst([X|Xs],Xs).

% Loesche das letzte Element aus einer Liste
delLast(Liste,Loesung):- myRev(Liste,Hs),delFirst(Hs,Hs2),myRev(Hs2,Loesung).


% Invertiere die Liste (reverse)
myRev([],[]) :- !.
myRev([X|Xs],InvListe):- myRev(Xs,Hs), append(Hs,[X],InvListe).


% Eigene Funktion zum Konkatenieren von Listen. (mit append bereits vorhanden)
appnd([],Liste,Liste).
appnd([X|Rest],Liste,[X|Ergebnis]):- appnd(Rest,Liste,Ergebnis).

% H�ngt ein Element an die Liste nach.
attach(X,Xs,Rs):- append(Xs,[X],Rs).

% H�ngt ein Element an die Liste vor.
vorhaengen(X,[], [X]):- !.
vorhaengen(X,[Element|Ys],[X,Element|Ys]):- !.


% Zeige das erste Element an
firstElement([X],[X]).
firstElement([X|Xs],X).

% Zeige das letzte Element an.
lastElement([X],X):-!.
lastElement([_|Xs],Y):- lastElement(Xs,Y).

% Pr�fe, ob ein Element in der Liste vorhanden ist. (siehe -> member)
memb(X,[X|Rs]):- !.
memb(X,[_|Rs]):- memb(X,Rs).


% Pr�ft, ob eine Liste mit einer anderen Liste anf�ngt.
prafix([],_):- !.
prafix([X|Rs],[X|Rs2]):- prafix(Rs,Rs2).

% Pr�ft, ob eine Liste mit einer anderen Liste endet.
postfix(Liste1,Liste2):- reverse(Liste1, L1rev), reverse(Liste2,L2rev), 
                                 prafix(L1rev,L2rev).

% Setze Pr�fix- Funktion ein, um zu bestimmen, ob eine Liste irgendwo in einer anderen
% Liste vorhanden ist. (Siehe *(I) Einige Tricks in Prolog)
infix([],[_|Rs]).
infix(Liste,[X|Rest]):- prafix(Liste,[X|Rest]) -> true,!; infix(Liste,Rest).

% Schreibweise wie in TILO 
infix2(Liste,[X|Rest]):- prafix(Liste,[X|Rest]).
infix2(Liste,[X|Rest]):- infix(Liste,Rest).


/*Eigene Aufgaben*/

% �berpr�ft, ob die der Inhalt einer Liste ein Palindrom ergibt.
palindrom(Wort):- reverse(Wort,Wort).


% Implementieren Sie das Praedikat range(N,M,Xs), das eine geordnete Xs erzeugt,
% die die nat�rlichen Zahen von N bis M enth�lt.
% z.B erhaelt man beim Aufruf  ?- range(3,6,Xs) das Ergebnis Xs = [3,4,5,6].


range(X,X,[X]):-!.
range(X,Y,Rs):- X<Y, append([X],Hs,Rs), H is X+1, range(H,Y,Hs).

range2(N,N,[N]).
range2(M,N,[M|Ns]):- M<N , H is M+1, range2(H,N,Ns).


%Zeige, ob zwei gleiche Elemente in einer Liste nebeneinander sind.
twice(X,[X,X|Rs]).
twice(X,[_|Liste]):- twice(X,Liste).

% Das Maximum aus einer Liste bestimmen
maximum([X],X) :- !, true.
maximum([X|Xs], M):- maximum(Xs, M), M >= X.
maximum([X|Xs], X):- maximum(Xs, M), X >  M.

% Teile eine Liste in zwei Haelften. Wenn die Liste nicht in zwei haelften
% geteilt werden kann,dann streiche das mittlere Element raus.
nGerade(0):- !.
nGerade(X):- H is X-2 ,H>=0, nGerade(H).

nUngerade(1):- !.
nUngerade(X):- H is X-2, H>0,nUngerade(H).

teile(Ls,Ls1,Ls2):- length(Ls,N), nGerade(N), N1 is N/2, length(Ls1,N1),
                    length(Ls2,N1),append(Ls1,Ls2,Ls).
                    
teile(Ls,Ls1,Ls2):- length(Ls,N), nUngerade(N), N1 is (N-1)/2, length(Ls1,N1),
                    length(Ls2,N1),append(Ls1,[_|Ls2],Ls).
                                        
                                        


                                        
                                        

                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        

% Remove Duplicates. Beispiel: rd([1,1,5,4,3,5,3],[1,5,4,3]).
% Das folgende Programm loescht Duplikate aus einer Liste.

% Erklaerung:
% I.A: Sei die Liste komplett leer, dann soll eine leere Liste zur�ckgegeben werden.
%      Sei nur ein Element in der Liste, dann fuege X in Ls ein.
%
% I.S: Gehe die Liste bis zum Ende durch, und schaue jedes mal, ob X Element
%      von Rs ist. Wenn ja, dann tu nichts und fahre fort, ansonsten fuege
%      das Element X in Rs ein.

rd([],[]).
rd([X],Ls):- member(X,Ls)-> append(Ls,[],Ls),!; append(Ls,[X],Ls),!.
rd([X|Xs],Rs):- member(X,Rs)-> rd(Xs,Rs);append(Rs,[X],Hs), rd(Xs,Hs).

                                        
% Fibonacci Zahlen bestimmen
% Die Fibonacci Zahlen sind wie folgt rekursiv definiert.
% fib1 = 0
% fib2 = 1
% fibn = fibn-1 + fibn-2 f�r alle n >2

fibList([0]).
fibList([1,0]).
fibList([N,N1,N2|Rs]):-  fibList([N1,N2|Rs]),N is N1+ N2.


% Gibt an, wie oft ein Element in einer Liste vorkommt.
anz(X,[],0):- !.
anz(X,[Element|Rs],V):- X = Element -> anz(X,Rs,Anzahl), V is 1+ Anzahl; anz(X,Rs,V).

% Gibt die L�nge der Liste an.
leng([],0).
leng([X|Rs],R):-  count(Rs,Anzahl), R is Anzahl +1.


sqr(X,X,Z):- X>=0, Z is X * X -> true; H is X -1, sqr(H,H,Z).

isSqr(Zahl):- sqr(Zahl,Zahl,Zahl).













































%------------------------------------------------------------------------------%
/*3. Bin�rbaum- Operationen */
%------------------------------------------------------------------------------%

% Bin�rbaum- Operationen

isEmpty(e).

binBaum(e).
binBaum(n(X,L,R)):- binBaum(L),binBaum(R).

wurzel(e,e).
wurzel(n(X,L,R),X):-binBaum(L),binBaum(R).

getLinks(e,e).
getLinks(n(_,L,R),L).

getRechts(e,e).
getRechts(n(_,L,R),R).
getWert(n(Y,L,R),Y):- binBaum(L),binBaum(R).

% Traversierungsverfahren
praorder(e,[]).
praorder(n(X,L,R),[X|Liste]):- binBaum(L),binBaum(R),praorder(L,Ls),praorder(R,Rs),
append(Ls,Rs,Liste).

% Suchverfahren
inBaum(X,n(X,_,_)).
inBaum(X,n(_,L,_)):- binBaum(L), inBaum(X,L).
inBaum(X,n(_,_,R)):- binBaum(R),inBaum(X,R).


% F�gt einen Knoten in einen bestehenden Bin�ren- Suchbaum ein. (Ohne Duplikate)
einfuegen(Wert,e,n(Wert,e,e)):- !.
einfuegen(Wert,n(Y,L,R),n(Y,L,Rb)):- Wert > Y, einfuegen(Wert,R,Rb).
einfuegen(Wert,n(Y,L,R),n(Y,Lb,R)):- Wert < Y, einfuegen(Wert,L,Lb).
einfuegen(Wert,n(Y,L,R),n(Y,L,R)):- Wert = Y,!. %hier vermeiden von Duplikaten%


% �bertr�gt einen Listeninhalt in einen bestehenden Bin�ren- Suchbaum.
binEintragen([],Baum,Baum):- binBaum(Baum).
binEintragen([Wert|Rest],Root,Baum):- einfuegen(Wert,Root,Hs) ,
                                      binEintragen(Rest,Hs,Baum),
                                      binBaum(Baum),!.
                                      
% Spiegelt einen Bin�rbaum
mirror(e,e).
mirror(n(X,L,R),n(X,Lb,Rb)):- mirror(R,Lb),mirror(L,Rb).























%------------------------------------------------------------------------------%
/* 4. Gramatiken und Graphen */
%------------------------------------------------------------------------------%

% Setze eine Typ 3 Grammatik um.
rS([]).
rS([a]).
rS([a|Xs]):-rA(Xs).
rA([a]).
rA([a|Xs]):- rA(Xs).
rA([b]).
rA([b|Xs]):-rB(Xs).
rB([b]).
rB([b|Xs]):- rB(Xs).

% Ein Beispiel- Programm, wie man durch einen Graphen traversiert.

kante(a,b).
kante(a,c).
kante(a,d).
kante(a,e).
kante(b,c).
kante(b,d).
kante(b,e).
kante(c,d).
kante(e,c).
kante(e,d).

wegStrecke(X,X,[X]).
wegStrecke(X,Y,[X|Rests]):- kante(X,Irgend), wegStrecke(Irgend,Y,Rests).










































%------------------------------------------------------------------------------%
/*(I). Einige Tricks in Prolog */
%------------------------------------------------------------------------------%

% Cut- Operator
        % Der Cut- Operator  ( ! ) unterbricht das Backtracking in Prolog. 
        % Bei Sprachen wie Java, oder C++ k�nnte man einen Cut- Operator 
        % �hnlich wie eine "break" Anweisung betrachten. 

        
% if/else in Prolog
        % In Prolog wird verordert, indem man Fakten untereinander schreibt.
        % In den meisten F�llen ist diese Variante auch unumg�nglich.
        % 
        % Eine weitere M�glichkeit besteht jedoch. Ich habe im Beispiel 
        % rd (L�sche Duplikate) eine solche M�glichkeit genutzt.
        
        % rd([],[]).
        % rd([X],Ls):- member(X,Ls)-> append(Ls,[],Ls),!; append(Ls,[X],Ls),!.
        % rd([X|Xs],Rs):- member(X,Rs)-> rd(Xs,Rs);append(Rs,[X],Hs), rd(Xs,Hs).
        
        % Erkl�rung: 
        % Der erste Fakt ist in dieser Form bereits bekannt.
        % Beim zweiten Fakt wird eine if/else M�glichkeit genutzt
        % Verbal kann die Anweisung wie folgt beschrieben werden: 
        
        % rd([X],Ls):- wenn X, also das letze Elemente in der Liste, ein Teil 
        % der neuen Liste (Ls) ist, dann �bergib der neuen Liste kein Element, 
        % ansonsten �bergib X an die neue Liste.
        
        % rd([X|Xs],Rs):- wenn X bereits ein Teil der neuen Liste (Rs) ist, dann
        % dann �berspringe das Element und setze mit der neuen Liste (Rs) fort.
        % Ansonsten �bergib X an die neue Liste und setze dann mit der Restliste
        % (Xs) fort.
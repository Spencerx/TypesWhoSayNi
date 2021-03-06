module Basics where

data   Zero : Set where
record One  : Set where constructor <>
data   Two  : Set where #0 #1 : Two

naughty : forall {l}{X : Set l} -> Zero -> X
naughty ()

_<?>_ : forall {l}{P : Two -> Set l} -> P #0 -> P #1 -> (b : Two) -> P b
(p0 <?> p1) #0 = p0
(p0 <?> p1) #1 = p1

data So : Two -> Set where
  oh : So #1

record Sg (S : Set)(T : S -> Set) : Set where
  constructor _,_
  field
    fst : S
    snd : T fst
open Sg public
infixr 4 _,_ _*_

_*_ _+_ : Set -> Set -> Set
S * T = Sg S \ _ -> T
S + T = Sg Two (S <?> T)

_?>=_ : forall {X Y} -> One + X -> (X -> One + Y) -> One + Y
(#0 , _) ?>= _ = #0 , _
(#1 , x) ?>= k = k x

un : forall {l}{S T}{P : Sg S T -> Set l} ->
     ((s : S)(t : T s) -> P (s , t)) -> (x : Sg S T) -> P x
un f (s , t) = f s t

Dec : Set -> Set
Dec X = (X -> Zero) + X

Pi : (S : Set)(T : S -> Set) -> Set
Pi S T = (x : S) -> T x

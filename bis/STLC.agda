module STLC where

open import Basics
open import Eq
open import Bwd
open import All
open import Atom
open import Pat
open import Term
open import Thin
open import Deriv

open TypeTheory

pattern BASE  = atom 1
pattern ARROW = atom 2

STLC : TypeTheory

formation STLC = [] -,
  record { typeSuj = BASE ; typePrems = [] }
  -,
  record
  { typeSuj =
    cons ARROW (cons (hole oi) (cons (hole oi) NIL))
  ; typePrems =
     [] -, type (_ , cdr (car hole) , oi)
        -, type (_ , cdr (cdr (car hole)) , oi)
  }
checking STLC = [] -,
  record
  { chkInp = 
    cons ARROW (cons (hole oi) (cons (hole oi) NIL))
  ; chkSuj = abst (hole oi)
  ; chkPrems = [] -, ((car (cdr (car hole)) ?- [])
                     !- ((car (cdr (cdr (car hole))) ?- [])
                       :> (_ , abst hole , oi)))
  }
elimination STLC = [] -,
  record
  { trgType = 
    cons ARROW (cons (hole oi) (cons (hole oi) NIL))
  ; elimSuj = hole oi
  ; elimPrems = [] -, ((car (cdr (car hole)) ?- [])
                      :> (_ , hole , oi))
  ; resType = car (cdr (cdr (car hole))) ?- [] }
universe STLC = []
reducts STLC  = [] -,
  (car (car (abst hole)) ?-
    ([] -, ((cdr hole ?- []) ::
            (car (cdr (cdr (cdr (car hole)))) ?- []))))
unambiguous STLC = _

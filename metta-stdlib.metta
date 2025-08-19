
;;;;;;;;;;;;Equality and Reduction;;;;;;;;

;!(assertEqual (+ 1 2) (+ 2 2)) 
;!(assertEqualToResult (+ 1 2) (+ 1 2)) 
;!(assertEqualToResult 3 3) 
;!(id "abebe") ;"abebe"
;!(id abebe) ;abebe
;!(=alpha (+ x x) (- x x))  ;false
;!(=alpha (+ x x) (+ b b)) ;false
;!(=alpha (+ $x $x) (+ $b $b)) ;true
;!(=alpha (+ $x $y) (+ $f $g)) ;true
;!(=alpha (+ $x $y) (+ $y $x)) ;true
;!(assertEqual (+ 1 2) (+ 2 2)) ;false
;!(assertAlphaEqual (+ $x $y) (+ $a $b))  ;[()]
;!(assertAlphaEqual (+ $x $y) (- $a $b))
;!(assertEqualToResult (+ 1 2) (3)) ;[()]
; (= (name) $selam)
;!(assertAlphaEqualToResult (name) ($hana)) ;[()]
;!(assertAlphaEqualToResult (name) $hana) ; error

;;;;;;; Error handling ;;;;;;;
;!(Error (add "a" 2) BadType)
;(Error 5 BadType)---value 5 caused a BadType error
;!(if-error (Error 5 BadType) "error" "no error") ;["error"]
;!(return-on-error (Error 5 BadType) 6) ; [(return (Error 5 BadType))]
;!(return-on-error 5 6) ; [6]

;;;;; Evaluation Control ;;;;;;
;!(function (return 5)) ; Returns 5
;!(function (return (+ 1 2))) ; Returns 3 
(= (double $x) (+ $x $x))
;!(eval (double 5)) ; Returns 10
;!(eval (+ 5 5)) ; Returns 10
;!(evalc (double 5) &self) ; Return [10]
;!(evalc (+ 5 5) &self) ; Returns 10
;takes the atom , variable ,template
;!(chain (+ 2 3) $x (* $x 6)) ;  returning 10.
;(= (double-each $x) (println! (double $x)))
;!(for-each-in-atom (1 3 5 62 2 5) double-each) ; Prints: 2 6 10 124 4 10 in separate lines ; Then it returns: ()

;;;;;;expression manipulation ;;;;;
;!(cons-atom 1 (2 3)) ; Returns [(1 2 3)]
;!(decons-atom (1 2 3)) ;return [(1 (2 3))]
;!(car-atom (1 2 3)) ; Returns 1
;!(cdr-atom (1 2 3)) ; Returns [(2 3)]
;!(size-atom (1 2 3)) ; return [3]
;!(size-atom ()) ; return [0]
;!(index-atom (1 2 3) 0) ;return 1
;!(index-atom (1 2 3) -1) ;return [(Error (index-atom (1 2 3) -1) Index is out of bounds)]

;;;;; mathematical operations ;;;;
;!(atan-math 0) ; Returns 0.0
;!(log-math 10 100) ; Returns 2.0
;!(isnan-math 0.0) ; Returns False
;!(isinf-math 0.0) ; Returns False
;!(min-atom (2 6 7 4 9 3)) ; Returns 2.0
;!(min-atom ()) ; Returns [(Error (min-atom ()) Empty expression)]
;!(min-atom (lala,sprinkle)) ;Returns [(Error (min-atom ()) Empty expression)]
;!(random-int &rng 5 4) ; Returns [(Error (random-int RandomGenerator-0x177c8e70 5 4) RangeIsEmpty)]
;!(random-int &rng -10 -1) ; return [-4]
;!(random-float &rng 2 9) ; Returns any int number between 2 to 9

;;;;;Non-deterministic computation;;;;;
;(= (bin) 0)
;(= (bin) 1) 
;!(collapse-bind (bin)) ; Returns (0 { }), (1 { }) nondeterministically
;!(superpose-bind ((A (Grounded ...)) (B (Grounded ...)))) ; returns the equivalent of (superpose (A B))
;!(superpose (a b c))
;!(collapse (superpose (a b c)))

;;;;;type system ;;;;
;!(first-from-pair (A B)) ; Returns A
;!(car-atom (A B)) ; Returns A
;!(is-function (-> Atom Atom)) ; Returns True
;!(is-function Atom) ; Returns False
;(: type1 Type)
;!(type-cast A type1 &self) ; A
;!(type-cast 1 type1 &self) ; Error 1 BasType
;!(match-types Atom Atom "Matched!" "Didn't match") ; Returns "Matched!"

;error found
;?? !(match-types Atom Number "Matched!" "Didn't match") ; Returns "Matched!"

;!(match-types Bool Number "Matched!" "Didn't match") ; 
;!(match-type-or True Number Number) ; Returns True
;!(match-type-or False Number Number) ; Returns True
;!(match-type-or True Number Bool) ; Returns True
;!(match-type-or False Number Bool) ; Returns False

;;;;;;list manipulation;;;;

;error found
;!(filter-atom (1 2 3 4 5) $x (> $x 3)) ; ???? runs infinitly 

;!(map-atom (1 2 3) $x (+ $x 1)) ; return [(2 3 4)]
;!(foldl-atom (1 2 3 4) 0 $acc $x (+ $acc $x)) ; return [10]
;!(format-args (Probability of {} is {}%) (head 50)) ; Returns ["(Probability of head is 50%)"]

;;;;; Atomspace Interaction;;;;;;
;!(add-reduct &self (= (add) (+ 1 3))); return [()]...... This will add (= (add) 4) to the working space, &self
;!(add-atom &self (= (add) (+ 1 3))); return [()]......This will add (= (add) (+ 1 3)) to the working space, &self
;!(get-type 1) ; Returns Number
(: a A)
;!(get-type-space &self a); Returns A 
;!(get-metatype True); Returns Grounded
;!(get-metatype (a b)); Return Expression
;!(get-metatype a); Return symbol
;!(get-metatype $a); Return variable
;!(if-equal 1 1 "Equal" "Not Equal"); Returns "Equal"
;!(if-equal 1 2 "Equal" "Not Equal"); Returns "Not Equal"
;!(new-space); Returns reference to the new space [GroundingSpace-0x2ddcd768]
;!(new-state rest); Returns (State rest)
;!(bind! state (new-state rest)) !(change-state! state active); Returns (State active)
;!(bind! state (new-state rest)) !(get-state state); returns [(State active)] and [()]
;!(remove-atom &self (= (add) 4)); return [()]   ....Removes (= (add) 4) from the working space, &self
;!(get-atoms &self); Returns all atoms inside &self
;(= (add) (+ 1 2))
;(= (add) (+ 4 2))
;!(match &self (= (add) (+ $x $y)) $x); Returns 1, 4

;;;;;quoting;;;
;!(quote(+ 1 2)) ;return [(quote (+ 1 2))]
;!(unquote (quote(+ 1 2))) ;return [3]
;!(noreduce-eq (+ 1 2) (+ 1 2)) ; Returns True
;!(noreduce-eq (+ 1 2) 3) ; Returns False

;;;;set operations ;;;;
!(eval (unique (superpose (a b c d d)))) ;[d, c, b, a] ;return [d, c, b, a]
!(eval (union (superpose (a b b c)) (superpose (b c c d)))) ;return [d, c, c, b, c, b, b, a]
!(eval (intersection (superpose (a b c c)) (superpose (b c c c d)))) ;return [c, c, b]
!(eval (subtraction (superpose (a b b c)) (superpose (b c c d)))) ; return [b, a]

;error found
;??!(unique (superpose (a b c d d))) ; Returns[(let $c#21 (collapse (superpose (a b c d d))) (let $u#22 (unique-atom $c#21) (superpose $u#22)))]
;!(union (superpose (a b b c)) (superpose (b c c d)))  
;!(intersection (superpose (a b c c)) (superpose (b c c c d)))   
;!(subtraction (superpose (a b b c)) (superpose (b c c d)))  

;!(unique-atom (a b c d d)) ; Returns (a b c d)
;!(union-atom (a b b c) (b c c d)) ; Returns (a b b c b c c d)
;!(intersection-atom (a b c c) (b c c c d)) ; Returns (b c c)
;!(subtraction-atom (a b b c) (b c c d)) ; Returns (a b)

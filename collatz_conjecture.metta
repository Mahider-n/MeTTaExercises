; collatz conjecture
;guard-case: $n=0...prevents infinite recursion
;recursive 
(= (collatz $n) 
   (if (<= $n 0) 
       "collatz works only for positive numbers" 
       ;base-case
        (if (== $n 1) 
            1
            ;recursive-logic
            (if (== (% $n 2) 0)
                (collatz (/ $n 2))
                (collatz (+ (* 3 $n) 1))
            )
        )
   )
)
;sample example
!(collatz 1)
!(collatz 0)
!(collatz -9)
!(collatz 8)
!(collatz 9)






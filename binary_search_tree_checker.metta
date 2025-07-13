;bsc_checker

;if-then-else expressions         
(= (if true $then $else) $then)
(= (if false $then $else) $else)
 
; for the nested case inside the recursion      
(= (my-and true true) true)  
(= (my-and true false) false)  
(= (my-and false true) false)  
(= (my-and false false) false)


;extracting parts of a node 
(= (value (node $value $left $right)) $value)
(= (left (node $value $left $right)) $left)
(= (right (node $value $left $right)) $right)

;check if value is in a range 
(= (in-range $value $low $high)
   (if 
   (and 
       (> $value $low)
       (< $value $high)
    )
    true
    false
   )
)

;recursion-rule
(= (binary_checker $tree $low $high)
   (if (== $tree leaf)
       true
       (if (in-range (value $tree) $low $high)
           (my-and 
               (binary_checker (left $tree) $low (value $tree))
               (binary_checker (right $tree) (value $tree) $high)
           )
           false
       )
   )
)
;test
! (value (node 10 (node 5 leaf leaf) (node 15 leaf leaf)))
! (left (node 10 (node 5 leaf leaf) (node 15 leaf leaf)))
! (right (node 10 (node 5 leaf leaf) (node 15 leaf leaf)))
! (binary_checker leaf -999 999)
! (in-range (value (node 10 (node 5 leaf leaf) (node 15 leaf leaf))) -999 999)

! (binary_checker (node 10 (node 5 leaf leaf) (node 15 leaf leaf)) -999 999)
! (binary_checker (node 10 (node 5 leaf leaf) (node 15 leaf leaf)) 20 30)
! (binary_checker (node 10 (node 20 leaf leaf) (node 15 leaf leaf)) -999 999)

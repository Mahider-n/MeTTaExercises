
;DFS

;edge relationship
(has-edge A B)
(has-edge A C)
(has-edge B D)
(has-edge B G)
(has-edge G E)
(has-edge C ())
(has-edge D ())
(has-edge E ())

get neighbors 
(= (neighbors $node)
   (match &self (has-edge $node $neighbor) $neighbor)
) 
;implementing visited tracking

;visited node
( =(visited $node) 
   (match &self (mark-visited $node) True)
)
;mark node visited
( = (mark-visited $node) 
    (add-atom &self (mark-visited $node))
)
;check if visited
(= (is-visited $node)
   (collapse 
      (match &self (mark-visited $node) True)
   )
)
; Helper function to process tuples of neighbors
(= (dfs ()) 
   "leaf node"
)
(= (leaf $x $y $xy) $x)
!(leaf C () "leafnode")
;dfs-recursion-rule
(= (dfs $node)
   (if (== (is-visited $node) ())
       (
         $node
         (mark-visited $node)
         (dfs (neighbors $node))
        ) 
        "visited"
   )
)

;test
! (neighbors A)
! (neighbors B)
! (neighbors G)
! (neighbors C)
! (is-visited C)
;! (== (is-visited A) ())
;! (mark-visited A)
! (dfs A)
! (dfs A)
! (== (neighbors C) ())
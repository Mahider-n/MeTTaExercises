
;DFS

;edge relationship
(has-edge A C)
(has-edge A B)
(has-edge B D)
(has-edge B G)
(has-edge G E)
(has-edge C ())
(has-edge D ())
(has-edge E ())


;get neighbors 
(= (neighbors $node)
   (match &self (has-edge $node $neighbor) $neighbor)
) 
; Mark node as visited
;mark node visited
( = (mark-visited $node) 
    (add-atom &self (visited $node))
)
;check if node is visited
(= (is-visited $node)
   (unify &self (visited $node) True False)
)
; Leaf function as specified (takes 3 args, returns first)
(= (leaf $x $y $xy) $x)
; Helper function to process neighbors recursively

(= (process-neighbor $node $neighbor)
   (if (is-visited $neighbor)
       (leaf "visited" () ())
       (dfs $neighbor)
   )
)

;dfs-recursion-rule
(= (dfs $node)
   (collapse   
      (if (is-visited $node)
          (leaf "visited" () ())
          (let $marked (mark-visited $node)
               (let $neighbor (neighbors $node) 
                    (if (== $neighbor ())
                        (leaf $node () ())
                        (   $node
                            (process-neighbor $node $neighbor) 
                            ;(dfs node)
                        )
                    )
               )
          )
      )
   )
)

;tests

! (dfs A)
! (dfs A)


;! (neighbors A)
;! (neighbors B)
;! (neighbors G)
;! (neighbors C)
;! (is-visited C)
;! (== (is-visited A) ())
;! (mark-visited A)

;! (== (neighbors C) [])

;! (mark-visited A)
;! (process-neighbor A $neighbor)

;! (dfs A)
;! (dfs A)
;! (is-visited A)
;! (is-visited B)




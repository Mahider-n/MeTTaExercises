;quick sort 

;compute the length of the arr
(= (length ()) 0)
(= (length (:: $x $xs))
   (+ 1 (length $xs)))
;extract last element of the arr 
(= (extract-last ()) ())
(= (extract-last (:: $x ())) $x)
(= (extract-last (:: $_ (:: $y $ys))) (extract-last (:: $y $ys)))
;iterate-and print all elements in the arr except last 
(= (init ()) ())
(= (init (:: $x ())) ())
(= (init (:: $x (:: $y $ys))) (:: $x (init (:: $y $ys))))
; get elements less than pivot
(= (filter-less $pivot ()) ())
(= (filter-less $pivot (:: $x $xs))
   (if (< $x $pivot)
       (:: $x (filter-less $pivot $xs))
       (filter-less $pivot $xs)
    )
)
;get elements greater than pivot 
(= (filter-greater $pivot ()) ())
(= (filter-greater $pivot (:: $x $xs))
   (if (> $x $pivot)
       (:: $x (filter-greater $pivot $xs))
       (filter-greater $pivot $xs)
    )
)
;get elements equal to pivot
(= (filter-equal $pivot ()) ())
(= (filter-equal $pivot (:: $x $xs))
   (if (== $x $pivot)
       (:: $x (filter-equal $pivot $xs))
       (filter-equal $pivot $xs)
    )
)
;append lists
(= (append () $ys) $ys)
(= (append (:: $x $xs) $ys) (:: $x (append $xs $ys)))

;quick-sort function
(= (quick-sort $list)
   (if (<= (length $list) 1)
       $list
       (let* (
             ($pivot (extract-last $list))
             ($rest (init $list))
             ($less (filter-less $pivot $rest))
             ($equal (:: $pivot (filter-equal $pivot $rest)))
             ($greater (filter-greater $pivot $rest))
             ($sortedless (quick-sort $less))
             ($sortedgreater (quick-sort $greater))
            )
         (append $sortedless (append $equal $sortedgreater))
       )
   )
)


;test 
! (quick-sort (:: 1 (:: 4 (:: 2 (:: 6 (:: 3 ()))))))
! (quick-sort (:: 1 ()))
! (quick-sort (:: 2 (:: 1 (:: 3 ()))))
! (quick-sort ())


(= (my-list) (:: 2 (:: 1 (:: 3 ()))))
(= (my-list-one) (:: 1 ()))
(= (my-list-none) ())
(= (my-list-five) (:: 1 (:: 4 (:: 2 (:: 6 (:: 3 ()))))))
;! (length (my-list-none))
;! (length (my-list))
;! (length (my-list-one))
;! (length (my-list-five))
;! (extract-last (my-list-five))
;! (<= (length (my-list-none)) 1)
;! (my-list)
;! (init (my-list))
;! (filter-less 2 (my-list))
;! (filter-less 3 (my-list))
;! (filter-equal 2 (my-list))
;! (append (my-list-one) (my-list))

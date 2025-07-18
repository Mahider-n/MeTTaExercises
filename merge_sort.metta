;merge sort

; get len of arr
(= (length ()) 0)
(= (length (:: $x $xs)) (+ 1 (length $xs)))
; get list element from tuple ()
(= (pair $a $b) (:: $a (:: $b ())))
;get first element
(= (fst (:: $a (:: $b ()))) $a)
;get second element
(= (snd (:: $a (:: $b ()))) $b)
; merge the sorted lists
(= (merge $left ()) $left)
(= (merge () $right) $right)
(= (merge (:: $left_first $left_rest) (:: $r $rs))
   (if (<= $left_first $r)
       (:: $left_first (merge $left_rest (:: $r $rs)))
       (:: $r (merge (:: $left_first $left_rest) $rs)))
)
; split list into half
(= (split_helper $current_pointer $end_detector $accumulator)
   (if (== $end_detector ())
       (pair (reverse $accumulator) $current_pointer)
       (if (== (tail $end_detector) ())
           (pair (reverse (:: (head $current_pointer) $accumulator)) (tail $current_pointer))
           (split_helper (tail $current_pointer) (tail (tail $end_detector)) (:: (head $current_pointer) $accumulator)))))

; Reverse list helper
(= (reverse $list) (reverse_aux $list ()))
(= (reverse_aux () $accumulator) $accumulator)
(= (reverse_aux (:: $x $xs) $accumulator) (reverse_aux $xs (:: $x $accumulator)))
; get-head and get-tail of list 
(= (head (:: $x $xs)) $x)
(= (tail (:: $x $xs)) $xs)
; split function
(= (split $list) (split_helper $list $list ()))
; merge sort 
(= (merge_sort $list)
   (if (<= (length $list) 1)
       $list
       (let* (
             ($pairs (split $list))
             ($left (fst $pairs))
             ($right (snd $pairs))
             ($sorted_left (merge_sort $left))
             ($sorted_right (merge_sort $right)))
          (merge $sorted_left $sorted_right))))

; test 
! (merge_sort (:: 6 (:: 3 (:: 8 (:: 5 (:: 2 ()))))))
! (merge_sort (:: 1 ()))
! (merge_sort (:: 2 (:: 1 (:: 3 ()))))
! (merge_sort ())
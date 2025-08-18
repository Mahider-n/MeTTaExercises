;using sigmoid function
;doesn't require dataset statistics 

;declare e, euler's number 
(= (e) 2.718281828459045)
;sigmoid function
(= (sigmoid $x)
   (/ 1.0 (+ 1.0 (pow-math (e) (* -1.0 $x))))
)
;normalization function
(= (normalize $x)
   (if (and (>= $x 0.0) (<= $x 1.0))
       $x
       (sigmoid $x)
    )
)
; normalize to range [a, b]
(= (normalize_withSpecificRange $x $a $b)
   (if (and (>= $x $a) (<= $x $b))
       $x
       (+ $a (* (- $b $a) (sigmoid $x)))
    )
)
;normalization using minmax
;normalize single value given min and max 
(= (normalize_usingMinMax $x $min $max)
  (if (and (>= $x 0) (<= $x 1))
    $x
    (/ (- $x $min) (- $max $min)))
)
;normalize list of values using min-max
; get min of two nums
(= (get_min $a $b)
  (if (< $a $b) $a $b)
)
;get max of two nums
(= (get_max $a $b)
  (if (> $a $b) $a $b)
)
;find min,max recursively
;base-case 
(= (find-min-max Nil)
  Error-empty-list)
(= (find-min-max (Cons $head $tail))
  (if (== $tail Nil)
    (min-max-pair $head $head)
    (let $pair (find-min-max $tail)
      (let $tmin (get-min $pair)
        (let $tmax (get-max $pair)
          (min-max-pair (get_min $head $tmin) (get_max $head $tmax)))
      )
    )
  )
)

; get min from pair
(= (get-min (min-max-pair $min $max))
  $min)
(= (get-min Error-empty-list)
  Error-empty-list)
; get max from pair
(= (get-max (min-max-pair $min $max))
  $max)
(= (get-max Error-empty-list)
  Error-empty-list)

;normalize recursively 
(= (normalize-helper Nil $min $max)
  Nil)
(= (normalize-helper (Cons $h $t) $min $max)
  (Cons (/ (- $h $min) (- $max $min)) (normalize-helper $t $min $max)))

; create list of zeros, for case min=max
(= (zero-list Nil)
  Nil)
(= (zero-list (Cons $h $t))
  (Cons 0 (zero-list $t)))

; main
(= (normalize-list $list)
  (let $pair (find-min-max $list)
    (if (== $pair Error-empty-list)
      Nil
      (let $min (get-min $pair)
        (let $max (get-max $pair)
          (if (== $min $max)
            (zero-list $list)
            (normalize-helper $list $min $max))
        )
      )
    )
  )
)
;normalize using z-score
;given value,mean,standard deviation 
(= (normalize_usingZScore $x $mean $std)
  (if (and (>= $x 0) (<= $x 1))
    $x
    (let $z (/ (- $x $mean) $std)
            $z
    )
  )
)
;normalize using z-score given value and dataset
; iteration for square root using newton-raphson method 
(= (sqrt-iter $x $guess $iters)
  (if (== $iters 0)
    $guess
    (let $next (/ (+ $guess (/ $x $guess)) 2)
      (sqrt-iter $x $next (- $iters 1))
    )
  )
)

;get sqrt of num
(= (sqrt $x)
  (if (< $x 0)
    Error-negative-sqrt
    (if (== $x 0)
      0
      (sqrt-iter $x $x 10))
    )
)
; get sum of list
(= (sum Nil) 0)
(= (sum (Cons $h $t)) (+ $h (sum $t)))
; get length of list
(= (length Nil) 0)
(= (length (Cons $h $t)) (+ 1 (length $t)))

; mean
(= (mean $list)
  (let $len (length $list)
    (if (== $len 0) Error-empty-list (/ (sum $list) $len)))
)

; sum of squared differences 
(= (sum_sq_diff Nil $mean) 0)
(= (sum_sq_diff (Cons $h $t) $mean)
  (+ (* (- $h $mean) (- $h $mean)) (sum_sq_diff $t $mean))
)

; standard deviation of list
(= (std $list)
  (let $m (mean $list)
    (if (== $m Error-empty-list)
      Error-empty-list
      (let $len (length $list)
        (if (== $len 0)
          Error-empty-list
          (sqrt (/ (sum_sq_diff $list $m) $len)))
      )
    )
  )
)

;main
(= (normalize_usingZScore_dataset $x $data)
  (if (and (>= $x 0) (<= $x 1))
    $x
    (let $m (mean $data)
      (if (== $m Error-empty-list)
        Error-empty-list
        (let $s (std $data)
          (if (== $s Error-empty-list)
            Error-empty-list
            (if (== $s 0)
              Error-zero-std
              (/ (- $x $m) $s))
          )
        )
      )
    )
  )
)

;tests
!(normalize_usingZScore_dataset 6.0 (Cons 5.0 (Cons 4.0 (Cons 7.0 Nil))))
!(normalize_usingZScore_dataset 7.0 (Cons 2.0 (Cons 4.0 (Cons 6.0 (Cons 8.0 (Cons 10.0 Nil))))))

!(normalize_usingZScore 10.0 8 4)
!(normalize_usingZScore 0.7 5 2)

;using minmax
;!(normalize-list (Cons 5.0 (Cons 0.0 (Cons 10.0 (Cons 15.0 (Cons 92.0 Nil))))))
;!(find-min-max (Cons 5 (Cons 0 (Cons 10 Nil))))

;!(normalize_usingMinMax 0.5 0 10)
;!(normalize_usingMinMax 5.0 0 10)
;!(normalize_usingMinMax -2.0 0 10)

;!(normalize_withSpecificRange 5 2 5)
;!(normalize_withSpecificRange 2 2 100)
;!(normalize_withSpecificRange 0 2 5)
;!(normalize_withSpecificRange -2 2 5)
;!(normalize_withSpecificRange 10 2 5)
;!(normalize_withSpecificRange -3 -100 2)   
;!(normalize_withSpecificRange 3 -100 2)   
;!(normalize_withSpecificRange 4 5 100) 
;!(normalize_withSpecificRange 1 50 100) 
;!(normalize_withSpecificRange 3000 2 100)   

;!(normalize 0.599)  
;!(normalize -2) 
;!(normalize 1.588)  
;!(normalize 100) 
;!(normalize -100) 

;!(sqrt 9)
;!(sqrt -9)
;!(sqrt 9.98)
;!(sqrt 0)
;!(sqrt 1)
;!(get_min 2 4)
;!(get_max 2 4)
;!(normalize -1)
;!(normalize 1)
;!(normalize 0)
;!(pow-math 2 5)
;!(e)

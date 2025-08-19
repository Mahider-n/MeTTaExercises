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
;main
(= (normalize-list $list)
  (if-equal (size-atom $list) [0]
    ()  ; Empty list returns empty
    (let $min (min-atom $list)
      (let $max (max-atom $list)
        (let $normalized
          (if-equal $min $max
            (map-atom $list $x 0.0)  ; If min == max, return list of zeros
            (map-atom $list $x (/ (- $x $min) (- $max $min))))
          (superpose $normalized)
        )
      )
    )
  )
)   

; define max-atom 
(= (max-atom $list)
  (if-equal (size-atom $list) [0]
    [(Error (max-atom $list) EmptyExpression)]
    (foldl-atom $list (index-atom $list 0) $acc $x (if (> $x $acc) $x $acc))
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
; Compute sum of list using foldl-atom
(= (sum-atom $list)
  (foldl-atom $list 0 $acc $x (+ $acc $x)))

;mean
(= (mean $list)
  (let $len (size-atom $list)
    (if (== $len 0)
      ()   
      (/ (sum-atom $list) $len)
    )
  )
)

;sum of squared differences  
(= (sum_sq_diff $list $mean)
  (sum-atom (map-atom $list $x (* (- $x $mean) (- $x $mean))))
)

;standard deviation
(= (std $list)
  (let $m (mean $list)
    (if (== $m ())
      ()   
      (let $len (size-atom $list)
        (if (== $len 0)
          ()   
          (sqrt-math (/ (sum_sq_diff $list $m) $len))
        )
      )
    )
  )
)
;main
(= (normalize_usingZScore_dataset $x $data)
  (let $m (mean $data)
    (if (== $m ())
      ()   
      (let $s (std $data)
        (if (== $s ())
          ()   
          (if (== $s 0)
            0  ; Zero std returns 0
            (/ (- $x $m) $s))
        )
      )
    )
  )
)
;tests
;!(normalize_usingZScore_dataset 6.0 (5 4 7))
;!(normalize_usingZScore_dataset 7.0 (2.0 4.0 6.0 8.0 10.0))
;!(normalize_usingZScore 10.0 8 4)
;!(normalize_usingZScore 0.7 5 2)

;using minmax
;!(normalize-list (5.0 0.0 10.0 15.0 92.0))

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

;!(sqrt-math 9)
;!(sqrt-math -9)
;!(get_min 2 4)
;!(get_max 2 4)
;!(normalize -1)
;!(normalize 1)
;!(normalize 0)
;!(pow-math 2 5)
;!(e)

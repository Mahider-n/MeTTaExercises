
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


;tests

!(normalize_withSpecificRange 5 2 5)
!(normalize_withSpecificRange 2 2 100)
!(normalize_withSpecificRange 0 2 5)
!(normalize_withSpecificRange -2 2 5)
!(normalize_withSpecificRange 10 2 5)
!(normalize_withSpecificRange -3 -100 2)   
!(normalize_withSpecificRange 3 -100 2)   
!(normalize_withSpecificRange 4 5 100) 
!(normalize_withSpecificRange 1 50 100) 
!(normalize_withSpecificRange 3000 2 100)   

!(normalize 0.599)  
!(normalize -2) 
!(normalize 1.588)  
!(normalize 100) 
!(normalize -100) 

;!(normalize -1)
;!(normalize 1)
;!(normalize 0)
;!(pow-math 2 5)
;!(e)

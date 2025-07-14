;tower_of_hanoi

(= (tower_of_hanoi $disk_num $source $helper $destination)
    ;base case: if only 1 disk, move directly A TO C
    (if (== $disk_num 1)
        ("Move disk 1 from " $source "to" $destination)
        ;recursion-rule
        (
            (tower_of_hanoi (- $disk_num 1) $source $destination $helper)
            ("Move disk" $disk_num "from" $source "to" $destination)
            (tower_of_hanoi (- $disk_num 1) $helper $source $destination)
        ) 
    )
)

;test case 

;! (- 3 1)
! (tower_of_hanoi 1 A B C)
! (tower_of_hanoi 3 A B C)
! (tower_of_hanoi 2 A B C)

 
; healthcare 

;diseases 
(diseases "common cold")
(diseases "HIV/AIDS")
(diseases "Covid-19")
;symptoms 
;for common cold
(symptom "Runny or stuffy nose")
(symptom "Sneezing")
(symptom "Cough")
;for hiv
(symptom "Extreme Fatigue")
(symptom "Rapid Weight loss")
(symptom "Recurring fever")
;for Covid-19
(symptom "Shortness of breath")
(symptom "Loss of taste or smell")
(symptom "Headache")

;treatments 
(treatment "Paracetamol or ibuprofen")
(treatment "Antiretroviral Therapy")
(treatment "Rest and Self-isolation")

;relationships 
;symptom-relationships

(has-symptom "Covid-19" "Shortness of breath")
(has-symptom "Covid-19" "Loss of taste or smell")
(has-symptom "Covid-19" "Headache")
;
(has-symptom "HIV/AIDS" "Extreme Fatigue")
(has-symptom "HIV/AIDS" "Rapid Weight loss")
(has-symptom "HIV/AIDS" "Recurring fever")
;
(has-symptom "common cold" "Runny or stuffy nose")
(has-symptom "common cold" "Sneezing")
(has-symptom "common cold" "Cough")
;treatment- relationships

(treated-by "common cold" "Paracetamol or ibuprofen")
(treated-by "common cold" "Warm fluids and hydration")
(treated-by "HIV/AIDS" "Regular CD4 count and viral load monitoring")
(treated-by "HIV/AIDS" "Antiretroviral Therapy")
(treated-by "Covid-19" "Fever reducers like paracetamol")
(treated-by "Covid-19" "Rest and Self-isolation")

; get the disease from single symptom
(= (get-disease $symptom $diseases)
   (match &self (has-symptom $disease $symptom) $disease)
)
;get the disease from multiple symptoms
(= (get-disease-from $symptom1 $symptom2 $diseases)
   (match &self 
        (,
            (has-symptom $disease $symptom1)
            (has-symptom $disease $symptom2)
        )
        ($disease)
   )
)

;get treatment based on the symptom
( =(get-treatment $symptom $treatment)
   (match &self 
        (, (has-symptom $disease $symptom)
           (treated-by $disease $treatment))
        ($treatment)
    )
 )
;test
! (get-disease "Cough" $diseases)
! (get-disease "Rapid Weight loss" $diseases)
! (get-disease "Loss of taste or smell" $diseases)
! (get-treatment "Cough" $treatment)
! (get-treatment "Recurring fever" $treatment)
! (get-treatment "Shortness of breath" $treatment)
! (get-disease-from "Cough" "Sneezing" $disease)
! (get-disease-from "Extreme Fatigue" "Rapid Weight loss" $disease)

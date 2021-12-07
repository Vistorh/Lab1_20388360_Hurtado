#lang scheme
(provide (all-defined-out))

;TDA fecha

;Representación

;CONSTRUCTOR

;Descripción: Permite crear una fecha en una lista
;Dom: entero X entero X entero
;Rec: lista
(define (date day month year)
  (if (and (integer? day) (integer? month) (integer? year)
           (> day 0) (> month 0) (< month 13) (not (= year 0))
           (<=  day (getDiasDelMes month year)))
      (list day month year)
      null
  )
)


;Descripción: función que determina si un año es bisiesto
;Dom: entero
;Rec: boolean
(define (bisiesto? year)
  (if (and (integer? year) (not (= year 0)))
      (or (= (remainder year 400) 0)
              (and (= (remainder year 4) 0) (not (= (remainder year 100) 0))))
      #f
  )
)

;Descripción: función para determinar cuantos dias tiene un mes
;Dom: entero X entero
;Rec: entero
(define (getDiasDelMes month year)
  (if (and (integer? month) (integer? year) (not (= year 0))
           (> month 0) (< month 13))
           (if (or (= month 1) (= month 3) (= month 5) (= month 7) (= month 8) (= month 10) (= month 12))
                31
                (if (= month 2)
                    (if (bisiesto? year)
                        29
                        28
                    )
                    30
                )
            )
           0
   )
 )

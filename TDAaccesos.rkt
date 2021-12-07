#lang racket
(provide (all-defined-out))
(require "TDAsocialnetwork_20388360_HurtadoMeza.rkt")

;TDA accesos
 ;usuario
 ;tipo de acceso
 ;id documento
 ;autor del documento
 
; // Selectores \\

;Descripción: Funcion que retorna el usuario que se le otorgo acceso
;Dom: lista
;Rec: string
(define getUsuarioA (lambda (stack)
    (list-ref stack 0)
    )
  )

;Descripción: Funcion que retorna la fecha del documento
;Dom: lista
;Rec: lista
(define getFechaA (lambda (stack)
    (list-ref stack 1)
    )
  )
;Descripción: Funcion que retorna el ID del documento
;Dom: lista
;Rec: string
(define getIDA (lambda (stack)
    (list-ref stack 2)
    )
  )

;Descripción: Funcion que retorna el autor del documento
;Dom: lista
;Rec: string
(define getAA (lambda (stack)
    (list-ref stack 3)
    )
  )


;Descripción: busca al usuario en la lista de accesos y lo quita para poder actualizarlo
;Dom: string X lista X lista X string
;Rec: lista
(define buscarAccesos(lambda(autor lista listaupdate)
       (if (null? lista)
          listaupdate
           (if (equal? (getAA(car lista)) (dcryptFn autor)) 
             (buscarAccesos autor (cdr lista) listaupdate)
             (buscarAccesos autor (cdr lista) (append listaupdate (list(car lista))))
           )
       )
    )
 )


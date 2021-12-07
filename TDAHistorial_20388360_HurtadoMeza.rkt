#lang racket
(provide (all-defined-out))
(require "TDAplataforma_20388360_HurtadoMeza.rkt")


;TDA historial
 ;contenido
 ;id documento
 ;version
 
; // Selectores \\

;Descripción: Funcion que retorna contenido de la lista historial
;Dom: lista
;Rec: string
(define getContenido (lambda (stack)
    (list-ref stack 0)
    )
  )

;Descripción: Funcion que retorna el ID de la lista historial
;Dom: lista
;Rec: string
(define getIDH (lambda (stack)
    (list-ref stack 1)
    )
  )
;Descripción: Funcion que retorna la version de la lista historial
;Dom: lista
;Rec: string
(define getVH (lambda (stack)
    (list-ref stack 2)
    )
  )



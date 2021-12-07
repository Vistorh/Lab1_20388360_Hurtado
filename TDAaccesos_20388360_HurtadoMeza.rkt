#lang racket
(provide (all-defined-out))
(require "TDAplataforma_20388360_HurtadoMeza.rkt")

;TDA accesos
 ;usuario
 ;tipo de acceso
 ;id documento
 ;autor del documento
 ;version
 
; // Selectores \\

;Descripción: Funcion que retorna el usuario al que se le otorgo acceso
;Dom: lista
;Rec: string
(define getUsuarioA (lambda (stack)
    (list-ref stack 0)
    )
  )

;Descripción: Funcion que retorna el tipo de acceso otorgado
;Dom: lista
;Rec: string
(define getTipoA (lambda (stack)
    (list-ref stack 1)
    )
  )
;Descripción: Funcion que retorna el ID del documento que se le otorgo acceso
;Dom: lista
;Rec: string
(define getIDA (lambda (stack)
    (list-ref stack 2)
    )
  )

;Descripción: Funcion que retorna el autor del documento original
;Dom: lista
;Rec: string
(define getAA (lambda (stack)
    (list-ref stack 3)
    )
  )

;Descripción: Funcion que retorna la version que se guarda en el historial
;Dom: lista
;Rec: string
(define getVer (lambda (stack)
    (list-ref stack 4)
    )
  )

;Descripción: busca al usuario en la lista de accesos y lo quita para poder actualizarlo
;Dom: string X lista X lista 
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

;Descripción: busca al usuario en la lista de accesos y lo guarda
;Dom: string X lista X lista
;Rec: lista
(define accesosUsuario(lambda(autor lista listaupdate)
       (if (null? lista)
          listaupdate
           (if (equal? (getUsuarioA(car lista)) (dcryptFn autor)) 
             (accesosUsuario autor (cdr lista) (append listaupdate (list(car lista))))
             (accesosUsuario autor (cdr lista) listaupdate)
           )
       )
    )
 )

;Descripción: busca al usuario en la lista de accesos y lo guarda
;Dom: string X lista X string 
;Rec: string
(define accesosUsuario_b(lambda(usuario lista id)
       (if (null? lista)
           #f
           (if (equal? (getUsuarioA(car lista)) (dcryptFn usuario)) 
               (if (equal? (getIDA(car lista)) id)
                   (getTipoA (car lista))
                   (accesosUsuario_b usuario (cdr lista) id)
               )
             
             (accesosUsuario_b usuario (cdr lista) id)
           )
       )
    )
 )


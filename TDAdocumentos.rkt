#lang racket
(provide (all-defined-out))
(require "TDAsocialnetwork_20388360_HurtadoMeza.rkt")
(require "TDAcompartido_20388360_HurtadoMeza.rkt")

;TDA publicaciones
 ;autor
 ;fecha
 ;titulo
 ;contenido
 ; id


; // Selectores \\

;Descripción: Funcion que retorna el usuario de la publicacion
;Dom: lista
;Rec: string
(define getAutor (lambda (stack)
    (list-ref stack 0)
    )
  )

;Descripción: Funcion que retorna la fecha de la publicacion
;Dom: lista
;Rec: lista
(define getFechaP (lambda (stack)
    (list-ref stack 1)
    )
  )
;Descripción: Funcion que retorna el tipo de la publicacion
;Dom: lista
;Rec: string
(define getTipo (lambda (stack)
    (list-ref stack 2)
    )
  )

;Descripción: Funcion que retorna string de la publicacion
;Dom: lista
;Rec: string
(define getPost (lambda (stack)
    (list-ref stack 3)
    )
  )
;Descripción: Funcion que retorna la id de la publicacion
;Rec: entero
(define getPID (lambda (stack)
    (list-ref stack 4)
    )
  )
; // Funciones \\

;Descripcion: Funcion que permite crear la publicacion
;Dom: string X string X fecha X string X stack X lista
;Rec: lista o print
(define crearPost(lambda (post autor fecha titulo stack)
    (if (and (string? post) (string? titulo))
        (list (dcryptFn autor) fecha (dcryptFn titulo) (dcryptFn post) (+ (getidPubli stack) 1))
        (print "Verifique que la pregunta y el titulo sean un string")
        )
    )
  )

;Descripción: busca al usuario en la lista de usuarios y lo quita para poder actualizarlo
;Dom: string X lista X lista X string
;Rec: lista
(define buscarPublicacion(lambda(id lista listaupdate usuario acceso listaAccesos)
       (if (null? lista)
          (print " la publicacion no existe")
           (if (equal? (getPID(car lista)) id)
			         (buscarUsuarios usuario listaAccesos '() acceso id)  ;significa que la publicacion existe
               (buscarPublicacion id (cdr lista) (append listaupdate (list(car lista))) usuario acceso listaAccesos)
           )
       )
    )
 )

;Descripción: busca al usuario en la lista de usuarios y lo quita para poder actualizarlo
;Dom: string X lista X lista X string
;Rec: lista
(define buscarUsuarios(lambda(nombre lista listaupdate acceso id) 
       (if (null? lista)
           (crea listaupdate nombre acceso id)
           (if (equal? (car(car lista)) (dcryptFn nombre))
               (crea (append listaupdate (cdr lista)) nombre acceso id) ;significa que la publicacion existe
               (buscarUsuarios nombre (cdr lista) (append listaupdate (list(car lista))) acceso)
           )
       )
    )
 )

;Descripción: actualiza la publicacion
;Dom: lista X string X string
;Rec: lista
;Usuario ( nombre pass fecha followers )
(define crea(lambda (lista usuario acceso id)
    (append lista (list(list (dcryptFn usuario)(dcryptFn acceso) id)))
    )
 )

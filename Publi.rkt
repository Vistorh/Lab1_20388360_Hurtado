#lang racket
(provide (all-defined-out))
(require "TDAsocialnetwork_20388360_HurtadoMeza.rkt")
(require "TDAcompartido_20388360_HurtadoMeza.rkt")

;TDA publicaciones
 ;autor
 ;fecha
 ;tipo
 ;contenido
 ;likes
 ;id


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
;Descripción: Funcion que retorna los likes de la publicacion
;Dom: lista
;Rec: entero
(define getLikes (lambda (stack)
    (list-ref stack 4)
    )
  )
;Descripción: Funcion que retorna la id de la publicacion
;Dom: lista
;Rec: entero
(define getPID (lambda (stack)
    (list-ref stack 5)
    )
  )
;Descripción: Funcion que retorna la id de la publicacion
;Dom: lista
;Rec: lista
(define getEtiquetados (lambda (stack)
    (list-ref stack 6)
    )
  )

; // Funciones \\

;Descripcion: Funcion que permite crear la publicacion
;Dom: string X string X fecha X string X stack X lista
;Rec: lista o print
(define crearPost(lambda (post autor fecha tipo stack etiquetados)
    (if (and (string? post) (string? tipo))
        (list (dcryptFn autor) fecha (dcryptFn tipo) (dcryptFn post) 0 (+ (getidPubli stack) 1)  etiquetados) ;el 0 representa los likes
        (print "Verifique que la pregunta y el tipo sean un string")
        )
    )
  )

;Descripcion: Funcion que busca si una publicacion existe y la retorna
;Dom: id X lista
;Rec: lista
(define buscarPost(lambda (id listaPublicaciones)
        (if (null? listaPublicaciones)
            '()
            (if (equal? id (getPID (car listaPublicaciones)))
                (list (getPID (car listaPublicaciones)) (getAutor(car listaPublicaciones)))
                (buscarPost id (cdr listaPublicaciones))
            )
         )
     )
 )


;Descripción: obtiene la lista con todas las publicaciones del usuario logueado
;Dom: lista X string
;Rec: string
(define obtenerPublis(lambda(nombre listaPublicaciones listaP) 
      (if(null? listaPublicaciones)
          listaP
          (if (equal? (car(car listaPublicaciones)) (cryptFn nombre))
               (obtenerPublis nombre (cdr listaPublicaciones) (append listaP (list(car listaPublicaciones))))
                (obtenerPublis nombre (cdr listaPublicaciones) listaP)
           )
       )            
     )
   )

;Descripción: crea un comentario
;Dom: entero X string X fecha X string X entero X lista
;Rec: lista
(define crearComentario (lambda (id logueado fecha comentario likes listaComentarios)
         (list (+ 1 id) (cryptFn logueado) fecha (cryptFn comentario) listaComentarios)))




;Descripción: Busca el autor de un post
;Dom: entero X lista
;Rec: string
(define buscarAutorPost(lambda (id listaPublicaciones)
        (if (null? listaPublicaciones)
            "nombre malo"
            (if (equal? id (getPID (car listaPublicaciones)))
                (getAutor(car listaPublicaciones))
                (buscarAutorPost id (cdr listaPublicaciones))
            )
         )
     )
 )

;Descripcion: funcion que busca la publicacion y guarda todos los datos de esta
;Dom: entero X lista
;Rec: lista
(define buscarDatosPost(lambda (id listaPublicaciones)
        (if (null? listaPublicaciones)
            '()
            (if (equal? id (getPID (car listaPublicaciones)))
                (list (getAutor(car listaPublicaciones)) (getFechaP(car listaPublicaciones)) (getTipo(car listaPublicaciones)) (getPost(car listaPublicaciones)) (+ 1 (getLikes(car listaPublicaciones))) (getPID(car listaPublicaciones)) (getEtiquetados (car listaPublicaciones)))
                (buscarPost id (cdr listaPublicaciones))
            )
         )
     )
 )

;Descripcion: funcion que guarda todos las publicaciones que no sean la que busco
;Dom: lista X entero X lista
;Rec: lista
(define guardarPost(lambda (listaPost id listaNewPost)
        (if (null? listaPost)
            listaNewPost
            (if (equal? (getPID(car listaPost)) id)
                (guardarPost (cdr listaPost) id listaNewPost)
                (guardarPost (cdr listaPost) id (append listaNewPost (list(car listaPost))))
            )
       )
     )
  )
         
;Descripción: verifica si la cantidad de veces que se compartio una publicacion esta de acuerdo con la solicitada
;Dom: lista X entero X entero X stack
;Rec: lista
(define contarCompartido (lambda (listaComp cont cantidad stack)
        (if (equal? cantidad (sumaCantidad(guardarCompartidos (getIDC(car listaComp )) listaComp '()) 0))
            (append (list cantidad) (buscarDatosPost (getIDC(car listaComp)) (getPubli stack)))
            (contarCompartido (cdr listaComp) 0 cantidad stack)
         )
     )
  )
              
;Descripción: crea una lista con todas las publicaciones compartidas con cierta id
;Dom: entero X listo X listo
;Rec: lista         
(define guardarCompartidos(lambda (id listaComp lista) ;lista de compartidos con 1 id
        (if (null? listaComp)
            lista
            (if (equal? id (getIDC(car listaComp)))
                (guardarCompartidos id (cdr listaComp) (append lista (list(car listaComp))))
                (guardarCompartidos id (cdr listaComp) lista)
            )
        )
     )
 )                       

;Descripción: cuanta la cantidad de veces que aparece una publicacion 
;Dom: entero X entero
;Rec: entero 
(define sumaCantidad(lambda (lista contador)
           (if (null? lista)
               contador
               (sumaCantidad (cdr lista) (+ 1 contador))
           )
       )
  )








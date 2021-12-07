#lang scheme
(provide (all-defined-out))

;TDA Plataforma
 ;nombre
 ;fecha
 ;usuarios
 ;documentos
 ;logueado
 ;id documentos
 ;compartido
 ;id registrados
 ;historial docs
 ;EncryptFunction
 ;DecryptFunction

;EncryptFunction y DecryptFunction
;funciones de encriptado 
(define cryptFn (lambda (s) (list->string (reverse (string->list s)))))
(define dcryptFn (lambda (s) (list->string (reverse (string->list s)))))

;socialnetwork
;Descripción: Funcion que crea la socialnetwork
;Dom: string X fecha X lista X lista X lista X string X lista X string X lista X funcion X funcion.
;Rec: stack.
(define crear_paradigmadocs (lambda(nombre fecha lista_usuarios lista_publicaciones lista_Log idPublucaciones listaCompartido idRegistrados listaHistorial cryptFn dcryptFn)  ;se crea la plataforma
      (list nombre fecha lista_usuarios lista_publicaciones lista_Log idPublucaciones listaCompartido idRegistrados listaHistorial cryptFn dcryptFn)
     )
  )

;Descripción: Funcion que pide los datos para crear la socialnetwork.
;Dom: string X fecha X funcion X funcion.
;Rec: stack.
(define registrar_plataforma (lambda(nombre fecha cryptFn dcryptFn) ;se registra la nueva plataforma
      (crear_paradigmadocs nombre fecha '() '() '() 0 '() 0 '() cryptFn dcryptFn) 
    )
 )


;Selectores

;Descripción: Funcion que retorna el paradigmaDocs del stack, para ello se solicita el stack.
;Dom: stack.
;Rec: string.
(define getRed(lambda (stack)
     (list-ref stack 0)
    )
 )

;Descripción: Funcion que retorna la fecha del stack, para ello se solicita el stack.
;Dom: stack
;Rec: fecha
(define getFecha(lambda (stack)
     (list-ref stack 1)
    )
 )

;Descripción: Funcion que retorna la lista con usuarios del stack, para ello se solicita el stack.
;Dom: stack
;Rec: lista
(define getUsuarios(lambda (stack)
    (list-ref stack 2)
    )
  )

;Descripción: Funcion que retorna la lista con publicaciones del stack, para ello se solicita el stack.
;Dom: stack
;Rec: lista
(define getPubli(lambda (stack)
    (list-ref stack 3)
    )
  )


;Descripción: Funcion que retorna la lista con el usuario logueado del stack, para ello se solicita el stack.
;Dom: stack
;Rec: lista con 1 string
(define getLog(lambda (stack)
    (list-ref stack 4)
    )
  )

;Descripción: Funcion que retorna el id de la publicacion del stack, para ello se solicita el stack.
;Dom: stack
;Rec: entero
(define getidPubli(lambda (stack)
    (list-ref stack 5)
    )
  )

;Descripción: Funcion que retorna la lista con los accesos
;Dom: stack
;Rec: lista
(define getCompa(lambda (stack)
    (list-ref stack 6)
    )
  )

;Descripción: Funcion que retorna el id de los usuarios registrados del stack, para ello se solicita el stack.
;Dom: stack
;Rec: entero
(define getidRe(lambda (stack)
    (list-ref stack 7)
    )
  )

;Descripción: Funcion que retorna la lista con el historial de publicaciones del stack, para ello se solicita el stack.
;Dom: stack
;Rec: lista
(define getHistorial(lambda (stack)
    (list-ref stack 8)
    )
  )



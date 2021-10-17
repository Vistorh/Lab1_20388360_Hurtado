#lang scheme
(provide (all-defined-out))

;TDA Plataforma
 ;nombre 
 ;fecha
 ;usuarios
 ;documentos
 ;logueado
 ;historial docs
 ;EncryptFunction
 ;DecryptFunction

;EncryptFunction y DecryptFunction
;funciones de encriptado que se utilizaron de prueba durante este laboratorio, agradeceria que los usara (son los que se dieron de ejemplo)
(define cryptFn (lambda (s) (list->string (reverse (string->list s)))))
(define dcryptFn (lambda (s) (list->string (reverse (string->list s)))))

;plataforma
;Descripción: Funcion que crea la plataforma
;Dom: string X fecha X lista X lista X lista X lista X funcion X funcion.
;Rec: stack.
(define crear_paradigmadocs (lambda(nombre fecha lista_usuarios lista_publicaciones lista_Log lista_historial cryptFn dcryptFn)  ;se crea la plataforma
      (list nombre fecha lista_usuarios lista_publicaciones lista_Log lista_historial cryptFn dcryptFn)
     )
  )

;Descripción: Funcion que pide los datos para crear la plataforma.
;Dom: string X fecha X encryptFunction X decryptFunction
;Rec: stack.
(define registrar_plataforma (lambda(nombre fecha cryptFn dcryptFn) ;se registra la nueva red
      (crear_paradigmadocs nombre fecha '() '() '() '() cryptFn dcryptFn)
    )
 )


;Selectores

;Descripción: Funcion que retorna la plataforma del stack, para ello se solicita el stack.
;Dom: stack.
;Rec: string.
(define getPlat(lambda (stack)
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

;Descripción: Funcion que retorna la lista con documentos del stack, para ello se solicita el stack.
;Dom: stack
;Rec: lista
(define getDocs(lambda (stack)
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

;Descripción: Funcion que retorna la lista con el historial de documentos del stack, para ello se solicita el stack.
;Dom: stack
;Rec: entero
(define getHistorial(lambda (stack)
    (list-ref stack 5)
    )
  )
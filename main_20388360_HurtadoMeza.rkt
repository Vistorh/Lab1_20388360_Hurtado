#lang racket
(require "TDAplataforma_20388360_HurtadoMeza.rkt")
(require "TDAfecha_20388360_HurtadoMeza.rkt")
(require "TDApublicaciones_20388360_HurtadoMeza.rkt")
(require "TDAusuarios_20388360_HurtadoMeza.rkt")
(require "TDAaccesos_20388360_HurtadoMeza.rkt")
(require "TDAHistorial_20388360_HurtadoMeza.rkt")

;Constructores

;TDA registrar
 ;paradigmaDocs
 ;nombre (unico)
 ;contraseña
 ;fecha

;Descripción: Permite crear un usuario, junto a su contraseña
;Dom: stack X string X string X fecha
;Rec: stack
(define registrar_usuario(lambda (stack nombre pass fecha)
    (if (equal? (buscar_usuario (getUsuarios stack) nombre) #t) ;Si ya esta registrado
        stack ;se retorna la socialnetwork sin cambios
        ;Si no esta registrado, se registra al usuario
        (list (getRed stack) (getFecha stack) (append (getUsuarios stack) (list (nuevo_usuario nombre pass fecha))) (getPubli stack) (getLog stack) (getidPubli stack) (getCompa stack) (+ 1 (getidRe stack)) (getHistorial stack) dcryptFn dcryptFn)
    )
  )
)

;TDA login
 ;paradigmaDocs
 ;nombre
 ;contraseña
 ;operacion

;Descripción: Permite a un usuario registrado, conectarse y ejecutar una funcion en el stack
;Dom: stack X string X string X operation
;Rec: (operation stack)
(define login(lambda (stack nombre pass operation) 
    (if (equal? (comprobarPass (getUsuarios stack) nombre pass) #t);Si se encuentra el usuario y su password es la misma registrada
        ;se debe conectar al usuario y retornar la funcion currificada entregandole el stack con el usuario conectado ya como parametro   
       (operation (list (getRed stack) (getFecha stack) (getUsuarios stack) (getPubli stack) (append (getLog stack)  (list nombre)) (getidPubli stack) (getCompa stack) (getidRe stack) (getHistorial stack)))
        ;de lo contrario solo se debe retornar operation
        (operation)
        )
    )
  )

;TDA publicaciones
;autor
 ;fecha
 ;titulo
 ;contenido
 ; id
 ; version

;descripción: Permite a un usuario logueado hacer 1 post
;Dom: stack X fecha X string X string 
;Rec: stack
(define publicar(lambda (stack)(lambda(fecha)(lambda (titulo contenido)
        ;En primer lugar se verifica que el usuario se encuentre logueado
        (if (null? (getLog stack))
            stack ;si no esta loggeado, se retorna el stack sin cambios
            (list (getRed stack) (getFecha stack) (getUsuarios stack) (append (getPubli stack) (list(crearPost contenido (car(getLog stack)) fecha titulo stack))) (list ) (+ 1 (getidPubli stack)) (getCompa stack) (getidRe stack) (append (getHistorial stack) (list(list (dcryptFn contenido) (+ (getidPubli stack) 1) 0))) dcryptFn dcryptFn)    
        )
     ) 
    )
  )
)

;Funcion share: me permite otorgarle accesos a los usuarios
;Dom: stack X string X string X string
;Rec: stack
(define share(lambda (stack)(lambda (id usuario acceso)
        ;En primer lugar se verifica que el usuario se encuentre logueado
        (if (null? (getLog stack))
            stack ;si no esta loggeado, se retorna el stack sin cambios
            (if (equal? usuario (car(getLog stack)))
                (list (getRed stack) (getFecha stack) (getUsuarios stack) (getPubli stack) (list ) (getidPubli stack) (getCompa stack) (getidRe stack) (getHistorial stack) dcryptFn dcryptFn) ;como no se puede dar permisos a si mismo, se muestra el stack sin cambios
                ;En caso de encontrarse loggeado y encuentre al usuario, se crea la nueva plataforma y se deslogea al usuario
                (list (getRed stack) (getFecha stack) (getUsuarios stack) (getPubli stack) (list ) (getidPubli stack) (buscarPublicacion id (getPubli stack) '() usuario acceso (getCompa stack) (car(getLog stack))) (getidRe stack) (getHistorial stack) dcryptFn dcryptFn)
            )
        )
    )
  )
)


;Funcion revokeAllAccesses: permite al usuario revocar todos los accesos a sus documentos
;Dom: stack
;Rec: stack
(define revokeAllAccesses(lambda (stack)
      ;En primer lugar se verifica que el usuario se encuentre logueado
      (if (null? (getLog stack))
          stack ;si no esta loggeado, se retorna el stack sin cambios
          (list (getRed stack) (getFecha stack) (getUsuarios stack) (getPubli stack) (list ) (getidPubli stack) (buscarAccesos (car(getLog stack)) (getCompa stack) '()) (getidRe stack) (getHistorial stack) dcryptFn dcryptFn)
      )
   )
)


;Funcion add: me permite otorgarle accesos a los usuarios
;Dom: stack X string X string
;Rec: stack
(define add(lambda (stack)(lambda (id nuevoTexto)
        ;En primer lugar se verifica que el usuario se encuentre logueado
        (if (null? (getLog stack))
            stack ;si no esta loggeado, se retorna el stack sin cambios
            (if (equal? #t (buscar_publi (getPubli stack) id));se busca si el edocumento existe
                (if (equal? (buscar_AutorDocs (getPubli stack) id) (dcryptFn (car (getLog stack))))
                    ;En caso de encontrarse loggeado y encuentre que el documento pertenece al usuario logueado, se actualiza el documento
                    (list (getRed stack) (getFecha stack) (getUsuarios stack) (busca_documento id (getPubli stack) '() nuevoTexto) (list ) (getidPubli stack) (getCompa stack) (getidRe stack) (append (getHistorial stack) (list(list (getPost (car(busca_documento id (getPubli stack) '() nuevoTexto))) id  (getVersion (car(busca_documento id (getPubli stack) '() nuevoTexto)))))) dcryptFn dcryptFn)                                               
                    (if (equal? "w" (accesosUsuario_b (car (getLog stack)) (getCompa stack) id))
                        (list (getRed stack) (getFecha stack) (getUsuarios stack) (busca_documento id (getPubli stack) '() nuevoTexto) (list ) (getidPubli stack) (getCompa stack) (getidRe stack) (append (getHistorial stack) (list(list (getPost (car(busca_documento id (getPubli stack) '() nuevoTexto))) id   (getVersion (car(busca_documento id (getPubli stack) '() nuevoTexto)))))) dcryptFn dcryptFn)   
                        (print "el usuario no posee los permisos necesarios para poder editar el documento")
                    )
                )
                (print "el documento buscado no existe")
            )
        )
    )
  )
)


;descripción: Permite a un usuario volver un post a alguno de sus estados anteriores
;Dom: stack X string X string 
;Rec: stack
(define restoreVersion(lambda (stack)(lambda (id version)
        ;En primer lugar se verifica que el usuario se encuentre logueado
        (if (null? (getLog stack))
            stack ;si no esta loggeado, se retorna el stack sin cambios
            (if (equal? #t (buscar_publi (getPubli stack) id));se busca si el edocumento existe
                (if (equal? (buscar_AutorDocs (getPubli stack) id) (dcryptFn (car (getLog stack))))
                    ;En caso de encontrarse loggeado y encuentre que el documento pertenece al usuario logueado, se actualiza el documento
                    (list (getRed stack) (getFecha stack) (getUsuarios stack) (busca_documentoVer id (getHistorial stack) '() version (getPubli stack)) (list ) (getidPubli stack) (getCompa stack) (getidRe stack) (getHistorial stack) dcryptFn dcryptFn)                                              
                    (print "el usuario no posee los permisos necesarios para poder editar el documento")
                    
                )
                (print "el documento buscado no existe")
            )
        )
    )
  )
)
              

;Funcion socialnetwork->string: transformo la socialnetwork en un string capaz de ser leido por el comando display
;Dom: stack
;Rec: string
(define socialnetwork->string(lambda (stack)
        (if (null? (getLog stack)) ;mostrar cosas basicas de la red social
              (string-append "\n La plataforma : " (getRed stack) ", creada el dia: " (number->string(car(getFecha stack)))"/"(number->string(cadr(getFecha stack)))"/"(number->string(list-ref (getFecha stack) 2))"\n"
                              " Actualmente cuenta con: " (number->string(getidRe stack)) " usuarios y " (number->string(getidPubli stack)) " publicaciones. \n\n")

               ;buscar al usuario en la lista de usuarios y tomar todos su datos
               (string-append "\n El usuario que acaba de iniciar sesion es: "(car(getLog stack)) ", creo la cuenta el dia: " (number->string(car(car(cdr(obtenerUsuario (car(getLog stack)) (getUsuarios stack))))))"/"(number->string(cadr(car(cdr(obtenerUsuario (car(getLog stack)) (getUsuarios stack))))))"/"(number->string(list-ref(car(cdr(obtenerUsuario (car(getLog stack)) (getUsuarios stack))))2))"\n"
                         "a publicado: " (crearString (obtenerPublis (car(getLog stack)) (getPubli stack) '()) "") (crearST_compartido (accesosUsuario (car(getLog stack)) (getCompa  stack) '()) "") ) 
        )                                                                                                          
    )
  )


#lang racket
(require "paradigmadocs.rkt")
(require "TDAfecha.rkt")
(require "usuarios.rkt")
(require "TDAdocumentos.rkt")

;Constructores

;TDA registrar
 ;paradigmadocs
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
        (list (getPlat stack) (getFecha stack) (append (getUsuarios stack) (list (nuevo_usuario nombre pass fecha '()))) (getDocs stack) (getLog stack) (getHistorial stack) dcryptFn dcryptFn)
    )
  )
)

;TDA login
 ;socialnetwork
 ;nombre
 ;contraseña
 ;operacion

;Descripción: Permite a un usuario registrado, conectarse y ejecutar una funcion en el stack
;Dom: stack X string X string X operation
;Rec: (operation stack)
(define login(lambda (stack nombre pass operation)
    (if (equal? (comprobarPass (getUsuarios stack) nombre pass) #t);Si se encuentra el usuario y su password es la misma registrada
        ;se debe conectar al usuario y retornar la funcion currificada entregandole el stack con el usuario conectado ya como parametro   
       (operation (list (getRed stack) (getFecha stack) (getUsuarios stack) (getPubli stack) (append (getLog stack)  (list nombre)) (getHistorial stack)))
        ;de lo contrario solo se debe retornar operation
        (operation)
        )
    )
  )

;TDA publicaciones
 ;autor
 ;fecha
 ;tipo
 ;contenido
 ;extras  Veces compartida y likes

;descripción: Permite a un usuario logueado hacer 1 post
;Dom: stack X fecha X string X string . strings
;Rec: stack
(define publicar(lambda (stack)(lambda(fecha)(lambda (tipo contenido . etiquetados)
        ;En primer lugar se verifica que el usuario se encuentre logueado
        (if (null? (getLog stack))
            stack ;si no esta loggeado, se retorna el stack sin cambios
            (if (null? etiquetados)
                 (list (getRed stack) (getFecha stack) (getUsuarios stack) (append (getPubli stack) (list(crearPost contenido (car(getLog stack)) fecha tipo stack '()))) (list ) (+ 1 (getidPubli stack)) (getCompa stack) (getidRe stack) (getComentarios stack) dcryptFn dcryptFn)       
                 (if (null? (buscarSeguidores (car(getLog stack)) (getUsuarios stack)))
                     (list (getRed stack) (getFecha stack) (getUsuarios stack) (getPubli stack) (list ) (getidPubli stack) (getCompa stack) (getidRe stack) dcryptFn dcryptFn) ; ya que no puede etiquetar a gente si no tiene amigos
                     (list (getRed stack) (getFecha stack) (getUsuarios stack) (append (getPubli stack) (list(crearPost contenido (car(getLog stack)) fecha tipo stack (list(amigos (buscarSeguidores (car(getLog stack)) (getUsuarios stack)) etiquetados '() ))))) (list ) (+ 1 (getidPubli stack)) (getCompa stack) (getidRe stack) (getComentarios stack) dcryptFn dcryptFn )
           )
        ) 
      )
     ) 
    )
  )
)




;Ejemplos para ejecutar el programa


;Ejemplo de como crear una socialnetwork
;(define redSocial (registrar_red "ig" (date 25 05 2019) cryptFn cryptFn))


;Ejemplos de como registrar usuarios, se pueden crear uno despues de otro pero no se registrara 2 veces al mismo usuario

;se registra juan
;(define redSocial (registrar_usuario redSocial "juan" "123" (date 13 01 2020)))

;se registra pedrito
;(define redSocial (registrar_usuario redSocial "pedrito" "456" (date 11 04 2020)))

;se registra cristo
;(define redSocial (registrar_usuario redSocial "cristo" "789" (date 20 06 2021)))


;Ejemplos de login

;se loguea juan y imprimen sus datos
;(define redSocial(login redSocial "juan" "123" socialnetwork->string)) este seria un ejemplo de login y la funcion socialnetwork->string

;se loguea pedrito y imprimen sus datos
;(define redSocial(login redSocial "pedrito" "456" socialnetwork->string)) este seria un ejemplo de login y la funcion socialnetwork->string

;se loguea cristo y imprimen sus datos
;(define redSocial(login redSocial "cristo" "789" socialnetwork->string)) este seria un ejemplo de login y la funcion socialnetwork->string


;Ejemplos de post

;juan realiza un post
;(define redSocial(((login redSocial "juan" "123" publicar)(date 16 08 2020))"texto.txt" "hola mundo"))

;cristo realiza un post
;(define redSocial(((login redSocial "cristo" "789" publicar)(date 21 07 2020))"texto.txt" "viva cristo"))

;pedrito realiza un post
;(define redSocial(((login redSocial "pedrito" "456" publicar)(date 26 02 2020))"texto.txt" "me encata programacion" "juan")) -> etiqueta a juan pero como no es su seguidor no se realiza el post


;Ejemplo de follow

;Pedrito obtiene el follow de juan
;(define redSocial(((login redSocial "juan" "123" follow)(date 16 11 2020))"pedrito"))

;Cristo obtiene el follow de pedrito
;(define redSocial(((login redSocial "pedrito" "456" follow)(date 16 11 2020))"cristo"))

;Juan obtiene el follow de cristo
;(define redSocial(((login redSocial "cristo" "789" follow)(date 16 11 2020))"juan"))


;Ejemplo de share

;juan comparte un post
;(define redSocial(((login redSocial "juan" "123" share)(date 16 11 2020))1))

;pedrito comparte un post
;(define redSocial(((login redSocial "pedrito" "456" share)(date 16 11 2020))2))

;cristo comparte un post
;(define redSocial(((login redSocial "cristo" "789" share)(date 16 11 2020))1))


;Ejemplo de socialnetwork->string

;se loguea juan y imprimen sus datos
;(define redSocial(login redSocial "juan" "123" socialnetwork->string))

;se loguea pedrito y imprimen sus datos
;(define redSocial(login redSocial "pedrito" "456" socialnetwork->string))

;se loguea cristo y imprimen sus datos
;(define redSocial(login redSocial "cristo" "789" socialnetwork->string))


;Ejemplo de comment

;pedrito comenta la primera publicacion 
;(define redSocial(((login lredSocial1 "pedrito" "456" comentar)(date 13 01 2000))1 "no me gusto"))

;juan comenta la primera publicacion 
;(define redSocial(((login lredSocial1 "juan" "123" comentar)(date 13 01 2000))1 "no me gusto"))

;cristo comenta la primera publicacion 
;(define redSocial(((login lredSocial1 "cristo" "789" comentar)(date 13 01 2000))1 "no me gusto"))


;Ejemplo de like

;juan da like a la primera publicacion
;(define redSocial(((login redSocial "juan" "123" like)(date 16 11 2020))1))

;pedrito da like a la primera publicacion
;(define redSocial(((login redSocial "pedrito" "456" like)(date 16 11 2020))1))

;cristo da like a la primera publicacion
;(define redSocial(((login redSocial "cristo" "789" like)(date 16 11 2020))1))


;Ejemplo de viral
;quedara una lista con los siguientes datos: ( cantidad de veces compartida / autor / fecha de creacion / tipo / contenido / likes / id / lista de etiquetados)
;y se muestra de forma encriptada.

;(viral redSocial 1)
;(viral redSocial 2)
;(viral redSocial 3)
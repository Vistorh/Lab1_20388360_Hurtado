#lang racket
(provide (all-defined-out))
(require "TDAsocialnetwork_20388360_HurtadoMeza.rkt")

;TDA usuarios
 ;nombre
 ;pass
 ;fecha
 ;seguidores

;Selectores

;Descripción: Funcion que retorna el nombre de la lista de usuarios
;Dom: lista
;Rec: string
(define getNombre(lambda (stack)
     (list-ref stack 0)
    )
 )

;Descripción: Funcion que retorna la pass de la lista de usuarios
;Dom: lista
;Rec: string
(define getPass(lambda (stack)
     (list-ref stack 1)
    )
 )

;Descripción: Funcion que retorna la fecha de la lista de usuarios
;Dom: lista
;Rec: lista
(define getFechau(lambda (stack)
    (list-ref stack 2)
    )
  )

;Descripción: Funcion que retorna los seguidores de la lista de usuarios
;Dom: lista
;Rec: lista
(define getSeguidores(lambda (stack)
    (list-ref stack 3)
    )
  )

;Descripción: Permite saber si un usuario ya se encuentra dentro de la lista de usuarios.
;Dom: lista X string
;Rec: booleano
;Recursion natural, se pide en el enunciado
(define buscar_usuario(lambda (listaUsuarios nombre)
    (if (null? listaUsuarios)
        #f ;No esta registrado
        (if (equal? (getNombre(car listaUsuarios)) (cryptFn nombre)) 
            #t ; Ya se encuentra registrado
            (buscar_usuario (cdr listaUsuarios) nombre) 
            )
        )
    )
  )

;Descripción: Permite crear un usuario, junto a su contraseña correspondiente
;Dom: string X string X fecha X lista
;Rec: lista
(define nuevo_usuario (lambda(nombre pass fecha follows)  ;se guarda la lista de los usuarios
      (list (cryptFn nombre) (cryptFn pass) fecha follows)
     )
  )

;Descripción: Permite comparar si la contraseña ingresada es igual a la del usuario
;Dom: lista X string X string
;Rec: booleano
;Recursion natural, se pide en el enunciado
(define comprobarPass(lambda (listaUsuarios nombre pass)
    (if (null? listaUsuarios)
        #f ;El usuario no existe
        (if (equal? (car(car listaUsuarios)) (cryptFn nombre)) 
            (if (equal? (car(cdr(car listaUsuarios))) (cryptFn pass))
                #t ;El usuario existe y su password es correcta
                #f ;El usuario existe, pero la password no es correcta
            )
            (comprobarPass (cdr listaUsuarios) nombre pass) 
            )
      )
    )
)


;Descripción: busca al usuario en la lista de usuarios y lo quita para poder actualizarlo
;Dom: string X lista X lista X string
;Rec: lista
(define buscarFollow(lambda(cosa lista listaupdate seguidor)
       (if (null? lista)
          (list cosa)
           (if (equal? (car(car lista)) (dcryptFn cosa))
             (crea (append listaupdate (cdr lista)) (car lista) seguidor)
               (buscarFollow cosa (cdr lista) (append listaupdate (list(car lista))) seguidor)
           )
       )
    )
 )

;Descripción: actualiza al usuario al cual le dieron follow
;Dom: lista X string X string
;Rec: lista
;Usuario ( nombre pass fecha followers )
(define crea(lambda (lista Usuario seguidor)
     (append lista (list(list (getNombre Usuario) (getPass Usuario) (getFechau Usuario) (append (getSeguidores Usuario) (list (cryptFn seguidor))))))
    )
 )


;Descripción: Busca al usuario dentro de la lista de usuario y saca sus seguidores.
;Dom: string X lista
;Rec: lista
(define buscarSeguidores(lambda(nombre lista)
           (if (equal? (car(car lista)) (cryptFn nombre))
               (getSeguidores (car lista))
               (buscarSeguidores nombre (cdr lista))
           )              
      )
   )

;Descripción: busca si el usuario esta dentro de su lista de contactos
;Dom: lista X lista X lista
;Rec: lista
(define amigos(lambda (listaAmigos etiquetados funca)
    (if (null? etiquetados) ;si no tiene amigo o se termina la lista de etiquetados
        funca
        (if (equal? #f (member (cryptFn(car etiquetados)) listaAmigos))          
            (amigos listaAmigos (cdr etiquetados) funca)
            (amigos listaAmigos (cdr etiquetados) (append funca (cryptFn(car etiquetados))))
         )
    )
  )
)

;Descripción: obtiene la informacion util del usuario logueado
;Dom: string X lista
;Rec: lista
(define obtenerUsuario(lambda(nombre listaUsuarios) 
           (if (equal? (car(car listaUsuarios)) (cryptFn nombre))
              (list (dcryptFn(getNombre(car listaUsuarios))) (getFechau(car listaUsuarios)) (getSeguidores(car listaUsuarios)))
               (obtenerUsuario nombre (cdr listaUsuarios))
           )              
      )
   )

;Descripción: obtiene la cantidad de followers que tiene un usuario
;Dom: lista X entero
;Rec: entero
(define obtenerCantFollows(lambda(lista cont) 
        (if (null? lista)
           cont
           (obtenerCantFollows (cdr lista) (+ 1 cont))
        )              
      )
   )

;Descripción: Busca al usuario dentro de la lista de usuario y saca sus seguidores.
;Dom: string X lista
;Rec: lista
(define buscarSeguidores1(lambda(nombre lista)
           (if (equal? (car(car lista))  nombre)
               (getSeguidores (car lista))
               (buscarSeguidores nombre (cdr lista))
           )              
      )
   )

;Descripcion: saber si un usuario sigue a otro
;Dom: lista X string
;Rec: booleano
(define SigueA(lambda (listaSeguidores seguidor)
     (if(equal? #f (member (cryptFn seguidor) listaSeguidores))
          #f
          #t
     )
   )
 )





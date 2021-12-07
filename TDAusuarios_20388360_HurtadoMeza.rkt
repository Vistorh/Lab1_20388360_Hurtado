#lang racket
(provide (all-defined-out))
(require "TDAplataforma_20388360_HurtadoMeza.rkt")

;TDA usuarios
 ;nombre
 ;pass
 ;fecha

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
;Rec: fecha
(define getFechau(lambda (stack)
    (list-ref stack 2)
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
;Dom: string X string X fecha 
;Rec: lista
(define nuevo_usuario (lambda(nombre pass fecha)  ;se guarda la lista de los usuarios
      (list (cryptFn nombre) (cryptFn pass) fecha)
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

;Descripción: obtiene la informacion util del usuario logueado
;Dom: string X lista
;Rec: lista
(define obtenerUsuario(lambda(nombre listaUsuarios) 
    (if (equal? (car(car listaUsuarios)) (cryptFn nombre))
        (list (dcryptFn(getNombre(car listaUsuarios))) (getFechau(car listaUsuarios)))
        (obtenerUsuario nombre (cdr listaUsuarios))
    )              
  )
)




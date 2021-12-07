#lang racket
(provide (all-defined-out))
(require "TDAplataforma_20388360_HurtadoMeza.rkt")
(require "TDAcompartido_20388360_HurtadoMeza.rkt")
(require "TDAHistorial_20388360_HurtadoMeza.rkt")
(require "TDAaccesos_20388360_HurtadoMeza.rkt")

;TDA publicaciones
 ;autor
 ;fecha
 ;titulo
 ;contenido
 ; id
 ; version


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
;Descripción: Funcion que retorna el titulo de la publicacion
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

;Descripción: Funcion que retorna la version de la publicacion
;Rec: entero
(define getVersion (lambda (stack)
    (list-ref stack 5)
    )
  )


; // Funciones \\

;Descripcion: Funcion que permite crear la publicacion
;Dom: string X string X fecha X string X stack X lista
;Rec: lista o print
(define crearPost(lambda (post autor fecha titulo stack)
    (if (and (string? post) (string? titulo))
        (list (dcryptFn autor) fecha (dcryptFn titulo) (dcryptFn post) (+ (getidPubli stack) 1) 0)
        (print "Verifique que la pregunta y el titulo sean un string")
        )
    )
  )

;Descripción: busca la publicacion en la lista de usuarios y lo quita para poder actualizarlo
;Dom: string X lista X lista X string X string X lista X string
;Rec: lista
(define buscarPublicacion(lambda(id lista listaupdate usuario acceso listaAccesos logueado)
       (if (null? lista)
          (print " la publicacion no existe o no es del usuario logueado")
           (if (equal? (getPID(car lista)) id)
              (if (equal? (getAutor(car lista)) (dcryptFn logueado))
			            (buscarUsuarios usuario listaAccesos '() acceso id logueado)  ;significa que la publicacion existe y pertenece al logueado
                  (buscarPublicacion id (cdr lista) (append listaupdate (list(car lista))) usuario acceso listaAccesos logueado)
              )
              (buscarPublicacion id (cdr lista) (append listaupdate (list(car lista))) usuario acceso listaAccesos logueado)
           )
       )
    )
 )

;Descripción: busca al usuario en la lista de usuarios y lo quita para poder actualizarlo
;Dom: string X lista X lista X string X string X string
;Rec: lista
(define buscarUsuarios(lambda(nombre lista listaupdate acceso id logueado) 
       (if (null? lista)
           (crea listaupdate nombre acceso id logueado)
           (if (equal? (car(car lista)) (dcryptFn nombre))
               (crea (append listaupdate (cdr lista)) nombre acceso id logueado) 
               (buscarUsuarios nombre (cdr lista) (append listaupdate (list(car lista))) acceso id logueado)
           )
       )
    )
 )

;Descripción: actualiza la lista de accesos
;Dom: lista X string X string X string X string
;Rec: lista
(define crea(lambda (lista usuario acceso id logueado)
    (append lista (list(list (dcryptFn usuario)(dcryptFn acceso) id (dcryptFn logueado))))
    )
 )


;Descripción: busca los documentos que pertenescan al autor
;Dom: string X lista X lista
;Rec: lista
(define obtenerPublis(lambda(autor lista listaupdate)
       (if (null? lista)
          listaupdate
           (if (equal? (getAutor(car lista)) (dcryptFn autor)) 
             (obtenerPublis autor (cdr lista) (append listaupdate (list(car lista))))
             (obtenerPublis autor (cdr lista) listaupdate)
           )
       )
    )
 )


;Descripción: Permite saber si un documento ya se encuentra dentro de la lista de documentos.
;Dom: lista X string
;Rec: booleano
(define buscar_publi(lambda (listapublis id)
    (if (null? listapublis)
        #f ;No esta el documento
        (if (equal? (getPID(car listapublis)) id)
            #t ; Si esta el documento
            (buscar_publi (cdr listapublis) id) 
            )
        )
    )
  )

;Descripción: Permite buscar el autor del documento que se busca
;Dom: lista X string
;Rec: booleano o string
(define buscar_AutorDocs(lambda (listapublis id)
    (if (null? listapublis)
        #f ;No esta el documento
        (if (equal? (getPID(car listapublis)) id)
            (getAutor (car listapublis))
            (buscar_AutorDocs (cdr listapublis) id) 
            )
        )
    )
  )


;Descripción: busca el documento en la lista de documentos y lo quita para poder actualizarlo
;Dom: string X lista X lista X string
;Rec: lista
(define busca_documento(lambda(id lista listaupdate texto) 
       (if (null? lista)
          listaupdate
           (if (equal? (getPID(car lista)) id)
             (create (append listaupdate (cdr lista)) (car lista) texto)
               (busca_documento id (cdr lista) (append listaupdate (list(car lista))) texto)
           )
       )
    )
 )

;Descripción: actualiza el documento el cual tiene una actualizacion
;Dom: lista X string X string
;Rec: lista
(define create(lambda (lista publicacion texto)
     (append lista (list(list (getAutor publicacion) (getFechaP publicacion) (getTipo publicacion) (string-append (cryptFn texto) (getPost publicacion)) (getPID publicacion) (+ 1 (getVersion publicacion)))))                              
    )
 )

;Descripción: busca el documento en la lista de documentos para trabajar con el
;Dom: string X lista X lista X string X lista
;Rec: lista
(define busca_documentoVer(lambda(id lista listaupdate version listaPublicaciones) 
       (if (null? lista)
           listaupdate
           (if (equal? (getIDH(car lista)) id)
              (if (equal? (getVH(car lista)) version)
                 (buscaASD id listaPublicaciones '() (append listaupdate (list (getContenido(car lista)) version)))
                 (busca_documentoVer id (cdr lista) listaupdate version listaPublicaciones) 
              )
              (busca_documentoVer id listaPublicaciones '() (cdr lista) listaupdate version listaPublicaciones)
           )
       )
    )
 )

;Descripción: busca el documento en la lista de documentos y lo quita para poder actualizarlo
;Dom: string X lista X lista X lista
;Rec: lista
(define buscaASD(lambda(id lista listaupdate listaChange) 
       (if (null? lista)
          listaupdate
           (if (equal? (getPID(car lista)) id)
             (createV (append listaupdate (cdr lista)) (car lista) listaChange)
               (buscaASD id (cdr lista) (append listaupdate (list(car lista))) )
           )
       )
    )
 )



;Descripción: actualiza el documento y su contenido al igual que la version
;Dom: lista X lista X lista
;Rec: lista
(define createV(lambda (lista publicacion listaChange)
     (append lista (list(list (getAutor publicacion) (getFechaP publicacion) (getTipo publicacion) (car listaChange) (getPID publicacion)  (cadr listaChange))))                              
    )
 )



;Descripción: transformar una lista en un string 
;Dom: lista X string
;Rec: string
(define crearString (lambda (lista string)
       (if (null? lista)
           string
           (crearString (cdr lista) (string-append "el dia " (number->string(car(getFechaP(car lista))))"/"(number->string(cadr(getFechaP(car lista))))"/"(number->string(list-ref(getFechaP(car lista))2))
                   " hizo una publicacion con el titulo: " (cryptFn(getTipo (car lista))) "\n su contenido es: " (cryptFn(getPost (car lista))) "\n"
                                     )
           )
        )
      )
  )
  
;Descripción: transformar una lista en un string (las publicaciones compartidas)
;Dom: lista X string
;Rec: string
(define crearST_compartido(lambda(lista string)
      (if (null? lista)
           string
           (crearST_compartido (cdr lista) (string-append "\n Finalmente tienen acceso a sus documentos los usuarios: " (getUsuarioA (car lista)) " "))
       )
    )
)
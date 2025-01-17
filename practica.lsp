; Dibuja un paralelepipedo en las coordenadas especificadas
(defun paralelepipedo (x1 y1 x2 y2)
	(move x1 y1)
	(draw x1 y2 x2 y2 x2 y1 x1 y1)
)

; Dibuja un paralelepipedo del color con componentes R G B en las coordenadas especificadas
(defun paralelepipedoRelleno (r g b x1 y1 x2 y2)
	(color r g b)
	(paralelepipedo x1 y1 x2 y2)
	(dotimes (i (- y2 y1))
		(move x1 (+ i y1))
		(draw x2 (+ i y1))
	)
	(color 0 0 0)	; Reset del color
)

; Abre la imagen desde el fichero especificado y la pinta en las coordenadas A Z
; La imagen tiene tamaño de 200 x 200 pixeles (imagenes de producto)
(defun VISUALIZADORCOLOR200 (imagen a z)
	(setq fichero (open imagen :direction :input
	:element-type 'unsigned-byte))
	(setq pixel 1)	; Index del pixel actual
	(setq B 0)		; Componente azul
	(setq G 0)		; Componente verde
	(setq R 0)		; Compomente roja
	(setq x a)		; Coordenada X
	(setq y z)		; Coordenada Y
	(move x y)
	(loop			; Leemos 3 bytes del fichero: B (azul), G (verde) y R (rojo)
		(setq B (read-byte fichero nil))
		(if (null B) (return ()))
		(setq G (read-byte fichero nil))
		(if (null G) (return ()))
		(setq R (read-byte fichero nil))
		(if (null R) (return ()))
		(color R G B)		; Set del color según los valores leidos
		(draw (+ 1 x) y)
		(setq pixel (+ pixel 1))
		(setq x (+ x 1))
		(cond  ((> pixel 200) (setq pixel 1) (setq x a) (setq y (+ y 1)) ) ) ; Una vez llegado a 200 pixeles, resetea la X y pasa a la linea siguiente
		(move x y)
	)
	(color 0 0 0)		; Reset del color
       (close fichero)
)


; Abre la imagen desde el fichero especificado y la pinta en las coordenadas A Z
; La imagen tiene tamaño de 20 x 20 pixeles (letras)
(defun VISUALIZADORCOLOR20 (imagen a z)
	(setq fichero (open imagen :direction :input
	:element-type 'unsigned-byte))
	(setq pixel 1)
	(setq B 0)
	(setq G 0)
	(setq R 0)
	(setq x a)
	(setq y z)
	(move x y)
	(loop
		(setq B (read-byte fichero nil))
		(if (null B) (return ()))
		(setq G (read-byte fichero nil))
		(if (null G) (return ()))
		(setq R (read-byte fichero nil))
		(if (null R) (return ()))
		(color R G B)
		(draw (+ 1 x) y)
		(setq pixel (+ pixel 1))
		(setq x (+ x 1))
		(cond  ((> pixel 20) (setq pixel 1) (setq x a) (setq y (+ y 1)) ) ) ; Una vez llegado a 20 pixeles, resetea la X y pasa a la linea siguiente
		(move x y)
	)
	(color 0 0 0)
       (close fichero)
)

; Visualiza las imagenes de la interfaz: Logo y letras 'PRODUCTO'
(defun cargarFotos ()
	(VISUALIZADORCOLOR200 "fotos/LogoPractica.img" 440 175)
	(VISUALIZADORCOLOR20 "fotos/P_NB.img" 90 345)
	(VISUALIZADORCOLOR20 "fotos/R_NB.img" 120 345)
	(VISUALIZADORCOLOR20 "fotos/O_NB.img" 150 345)
	(VISUALIZADORCOLOR20 "fotos/D_NB.img" 180 345)
	(VISUALIZADORCOLOR20 "fotos/U_NB.img" 210 345)
	(VISUALIZADORCOLOR20 "fotos/C_NB.img" 240 345)
	(VISUALIZADORCOLOR20 "fotos/T_NB.img" 270 345)
	(VISUALIZADORCOLOR20 "fotos/O_NB.img" 300 345)
	(VISUALIZADORCOLOR20 "fotos/S_NB.img" 330 345)
)

; Visualiza las imagenes de la interfaz: Indicador de pedido
(defun cargarLetrasPedido (numPedido)
	(VISUALIZADORCOLOR20 "fotos/P_NB.img" 10 145)
	(VISUALIZADORCOLOR20 "fotos/E_NB.img" 31 145)
	(VISUALIZADORCOLOR20 "fotos/D_NB.img" 52 145)
	(VISUALIZADORCOLOR20 "fotos/I_NB.img" 73 145)
	(VISUALIZADORCOLOR20 "fotos/D_NB.img" 94 145)
	(VISUALIZADORCOLOR20 "fotos/O_NB.img" 115 145)
	(VISUALIZADORCOLOR20 "fotos/_NB.img" 136 145)
	(setq x 136)
	(dotimes (i 22 x)       ;desde i=0 hasta i=21
		(VISUALIZADORCOLOR20 "fotos/_NB.img" (+ x 21) 145)
	)
	(mostrarPedido numPedido)
)

; Visualiza el número de pedido actual
(defun mostrarPedido (numPedido)
		(setq s (princ-to-string numPedido))	; Guardamos número de pedido

		; Cogemos solo el número
		(setq lista (list (subseq s 0 1)))

		(dotimes (n (- (length s) 1))
		    (setq lista (append lista (list (subseq s (+ n 1) (+ n 2)))))
		)

		(setq x 136)	; Coorenada donde irá el número

		(dotimes (n (length s) x)
		    (cond		; Carga la imagen apropiada según el número
		        ((string-equal "0" (car lista)) (cargarFotoNumero 0 (+ x 21) 145))
		        ((string-equal "1" (car lista)) (cargarFotoNumero 1 (+ x 21) 145))
		        ((string-equal "2" (car lista)) (cargarFotoNumero 2 (+ x 21) 145))
		        ((string-equal "3" (car lista)) (cargarFotoNumero 3 (+ x 21) 145))
		        ((string-equal "4" (car lista)) (cargarFotoNumero 4 (+ x 21) 145))
		        ((string-equal "5" (car lista)) (cargarFotoNumero 5 (+ x 21) 145))
		        ((string-equal "6" (car lista)) (cargarFotoNumero 6 (+ x 21) 145))
		        ((string-equal "7" (car lista)) (cargarFotoNumero 7 (+ x 21) 145))
		        ((string-equal "8" (car lista)) (cargarFotoNumero 8 (+ x 21) 145))
		        ((string-equal "9" (car lista)) (cargarFotoNumero 9 (+ x 21) 145))
		    )
		    (setq lista (cdr lista))
		)
)

; Visualiza las imagenes de la interfaz: Indicador de importe total
(defun cargarLetrasTotal (total)
	(VISUALIZADORCOLOR20 "fotos/T_NB.img" 334 5)
	(VISUALIZADORCOLOR20 "fotos/O_NB.img" 355 5)
	(VISUALIZADORCOLOR20 "fotos/T_NB.img" 376 5)
	(VISUALIZADORCOLOR20 "fotos/A_NB.img" 397 5)
	(VISUALIZADORCOLOR20 "fotos/L_NB.img" 418 5)
	(setq x 423)
	(dotimes (i 9 x)       ;desde i=0 hasta i=8
		(VISUALIZADORCOLOR20 "fotos/0_NB.img" (+ x 21) 5)
	)
	(mostrarTotal total)
)

; Visualiza el importe del pedido actual
(defun mostrarTotal (total)
		(setq s (princ-to-string total))	; Guardamos el total

		; Cogemos solo el número
		(setq lista (list (subseq s 0 1)))

		(dotimes (n (- (length s) 1))
		    (setq lista (append lista (list (subseq s (+ n 1) (+ n 2)))))
		)

		(setq lista (reverse lista))

		(setq x 633)

		(dotimes (n (length s) x)
		    (cond
		        ((string-equal "0" (car lista)) (cargarFotoNumero 0 (- x 21) 5))
		        ((string-equal "1" (car lista)) (cargarFotoNumero 1 (- x 21) 5))
		        ((string-equal "2" (car lista)) (cargarFotoNumero 2 (- x 21) 5))
		        ((string-equal "3" (car lista)) (cargarFotoNumero 3 (- x 21) 5))
		        ((string-equal "4" (car lista)) (cargarFotoNumero 4 (- x 21) 5))
		        ((string-equal "5" (car lista)) (cargarFotoNumero 5 (- x 21) 5))
		        ((string-equal "6" (car lista)) (cargarFotoNumero 6 (- x 21) 5))
		        ((string-equal "7" (car lista)) (cargarFotoNumero 7 (- x 21) 5))
		        ((string-equal "8" (car lista)) (cargarFotoNumero 8 (- x 21) 5))
		        ((string-equal "9" (car lista)) (cargarFotoNumero 9 (- x 21) 5))
		        ((string-equal "." (car lista)) (cargarFotoNumero 10 (- x 21) 5))
		    )
		    (setq lista (cdr lista))
		)
)

; Visualiza la imagen con el número especificado en las coordenadas X Y
(defun cargarFotoNumero (num x y)
		(case num
			(0 (VISUALIZADORCOLOR20 "fotos/0_NB.img" x y))
			(1 (VISUALIZADORCOLOR20 "fotos/1_NB.img" x y))
			(2 (VISUALIZADORCOLOR20 "fotos/2_NB.img" x y))
			(3 (VISUALIZADORCOLOR20 "fotos/3_NB.img" x y))
			(4 (VISUALIZADORCOLOR20 "fotos/4_NB.img" x y))
			(5 (VISUALIZADORCOLOR20 "fotos/5_NB.img" x y))
			(6 (VISUALIZADORCOLOR20 "fotos/6_NB.img" x y))
			(7 (VISUALIZADORCOLOR20 "fotos/7_NB.img" x y))
			(8 (VISUALIZADORCOLOR20 "fotos/8_NB.img" x y))
			(9 (VISUALIZADORCOLOR20 "fotos/9_NB.img" x y))
			(10 (VISUALIZADORCOLOR20 "fotos/._NB.img" x y))
		)
)

; Visualiza la imagen del producto según su número
(defun cargarFotoProducto (numProd)
		(case numProd
			(1 (VISUALIZADORCOLOR200 "fotos/mascarilla.img" 440 175))
			(2 (VISUALIZADORCOLOR200 "fotos/jabon.img" 440 175))
			(3 (VISUALIZADORCOLOR200 "fotos/pasta.img" 440 175))
			(4 (VISUALIZADORCOLOR200 "fotos/cerveza.img" 440 175))
			(5 (VISUALIZADORCOLOR200 "fotos/fresas.img" 440 175))
			(6 (VISUALIZADORCOLOR200 "fotos/arroz.img" 440 175))
			(7 (VISUALIZADORCOLOR200 "fotos/aguacate.img" 440 175))
			(8 (VISUALIZADORCOLOR200 "fotos/aceite.img" 440 175))
			(9 (VISUALIZADORCOLOR200 "fotos/azucar.img" 440 175))
			(10 (VISUALIZADORCOLOR200 "fotos/galletas.img" 440 175))
			(11 (VISUALIZADORCOLOR200 "fotos/salsa.img" 440 175))
			(12 (VISUALIZADORCOLOR200 "fotos/vinagre.img" 440 175))
			(13 (VISUALIZADORCOLOR200 "fotos/agua.img" 440 175))
			(14 (VISUALIZADORCOLOR200 "fotos/vino.img" 440 175))
			(15 (VISUALIZADORCOLOR200 "fotos/cafe.img" 440 175))
			(16 (VISUALIZADORCOLOR200 "fotos/cereales.img" 440 175))
			(17 (VISUALIZADORCOLOR200 "fotos/garbanzos.img" 440 175))
			(18 (VISUALIZADORCOLOR200 "fotos/alubias.img" 440 175))
			(19 (VISUALIZADORCOLOR200 "fotos/harina.img" 440 175))
			(20 (VISUALIZADORCOLOR200 "fotos/comino.img" 440 175))
		)
)

; Lee la lista de productos desde el fichero y los visualiza en la interfaz
(defun visualizarListaProductos ()
	(setq fichero (open "docs/productos.txt" :direction :input))
	(goto-xy 1 3)
	(princ (read-line fichero nil))
	(goto-xy 30 3)
	(princ (read-line fichero nil))
	(goto-xy 1 4)
	(princ (read-line fichero nil))
	(goto-xy 30 4)
	(princ (read-line fichero nil))
	(goto-xy 1 5)
	(princ (read-line fichero nil))
	(goto-xy 30 5)
	(princ (read-line fichero nil))
	(goto-xy 1 6)
	(princ (read-line fichero nil))
	(goto-xy 30 6)
	(princ (read-line fichero nil))
	(goto-xy 1 7)
	(princ (read-line fichero nil))
	(goto-xy 30 7)
	(princ (read-line fichero nil))
	(goto-xy 1 8)
	(princ (read-line fichero nil))
	(goto-xy 30 8)
	(princ (read-line fichero nil))
	(goto-xy 1 9)
	(princ (read-line fichero nil))
	(goto-xy 30 9)
	(princ (read-line fichero nil))
	(goto-xy 1 10)
	(princ (read-line fichero nil))
	(goto-xy 30 10)
	(princ (read-line fichero nil))
	(goto-xy 1 11)
	(princ (read-line fichero nil))
	(goto-xy 30 11)
	(princ (read-line fichero nil))
	(goto-xy 1 12)
	(princ (read-line fichero nil))
	(goto-xy 30 12)
	(princ (read-line fichero nil))
)

; Prepara la interfaz
(defun dibujarInterfaz ()
	(paralelepipedorelleno 0 0 0 5 335 435 375)
	(paralelepipedo 5 175 435 330)
	(paralelepipedorelleno 0 0 0 5 138 635 173)
	(paralelepipedo 5 35 635 135)
	(paralelepipedo 5 0 330 30)
	(paralelepipedorelleno 0 0 0 330 0 635 30)
)

; Prepara la interfaz inferior
(defun dibujarInterfazInferior ()
	(paralelepipedo 5 35 635 135)
	(paralelepipedo 5 0 330 30)
	(paralelepipedorelleno 0 0 0 330 0 635 30)
)

; Escribe los contenidos del pedido y el total en un fichero
(defun ficheroPedido (nombre nPedido listaPedidos nDeProductos total)
	(setq fichero (open nombre :direction :output))
	(setq aux (format nil "PEDIDO ~d\n" nPedido))
	(princ aux fichero)
	(setq aux (format nil "\tPRODUCTOS\t\t     UNIDADES\t\t\tIMPORTE\n"))
	(princ aux fichero)
	(setq listaPedidos (cdr listaPedidos))
	(dotimes (n nDeProductos)
		(setq aux (car listaPedidos))
		(princ aux fichero)
		(setq listaPedidos (cdr listaPedidos))
	)
	(setq aux (format nil "TOTAL PEDIDO\t~d euros" total))
	(princ aux fichero)
					(close fichero)
)

; Main
(defun inicio ()
	(cls)
	(visualizarListaProductos)
	(dibujarInterfaz)
	(cargarFotos)

	;INSTANCIACIÓN DE VARIABLES A UTILIZAR
	(setq total 0.00)
	(setq carrito 0)
	(setq columna 0)
	(setq fila 0)
	(setq listaPedidos (list nil))
	(setq nDeProductos 0)

	(loop
		;INICIO
		(goto-xy 1 23)
		(princ "[] INICIAR PEDIDO (S/N): ")
		(setq entrada (read))
		(if (string-equal entrada "S") (return()))
	)

	;NUMERO DE PEDIDO
	(goto-xy 1 23)
	(cleol)
	(dibujarInterfazInferior)
	(princ "[] NUMERO DE PEDIDO: ")
	(setq nPedido (read))

	;DISPLAY DE NUMERO DE PEDIDO EN PANTALLA
	(cargarLetrasPedido nPedido)

	(loop
	;NUMERO DE PRODUCTO
	(goto-xy 1 23)
	(cleol)
	(dibujarInterfazInferior)
	(cargarLetrasTotal total)
	(princ "[] NUMERO DE PRODUCTO: ")
	(setq nProducto (read))
	(case nProducto
		(1 (setq nombre "mascarilla") (setq precio 10.00))
		(2 (setq nombre "jabon manos") (setq precio 05.00))
		(3 (setq nombre "pasta gallo") (setq precio 02.39))
		(4 (setq nombre "cerveza") (setq precio 03.69))
		(5 (setq nombre "fresas") (setq precio 02.56))
		(6 (setq nombre "arroz sos") (setq precio 69.05))
		(7 (setq nombre "aguacate") (setq precio 02.78))
		(8 (setq nombre "aceite") (setq precio 01.98))
		(9 (setq nombre "azucar") (setq precio 01.34))
		(10 (setq nombre "galletas") (setq precio 03.78))
		(11 (setq nombre "salsa soja") (setq precio 04.32))
		(12 (setq nombre "vinagre") (setq precio 05.65))
		(13 (setq nombre "agua gas") (setq precio 15.76))
		(14 (setq nombre "vino tinto") (setq precio 36.34))
		(15 (setq nombre "cafe negro") (setq precio 05.86))
		(16 (setq nombre "cereales") (setq precio 04.67))
		(17 (setq nombre "garbanzos") (setq precio 01.23))
		(18 (setq nombre "alubias") (setq precio 02.56))
		(19 (setq nombre "harina") (setq precio 00.47))
		(20 (setq nombre "comino") (setq precio 07.14))
	)
	(cargarFotoProducto nProducto)

	;PREGUNTAR UNIDADES
	(goto-xy 1 23)
	(cleol)
	(dibujarInterfazInferior)
	(cargarLetrasTotal total)
	(format t "[] UNIDADES ~s: " nombre)
	(setq unidades (read))

	;CONFIRMACION DE UNIDADES + SUMA AL TOTAL + DISPLAY EN PANTALLA
	(goto-xy 1 23)
	(cleol)
	(dibujarInterfazInferior)
	(cargarLetrasTotal total)
	(format t "[] ~d DE ~s (S/N): " unidades nombre)
	(setq confirmacion (read))
	(cond ((string-equal confirmacion "S")
		(setq total (+ total (* unidades precio)))
		(goto-xy (+ 1 columna) (+ 16 fila))
		(setq columna (+ 27 columna))
		(setq carrito (+ 1 carrito))
		(format t "[~s/~d/~d]" nombre unidades (* precio unidades))
		;METEMOS LOS PRODUCTOS EN UNA LISTA PARA POSTERIORMENTE GUARDARLOS EN FICHERO
		(setq aux (format nil "~s\t\t\t\t~d\t\t\t~d euros\n" nombre unidades (* precio unidades)))
		(setq listaPedidos (append listaPedidos (list aux)))
		(cond ((= carrito 3)
			(setq carrito 0)
			(setq columna 0)
			(setq fila (+ fila 1))
		))
		;ACTUALIZAR TOTAL EN PANTALLA
		(cargarLetrasTotal total)
		(setq nDeProductos (+ nDeProductos 1))
	))

	;CONTINUAR CON EL PEDIDO?
	(goto-xy 1 23)
	(cleol)
	(dibujarInterfazInferior)
	(cargarLetrasTotal total)
	(princ "[] CONTINUAR PEDIDO (S/N): ")
	(setq continuar (read))
	(if (string-equal continuar "N") (return()))
	) ;Acaba el loop

	;CREAR FICHERO PEDIDO
	(setq nombre (format nil "pedido~d.txt" nPedido))
	(ficheroPedido nombre nPedido listaPedidos nDeProductos total)

	;FINALIZACION
	(goto-xy 1 23)
	(cleol)
	(dibujarInterfazInferior)
	(cargarLetrasTotal total)
	(format t "[] EL PEDIDO HA SIDO GUARDADO CORRECTAMENTE")
)

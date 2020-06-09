# Convertidor de BMP a IMG
# Práctica no presencial LISP - Curso 2019/2020
# Izar Castorina y Lisandro Rocha


import os

cont = 0            # Contador de files convertidos
arr = os.listdir()  # Lee los contenidos de la carpeta actual
#print(arr)

for f in arr:

    if ".bmp" in f:

        input = f
        output = f
        output = output.replace(".bmp", ".img")

        cont += 1

        #print(input)
        #print(output)
        
        # Conversión: se elimina la cabecera BMP y quedan solo los bytes de la imagen
        with open(input, 'rb') as in_file:
            with open(output, 'wb') as out_file:
                out_file.write(in_file.read()[54:])

        print("Creado fichero " + output)
print("Convertidos " + str(cont) + " ficheros bmp en img.")
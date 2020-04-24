import os

cont = 0
arr = os.listdir()
#print(arr)

for f in arr:

    if ".bmp" in f:

        input = f
        output = f
        output = output.replace(".bmp", ".img")

        cont += 1

        #print(input)
        #print(output)

        with open(input, 'rb') as in_file:
            with open(output, 'wb') as out_file:
                out_file.write(in_file.read()[54:])

        print("Creado fichero " + output)
print("Convertidos " + str(cont) + " ficheros bmp en img.")
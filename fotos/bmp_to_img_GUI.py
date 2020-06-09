# Convertidor de BMP a IMG - Versión GUI
# Práctica no presencial LISP - Curso 2019/2020
# Izar Castorina y Lisandro Rocha


import os
from tkinter import *
from tkinter import filedialog
from tkinter import messagebox

files = []
initdir = os.getcwd()
savedir = initdir


def abreImagen():
    global files
    files = filedialog.askopenfilenames(initialdir=initdir,
                                        title="Selecciona imagen",
                                        filetypes=(("Imagenes BMP", "*.bmp"),
                                                   ("Todos los files", "*.*")))

    # Actualiza status bar
    statusBar = Label(f_status,
                      text="Imagenes abiertas: " + str(len(files)),
                      bd=1,
                      relief=SUNKEN)
    statusBar.grid(row=0, column=0, sticky="nsew")

    # Actualiza lista
    listbox.delete(0, 'end')
    elemcounter = 1
    for f in files:
        string = f
        string = string.replace(os.path.dirname(f) + "/", "")

        listbox.insert(elemcounter, string)
        elemcounter += 1

    #print(files)


# Selecciona carpeta donde guardar los ficheros convertidos
def carpetaDestino():
    global savedir
    savedir = filedialog.askdirectory()
    print("DEBUG - savedir: " + savedir)


# Rutina de conversión
def convertidor():
    cont = 0
    #arr = os.listdir()
    #print(arr)

    if len(files) == 0:
        messagebox.showwarning(
            "Error", "No has abierto ningúna imagen para la conversión!")
        return

    for f in files:

        if ".bmp" in f:

            input = f
            output = f
            output = output.replace(os.path.dirname(f), savedir)
            output = output.replace(".bmp", ".img")

            cont += 1

            #print(input)
            #print(output)

            with open(input, 'rb') as in_file:
                with open(output, 'wb') as out_file:
                    out_file.write(in_file.read()[54:])

            print("Creado fichero " + output)
    if cont > 1:
        messagebox.showinfo(
            "Conversión completada", "Convertidos " + str(cont) + " ficheros bmp en img.")
    else:
        messagebox.showinfo(
            "Conversión completada", "Convertido 1 fichero bmp en img.")


# http://zetcode.com/tkinter/layout/

if __name__ == "__main__":
    root = Tk()
    root.title("Convertidor BMP a IMG")
    root.resizable(False, False)

    f_list = Frame(root, pady=3, bg="light grey")
    f_buttons = Frame(root, pady=10, bg="light grey")
    f_status = Frame(root, height=20, pady=3, padx=20, bg="light blue")

    f_list.grid(row=0, column=0, sticky="nsew", columnspan=2)

    f_status.grid_columnconfigure(0, weight=1)
    f_status.grid_rowconfigure(0, weight=1)
    f_status.grid(row=1, column=0, columnspan=3, sticky="nsew")
    f_status.grid_columnconfigure(0, weight=1)

    f_buttons.grid(row=0, column=2, sticky="nsew")
    f_buttons.grid_rowconfigure(0, weight=1)
    f_buttons.grid_rowconfigure(4, weight=1)
    
    root.columnconfigure(0, weight=3)
    root.columnconfigure(1, weight=1)
    root.columnconfigure(2, weight=0)
    #frame.columnconfigure(3, pad=7)
    root.rowconfigure(0, weight=3)
    root.rowconfigure(1, weight=0)
    #frame.rowconfigure(5, pad=7)

    listbox = Listbox(f_list)
    listbox.grid(row=0, column=0, pady=5, padx=5, sticky="nsew")
    listbox.config(width=25, height=10)

    boton_open = Button(f_buttons, text="Abre imagenes", command=abreImagen)
    boton_open.grid(row=1, column=0, pady=3, padx=10, sticky="ew")

    boton_conv = Button(f_buttons, text="Convierte imagenes", command=convertidor)
    boton_conv.grid(row=3, column=0, pady=3, padx=10, sticky="ew")

    boton_sel_savedir = Button(f_buttons,
                               text="Selecciona carpeta de destino",
                               command=carpetaDestino)
    boton_sel_savedir.grid(row=2, column=0, pady=3, padx=10, sticky="ew")

    statusBar = Label(f_status,
                      text="Ninguna imagen abierta.",
                      bd=1,
                      relief=SUNKEN)
    statusBar.grid(row=0, column=0, sticky="nsew")

    root.mainloop()
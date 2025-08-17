def mostrar_menu():
    print("\n--- MENÚ PRINCIPAL ---")
    print("1. Opción 1")
    print("2. Opción 2")
    print("3. Opción 3")
    print("4. Salir")

def main():
    while True:
        mostrar_menu()
        opcion = input("Elige una opción: ")
        
        if opcion == '1':
            print("Has elegido la Opción 1.")
        elif opcion == '2':
            print("Has elegido la Opción 2.")
        elif opcion == '3':
            print("Has elegido la Opción 3.")
        elif opcion == '4':
            print("¡Hasta la vista, bebé!")
            break
        else:
            print("Opción no válida. Intenta de nuevo.")

if __name__ == "__main__":
    main()

shopping_list = []  
compteur = 0

print("######## Bienvenue à Shopping List ######## ")
while True:
    print("\nQuel est l'action que vous souhaitez effectuer ?")
    print("1) Ajouter un article")
    print("2) Afficher la liste")
    print("3) Supprimer un article")
    print("4) Quitter\n")

    reponse2 = input(" Choisissez une option (1-4) : ")
    while reponse2 not in {"1", "2", "3", "4"}:
        reponse2 = input(" Format invalide ! Entrez une option valide (1-4) : ")

    if reponse2 == "1":  # Ajouter un article
        for i in range(0,5):
            while True:
                n = input("Entrez votre article (lettres uniquement) ou tapez 0 pour revenir au menu : ")
                if n == "0":  
                    print(" Retour au menu principal.")
                    break
                elif n.isalpha():
                    shopping_list.append(n)
                    print(f" '{n}' ajouté à votre liste !")
                    break
                else:
                    print(" Erreur : Entrez un nom valide (sans chiffres ni caractères spéciaux) !")
    else:
        print(" Vous avez atteint le nombre maximum d'ajouts.")

    elif reponse2 == "2":  # Afficher la liste
        print("\n Votre liste d'achats :")
        if shopping_list:
            for element in shopping_list:
                print(f"- {element}")
        else:
            print("Votre liste est vide.")

    elif reponse2 == "3":  # Supprimer un article
        if shopping_list:
            while True:
                n = input("Quel élément supprimer ? (ou tapez 0 pour revenir au menu) : ")
                if n == "0":
                    print(" Retour au menu principal.")
                    break
                elif n in shopping_list:
                    shopping_list.remove(n)
                    print(f" '{n}' a été supprimé de votre liste.")
                    break
                else:
                    print(" Cet article n'est pas dans la liste.")
        else:
            print(" Votre liste est vide, rien à supprimer.")

    else:  # Quitter le programme
        print("Merci d'avoir utilisé ### Shopping List ###. À bientôt !")
        break


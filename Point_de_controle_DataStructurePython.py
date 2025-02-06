shopping_list = [] 
n = ""
compteur = 0
element = ""

print("######## Bienvenue à Shopping List ######## \n")
while True:
    print("Quel est l'action que vous souhaitez effectuer ? \n")
    print("1) Ajouter : ")
    print("2) Afficher : ")
    print("3) Supprimez : ")
    print("4) Quittez :  \n")

    reponse2 = input()
    while reponse2 not in {"1", "2", "3", "4"}:
        reponse2 = input("Entrez le format requis svp : ")

    if reponse2 == "1":
        for i in range(0,10):
            while True :
                n = input("Entrez votre article svp (lettres uniquement) : \n")
                if n.isalpha() :
                   shopping_list.append(n)
                   print(f" {n} a bien été ajoutez \n")
                   compteur += 1
                   break
                    
                else :
                   print("Erreur , entrez le format demander ")
        else:
            print("Vous avez atteint le nombre maximum d'ajout.")
    
    elif reponse2 == "2":
    
        if shopping_list:
            print("Vous avez sélectionné les éléments suivants :\n")
            for element in shopping_list:
                print(element)
        else:
            print("Votre liste est vide.\n")
    
    elif reponse2 == "3":
        if shopping_list:
            while True:
                n = input("Quel est le nom de l'élément que vous voulez supprimer ? ")
                if n in shopping_list:
                    shopping_list.remove(n)
                    print(f"Vous avez supprimé {n} de votre shopping list.\n")
                    break
                else:
                    print("Désolé, cet article ne figure pas parmi vos articles.\n")
        else:
            print("Votre liste est vide, il n'y a rien à supprimer.")
    
    else:
        print("Merci d'avoir utilisé ### Shopping List ###. À bientôt !")
        break

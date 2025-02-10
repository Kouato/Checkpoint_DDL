## CALCULATRICE ###

def Ajouter(a,b):
    return a + b

def Soustraire(a,b):
    return a-b

def Multiplier(a,b):
    return a*b

def Diviser(a,b):
    if b !=0 :
        return a/b


operations = {
    Ajouter : "+",
    Soustraire : "-",
    Multiplier : "*",
    Diviser : "/"
}

def calculatrice() :           # Declaration de la fonction qui nous permettra d'obtenir a , b et le symbole (symb) 
    global a,b,symb
    while True :
         try :
            a = int(input("Entrez votre premier nombre :   "))
            break
         except ValueError : 
            print("Valeur incorrect ")
    
    for symb in ["+","-","*","/"]:
        print(f"{symb}")
    
    while True :
        symb = input("Entrez le symbole math que vous souhaitez utiliser ")
        if symb in ["+","-","*","/"]:
            break
        else :
            print("Erreur, entrez un symbole correct ")

    while True :
       try :
           b = int(input("Veillez entrer le deuxième nombre  :"))
           break
       except ValueError :
           print("Erreur , veillez entrer un nombre ! ")
           
    return a,b,symb



def calculation_function(a,b,symb):                    # Declaration de la fonction ou se deroulera les calculs 
    global answers
    for cle , valeur in operations.items():
        if valeur == symb :
            calculation_function2 = cle       
    print(f"{a} {symb} {b} = {calculation_function2(a,b)}  ")
    answers = calculation_function2(a,b)
    return answers


reponse3 = "OUI"         # Initialisation d'une variable qui permettra à l'utilisateur de pouvoir sortir des repetitions de calcul s'il souhaite 

print(" ######## CALCULATRICE ######## ")

while True :         # Nous avons là le corps du programme principale 
    
    if reponse3 == "OUI" :
        
        calculatrice() 
        calculation_function(a,b,symb)   # Ici , nous deroulons le premier calcul pour l'utilisateur avec les deux fonctions .
        
    else :
        break
        
    while True :    # Là , nous permettons à l'utilisateur de pouvoir reprendre les calculs avec ou sans le resultat precedent , aussi de pouvoir sortir 
        while True :  
              reponse= input("Souhaitez vous continuer d’autres calculs.(Oui ou Non)").upper()
              if reponse in ["OUI","NON"]:
                    break
              else : 
                 print("Erreur ! entrez la reponse demander ")
        if reponse == "OUI" :
           while True :
                 reponse2 = input("Souhaitez vous continuer à utiliser le résultat comme premier nombre pour d’autres calculs.(Oui ou Non)").upper()
                 if reponse2 in ["OUI","NON"]:
                     break
                 else : 
                     print("Erreur ! , entrez la reponse demander ")
                     
           if reponse2 == "NON" : # Ici , une fois l'utilisateur refuse à travers le Non on remonte au calcul avec deux nombres à definir .
                break
        else :
            reponse3 = "NON"
            break
            
        while True :    # Ici , une fois l'utilisateur a accepter de refaire un calcul avec resultat precedent , cette boucle l'amène à renseigner le signe et le 2 eme nombre
            if reponse2 == "OUI" :
                  a = answers
                  while True :
                         symb = input(" Entrez le symbole math que vous souhaitez utiliser ")
                         if symb in ["+","-","*","/"]:
                            break
                         else :
                             print("Erreur, entrez un symbole correct ")
 
                  while True :
                        try :
                             b = int(input("Veillez entrer le deuxième nombre  :"))
                             break
                        except ValueError :
                             print("Erreur , veillez entrer un nombre ! ")

                  calculation_function(a,b,symb)
                  break
            else : 
                pass
        else :
             break 
    else :
        break 
    


      
         

    

 
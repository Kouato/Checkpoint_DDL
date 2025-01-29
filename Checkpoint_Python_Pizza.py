print("****Bienvenue chez Python Pizza Deliveries****")

size = input("Entrez la taille de votre pizza svp ; L(Grande) , M(Moyenne) ou S(Petite) ...").upper()
while size not in {"L","M","S"} :
      size = input("Entrez la reponse demander svp: ou (q) pour quitter   ...").upper()
    
add_pepperoni = input("Souhaitez vous du pepperoni ? :    Y ou N ...").upper()
while add_pepperoni not in {"Y","N",} :
      add_pepperoni = input("Entrez la reponse demander svp ...").upper()
    
extra_cheese = input("Souhaitez vous des cheeses :   Y ou N ...").upper()
while extra_cheese not in {"Y","N",} :
      extra_cheese = input("Entrez la reponse demander svp :   ...").upper()
    
Prix_pizza = 0

if size == "L":
   Prix_pizza = 25
   if add_pepperoni == "Y" :
      Prix_pizza +=3
   else :
      Prix_pizza +=0
   if extra_cheese == "Y":
      Prix_pizza +=1
   else :
      Prix_pizza +=0
   print(f"Votre pizza vous coute en tout {Prix_pizza} $ ")

elif size == "M" :
     Prix_pizza = 20
     if add_pepperoni == "Y" :
        Prix_pizza += 3
     else :
        Prix_pizza += 0
     if extra_cheese == "Y":
        Prix_pizza += 1
     else :
        Prix_pizza += 0
     print(f"Votre pizza coute en tout {Prix_pizza} $ ")

elif size == "S" :
     Prix_pizza = 15
     if add_pepperoni == "Y" :
        Prix_pizza += 2
     else :
        Prix_pizza +=0
     if extra_cheese == "Y" :
        Prix_pizza += 1
     else :
        Prix_pizza += 0
     print(f"Votre pizza coute en tout {Prix_pizza} $ ")

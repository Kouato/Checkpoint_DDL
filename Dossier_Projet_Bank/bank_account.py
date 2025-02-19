class Account :
    
    def __init__(self,numero_compte="",titulaire_compte="",balance_compte=100000) :
        self.numero_compte = numero_compte
        self.__balance_compte = balance_compte
        self.titulaire_compte = titulaire_compte

    def deposit(self,depot) :
        
       self.__balance_compte += depot
       print(f"Monsieur {self.titulaire_compte} vous avez effectuer un depot de {depot}, votre solde est donc de {self.__balance_compte} F CFA ")

    def withdraw(self,retrait):
        
        if retrait < self.__balance_compte :
           self.__balance_compte -= retrait
           print(f"Monsieur {self.titulaire_compte} vous avez effectuer un retrait de {retrait}, votre solde est donc de {self.__balance_compte} F CFA ")

        elif retrait == self.__balance_compte :
            print("Vous ne pouvez retirer la totalité de votre compte ")

        else :
            print("Erreur ! , solde insuffissant pour effectuer ce retrait  ")

    def check_balance(self):
       print(f"Votre solde est de {self.__balance_compte} F CFA ")
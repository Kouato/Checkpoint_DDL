import streamlit as st
import pandas as pd
import pickle

# Charger le modèle et les colonnes encodées
model = pickle.load(open("modele_inclusion.pkl", "rb"))
colonnes_attendues = pickle.load(open("colonnes_inclusion.pkl", "rb"))

st.title("Prédiction de détention d’un compte bancaire")

# Champs de formulaire utilisateur
st.header("Veuillez renseigner les informations suivantes :")

household_size = st.number_input("Taille du ménage", min_value=1, max_value=50, step=1)
age = st.number_input("Âge du répondant", min_value=10, max_value=100, step=1)
year = st.selectbox("Année", [2016, 2017, 2018])
location_type = st.selectbox("Lieu de résidence", ["Urban", "Rural"])
cellphone_access = st.selectbox("Accès au téléphone portable", ["Yes", "No"])
gender = st.selectbox("Genre", ["Male", "Female"])
relationship = st.selectbox("Relation avec le chef de ménage", ["Head of Household", "Spouse", "Child", "Other relative", "Other non-relatives"])
marital_status = st.selectbox("Statut matrimonial", ["Married/Living together", "Single/Never Married", "Widowed", "Divorced/Separated", "Dont know"])
education = st.selectbox("Niveau d'éducation", ["No formal education", "Primary education", "Secondary education", "Tertiary education", "Vocational/Specialised training"])
job_type = st.selectbox("Type d’emploi", ["Self employed", "Government Dependent", "Formally employed Private", "Formally employed Government", "Informally employed", "Farming and Fishing", "Remittance Dependent", "Other Income", "No Income"])

# Construction du dictionnaire d'entrée
user_input = {
    "household_size": household_size,
    "age_of_respondent": age,
    "year": year,
    "location_type": location_type,
    "cellphone_access": cellphone_access,
    "gender_of_respondent": gender,
    "relationship_with_head": relationship,
    "marital_status": marital_status,
    "education_level": education,
    "job_type": job_type
}

# Préparation des données pour la prédiction
df_input = pd.DataFrame([user_input])
df_input_encoded = pd.get_dummies(df_input, drop_first=True)
df_input_encoded = df_input_encoded.reindex(columns=colonnes_attendues, fill_value=0)

# Bouton de prédiction
if st.button("Prédire"):
    prediction = model.predict(df_input_encoded)[0]
    if prediction == 1:
        st.success("✅ Cette personne est susceptible d’avoir un compte bancaire.")
    else:
        st.warning("⚠️ Cette personne est peu susceptible d’avoir un compte bancaire.")

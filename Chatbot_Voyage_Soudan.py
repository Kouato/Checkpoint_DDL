import streamlit as st
import nltk
import string
import re
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

nltk.download('punkt')
nltk.download('stopwords')

from nltk.corpus import stopwords
from nltk.tokenize import sent_tokenize, word_tokenize

# Chargement du texte
with open("Soldat.txt", "r", encoding="utf-8") as file:
    text = file.read()

sentences = sentences = re.split(r'(?<=[.!?])\s+', text)

#  Prétraitement
def preprocess(sentence):
    stop_words = set(stopwords.words("french"))
    # Découpe des mots simple sans word_tokenize
    words = sentence.lower().split()
    words = [word.strip(string.punctuation) for word in words]
    words = [word for word in words if word not in stop_words and word != '']
    return ' '.join(words)


# Appliquer le prétraitement sur toutes les phrases
processed_sentences = [preprocess(s) for s in sentences]

# Fonction de similarité
def get_most_relevant_sentence(question):
    question_keywords = set(question.lower().split())

    # Sélectionne les phrases contenant des mots communs avec la question
    filtered_sentences = [
        sentence for sentence in sentences 
        if any(word in sentence.lower() for word in question_keywords)
    ]

    if not filtered_sentences:
        return "Je n'ai pas trouvé d'information claire à ce sujet dans le texte."

    # Applique TF-IDF uniquement sur les phrases filtrées
    vectorizer = TfidfVectorizer()
    vectors = vectorizer.fit_transform(filtered_sentences + [question])
    cosine_similarities = cosine_similarity(vectors[-1], vectors[:-1])
    best_index = cosine_similarities.argmax()

    return filtered_sentences[best_index]

# Fonction chatbot
def chatbot(user_input):
    if user_input.strip() == "":
        return "Merci de poser une question."
    else:
        return get_most_relevant_sentence(user_input)

# Interface Streamlit
def main():
    st.title("🤖 Chatbot sur un livre parlant d'un soldat")
    st.write("Posez-moi une question sur ce livre et je vous répondrai en me basant sur le texte fourni.")

    user_input = st.text_input("Votre question :")

    if st.button("Envoyer"):
        response = chatbot(user_input)
        st.markdown(f"**Réponse :** {response}")

if __name__ == "__main__":
    main()

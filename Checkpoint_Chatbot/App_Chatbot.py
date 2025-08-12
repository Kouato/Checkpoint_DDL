import nltk
import streamlit as st
import speech_recognition as sr
import string
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import nltk
from nltk.corpus import stopwords

nltk.download('stopwords')
french_stopwords = stopwords.words('french')


# Télécharger ressources NLTK nécessaires
nltk.download('punkt', quiet=True)
nltk.download('wordnet', quiet=True)

# Charger corpus
with open("chatbot.txt", "r", encoding="utf-8") as f:
    raw = f.read().lower()

sent_tokens = nltk.sent_tokenize(raw)
lemmer = nltk.stem.WordNetLemmatizer()
remove_punct_dict = dict((ord(p), None) for p in string.punctuation)

def LemTokens(tokens):
    return [lemmer.lemmatize(token) for token in tokens]

def LemNormalize(text):
    return LemTokens(nltk.word_tokenize(text.lower().translate(remove_punct_dict)))

def chatbot_response(user_input):
    user_input = user_input.lower()
    sent_tokens.append(user_input)
    vectorizer = TfidfVectorizer(tokenizer=LemNormalize, stop_words=french_stopwords)

    tfidf = vectorizer.fit_transform(sent_tokens)
    vals = cosine_similarity(tfidf[-1], tfidf[:-1])
    idx = vals.argsort()[0][-1]
    flat = vals.flatten()
    flat.sort()
    req_tfidf = flat[-1]
    sent_tokens.pop()  # enlever la requête utilisateur pour ne pas polluer le corpus

    if req_tfidf == 0:
        return "Je ne suis pas sûr de comprendre. Pouvez-vous reformuler ?"
    else:
        return sent_tokens[idx]

def speech_to_text():
    r = sr.Recognizer()
    with sr.Microphone() as source:
        st.info("🎤 Parlez maintenant...")
        audio = r.listen(source)
        try:
            text = r.recognize_google(audio, language="fr-FR")
            st.success(f"Vous avez dit : {text}")
            return text
        except sr.UnknownValueError:
            st.error("Je n'ai pas compris, veuillez réessayer.")
            return ""
        except sr.RequestError:
            st.error("Erreur de service de reconnaissance vocale.")
            return ""

# Interface Streamlit
st.title("🤖 Chatbot vocal & texte autonome")

mode = st.radio("Choisissez mode :", ["Texte", "Voix"])

if mode == "Texte":
    user_text = st.text_input("Votre message :")
    if st.button("Envoyer") and user_text.strip() != "":
        response = chatbot_response(user_text)
        st.write("Bot :", response)

else:
    if st.button("Parler"):
        spoken_text = speech_to_text()
        if spoken_text.strip() != "":
            response = chatbot_response(spoken_text)
            st.write("Bot :", response)

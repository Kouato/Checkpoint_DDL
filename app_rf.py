import streamlit as st
import cv2
import numpy as np
from PIL import Image
import os
import datetime

# Titre de l'application
st.title("🎯 Détection de Visages - Algorithme de Viola-Jones")

# Instructions pour l'utilisateur
st.markdown("""
Bienvenue dans l'application de détection de visages basée sur l'algorithme de **Viola-Jones**.  
Voici comment l'utiliser :

1. 📷 Importez une image à partir de votre ordinateur.
2. 🎨 Choisissez la **couleur** des rectangles de détection.
3. ⚙️ Ajustez les **paramètres de détection** (*scaleFactor* et *minNeighbors*).
4. 🔍 Cliquez sur **"Détecter les visages"** pour lancer la détection.
5. 💾 Cliquez sur **"Enregistrer les visages détectés"** pour les sauvegarder localement.
""")

# Chargement du classifieur pré-entraîné
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

# Upload de l'image
uploaded_file = st.file_uploader("📁 Importer une image", type=["jpg", "jpeg", "png"])

# Choix de la couleur du rectangle
rect_color = st.color_picker("🎨 Choisissez la couleur du rectangle", "#00FF00")  # Vert par défaut

# Paramètres de détection
scaleFactor = st.slider("🔍 Ajustez scaleFactor", min_value=1.01, max_value=2.0, value=1.1, step=0.01)
minNeighbors = st.slider("👥 Ajustez minNeighbors", min_value=1, max_value=10, value=5, step=1)

if uploaded_file is not None:
    # Lecture de l'image avec OpenCV
    image = Image.open(uploaded_file).convert('RGB')
    img_array = np.array(image)
    img_gray = cv2.cvtColor(img_array, cv2.COLOR_RGB2GRAY)

    # Bouton de détection
    if st.button("🔎 Détecter les visages"):
        faces = face_cascade.detectMultiScale(img_gray, scaleFactor=scaleFactor, minNeighbors=minNeighbors)

        st.success(f"{len(faces)} visage(s) détecté(s).")

        # Dessin des rectangles autour des visages
        rect_rgb = tuple(int(rect_color.lstrip('#')[i:i+2], 16) for i in (0, 2, 4))

        for (x, y, w, h) in faces:
            cv2.rectangle(img_array, (x, y), (x + w, y + h), rect_rgb, 2)

        st.image(img_array, caption="Image avec visages détectés", use_container_width=True)


        # Enregistrement des visages détectés
        if st.button("💾 Enregistrer les visages détectés"):
            save_dir = "visages_detectes"
            os.makedirs(save_dir, exist_ok=True)

            timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
            for i, (x, y, w, h) in enumerate(faces):
                face_img = img_array[y:y+h, x:x+w]
                filename = f"{save_dir}/visage_{i+1}_{timestamp}.jpg"
                cv2.imwrite(filename, cv2.cvtColor(face_img, cv2.COLOR_RGB2BGR))

            st.success(f"{len(faces)} visage(s) enregistré(s) dans le dossier '{save_dir}'.")

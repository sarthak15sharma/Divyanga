import numpy as np
from PIL import Image, ImageOps
from keras.models import load_model
from keras.preprocessing import image
from keras.applications.mobilenet_v2 import preprocess_input
import cv2
import os
import pytesseract
from pdf2jpg import pdf2jpg
from transformers import pipeline
import re
import nltk
from nltk import edit_distance
from nltk.corpus import words
import difflib


np.set_printoptions(suppress=True)

img_label_model = load_model("keras_Model.h5", compile=False)
reversal_pred_model = load_model('Yash Phatak/Desktop/Divyanga/keras_model.h5')

def get_img_label():
  try:
    class_names = open("labels.txt", "r").readlines()
    # Create the array of the right shape to feed into the keras model
    # The 'length' or number of images you can put into the array is
    # determined by the first position in the shape tuple, in this case 1
    data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)
    # Replace this with the path to your image
    image = Image.open("Divyanga/thresh_image.jpg").convert("RGB")
    # resizing the image to be at least 224x224 and then cropping from the center
    size = (224, 224)
    image = ImageOps.fit(image, size, Image.Resampling.LANCZOS)
    # turn the image into a numpy array
    image_array = np.asarray(image)
    # Normalize the image
    normalized_image_array = (image_array.astype(np.float32) / 127.5) - 1
    # Load the image into the array
    data[0] = normalized_image_array

    # Predicts the model
    prediction = img_label_model.predict(data)
    index = np.argmax(prediction)
    class_name = class_names[index]
    confidence_score = prediction[0][index]
    return {
       "classname" : class_name,
       "confidence score" : confidence_score
    }
  except Exception as e:
    print("error", e)
  finally:
    print("get-img-label function called")


def predict_reversal(image_path):
  try:
    # Perform thresholding on the image
    image = cv2.imread(image_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    _, thresh = cv2.threshold(gray, 128, 255, cv2.THRESH_BINARY)

    # Save the thresholded image to disk
    cv2.imwrite('thresh_image.jpg', thresh)

    # Load the thresholded image directly as a numpy array
    test_image = cv2.imread('thresh_image.jpg')
    test_image = cv2.resize(test_image, (224, 224))
    test_image = np.expand_dims(test_image, axis=0)


    # Preprocess the image
    test_image = preprocess_input(test_image)

    # Perform prediction
    result = reversal_pred_model.predict(test_image)

    # Convert the probability to a class label
    if result[0][0] > 0.5:
      return {
          'reversal' : True
      }
    else:
      return {
          'reversal' : False
      }
  except Exception as e:
    return {
      'error' : e
    }
  finally:
    print("reversal_prediction function called")


def convert_pdf_to_text(pdf_path, ocr_folder):
  # Convert PDF to images
  pdf2jpg.convert_pdf2jpg(pdf_path,ocr_folder, pages="ALL")
  pdf_name = os.path.splitext(os.path.basename(pdf_path))[0]
  dir_path = os.path.join(ocr_folder,pdf_name+".pdf_dir")
  print(dir_path)
  # Iterate through the generated images and perform OCR
  output_text = ""
  try:
    for filename in os.listdir(dir_path):
      if filename.endswith('.jpg'):
        image_path = os.path.join(dir_path, filename)
        img = cv2.imread(image_path)
        gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        invert = cv2.bitwise_not(gray)
        thresh = cv2.threshold(invert,130,255,cv2.THRESH_BINARY)[1]
        cv2.imwrite(image_path,thresh)
        image = Image.open(image_path)
        text = pytesseract.image_to_string(image,lang='eng')
        output_text += text + '\n'
  except: pass
  return output_text



def spell_check(s1):
  # Load the spelling correction pipeline
  fix_spelling = pipeline("text2text-generation", model="oliverguhr/spelling-correction-english-base")

  input_words = s1.split() # to check each word
  corrections = fix_spelling(s1, max_length=2048) # Using transformer

  # output as array
  corrected_words = re.findall(r'\b\w+\b', corrections[0]['generated_text'])  # Corrected Output

  incorrect_words = []
  count = 0
  for i in range(len(corrected_words)):
    if corrected_words[i].lower() != input_words[i].lower():
      count += 1
      incorrect_words.append(input_words[i])

  # print("Incorrect Words: ",incorrect_words)
  total_words = len(corrected_words)
  error_percentage = (count / total_words) * 100 if total_words != 0 else 0  # error percentage

  # print(error_percentage, " % error detected")

  # Convert both lists to lowercase
  corrected_words_lower = [word.lower() for word in corrected_words]
  input_words_lower = [word.lower() for word in input_words]

  # Find words from corrected_words that are different from input_words
  different_words = [word for word in corrected_words if word.lower() not in input_words_lower]
  # print("Words which were originally wrong:" ,different_words)

  # nltk.download('words')
  english_words = words.words('en')

  # Filter words based on length
  filtered_words = [word for word in english_words if len(word) in {len(w) for w in different_words}]

  # Use difflib for initial efficient suggestions within filtered words
  similar_words_difflib = []
  for word in different_words:
    similar_words_difflib.extend(difflib.get_close_matches(word, filtered_words, n=10, cutoff=0.7))

  # Calculate additional suggestions using edit distance
  for word in different_words:
    max_distance = 0  # Adjust threshold as needed
    additional_words = [w for w in filtered_words if edit_distance(word, w) <= max_distance]
    similar_words_difflib.extend(additional_words[:min(10 - len(similar_words_difflib), len(additional_words))])
  similar_words_difflib = list(set(similar_words_difflib))
  
  # print("Similar words for", different_words, ":", similar_words_difflib)

  # Reversals
  reversal =  ['b','q','d','p']
  reversal2 = ['o','0']
  reversal3 = ['r','y','h']
  reversals = []
  for i in range(len(incorrect_words)):
    old_word = incorrect_words[i]
    word = different_words[i]
    for rev in reversal:
      if rev in word:
        for old_rev in reversal:
          if old_rev in old_word and old_rev!=rev:
            # print("Reversal Detected.")
            # print(f"{old_word} -> {word}")
            # print(f"reversal of {old_rev} -> {rev}")
            reversals.append((old_rev,rev))

    for rev in reversal2:
      if rev in word:
        for old_rev in reversal2:
          if old_rev in old_word and old_rev!=rev:
              # print("Reversal Detected.")
              # print(f"{old_word} -> {word}")
              # print(f"reversal of {old_rev} -> {rev}")
              reversals.append((old_rev,rev))

    for rev in reversal3:
      if rev in word:
        for old_rev in reversal3:
          if old_rev in old_word and old_rev!=rev:
            # print("Reversal Detected.")
            # print(f"{old_word} -> {word}")
            # print(f"reversal of {old_rev} -> {rev}")
            reversals.append((old_rev,rev))

  return {
    'error percentage' : error_percentage,
    'similar words' : similar_words_difflib,
    'reversals' : reversals
  }
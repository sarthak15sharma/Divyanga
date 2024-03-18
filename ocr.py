import os
from pdf2jpg import pdf2jpg
import pytesseract
from PIL import Image
import numpy as np
import cv2

# Function to convert PDF to images and perform OCR
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

# Input folder containing PDFs
input_folder = r'Input'

# Output folder for text files
ocr_folder = 'Output'

# Iterate through the PDFs in the input folder
for filename in os.listdir(input_folder):
    if filename.endswith('.pdf'):
        pdf_path = os.path.join(input_folder, filename)
        output_text = convert_pdf_to_text(pdf_path, ocr_folder)
        
        # Create the output text file with the same name as the PDF (excluding the extension)
        output_file = os.path.splitext(filename)[0] + '.txt'
        output_path = os.path.join(ocr_folder, output_file)
        with open(output_path, 'w', encoding='utf-8') as text_file:
            text_file.write(output_text)   
        print(f"Text extracted and saved to: {output_path}")

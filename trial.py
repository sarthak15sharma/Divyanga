import numpy as np
from keras.preprocessing import image
from keras.applications.mobilenet_v2 import preprocess_input
from keras.models import load_model
import cv2

# Load the model
loaded_model = load_model('Yash Phatak/Desktop/Divyanga/keras_model.h5')

def predict2(image_path):
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
    result = loaded_model.predict(test_image)

    # Convert the probability to a class label
    if result[0][0] > 0.5:
        return "Reversal"
    else:
        return "Normal"

# Example usage
prediction = predict2('dataset/test_camera.jpg')
print("Prediction:", prediction)

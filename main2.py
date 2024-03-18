from fastapi import FastAPI, Request
from PIL import Image
import io

app = FastAPI()

@app.post("/upload_image")
async def upload_image(request: Request):
    # Read the raw body of the request
    image_bytes = await request.json()
    print(image_bytes)
    # Create PIL Image object from bytes
    img = Image.open(io.BytesIO(image_bytes))
    # Save the image as JPEG
    img_path = "uploaded_image.jpg"
    img.save(img_path, format='JPEG')
    
    return {"message": "Image uploaded and saved successfully", "image_path": img_path}

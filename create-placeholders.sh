#!/bin/bash
# Create placeholder images using ImageMagick if available, otherwise use Python PIL

if command -v convert &> /dev/null; then
    # Using ImageMagick
    convert -size 1200x800 xc:#4A90E2 -pointsize 72 -fill white -gravity center -annotate +0+0 "HOUSE\nWASHING" service1-house-washing.jpg
    convert -size 1200x800 xc:#E24A4A -pointsize 72 -fill white -gravity center -annotate +0+0 "DRIVEWAY\nCLEANING" service2-driveway-cleaning.jpg
    convert -size 1200x800 xc:#4AE290 -pointsize 72 -fill white -gravity center -annotate +0+0 "DECK &\nPATIO" service3-deck-cleaning.jpg
    convert -size 1200x800 xc:#E2904A -pointsize 72 -fill white -gravity center -annotate +0+0 "FENCE\nCLEANING" service4-fence-cleaning.jpg
    convert -size 1200x800 xc:#904AE2 -pointsize 72 -fill white -gravity center -annotate +0+0 "COMMERCIAL\nSERVICES" service5-commercial-cleaning.jpg
else
    echo "ImageMagick not available, trying Python"
    python3 << 'PYEOF'
from PIL import Image, ImageDraw, ImageFont

services = [
    ("service1-house-washing.jpg", "#4A90E2", "HOUSE\nWASHING"),
    ("service2-driveway-cleaning.jpg", "#E24A4A", "DRIVEWAY\nCLEANING"),
    ("service3-deck-cleaning.jpg", "#4AE290", "DECK &\nPATIO"),
    ("service4-fence-cleaning.jpg", "#E2904A", "FENCE\nCLEANING"),
    ("service5-commercial-cleaning.jpg", "#904AE2", "COMMERCIAL\nSERVICES")
]

for filename, color, text in services:
    img = Image.new('RGB', (1200, 800), color)
    draw = ImageDraw.Draw(img)
    try:
        font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 72)
    except:
        font = ImageFont.load_default()
    
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    position = ((1200 - text_width) / 2, (800 - text_height) / 2)
    
    draw.text(position, text, fill="white", font=font, align="center")
    img.save(filename, 'JPEG')
    print(f"Created {filename}")
PYEOF
fi

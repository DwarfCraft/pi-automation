# Import the modules
import os
import shutil
import pydicom

# Define the source and target directories
source_dir = input ("Enter the source directory: ")
processed_dir = os.path.join (source_dir, "processed")
review_dir = os.path.join (source_dir, "review")

# Create the target directories if they do not exist
if not os.path.exists (processed_dir):
    os.mkdir (processed_dir)
if not os.path.exists (review_dir):
    os.mkdir (review_dir)

# Loop through the files in the source directory
for file in os.listdir (source_dir):
    # Get the file path
    file_path = os.path.join (source_dir, file)
    # Check if the file is an image file
    if file.lower ().endswith ((".jpg", ".png", ".bmp", ".gif")):
        # Try to read the DICOM metadata from the image file
        try:
            ds = pydicom.dcmread (file_path)
            # Get the DICOM tag for the image description
            image_desc = ds[0x0008, 0x0080].value
            # Create the new file name based on the image description
            new_file = image_desc + os.path.splitext (file) [1]
            # Move and rename the file to the processed directory
            shutil.move (file_path, os.path.join (processed_dir, new_file))
            print (f"Processed {file} as {new_file}")
        # If the file does not have DICOM metadata, handle the exception
        except pydicom.errors.InvalidDicomError:
            # Move the file to the review directory
            shutil.move (file_path, os.path.join (review_dir, file))
            print (f"Moved {file} to the review directory")
    # If the file is not an image file, skip it
    else:
        print (f"Skipped {file}")


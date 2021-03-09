# CoreML Tutorial/Workshop

## Description
This repo contains code for a demo of CoreML integration into an iOS Project. In particular, this project will show how the basics of retrieving an image input from the user (either from the user's photo library or camera), and will show the basics of inputting image data into a CoreML model as well as extracting and displaying the results.

## Important Notes about Usage
1. Due to file size limits, the CoreML model files are not included in this repo. Below are instructions on how to add these files to the project after cloning the repo:
   1. Download CoreML models from source. The SqueezeNet model can be found at https://developer.apple.com/machine-learning/models/, and the CNNEmotions model can be found at https://github.com/likedan/Awesome-CoreML-Models.
   2. After downloading the model file (extension is .mlmodel), open the project on Xcode, and drag the model file into the CoreMLWorkshop folder.
   3. Build Xcode project to make sure there are no errors.
2. The code is currently setup to use 1 of 2 possible models, the SqueezeNet object detection model or the CNNEmotions emotion detection model. In ViewController.swift, you will find a variable called "model" and two possible assignments, one of which will be commented out, and the other one not commented (indicating this is the model in use currently). To switch which model is in use, just switch which model assignment is commented out.
3. To best experience how this app works, I would recommend running the app on an actual iPhone rather than the iOS Simulator. The reason is because both of these CoreML models take in images as input, and the code allows for users to input images either through camera or through the photo library. The simulator cannot use the camera, and the images available in the default simulator photo library are probably insufficient to properly see how these models work and react to various inputs. For that reason, please try to run the app on an actual iPhone.

## Demo
![](demo2.gif)

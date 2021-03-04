# CoreML Tutorial/Workshop

## Description
This repo contains code for a demo of CoreML integration into an iOS Project. The code is currently setup to use 1 of 2 possible models, the SqueezeNet object detection model or the CNNEmotions emotion detection model. In ViewController.swift, you will find a variable called "model" and two possible assignments, one of which will be commented out, and the other one not commented (indicating this is the model in use currently). To switch which model is in use, just switch which model assignment is commented out.

## Important Note about Usage
Due to file size limits, the CoreML model files are not included in this repo. Below are instructions on how to add these files to the project after cloning the repo:
1. Download CoreML models from source. The SqueezeNet model can be found at https://developer.apple.com/machine-learning/models/, and the CNNEmotions model can be found at https://github.com/likedan/Awesome-CoreML-Models.
2. After downloading the model file (extension is .mlmodel), open the project on Xcode, and drag the model file into the CoreMLWorkshop folder.
3. Build Xcode project to make sure there are no errors.
# TutorScore

TutorScore is an application developed to assist beginners or newcomers into music theory. It has a collection of basic music theory data that will help kickstart the interest in music.

The main focus of TutorScore is the Music object detection function. Currently the model can only detect basic music objects.
TutorScore also has a built in metronome to assist musicians in practising their tempo.

## Music Object Detection

In this project, a self-trained object detection model is used to identify music objects on invidual staff lines.
The model is able to identify 5 simple music objects, music note, key signature, time signature, rest, and clef.


The model is trained from TensorFlow and runs in a flutter application smoothly.
Current result of the model requires more training but it is able to identify music notes.

## NOTE
Model is trained after MUSCIMA++ Dataset which can be found here https://ufal.mff.cuni.cz/muscima

Only the tflite model file is provided.
Tested on Android phone but not yet on iOS devices.
To train the model refer to this repository: 


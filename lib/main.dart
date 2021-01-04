import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'Metronome.dart';

//Firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ObjectDetection.dart';

final usersRef = Firestore.instance.collection('description');
int id = 0;

List<String> collectionTitle = ["Music Score", "Music Symbol", "Staff", "Clef", "G Clef", "F Clef", "Music Note", "Rest", "Time Signature", "Key Signature","Metronome"];
List<String> collectionDescription = ["image/music_score.jpg","image/music_symbol.jpg","image/staff.jpg","image/clef.jpg","image/G_clef.jpg","image/F_clef.jpg","image/music_note.jpg","image/rest.jpg","image/time_signature.jpg","image/key_signature.jpg","image/metronome.jpg"];

class BuildTutorBook extends StatefulWidget {
  @override
  _BuildTutorBook createState() => _BuildTutorBook();
}

class _BuildTutorBook extends State<BuildTutorBook> {
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Firestore.instance.collection('Notation Infor').snapshots(),
      builder: (context, snapshot) {
        //If there's no data in that child node
        if (!snapshot.hasData) return Text('Loading data... Please Wait');
        switch (id){
          //Music Note Section
          case 6:{
            final assetsAudioPlayer = AssetsAudioPlayer();
            return Column(children: <Widget>[
              //Retrieve the data from database known as description.
              Text(snapshot.data.documents[0][collectionTitle[id]],
                  style: TextStyle(fontSize: 20)),
              //Buttons for Whole, Half, Quarter, Eighth, and Sixteenth note
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children:<Widget>[
                    //First Row of buttons
                    Row(
                      children: <Widget>[
                        RaisedButton(
                            onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Pitches/whole_note.mp3')),
                            child: Text('Whole Note')
                        ),

                        new Container(
                          margin: EdgeInsets.only(right:5,left:5),
                          child: RaisedButton(
                              onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Pitches/half_note.mp3')),
                              child: Text('Half Note')
                          ),
                        ),
                      ],
                    ),
                    //Second Row of buttons
                    Row(
                      children: <Widget>[
                        RaisedButton(
                            onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Pitches/quarter_note.mp3')),
                            child: Text('Quarter Note')
                        ),

                        new Container(
                          margin: EdgeInsets.only(right:5,left:5),
                          child: RaisedButton(
                              onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Pitches/eighth_note.mp3')),
                              child: Text('Eighth Note')
                          ),
                        ),
                      ],
                    ),
                    //Third Row of buttons
                    Row(
                      children: <Widget>[
                        RaisedButton(
                            onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Pitches/sixteenth_note.mp3')),
                            child: Text('Sixteenth Note')
                        ),
                      ],
                    ),
                  ]
                ),
              ),
              //Image after buttons
              new Container(
                child: Image.asset(
                    'image/music_note_scale.jpg',
                    width: 300,
                    height: 180,
                    ),
                ),
              Text ("The example shown is from C, D, E, F, G, H, A, B which are the position of notes in G Clefs. There are 7 buttons below for you to test out its audio.",
              style: TextStyle(fontSize: 20)),
            //Buttons to play from C, D, E, F, G, A, and B note.
              new Container(
                margin: EdgeInsets.only(top:20),
               child: Column(
                children: <Widget>[
                    //First Row
                    Row(
                      children: <Widget>[
                      RaisedButton(
                      onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Note/c_note.mp3')),
                      child: Text('C Note')
                      ),

                      new Container(
                      margin: EdgeInsets.only(right:5,left:5),
                     child: RaisedButton(
                        onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Note/d_note.mp3')),
                        child: Text('D Note')
                      ),
                    ),
                      RaisedButton(
                        onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Note/e_note.mp3')),
                        child: Text('E Note')
                    ),
                    ],
                  ),
                  //Second Row
                  Row(
                    children: <Widget>[
                      RaisedButton(
                          onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Note/f_note.mp3')),
                          child: Text('F Note')
                      ),

                      new Container(
                        margin: EdgeInsets.only(right:5,left:5),
                        child: RaisedButton(
                            onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Note/g_note.mp3')),
                            child: Text('G Note')
                        ),
                      ),
                      RaisedButton(
                          onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Note/a_note.mp3')),
                          child: Text('A Note')
                      ),
                    ],
                  ),
                  //Third Row
                  Center(
                    child: RaisedButton(
                        onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Note/b_note.mp3')),
                        child: Text('B Note')
                    ),
                  )
                ],
             ),
              ),
            ]
            );
          }
          //Key signature Section
          case 9:{
            //Audio asset file player
            final assetsAudioPlayer = AssetsAudioPlayer();
            return Column(children: <Widget>[
              //Retrieve the data from database known as description.
              Text(snapshot.data.documents[0][collectionTitle[id]],
                  style: TextStyle(fontSize: 20)),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                    children:<Widget>[
                        Image.asset(
                          'image/black_tile.png',
                          width: 300,
                          height: 180,
                          ),
                      //First Row of key signature
                      Row(
                        children: <Widget>[
                          RaisedButton(
                              onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Blacktile/C_D_black.mp3')),
                              child: Text('C#/D♭')
                          ),

                          new Container(
                            margin: EdgeInsets.only(right:5,left:5),
                            child: RaisedButton(
                                onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Blacktile/D_E_black.mp3')),
                                child: Text('D#/E♭')
                            ),
                          ),
                          RaisedButton(
                              onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Blacktile/F_G_black.mp3')),
                              child: Text('F#/G♭')
                          ),
                        ],
                      ),
                      //Second Row of key signature
                      Row(
                        children: <Widget>[
                          RaisedButton(
                              onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Blacktile/G_A_black.mp3')),
                              child: Text('G#/A♭')
                          ),

                          new Container(
                            margin: EdgeInsets.only(right:5,left:5),
                            child: RaisedButton(
                                onPressed:() => assetsAudioPlayer.open(Audio('assets/audio/Blacktile/A_B_black.mp3')),
                                child: Text('A#/B♭')
                            ),
                          ),
                        ],
                      ),
                    ]
                ),
              )
            ]
            );
          }
          //Default printing display for all section
          default:
              return Column(children: <Widget>[
              //Retrieve the data from database known as description.
                Text(snapshot.data.documents[0][collectionTitle[id]],
                  style: TextStyle(fontSize: 20)),
                ]
              );
        }

      },
    );
  }

}

void main() {
  runApp(MaterialApp(
    title: 'Project Application',
    home: FirstRoute(),
  ));
}


//Main Menu of TutorScore
class FirstRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TutorScore'),
      ),
      backgroundColor: Color(0xffeceff1),
      body: ListView(
          children:[
        //Logo display in main menu
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Image.asset(
          'image/Logo.jpg',
          width: 170,
          height: 170,
          ),
        ),
        //Title displaying application name
        Container(
            child: new Center(
              child: Text("TutorScore",style: TextStyle(height: 2, fontWeight: FontWeight.bold, fontSize: 30))
             )),
        Container(
          margin: EdgeInsets.only( top : 10 , bottom : 20, left : 60 , right : 60),
          padding: EdgeInsets.only(left: 40, right: 40),
         child: Column(
             children: <Widget>[
               //Button detection to navigate TutorBook page
               new GestureDetector(
                   onTap:(){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => TutorBook()),
                     );
                   },
                   //Button design properties
                   child: new Container(
                     decoration: BoxDecoration(
                       color: const Color(0xffb0bec5),
                       border: Border.all(
                         color: Colors.black,
                         width: 2,
                       ),
                       borderRadius: BorderRadius.circular(12),
                     ),

                     width: 500,
                     padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                     margin: new EdgeInsets.only(top: 10, bottom: 10),

                     child: new Column(
                         children: [
                           new Text("TutorBook"),
                         ]
                     ),
                   )
               ),
               //Button detection to navigate Metronome page
               new GestureDetector(
                   onTap:(){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => MetronomePage()),
                     );
                   },
                   //Button design properties
                   child: new Container(
                     decoration: BoxDecoration(
                       color: const Color(0xffb0bec5),
                       border: Border.all(
                         color: Colors.black,
                         width: 2,
                       ),
                       borderRadius: BorderRadius.circular(12),
                     ),

                     width: 500,
                     padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                     margin: new EdgeInsets.only(top: 10, bottom: 10),

                     child: new Column(
                         children: [
                           new Text("Metronome"),
                         ]
                     ),
                   )
               ),
               //Button detection to navigate ObjectDetection page.
               new GestureDetector(
                   onTap:(){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => TfliteHome()),
                     );
                   },
                   //Button design properties
                   child: new Container(
                     decoration: BoxDecoration(
                       color: const Color(0xffb0bec5),
                       border: Border.all(
                         color: Colors.black,
                         width: 2,
                       ),
                       borderRadius: BorderRadius.circular(12),
                     ),

                     width: 500,
                     padding: new EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                     margin: new EdgeInsets.only(top: 10, bottom: 10),

                     child: new Column(
                         children: [
                           new Text("MOB"),
                         ]
                     ),
                   )
               ),
          ],
          ),
        ),
        ],
         ),
    );


  }
}
//Selection page of TutorBook
class TutorBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TutorBook"),
        ),
        backgroundColor: Color(0xffb0bec5),
        //To generate a list of buttons
        body: ListView.builder(
          itemCount: collectionTitle.length,
          itemBuilder: (context, index){
            return ListTile(
              //Button detection
              title: new GestureDetector(
                  onTap:(){
                    //Button ID for navigation purposes
                    id = index;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdRoute()),
                    );
                  },
                  //Design properties of button
                  child: new Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffeceff1),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    width: 500,
                    padding: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    margin: new EdgeInsets.only(top: 5, bottom: 5),

                    child: new Column(
                        children: [
                          new Text(collectionTitle.elementAt(index)),
                        ]
                    ),
                  )
              ),
            );
          }

        )

    );
  }

}
//Third Page
class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(collectionTitle.elementAt(id)),
        ),
        backgroundColor: Color(0xffeceff1),
        //Structure of TutorBook Info with listview
        body: ListView(
           children: [
             //Container for header image.
             Container(
               decoration: BoxDecoration(
                 border: Border.all(
                   color: Colors.black,
                   width:2,
                 ),
               ),
               child: Image.asset(
                 //Retrieve image url from list based on button ID.
                 collectionDescription.elementAt(id),
                 width: 200,
                 height: 200,
               ),
               margin: new EdgeInsets.only(top: 10),
             ),
             //Second Container for information on subject
             Container(
              decoration: BoxDecoration(
              color: Color(0xffb0bec5),
              border: Border.all(
              color: Colors.black,
              width:2,
              ),
              borderRadius: BorderRadius.circular(12),
               ),
               padding: new EdgeInsets.all(15),
               margin: EdgeInsets.all(25),
               //Retrieve from function BuildTutorBook.
               child: BuildTutorBook(),
              ),
          ],
        ),
    );
  }
}

//Metronome
class MetronomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metronome'),
      ),
      backgroundColor: Color(0xffeceff1),
      body: MetronomeControl(),
    );
  }
}

class ObjectDetectionPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return TfliteHome();
  }
}










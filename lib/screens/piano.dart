import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'package:flutter_midi_pro/flutter_midi_pro.dart';

class Piano extends StatefulWidget {
  const Piano({super.key});

  @override
  State<Piano> createState() => _PianoState();
}

class _PianoState extends State<Piano> {
  final midiPro = MidiPro();
  loadAsset() async {
    await midiPro.loadSoundfont(sf2Path: 'assets/Piano.sf2');
  }

  @override
  initState() {
    loadAsset().then((value) {
      midiPro.playMidiNote(midi: 60);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractivePiano(
        naturalColor: Colors.white,
        accidentalColor: Colors.black,
        animateHighlightedNotes: true,
        hideNoteNames: true,
        useAlternativeAccidentals: true,
        keyWidth: 50,
        noteRange: NoteRange.forClefs([
          Clef.Alto,
        ]),
        onNotePositionTapped: (position) {
          // Use an audio library like flutter_midi to play the sound
          midiPro.playMidiNote(midi: position.pitch);
        },
      ),
    );
  }
}

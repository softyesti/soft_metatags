// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:soft_metatags/soft_metatags.dart';

Future<void> main() async {
  await SoftMetaTags.initialize();

  print('-------------- Reading a file --------------');
  await _read();

  print('---------- Reading multiple files ----------');
  await _readAll();
}

Future<void> _read() async {
  final stopwatch = Stopwatch()..start();

  final file = File(p.join(p.current, 'example', 'new_america.mp3'));
  final song = await SoftMetaTags.instance.read(file);

  stopwatch.stop();

  final bpm = song?.bpm ?? '-';
  final year = song?.year ?? '-';
  final mood = song?.mood ?? '-';
  final isrc = song?.isrc ?? '-';
  final title = song?.title ?? '-';
  final label = song?.label ?? '-';
  final lyrics = song?.lyrics ?? '-';
  final barcode = song?.barcode ?? '-';
  final composer = song?.composer ?? '-';
  final lyricist = song?.lyricist ?? '-';
  final duration = song?.duration ?? '-';
  final performer = song?.performer ?? '-';
  final conductor = song?.conductor ?? '-';
  final copyright = song?.copyright ?? '-';
  final encodedBy = song?.encodedBy ?? '-';
  final totalDisc = song?.disc?.total ?? '-';
  final album = song?.mainAlbum?.title ?? '-';
  final discNumber = song?.disc?.number ?? '-';
  final artist = song?.mainArtist?.name ?? '-';
  final totalTracks = song?.track?.total ?? '-';
  final trackNumber = song?.track?.number ?? '-';
  final catalogNumber = song?.catalogNumber ?? '-';
  final genre = song?.genres?.firstOrNull?.name ?? '-';
  final albumArtist = song?.mainAlbum?.mainArtist?.name ?? '-';

  print('BPM: $bpm');
  print('Year: $year');
  print('Mood: $mood');
  print('ISRC: $isrc');
  print('Title: $title');
  print('Album: $album');
  print('Genre: $genre');
  print('Label: $label');
  print('Lyrics: $lyrics');
  print('Artists: $artist');
  print('Barcode: $barcode');
  print('Composer: $composer');
  print('Duration: $duration');
  print('Lyricist: $lyricist');
  print('Copyright: $copyright');
  print('Conductor: $conductor');
  print('Performer: $performer');
  print('Total disc: $totalDisc');
  print('Encoded by: $encodedBy');
  print('Disc number: $discNumber');
  print('Track number: $trackNumber');
  print('Total tracks: $totalTracks');
  print('Album artists: $albumArtist');
  print('Catalog number: $catalogNumber');
  print('-------------------- Elapsed: ${stopwatch.elapsed}');
}

Future<void> _readAll() async {
  final stopwatch = Stopwatch()..start();

  final files = await Directory('/Users/josereia/Music')
      .list(recursive: true)
      .where((fs) => _exts.any((e) => p.extension(fs.path) == e))
      .map((fs) => File(fs.path))
      .toList();

  final songs = await SoftMetaTags.instance.readAll(files);

  stopwatch.stop();

  print('Count: ${songs.length}');
  print('-------------------- Elapsed: ${stopwatch.elapsed}');
}

const _exts = [
  '.mp3',
  '.flac',
  '.mp4',
  '.m4a',
  '.m4v',
  '.m4b',
];

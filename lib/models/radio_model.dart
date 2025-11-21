// lib/model/radio_model.dart
class RadioModel {
  final String? image;
  final String? title;
  final String? subtitle;
  final String? serial;
  final String? audioUrl;
  RadioModel({required this.image,required  this.title, required this.subtitle,required  this.serial, required this.audioUrl});

  factory RadioModel.fromJson(Map json) => RadioModel(
    image:json['image'],
    title:json['title'],
    subtitle:json['subtitle'],
    serial:json['votes']?.toString(),
    audioUrl: json['audio_url'],
  );
}
// radio stream url search engine: https://streamurl.link/
// check bbc links: https://garfnet.org.uk/download/radio/bbc-radio.txt?spm=5aebb161.2ef5001f.0.0.7d725171xGHNfz&file=bbc-radio.txt
List<RadioModel> radioList2 = [
  RadioModel(
    image: 'https://picsum.photos/200?random=1',
    title: 'Radio Bhumi',
    subtitle: 'Biswashey Bangladesh',
    serial: '1',
    audioUrl: "http://stream.zeno.fm/7yu7rczw34zuv",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=2',
    title: 'Gaan Baksho - HD Bangla Radio',
    subtitle: 'পৃথিবী মাতুক বাংলা গানে',
    serial: '2',
    audioUrl: "https://listen.openstream.co/5013/audio",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=3',
    title: 'Bengali Radio Live',
    subtitle: 'Best Of Bengali Beats',
    serial: '3',
    audioUrl: "http://s2.xrad.io:8072/;stream/2",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=4',
    title: 'Classic FM', // new
    subtitle: 'classic fm',
    serial: '4',
    audioUrl: "https://media-ice.musicradio.com/ClassicFMMP3",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=5',
    title: 'BBC World',
    subtitle: 'bbc_world_service',
    serial: '5',
    audioUrl: "http://stream.live.vc.bbcmedia.co.uk/bbc_world_service", //updated
    //audioUrl: "https://as-hls-ww-live.akamaized.net/pool_904/live/ww/bbc_world_service/bbc_world_service.isml/bbc_world_service-audio%3d96000.norewind.m3u8",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=6',
    title: 'BBC Radio 1',
    subtitle: 'bbc radio 1',
    serial: '6',
    audioUrl: 'https://lstn.lv/bbcradio.m3u8?station=bbc_radio_one&bitrate=320000', // new
    //audioUrl: "https://as-hls-ww.live.cf.md.bbci.co.uk/pool_904/live/ww/bbc_radio_one/bbc_radio_one.isml/bbc_radio_one-audio%3d96000.norewind.m3u8",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=7',
    title: 'BBC Radio 6 Music',
    subtitle: 'music',
    serial: '7',
    audioUrl: 'https://lstn.lv/bbcradio.m3u8?station=bbc_6music&bitrate=320000', // new added
    //audioUrl: "https://as-hls-ww-live.akamaized.net/pool_904/live/ww/bbc_6music/bbc_6music.isml/bbc_6music-audio%3d96000.norewind.m3u8",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=8',
    title: 'Capital FM (UK)', // new
    subtitle: 'pop music and entertainment',
    serial: '8',
    audioUrl: "https://media-ice.musicradio.com/CapitalMP3",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=9',
    title: 'Triple J (Australia)', // new
    subtitle: 'new and alternative music',
    serial: '9',
    audioUrl: "https://live-radio01.mediahubaustralia.com/2TJW/mp3/",
  ),

  RadioModel(
    image: 'https://picsum.photos/200?random=10',
    title: 'France Inter (France)', // new
    subtitle: 'news, talk shows, and music',
    serial: '10',
    audioUrl: "https://direct.franceinter.fr/live/franceinter-midfi.mp3",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=11',
    title: 'Lofi Music',
    subtitle: 'lofi: a place to escape reality~.',
    serial: '11',
    audioUrl: "https://lofi.stream.laut.fm/lofi",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=12',
    title: 'LoFi Focus',
    subtitle: 'Lofi Beats to sleep/study...',
    serial: '12',
    audioUrl: "https://lofi.stream.laut.fm/lofi",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=13',
    title: 'Song',
    subtitle: '1-live-minden.',
    serial: '13',
    audioUrl: "https://song.stream.laut.fm/song",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=14',
    title: 'JAM FM',
    subtitle: 'Black and Dance Hits von morgen',
    serial: '14',
    audioUrl: "http://stream.jam.fm/jamfm-nmr/mp3-192/",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=15',
    title: '90s90s Hiphop',
    subtitle: 'Die 90er waren ohne Zweifel die goldenen Jahre für Rap und Hiphop',
    serial: '15',
    audioUrl: "http://streams.90s90s.de/hiphop/mp3-192/",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=16',
    title: 'Radio City Hindi',
    subtitle: 'Online Radio. Anytime, Anywhere.',
    serial: '16',
    audioUrl: "https://stream.zeno.fm/u7sgq72zrf9uv",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=17',
    title: 'Radio Dil',
    subtitle: 'Bhaktisangeet',
    serial: '17',
    audioUrl: "https://us3.streamingpulse.com/ssl/radiodil2",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=18',
    title: 'Hindi Desi Bollywood Evergreen Hits',
    subtitle: 'Best of Hindi Desi Bollywood Evergreen Hits',
    serial: '18',
    audioUrl: "http://cast2.asurahosting.com:8569/stream",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=19',
    title: 'Mera Sangeet USA',
    subtitle: 'No. 1 Hindi Radio Station in the US',
    serial: '19',
    audioUrl: "https://playerservices.streamtheworld.com/api/livestream-redirect/MS_EAST_S01.mp3",
  ),
  RadioModel(
    image: 'https://picsum.photos/200?random=20',
    title: 'Oye India Radio',
    subtitle: 'Your Life-Your Music',
    serial: '20',
    audioUrl: "http://janus.shoutca.st:8060/stream",
  ),
];

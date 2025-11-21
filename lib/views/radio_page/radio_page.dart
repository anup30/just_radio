import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_radio/constants/colors.dart'; // Ensure this matches your project structure
import 'package:just_radio/models/radio_model.dart'; // Ensure this matches your project structure
import 'package:just_radio/views/radio_page/widgets/custom_radio_list_tile.dart'; // Ensure this matches your project structure
import 'package:responsive_sizer/responsive_sizer.dart';

// Import your list
import '../../main.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  List<RadioModel>? radioList;
  RadioModel? currentPlayingRadio;

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false;
  double _volume = 1.0;

  bool get isRadioSelected => currentPlayingRadio != null;

  @override
  void initState() {
    super.initState();
    radioList = radioList2;

    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      setState(() {
        _isPlaying = isPlaying;
        if (kIsWeb) {
          // Web fix for buffering state
          _isLoading = processingState == ProcessingState.loading;
        } else {
          _isLoading = processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering;
        }
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playRadio(RadioModel radio) async {
    try {
      setState(() {
        currentPlayingRadio = radio;
      });
      await _player.setUrl(radio.audioUrl ?? "");
      _player.play();
    } catch (e) {
      print("Error loading audio: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot play this station: ${e.toString()}")),
      );
    }
  }

  // FIXED: Removed arguments.
  // UPDATED: Width set to 40.w
  Widget _buildVolumeSlider() {
    return SizedBox(
      width: 30.w, // 30% of screen width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.volume_mute_rounded, color: Colors.grey, size: 20),
          Expanded(
            child: Slider(
              activeColor: CustomColors.primary,
              inactiveColor: CustomColors.primary.withOpacity(0.2),
              value: _volume,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _volume = value;
                });
                _player.setVolume(value);
              },
            ),
          ),
          const Icon(Icons.volume_up_rounded, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Radio App"),
        // ADDED: 3-Dot Menu
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("About Developer"),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("App built by Anup Barua"),
                        SizedBox(height: 8),
                        Text("Email: anupbarua30@gmail.com"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SizedBox(
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isRadioSelected) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                        maxWidth: 300,
                      ),
                      child: Image.network(
                        currentPlayingRadio!.image ?? "",
                        width: 50.w,
                        height: 50.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, obj, _) => Container(
                          color: CustomColors.primary.withOpacity(0.2),
                          width: 50.w,
                          height: 50.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 55.w,
                  child: Text(
                    "${currentPlayingRadio!.serial}. ${currentPlayingRadio!.title ?? "No title"}",
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 55.w,
                  child: Text(
                    currentPlayingRadio!.subtitle ?? "No info",
                    style: textTheme.titleMedium?.copyWith(color: Colors.black54),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 16),

                // PLAYER CONTROLS
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_player.playing) {
                          _player.pause();
                        } else {
                          _player.play();
                        }
                      },
                      child: Container(
                        width: 58,
                        height: 58,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: CustomColors.primary.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 4,
                                offset: const Offset(0, 2))
                          ],
                          shape: BoxShape.circle,
                          color: CustomColors.primary,
                        ),
                        child: _isLoading
                            ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                            : Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // FIXED: Calling the function without arguments
                _buildVolumeSlider(),
              ],

              const SizedBox(height: 26),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Available Radios",
                    style: textTheme.titleLarge,
                  )),
              const SizedBox(height: 8),
              Expanded(
                child: radioList == null
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.separated(
                    itemBuilder: (context, index) => CustomRadioListTile(
                      radio: radioList![index],
                      isPlaying: currentPlayingRadio == radioList![index] && _isPlaying,
                      onTap: () {
                        _playRadio(radioList![index]);
                      },
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: radioList!.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
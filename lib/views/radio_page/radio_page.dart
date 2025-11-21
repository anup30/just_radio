import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart'; // Import just_audio
import 'package:just_radio/constants/colors.dart';
import 'package:just_radio/models/radio_model.dart'; // Ensure this path is correct based on your project
import 'package:just_radio/views/radio_page/widgets/custom_radio_list_tile.dart'; // Ensure this path is correct
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Import your list
import '../../main.dart'; // Assuming radioList2 is in main.dart, otherwise import where it is defined.

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  List<RadioModel>? radioList;
  RadioModel? currentPlayingRadio;

  // 1. Initialize just_audio player
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false;

  double _volume = 1.0; // Default to 100% ///
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
          // WEB FIX: Live streams on web often stay in 'buffering' state forever.
          // So on web, we ONLY show the spinner during the initial 'loading' phase.
          _isLoading = processingState == ProcessingState.loading;
        } else {
          // MOBILE: We can trust the buffering state on Android/iOS.
          _isLoading = processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering;
        }
      });
    });
  }

  @override
  void dispose() {
    // 3. Always dispose the player when the widget is closed
    _player.dispose();
    super.dispose();
  }

  Future<void> _playRadio(RadioModel radio) async {
    try {
      setState(() {
        currentPlayingRadio = radio;
      });

      // 4. Load the URL
      await _player.setUrl(radio.audioUrl ?? "");

      // 5. Play
      _player.play();
    } catch (e) {
      print("Error loading audio source: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot play this station: ${e.toString()}")),
      );
    }
  }

  Widget _buildVolumeSlider(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.volume_mute_rounded, color: Colors.grey),
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
          const Icon(Icons.volume_up_rounded, color: Colors.grey),
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
        title: const Text("Radio App"), // Replaced Image for simplicity in this snippet
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
                    // IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
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
                    // IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
                  ],
                ),
                // --- ADD THE SLIDER HERE ---
                const SizedBox(height: 16),
                _buildVolumeSlider(textTheme),
                // ---------------------------
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
                      // Logic to show playing icon on the list item if it matches current
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
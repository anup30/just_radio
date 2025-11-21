import 'package:flutter/material.dart';
import 'package:just_radio/constants/colors.dart';
import 'package:just_radio/models/radio_model.dart';

class CustomRadioListTile extends StatelessWidget {
  const CustomRadioListTile({
    super.key,
    required this.radio,
    required this.isPlaying,
    required this.onTap
  });
  final RadioModel radio;
  final bool isPlaying;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme; // here, 'cos context use
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero, // horizontal padding of the tile
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(radio.image??'', width: 40,height: 40,fit: BoxFit.cover,),
      ),
      horizontalTitleGap: 8, // gap between leading & title
      title: Transform.translate( // either Transform.translate or horizontalTitleGap
        offset: const Offset(0, 0), // -8, 0
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              radio.serial??'',
              style: textTheme.bodyMedium?.copyWith(
                  color: isPlaying? CustomColors.primary:null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    radio.title??'No title available',
                    style: const TextStyle(fontWeight: FontWeight.bold,),
                  ),
                  Text(
                      radio.subtitle??'No information available',
                      maxLines:1,
                      overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      trailing: Image.asset("assets/more.png"), // const Icon(Icons.more_vert),
    );
  }
}

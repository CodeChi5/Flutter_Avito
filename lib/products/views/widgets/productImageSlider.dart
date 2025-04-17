import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<String> images;

  const ImageSlider({super.key, required this.images});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            return Image.network(
              widget.images[index],
              fit: BoxFit.contain,
              width: double.infinity,
            );
          },
        ),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
            return Container(
              margin: EdgeInsets.all(5),
              width: _currentIndex == index ? 12 : 8,
              height: _currentIndex == index ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blue : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}

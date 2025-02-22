import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderComponent extends StatefulWidget {
  const SliderComponent({super.key});

  @override
  State<SliderComponent> createState() => _SliderComponentState();
}

class _SliderComponentState extends State<SliderComponent> {
  int carouselsliderindex = 0;

  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  List<String> allimages = [
    "https://images.freeimages.com/images/large-previews/6b0/nature-1056154.jpg?fmt=webp&w=500",
    "https://images.freeimages.com/images/large-previews/721/energetic-meadow-puppy-frolic-0410-5698635.jpg?fmt=webp&w=500",
    "https://images.freeimages.com/images/large-previews/abc/nature-1370825.jpg?fmt=webp&w=500",
    "https://media.istockphoto.com/id/510682838/photo/the-dance-competition.webp?b=1&s=612x612&w=0&k=20&c=urFdjgNFxikdDUhGOlyu_vh6fa24iDGuB6rr5aDOB3o=",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CarouselSlider(
            carouselController: carouselSliderController,
            options: CarouselOptions(
                height: 400,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (val, _) {
                  setState(() {
                    carouselsliderindex = val;
                  });
                }),
            items: List.generate(allimages.length, (i) {
              return Container(
                alignment: Alignment.center,
                child: Image.network(allimages[i]),
              );
            })),
        Container(
          width: 150,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(allimages.length, (i) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    carouselsliderindex = i;
                  });
                  //carouselSliderController.jumpToPage(i);
                  carouselSliderController.animateToPage(i,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor:
                      (i == carouselsliderindex) ? Colors.blue : Colors.grey,
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}

import 'package:dicoding_destination_app/model/tourism_place.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return DetailWebPage(
              place: place,
              informationTextStyle: informationTextStyle,
            );
          } else {
            return DetailMobilePage(
              place: place,
              informationTextStyle: informationTextStyle,
            );
          }
        },
      ),
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;
  final TextStyle informationTextStyle;

  const DetailWebPage({
    super.key,
    required this.place,
    required this.informationTextStyle,
  });

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Place
                Text(
                  widget.place.name,
                  style: TextStyle(
                    fontFamily: 'Staatliches',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.0),

                // Image and Information
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and Gallery
                    Expanded(
                      child: Column(
                        children: [
                          // Main Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(widget.place.imageAsset),
                          ),
                          const SizedBox(height: 16.0),

                          // Image Gallery
                          SizedBox(
                            height: 150,
                            child: Scrollbar(
                              controller: _scrollController,
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ListView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  children: widget.place.imageUrls.map((url) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        child: Image.network(url),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    // Information
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // Place Name
                              Text(
                                widget.place.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Staatliches',
                                ),
                              ),

                              // Open Days
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        widget.place.openDays,
                                        style: widget.informationTextStyle,
                                      ),
                                    ],
                                  ),
                                  FavoriteButton(),
                                ],
                              ),

                              // Open Time
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.access_time),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    widget.place.openTime,
                                    style: widget.informationTextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),

                              // Ticket Price
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.monetization_on),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    widget.place.ticketPrice,
                                    style: widget.informationTextStyle,
                                  ),
                                ],
                              ),

                              // Description
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                child: Text(
                                  widget.place.description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailMobilePage extends StatelessWidget {
  const DetailMobilePage({
    super.key,
    required this.place,
    required this.informationTextStyle,
  });

  final TourismPlace place;
  final TextStyle informationTextStyle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(place.imageAsset),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      FavoriteButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: Text(
              place.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Staatliches',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(height: 8.0),
                    Text(place.openDays, style: informationTextStyle),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(height: 8.0),
                    Text(place.openTime, style: informationTextStyle),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.monetization_on_outlined),
                    SizedBox(height: 8.0),
                    Text(place.ticketPrice, style: informationTextStyle),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              place.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: place.imageUrls.map((url) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(url, fit: BoxFit.cover),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
        final snackBar = SnackBar(
          content: Text(
            isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      color: Colors.red,
      tooltip: 'Add to Favorites',
    );
  }
}

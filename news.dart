import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  int _selectedIndex = 0;

  final List<Map<String, String>> facts = [
    {
      "image": "assets/images/world.jpg",
      "fact":
          "If 33 million people stand in a line holding hands, they can form a path around the earth."
    },
    {
      "image": "assets/images/snake.jpg",
      "fact":
          "A snake can detect an earthquake five days in advance and can sense it from 75 miles away."
    },
    {
      "image": "assets/images/rose.jpg",
      "fact": "The king of flower is rose but queen of flower is Gul-e-Daudi."
    },
    {
      "image": "assets/images/height.jpg",
      "fact":
          "Yes, this fact is scientifically accurate. Throughout the day, our body slightly compresses, especially our spinal cord, due to the effect of gravity. In the morning, we may be around 1% shorter than we were in the evening."
    },
    {"image": "assets/images/mo.jpg", "fact": "A Octopus has three heart"},
  ];

  late List<bool> isLiked;
  late List<int> likeCount;
  late List<bool> isBookmarked;
  List<Map<String, String>> bookmarkedFacts = [];

  @override
  void initState() {
    super.initState();
    isLiked = List.generate(facts.length, (index) => false);
    likeCount = List.generate(facts.length, (index) => 0);
    isBookmarked = List.generate(facts.length, (index) => false);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleBookmark(int index) {
    setState(() {
      isBookmarked[index] = !isBookmarked[index];
      if (isBookmarked[index]) {
        bookmarkedFacts.add(facts[index]);
      } else {
        bookmarkedFacts
            .removeWhere((fact) => fact["fact"] == facts[index]["fact"]);
      }
    });
  }

  Widget _buildFactCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              facts[index]["image"]!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  facts[index]["fact"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'DancingScript',
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Like Button
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 50,
                      color: isLiked[index] ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked[index] = !isLiked[index];
                        likeCount[index] = isLiked[index]
                            ? likeCount[index] + 1
                            : likeCount[index] - 1;
                      });
                    },
                  ),

                  Text(
                    'Likes: ${likeCount[index]}',
                    style: const TextStyle(fontSize: 18),
                  ),

                  // Bookmark Button
                  IconButton(
                    icon: Icon(
                      isBookmarked[index]
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 40,
                      color: isBookmarked[index] ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      _toggleBookmark(index);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informative Fact'),
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
              itemCount: facts.length,
              itemBuilder: (context, index) {
                return _buildFactCard(index);
              },
            )
          : _selectedIndex == 1
              ? bookmarkedFacts.isEmpty
                  ? const Center(
                      child: Text(
                        'No bookmarks yet!',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: bookmarkedFacts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  bookmarkedFacts[index]["image"]!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  bookmarkedFacts[index]["fact"]!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'DancingScript',
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    )
              : const Center(
                  child: Text('Search Page', style: TextStyle(fontSize: 24))),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

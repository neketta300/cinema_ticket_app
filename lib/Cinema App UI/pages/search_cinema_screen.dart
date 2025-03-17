import 'package:cinema_ticket_app/Cinema%20App%20UI/Widget/search_text_field.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/consts.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/models/movie_model.dart';
import 'package:cinema_ticket_app/Cinema%20App%20UI/pages/detail_page.dart';
import 'package:flutter/material.dart';

class SearchCinemaScreen extends StatefulWidget {
  const SearchCinemaScreen({super.key});

  @override
  State<SearchCinemaScreen> createState() => _SearchCinemaScreenState();
}

class _SearchCinemaScreenState extends State<SearchCinemaScreen> {
  TextEditingController searchController = TextEditingController();
  List<Movie> _foundFilm = [];

  @override
  void initState() {
    super.initState();
    _foundFilm = movies;
    searchController.addListener(() {
      _runFilter(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Функция для фильтрации фильмов
  void _runFilter(String nameOfFilm) {
    setState(() {
      if (nameOfFilm.isEmpty) {
        _foundFilm = movies;
      } else {
        _foundFilm = movies
            .where((movie) =>
                movie.title.toLowerCase().contains(nameOfFilm.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchTextField(
              hintText: "Search",
              controller: searchController,
              onChanged: (value) {
                _runFilter(value); // Фильтруем фильмы при изменении текста
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: _foundFilm.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: _foundFilm[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            width: 130,
                            fit: BoxFit.cover,
                            image: NetworkImage(_foundFilm[index]
                                .poster), // Исправлено: используем _foundFilm
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _foundFilm[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _foundFilm[index].synopsis,
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

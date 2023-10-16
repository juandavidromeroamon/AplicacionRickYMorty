import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/character.dart';
import '../../domain/entities/episode.dart';
import '../../domain/entities/location.dart';
import '../widgets/search_result_item.dart';
import '../bloc/search_I.dart/search_bloc.dart';
import '../bloc/search_I.dart/search_event.dart';
import '../bloc/search_I.dart/search_state.dart';
import '../widgets/searchs_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> selectedCategories = ['character', 'episode', 'location'];
  ScrollController _scrollController = ScrollController();
  double opacity = 1.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    context.read<SearchBloc>().add(
          SearchQueryChanged(query: query, categories: selectedCategories),
        );
  }

  void _handleCategorySelection(String value) {
    setState(() {
      if (selectedCategories.contains(value)) {
        selectedCategories.remove(value);
      } else {
        selectedCategories.add(value);
      }
    });
    context
        .read<SearchBloc>()
        .add(CategoriesChanged(categories: selectedCategories));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> avatarMap = {
      'Character': 'url_to_character_avatar',
      'Episode': 'url_to_episode_avatar',
      'Location': 'url_to_location_avatar',
    };

    return Scaffold(
      backgroundColor: Color(0xFF2E8B57),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: SearchsBar(
              // Asegúrate de que este widget esté definido en tu código.
              onChanged: _handleSearch,
              onCategorySelected: _handleCategorySelection,
              selectedCategories: selectedCategories,
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            flex: 8,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification &&
                    _scrollController.hasClients) {
                  final itemHeight = 150.0;
                  final delta = _scrollController.offset % itemHeight;
                  setState(() {
                    opacity = (1 - delta / itemHeight).clamp(0.0, 1.0);
                  });
                }
                return true;
              },
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchSuccess) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final result = state.results[index];
                        String subtitle;
                        String avatarUrl;
                        // Aquí es donde determinas subtitle y avatarUrl basándote en tu modelo de datos.
                        if (result is Character) {
                          subtitle = result.status;
                          avatarUrl = result.image;
                        } else if (result is Episode) {
                          subtitle = result.airDate;
                          avatarUrl = avatarMap['Episode']!;
                        } else if (result is Location) {
                          subtitle = result.dimension;
                          avatarUrl = avatarMap['Location']!;
                        } else {
                          subtitle = "Unknown Type";
                          avatarUrl = "url_to_default_avatar";
                        }

                        return SearchResultItem(
                          result: result,
                          subtitle: subtitle,
                          avatarUrl: avatarUrl,
                          opacity: index ==
                                  (_scrollController.offset / 150.0).floor()
                              ? opacity
                              : 1.0,
                        );
                      },
                    );
                  } else if (state is SearchFailure) {
                    return Center(child: Text(state.error));
                  } else {
                    return Center(child: Text('Start Searching'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

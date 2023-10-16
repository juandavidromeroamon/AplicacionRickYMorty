import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/search_result_item.dart';
import '../../bloc/episode/episode_bloc.dart';
import '../../bloc/episode/episode_event.dart';
import '../../bloc/episode/episode_state.dart';

import '../../widgets/searchs_bar.dart';

class EpisodePage extends StatefulWidget {
  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  ScrollController _scrollController = ScrollController();
  double opacity = 1.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    BlocProvider.of<EpisodeBloc>(context).add(SearchEpisodesEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E8B57),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: SearchsBar(
              // Cambié a SearchBar porque en tu código estaba como SearchsBar
              onChanged: _handleSearch,
              onCategorySelected: (category) {},
              selectedCategories: [],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
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
              child: BlocConsumer<EpisodeBloc, EpisodeState>(
                listener: (context, state) {
                  if (state is EpisodesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is EpisodesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is EpisodesLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.episodes.length,
                      itemBuilder: (context, index) {
                        final episode = state.episodes[index];
                        return SearchResultItem(
                          result: episode,
                          subtitle: episode.airDate,
                          avatarUrl: 'url_to_location_avatar',
                          opacity: index ==
                                  (_scrollController.offset / 150.0).floor()
                              ? opacity
                              : 1.0,
                        );
                      },
                    );
                  } else {
                    return Offstage();
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

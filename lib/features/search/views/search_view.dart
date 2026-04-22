import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/services/get_it_services.dart';
import 'package:movies/features/movies/repositories/movie_repository.dart';
import '../../../../../core/constants/app_colors.dart';
import '../view_models/search_cubit.dart';
import '../view_models/search_state.dart';
import 'widgets/search_input_field.dart';
import 'widgets/search_result_view.dart';
import 'widgets/search_states_widgets.dart';

class SearchView extends StatefulWidget {
  final bool showBackButton;
  const SearchView({super.key, this.showBackButton = true});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounce;
  final TextEditingController _controller = TextEditingController();

  void _onSearchChanged(String query, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (query.isNotEmpty) {
        context.read<SearchCubit>().search(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt<MovieRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // 1. Search Bar Area
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    if (widget.showBackButton)
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          return SearchInputField(
                            controller: _controller,
                            onChanged: (value) =>
                                _onSearchChanged(value, context),
                            onClear: () {
                              _controller.clear();
                              // Optional: Reset cubit state here
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Search Results Area
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    bool isLoading = false;
                    if (state is SearchInitial) {
                      isLoading = true;
                      return const SearchInitialWidget();
                    }
                    if (state is SearchLoading) {
                      isLoading = true;

                      return const SearchLoadingWidget();
                    }
                    if (state is SearchError) {
                      return SearchErrorWidget(message: state.message);
                    }
                    if (state is SearchLoaded) {
                      return SearchResultView(
                        movies: state.movies,
                        isLoading: isLoading,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

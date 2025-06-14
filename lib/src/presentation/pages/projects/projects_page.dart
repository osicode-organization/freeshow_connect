import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../dependency_injection/dependency_injection.dart';
import '../../../domain/entity/all_projects_entity/all_projects_entity.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => _ProjectsState();
}

class _ProjectsState extends ConsumerState<ProjectsPage>
    with SingleTickerProviderStateMixin {
  late List<AllProjectsEntity> projectsList = [];
  late PageController _pageController;
  String projectListError = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData();
    });
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    debugPrint('before fetch');
    final info =
        await ref.read(getCallsRepositoryImplProvider).callGetProjects();
    debugPrint('fetchData');
    info.match(
      (failure) {
        setState(() {
          projectListError = failure;
        });
      },
      (data) {
        debugPrint("$data");
        setState(() {
          projectsList = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = projectsList.length;
    final show = ref.watch(showProvider);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Projects'),
        trailing: CupertinoButton(
          child: Icon(HeroIcons.arrow_path),
          onPressed: () async {
            debugPrint('button press');
            await fetchData();
          },
        ),
      ),
      child: SafeArea(
        child:
            projectsList.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(projectListError),
                      GutterMedium(),
                      CupertinoActivityIndicator(),
                    ],
                  ),
                )
                : Column(
                  children: [
                    /*  ------------------ List all projects ------------------- */
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 15.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          /*  ------------------ each project ------------------- */
                          return GestureDetector(
                            onTap: () async {
                              await ref
                                  .read(postCallsRepositoryImplProvider)
                                  .selectProjectByName(
                                    projectsList[index].projectName,
                                  );
                              ref
                                  .read(projectProvider.notifier)
                                  .setCurrentProject = index;
                              ref.read(showProvider.notifier).setTotalSlides =
                                  -1;
                              ref.read(showProvider.notifier).setCurrentSlide =
                                  1;
                              _pageController.jumpToPage(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color:
                                    ref.watch(projectProvider).currentProject ==
                                            index
                                        ? CupertinoColors.systemBlue
                                        : CupertinoColors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(projectsList[index].projectName),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, i) => GutterMedium(),
                      ),
                    ),
                    /*  ------------------ List all shows for each project ------------------- */
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          final thisProject = projectsList[index];
                          return SizedBox(
                            child: Column(
                              children: [
                                // Text('Shows'),
                                GutterLarge(),
                                /*  ------------------ shows in selected project ------------------- */
                                if (thisProject.projectShows.isNotEmpty)
                                  SizedBox(
                                    height: 150,
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 15.0,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          thisProject.projectShows.length,
                                      itemBuilder: (context, index) {
                                        final normalSlidesMap =
                                            thisProject
                                                .projectShows[index]
                                                .slides;
                                        final lay =
                                            thisProject
                                                .projectShows[index]
                                                .layouts;
                                        List<String> layoutIds =
                                            lay.entries.map((entry) {
                                              return entry.key;
                                            }).toList();
                                        List<int> layoutSlides =
                                            lay.entries.map((entry) {
                                              if (entry
                                                  .value
                                                  .slides
                                                  .isNotEmpty) {
                                                return entry
                                                    .value
                                                    .slides
                                                    .length;
                                              }
                                              return 0;
                                            }).toList();
                                        int normalSlides =
                                            normalSlidesMap.length;
                                        int totalSlides = max(
                                          layoutSlides[0],
                                          normalSlides,
                                        );
                                        /*  ------------------ each show ------------------- */
                                        return CupertinoButton(
                                          color:
                                              show.showId ==
                                                      thisProject
                                                          .projectShows[index]
                                                          .showId
                                                  ? ref
                                                          .watch(
                                                            appModeProvider,
                                                          )
                                                          .switchThemeType
                                                      ? CupertinoColors.black
                                                      : CupertinoColors.white
                                                  : CupertinoColors.systemGrey5,
                                          child: Text(
                                            thisProject
                                                .projectShows[index]
                                                .name,
                                            style: TextStyle(
                                              color:
                                                  show.showId ==
                                                          thisProject
                                                              .projectShows[index]
                                                              .showId
                                                      ? ref
                                                              .watch(
                                                                appModeProvider,
                                                              )
                                                              .switchThemeType
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .systemGrey5
                                                              .darkColor
                                                      : CupertinoColors
                                                          .systemBlue,
                                            ),
                                          ),
                                          onPressed: () async {
                                            await ref
                                                .read(
                                                  postCallsRepositoryImplProvider,
                                                )
                                                .selectShowByName(
                                                  thisProject
                                                      .projectShows[index]
                                                      .name,
                                                );
                                            await ref
                                                .read(
                                                  postCallsRepositoryImplProvider,
                                                )
                                                .startShow(
                                                  thisProject
                                                      .projectShows[index]
                                                      .showId,
                                                );
                                            ref
                                                .read(showProvider.notifier)
                                                .setTotalSlides = totalSlides;
                                            ref
                                                .read(showProvider.notifier)
                                                .setLayoutId = layoutIds[0];
                                            ref
                                                .read(showProvider.notifier)
                                                .setShowId = thisProject
                                                    .projectShows[index]
                                                    .showId;

                                            ref
                                                .read(showProvider.notifier)
                                                .setCurrentSlide = 1;
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (_, _) => GutterMedium(),
                                    ),
                                  ),
                                GutterLarge(),
                                /*  ------------------ Previous and Next Slide buttons ------------------- */
                                if (show.totalSlides != -1)
                                  SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /*  ------------------ Prev button ------------------- */
                                          CupertinoButton(
                                            onPressed:
                                                show.currentSlide == 1
                                                    ? null
                                                    : () async {
                                                      await ref
                                                          .read(
                                                            postCallsRepositoryImplProvider,
                                                          )
                                                          .previousSlide();
                                                      ref
                                                          .read(
                                                            showProvider
                                                                .notifier,
                                                          )
                                                          .decreaseCurrentSlide();
                                                    },
                                            color: CupertinoColors.systemGrey4,
                                            child: const Text('Previous slide'),
                                          ),
                                          /*  ------------------ next slide ------------------- */
                                          CupertinoButton.filled(
                                            onPressed:
                                                show.currentSlide ==
                                                        show.totalSlides
                                                    ? null
                                                    : () async {
                                                      await ref
                                                          .read(
                                                            postCallsRepositoryImplProvider,
                                                          )
                                                          .nextSlide();
                                                      ref
                                                          .read(
                                                            showProvider
                                                                .notifier,
                                                          )
                                                          .increaseCurrentSlide();
                                                    },
                                            // color: CupertinoColors.systemMint,
                                            child: const Text('Next slide'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                GutterLarge(),
                                /*  ------------------ Slides ------------------- */
                                if (show.totalSlides != -1)
                                  Expanded(
                                    child: GridView.builder(
                                      padding: EdgeInsets.all(16),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                4, // Number of items in a row
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                      itemCount:
                                          ref
                                              .watch(showProvider)
                                              .totalSlides, // Number of buttons
                                      itemBuilder: (context, index) {
                                        String showId = show.showId;
                                        String layoutId = show.layoutId;
                                        return CupertinoButton(
                                          key: ValueKey(index.toString()),
                                          color:
                                              show.currentSlide == index + 1
                                                  ? ref
                                                          .watch(
                                                            appModeProvider,
                                                          )
                                                          .switchThemeType
                                                      ? CupertinoColors.black
                                                      : CupertinoColors.white
                                                  : CupertinoColors.systemGrey5,
                                          child: Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                              color:
                                                  show.currentSlide == index + 1
                                                      ? ref
                                                              .watch(
                                                                appModeProvider,
                                                              )
                                                              .switchThemeType
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .systemGrey5
                                                              .darkColor
                                                      : CupertinoColors
                                                          .systemBlue,
                                            ),
                                          ),
                                          onPressed: () async {
                                            debugPrint(
                                              'Button ${index + 1} pressed',
                                            );
                                            ref
                                                .read(showProvider.notifier)
                                                .setCurrentSlide = index + 1;
                                            await ref
                                                .read(
                                                  postCallsRepositoryImplProvider,
                                                )
                                                .selectSlideByIndex(
                                                  showId,
                                                  layoutId,
                                                  index + 1,
                                                );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

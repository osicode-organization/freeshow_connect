import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../dependency_injection/dependency_injection.dart';
import '../../../data/data_sources/get_calls.dart';
import '../../../data/data_sources/post_calls.dart';
import '../../../data/models/all_projects_models/all_projects_model.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => _BiblePageState();
}

class _BiblePageState extends ConsumerState<ProjectsPage>
    with SingleTickerProviderStateMixin {
  late List<AllProjectsModel> projectsList = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await getProjects();
      setState(() {
        projectsList = data;
      });
    });
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    final data = await getProjects();
    setState(() {
      projectsList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = projectsList.length;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Projects'),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.refresh_circled),
          onPressed: () {
            fetchData();
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
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
                  return GestureDetector(
                    onTap: () async {
                      await selectProjectByName(
                        projectsList[index].projectName,
                      );
                      ref.read(projectProvider.notifier).setCurrentProject =
                          index;
                      ref.read(showProvider.notifier).setTotalSlides = -1;
                      _pageController.jumpToPage(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            ref.watch(projectProvider).currentProject == index
                                ? CupertinoColors.activeOrange
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
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final thisProject = projectsList[index];
                  return Container(
                    // color: Color(0xff2a34da).withGreen(index * 50),
                    child: Column(
                      children: [
                        Text('Shows'),
                        GutterMedium(),
                        /* Project shows */
                        if (thisProject.projectShows.isNotEmpty)
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 15.0,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: thisProject.projectShows.length,
                              itemBuilder: (context, index) {
                                final normalSlidesMap =
                                    thisProject.projectShows[index].slides;
                                final lay =
                                    thisProject.projectShows[index].layouts;
                                List<String> layoutIds =
                                    lay.entries.map((entry) {
                                      return entry.key;
                                    }).toList();
                                List<int> layoutSlides =
                                    lay.entries.map((entry) {
                                      if (entry.value.slides.isNotEmpty) {
                                        return entry.value.slides.length;
                                      }
                                      return 0;
                                    }).toList();
                                int normalSlides = normalSlidesMap.length;
                                int totalSlides = max(
                                  layoutSlides[0],
                                  normalSlides,
                                );
                                return CupertinoButton.filled(
                                  child: Text(
                                    "${thisProject.projectShows[index].name}\nNumber of layout slides:  ${layoutSlides[0]}\nNumber of normal slides:  $normalSlides",
                                  ),
                                  onPressed: () async {
                                    await selectShowByName(
                                      thisProject.projectShows[index].name,
                                    );
                                    await startShow(
                                      thisProject.projectShows[index].showId,
                                    );
                                    ref
                                        .read(showProvider.notifier)
                                        .setTotalSlides = totalSlides;
                                    ref
                                        .read(showProvider.notifier)
                                        .setLayoutId = layoutIds[0];
                                    ref.read(showProvider.notifier).setShowId =
                                        thisProject.projectShows[index].showId;
                                  },
                                );
                              },
                              separatorBuilder: (_, _) => GutterMedium(),
                            ),
                          ),
                        GutterLarge(),
                        /*  ------------------ Previous and Next Slide buttons ------------------- */
                        SizedBox(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  onPressed: () async {
                                    await previousSlide();
                                  },
                                  color: CupertinoColors.systemGrey,
                                  child: const Text('Previous slide'),
                                ),
                                CupertinoButton.filled(
                                  onPressed: () async {
                                    await nextSlide();
                                  },
                                  // color: CupertinoColors.systemMint,
                                  child: const Text('Next slide'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GutterLarge(),
                        /*  ------------------ Slide buttons ------------------- */
                        if (ref.watch(showProvider).totalSlides != -1)
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
                                String showId = ref.watch(showProvider).showId;
                                String layoutId =
                                    ref.watch(showProvider).layoutId;
                                int selectedSlide =
                                    ref.watch(showProvider).currentSlide;
                                return CupertinoButton(
                                  key: ValueKey(index.toString()),
                                  color:
                                      selectedSlide == index
                                          ? CupertinoColors.activeBlue
                                          : CupertinoColors.inactiveGray,
                                  child: Text('${index + 1}'),
                                  onPressed: () async {
                                    debugPrint('Button ${index + 1} pressed');
                                    ref
                                        .read(showProvider.notifier)
                                        .setCurrentSlide = index;
                                    await selectSlideByIndex(
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

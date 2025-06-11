import 'package:flutter/cupertino.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../data/data_sources/get_calls.dart';
import '../../../data/data_sources/post_calls.dart';
import '../../../data/models/all_projects_models/all_projects_model.dart';

class BiblePage extends StatefulWidget {
  const BiblePage({super.key});

  @override
  State<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage>
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
        middle: const Text('Bible'),
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
              height: 60,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 15.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    onPressed: () async {
                      await selectProjectByName(
                        projectsList[index].projectName,
                      );
                      _pageController.jumpToPage(index);
                    },
                    child: Text(projectsList[index].projectName),
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
                    color: Color(0xff2a34da).withGreen(index * 50),
                    child: Column(
                      children: [
                        Text('data $index'),
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
                                return CupertinoButton.filled(
                                  child: Text(
                                    thisProject.projectShows[index].name,
                                  ),
                                  onPressed: () async {
                                    await selectShowByName(
                                      thisProject.projectShows[index].name,
                                    );
                                    await startShow(
                                      thisProject.projectShows[index].showId,
                                    );
                                    await getSlide(
                                      thisProject.projectShows[index].showId,
                                      null,
                                    );
                                    await getSlideThumbnail(
                                      thisProject.projectShows[index].showId,
                                      null,
                                      null,
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (_, _) => GutterMedium(),
                            ),
                          ),
                        GutterLarge(),
                        /*  Slide buttons */
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

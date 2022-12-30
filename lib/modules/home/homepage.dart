import 'package:flutter/material.dart';
import 'package:quran_app/modules/home/widgets/glassmorphism.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Quran App',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xff011240),
          leading: const Icon(
            Icons.sort,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff011240),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assalamualaikum',
                style: TextStyle(
                  color: Color(0xffA4A7D3),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Khoirul Wafa',
                style: TextStyle(
                  color: Color(0xffFAFBFB),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xffe3c3f8),
                          Color(0xffcdabe7),
                          Color(0xffb693d6),
                          Color(0xffa07cc5),
                          Color(0xff8966b5),
                          Color(0xff7251a5),
                          Color(0xff5a3c95),
                          Color(0xff412886),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                  Glassmorphism(
                    blur: 8,
                    opacity: 0.1,
                    radius: 20,
                    child: Container(
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Explore and Learn Flutter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Learn the best design here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: AppBar(
                  backgroundColor: const Color(0xff011240),
                  elevation: 0,
                  flexibleSpace: const TabBar(
                    indicatorColor: Color(0xffE3C3F8),
                    indicatorWeight: 3,
                    tabs: [
                      Tab(
                        child: Text(
                          'Surah',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Ayat',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Halaman',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    ColoredBox(
                      color: const Color(0xff011240),
                      child: ListView.separated(
                        itemCount: 25,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Color(0xffA4A7D3),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Color(0xffFAFBFB),
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            title: Text(
                              'Surah ${index + 1}',
                              style: const TextStyle(
                                color: Color(0xffFAFBFB),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              'Surah ${index + 1}',
                              style: const TextStyle(
                                color: Color(0xffFAFBFB),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            dense: true,
                            trailing: Text(
                              'Surah ${index + 1}',
                              style: const TextStyle(
                                color: Color(0xff7352CB),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    ColoredBox(
                      color: const Color(0xff011240),
                      child: ListView.separated(
                        itemCount: 25,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Color(0xffA4A7D3),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              'Ayat $index',
                              style: const TextStyle(
                                color: Color(0xffFAFBFB),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ColoredBox(
                      color: const Color(0xff011240),
                      child: ListView.separated(
                        itemCount: 25,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Color(0xffA4A7D3),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              'Halaman $index',
                              style: const TextStyle(
                                color: Color(0xffFAFBFB),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

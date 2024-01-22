import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

List<Event> events = [
  Event(
    id: '1',
    name: 'concert',
    description: 'really cool music, need someone to serve food',
    location: 'addition financial arena',
    sponsoringOrganization: 'Organization X',
    attendees: [],
    registeredVolunteers: [],
    picLink: 'assets/profile pictures/icon_musicnote.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1699875173000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1699875173099),
    eventTags: ['music', 'food'],
    semester: 'Fall 2023',
    maxAttendees: 1000,
    reviews: [],
  ),
  Event(
    id: '2',
    name: 'study session',
    description: 'cs1, need someone to bring water',
    location: 'ucf library',
    sponsoringOrganization: 'Organization Y',
    attendees: [],
    registeredVolunteers: [],
    picLink: 'assets/profile pictures/icon_apple.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1698433137000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1698433137099),
    eventTags: ['education', 'technology'],
    semester: 'Fall 2023',
    maxAttendees: 30,
    reviews: [],
  ),
  Event(
    id: '3',
    name: 'movie night',
    description: 'need someone to collect tickets',
    location: 'pegasus ballroom',
    sponsoringOrganization:
        'Organization Z long name long name long name long name long name long name long name long name long name long name long name long name',
    attendees: [],
    registeredVolunteers: [],
    picLink: 'assets/profile pictures/icon_controller.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1695774773000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1695774773099),
    eventTags: ['movie', 'education', 'food'],
    semester: 'Fall 2023',
    maxAttendees: 400,
    reviews: [],
  ),
  Event(
    id: '4',
    name: 'movie night but its date isn\'t previous',
    description: 'need someone to collect tickets',
    location: 'pegasus ballroom',
    sponsoringOrganization: 'Organization Z',
    attendees: [],
    registeredVolunteers: [],
    picLink: 'assets/profile pictures/icon_cat.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1734218796000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1734219036000),
    eventTags: ['movie', 'education', 'food'],
    semester: 'Fall 2023',
    maxAttendees: 400,
    reviews: [],
  ),
  Event(
    id: '5',
    name: 'movie night but it\'s very long',
    description: 'need someone to collect tickets',
    location: 'pegasus ballroom',
    sponsoringOrganization: 'Organization Z',
    attendees: [],
    registeredVolunteers: [],
    picLink: 'assets/profile pictures/icon_cat.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1695774773000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1702543765000),
    eventTags: ['movie', 'education', 'food'],
    semester: 'Fall 2023',
    maxAttendees: 400,
    reviews: [],
  ),
];

class EventHistoryScreen extends StatefulWidget {
  const EventHistoryScreen({super.key});

  @override
  State<EventHistoryScreen> createState() => _EventHistoryScreenState();
}

class _EventHistoryScreenState extends State<EventHistoryScreen> {
  int _selectedIndex = 0;
  bool tapped = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    EventsListScreen(),
    HomeScreenTab(),
    QRCodeScanner(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      tapped = true; // can't return to event history screen from navbar
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      /*appBar: AppBar(
        title: const Text(
          'Event History',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              tooltip: 'View notifications',
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                semanticLabel: 'Notifications',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.profileScreen.name);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: const Image(
                      semanticLabel: 'Profile picture',
                      image: AssetImage(
                          'assets/profile pictures/icon_paintbrush.png'),
                      height: 20),
                ),
              ),
            ),
          )
        ],
      ),*/
      body: tapped
          ? _widgetOptions.elementAt(_selectedIndex)
          : EventHistoryScreenTab(),
      /*Container(
        height: h,
        child: Column(
          children: [
            _topSection(w),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, index) =>
                    (events.elementAt(index).date.isBefore(DateTime.now())
                        ? EventCard(event: events.elementAt(index))
                        : const SizedBox(
                            height: 0,
                          )),
              ), // only show an event in the history page if its date has passed
            )
          ],
        ),
      ),*/
      drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: [
            //const DrawerHeader(
            //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/KnightAssistCoA3.png"),),),
            //child: Text('KnightAssist')),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                context.pushNamed(AppRoute.homeScreen.name);
              },
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                context.pushNamed(AppRoute.calendar.name);
              },
            ),
            ListTile(
              title: const Text('Organizations'),
              onTap: () {
                context.pushNamed(AppRoute.organizations.name);
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                context.pushNamed(AppRoute.events.name);
              },
            ),
            ListTile(
              title: const Text('Announcements'),
              onTap: () {
                context.pushNamed(AppRoute.updates.name);
              },
            ),
            ListTile(
              title: const Text('QR Scan'),
              onTap: () {
                context.pushNamed(AppRoute.qrScanner.name);
              },
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                context.pushNamed(AppRoute.eventHistory.name);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                context.pushNamed(AppRoute.account.name);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                context.pushNamed(AppRoute.emailConfirm.name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined), label: "QR Scan"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 91, 78, 119),
        onTap: _onItemTapped,
      ),
    );
  }
}

_topSection(double width) {
  return Container(
      //height: 200,
      width: width,
      color: const Color.fromARGB(255, 0, 108, 81),
      child: const Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: SearchBar(
                    hintText: 'Search Event History',
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    final difference = event.endTime.difference(event.startTime).inHours;

    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black26,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              elevation: 5,
              child: InkWell(
                onTap: () => context.pushNamed("historydetail", extra: event),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                            image: AssetImage(event.picLink), height: 75)),
                    title: Text(
                      event.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.sponsoringOrganization,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "${difference.toString()} hours",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class EventHistoryScreenTab extends ConsumerWidget {
  const EventHistoryScreenTab({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event History',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              tooltip: 'View notifications',
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                semanticLabel: 'Notifications',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.profileScreen.name);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: const Image(
                      semanticLabel: 'Profile picture',
                      image: AssetImage(
                          'assets/profile pictures/icon_paintbrush.png'),
                      height: 20),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: h,
        child: Column(
          children: [
            _topSection(w),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, index) =>
                    (events.elementAt(index).startTime.isBefore(DateTime.now())
                        ? EventCard(event: events.elementAt(index))
                        : const SizedBox(
                            height: 0,
                          )),
              ), // only show an event in the history page if its date has passed
            )
          ],
        ),
      ),
    );
  }
}

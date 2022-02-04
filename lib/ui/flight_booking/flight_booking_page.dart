import 'package:flutter/material.dart';

import '_flight_info.dart';
import '_ticket_list.dart';

const kColorPrimary = Color(0xFF2E8376);
const kColorText = Color(0xFF9E9E9E);
const kColorTextDark = Color(0xFF212121);
const kColorFlightText = Color(0xFFE0E0E0);
const kColorFlightIcon = Color(0xFFC1B695);
const kColorTicketBorder = Color(0xFFE0E0E0);
// if use Image.network(),
// need to configure Access-Control-Allow-Origin in firebase.json
const kSingaporeLogoUrl = 'assets/82220821-1ebc8880-995a-11ea-9d77-07edda64f05c.png';
const kQantasLogoUrl = 'assets/82220824-1fedb580-995a-11ea-8124-f59daff4ebda.png';
const kEmiratesLogoUrl = 'assets/82220816-1c5a2e80-995a-11ea-921d-38b3f991d8d2.png';
const kHainanLogoUrl = 'assets/82223309-73adce00-995d-11ea-98c0-2dba4e094aca.png';


class FlightBookingPage extends StatelessWidget {
  const FlightBookingPage({Key? key}) : super(key: key);
  static String routeName = '/ui/flight_booking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () { Navigator.of(context).pop(); },
        ),
      ),
      body: Column(
        children: const [
          FlightInfo(),
          TicketList(),
        ],
      ),
    );
  }
}

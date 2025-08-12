import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUs extends StatelessWidget {
  final List<Map<String, dynamic>> offices = [
    {
      'title': 'Registered Office',
      'address': [
        'Oil India Limited',
        'Duliajan - 786 602, Assam',
        'Email: oilindia@oilindia.in',
      ],
      'mapUrl': 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7087.278584155792!2d95.3117624348877!3d27.35574330000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x373f415344b4855b%3A0xb5b07618eb3df837!2sOIL%20General%20Office!5e0!3m2!1sen!2sin!4v1751468233612!5m2!1sen!2sin',
    },
    {
      'title': 'Corporate Office',
      'address': [
        'Oil India Limited',
        'Plot No 19, Sector 16A, NOIDA G.B.Nagar (UP)- 201301',
        'Phone: 0120 - 2419000',
        'Email: oilindia@oilindia.in',
      ],
      'mapUrl': 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d28032.958690350584!2d77.29900953955077!3d28.566164000000004!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce50073702a47%3A0x5174c6a08aa6689a!2sOil%20India%20Limited%2C%20Govt.%20of%20India%20(PSU)!5e0!3m2!1sen!2sin!4v1751468394708!5m2!1sen!2sin',
    },
    // Add other offices similarly
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F8),
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
        backgroundColor: Color(0xFF004080),
      ),
      body: SafeArea(child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...offices.map((office) => ContactOfficeCard(office)).toList(),
          FeedbackSection(),
        ],
      ),
      ),
    );
  }
}

class ContactOfficeCard extends StatelessWidget {
  final Map<String, dynamic> office;

  ContactOfficeCard(this.office);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              office['title'],
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF0055AA),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ...List.generate(
              office['address'].length,
                  (i) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  office['address'][i],
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(Uri.parse(office['mapUrl']))
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FeedbackSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'We Value Your Feedback',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF003366),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'If you have suggestions or encounter any issues with our app, please email us:',
            style: TextStyle(fontSize: 14, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'erp_dept@oilindia.in',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF003366),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

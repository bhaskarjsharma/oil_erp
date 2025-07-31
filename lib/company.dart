import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: PlatformAppBar(
        material: (_, __) => MaterialAppBarData(
          scrolledUnderElevation: 0,
          backgroundColor: Color(0xFFE5E5E5),
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(
          // Issue with cupertino where a bar with no transparency
          // will push the list down. Adding some alpha value fixes it (in a hacky way)
          backgroundColor: Color(0xFFE5E5E5).withAlpha(254),
        ),
        //toolbarHeight: 65,
        //scrolledUnderElevation: 0,
        title: Center(child:Image.asset('images/oil_logo_with_background.png',height:55),),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: ContentSection(),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color:Colors.white70,
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text('\u00A9 2025 Oil India Limited. All rights reserved', style: TextStyle(fontSize: 12)),
                      ),
                    ),

                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF333333),
      padding: const EdgeInsets.all(18),
      child: const Center(
        child: Text(
          'Company Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class ContentSection extends StatelessWidget {
  const ContentSection({super.key});

  Widget buildSectionTitle(String title) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 32),
      Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xFF004466),
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Container(height: 2, width: double.infinity, color: Color(0xFFCC0000)),
      const SizedBox(height: 12),
    ],
  );

  Widget buildList(List<String> items) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items.map((e) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text("• $e"),
    )).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildParagraph(
            "Oil India Limited (OIL), a Government of India enterprise, is engaged in the business of exploration, production and transportation of crude Oil and Natural Gas. In 1959, Oil India (P) Ltd was incorporated to expand and develop the newly discovered oil fields of Naharkatia and Moran in Assam..."),
        buildParagraph(
            "Company’s in-country E&P operational areas are spread over Assam, Arunachal Pradesh, Mizoram, Tripura, Nagaland, Odisha..."),
        buildParagraph("Government of India, on 04th August 2023, conferred MAHARATNA status to OIL..."),

        buildSectionTitle("Our People Our Asset"),
        buildList([
          "6,500+ employees",
          "Labour Relations – structured programs to improve skill levels & morale",
          "Diversity & Inclusion - equal job opportunities & benefits, training and skill building activities"
        ]),

        buildSectionTitle("We Discovered the First Oil Well in Asia in 1889"),
        buildList([
          "Independent India's first oil field was discovered at Naharkatiya in 1953",
          "1157 Km Crude oil Pipeline - over 6MMT",
          "Deepest onshore well in India",
          "First COCP Plant in Asia"
        ]),

        buildSectionTitle("A Maharatna PSU & Integrated Energy Company"),
        buildList([
          "Upstream + Midstream + Downstream",
          "69.63% Stake in Numaligarh Refinery",
          "Venturing into Offshore - Mahanadi, Andaman and Kerala Konkan Basins"
        ]),

        buildSectionTitle("Our Global and Domestic Presence"),
        buildList([
          "Pan India presence with NELP / OALP blocks",
          "Operating in over 61,000 Sq. Km acreage",
          "Our Global Presence in 7 Countries"
        ]),

        buildParagraph("Oil India Limited boasts a legacy spanning over six decades..."),

        buildSectionTitle("We Believe in Green Energy"),
        buildList([
          "First 100KG Green hydrogen pilot plant in 2022",
          "174 MW Wind Energy project in Rajasthan, Gujarat, MP",
          "14 MW Solar Energy projects in Rajasthan"
        ]),

        buildSectionTitle("We Spread Smiles through CSR"),
        buildList([
          "Health Care & Education",
          "Skill Development & Sustainable Livelihood",
          "Women Empowerment & Sports",
          "Sustainable Environment"
        ]),

        buildSectionTitle("We have Strong Financial Returns"),
        buildList([
          "5,552 Crores INR as Profit after Tax (FY 23-24)",
          "Paid 1,193 Crores INR as Tax (FY 23-24)",
          "Earned 24,514 Crores INR in Revenue (FY 23-24)"
        ]),

        buildSectionTitle("Our Road Ahead"),
        buildList([
          "Mission 4+ to enhance production",
          "Net Zero by 2040 - addressing climate change",
          "Compressed Bio Gas & Green Hydrogen"
        ]),

        buildSectionTitle("Strong in-house E&P Capabilities"),
        buildParagraph("Today, OIL is a vertically integrated E&P company possessing rich expertise..."),

        buildSectionTitle("Pioneering Milestones"),
        buildParagraph("These groundbreaking projects highlight Oil India Limited's role as an industry leader..."),

        const TimelineSection(),

        const SizedBox(height: 30),
/*        GestureDetector(
          onTap: () async {
            final url = Uri.parse("https://www.oil-india.com/");
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          child: const Text(
            "For more information, visit: https://www.oil-india.com/",
            style: TextStyle(color: Color(0xFF0066CC), decoration: TextDecoration.underline),
          ),
        ),*/
      ],
    );
  }

  Widget buildParagraph(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Text(text, textAlign: TextAlign.justify),
  );
}

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  final List<Map<String, String>> milestones = const [
    {"year": "1889", "desc": "Asia’s 1st Oil Well in Digboi, Assam"},
    {"year": "1953", "desc": "Independent India’s First Oil Well in Naharkatiya, Assam"},
    {"year": "1961", "desc": "Asia’s 1st Gas Turbine"},
    {"year": "1962", "desc": "Asia’s 1st Fully Automated Crude Oil Cross Country Trunk Pipeline"},
    {"year": "1963", "desc": "World’s 1st Crude Oil Conditioning Plant in Assam"},
    {"year": "1982", "desc": "Asia’s 1st LPG Plant using Turbo Expander Technology"},
    {"year": "2018", "desc": "India’s First successful Cyclic Steam Stimulation Project"},
    {"year": "2022", "desc": "India’s First 99.999% pure Green Hydrogen Plant"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: milestones.map((event) {
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(left: BorderSide(width: 5, color: Color(0xFFCC0000))),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFCC0000),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  event["year"]!,
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  event["desc"]!,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

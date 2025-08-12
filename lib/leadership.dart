import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Leadership extends StatefulWidget {
  const Leadership({Key? key}) : super(key: key);

  @override
  State<Leadership> createState() => _OurLeadershipPageState();
}

class _OurLeadershipPageState extends State<Leadership> {
  final List<bool> _isExpanded = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    final leaders = [
      {
        'name': 'Dr. Ranjit Rath',
        'title': 'Chairman & Managing Director',
        'image':
        'images/cmd.webp',
        'bio': 'Dr. Ranjit Rath, Chairman & Managing Director (CMD), Oil India Limited (OIL) is an alumnus of IIT Bombay & IIT Kharagpur. Dr. Rath is a proud recipient of the prestigious National Geosciences Award from the Honble President of India. A Geoscientist with impeccable experience and expertise of more than 26 years in the field of geosciences, Dr. Rath, prior to joining at the helm of affairs of OIL, was the Chairman'
    +'cum Managing Director of Mineral Exploration & Consultancy Limited under the Ministry of'
    +'Mines; Chief Executive Officer of Khanij Bidesh India Limited; Managing Director of Bharat'
    +'Gold Mines Limited and also held additional charge of the Director General of Geological'
    +'Survey of India under Govt. of India. Dr. Rath has a rich portfolio of diverse roles'
    +'spanning from strategy formulation, business development and upstream asset management to'
    +'application of geosciences & exploration geology in several important projects including'
    +'creation of Strategic Petroleum Reserves (SPRs), a first of its kind initiative of Govt. of'
    +'India entailing underground rock caverns for strategic storage of crude oil - An'
            +'intervention towards Energy Security.'
      },
      {
        'name': 'Shri Saloma Yomdo',
        'title': 'Director (E&D)',
        'image':
        'images/DE.webp',
        'bio': 'Shri Saloma Yomdo, is a Petroleum Engineering Graduate'+
      'from Indian Institute of Technology (Indian School of Mines), Dhanbad. He joined Oil India'+
      'Limited in 1994. Before his elevation as Director (Exploration & Development) of the'+
      'Company, he was heading the Exploration & Development Directorate of the Company in the'+
      'capacity of Executive Director, overseeing E&D activities across India and overseas. Shri'+
      'Yomdo actively implemented various exploration, development as well as reservoir management'+
      'practices in OIL’s oil and gas fields, addressing challenges and achieving breakthroughs'+
      'through fit-for-purpose technology and geoscientific studies. His efforts have contributed'+
      'to sustaining production levels and extending the life of the oil and gas fields.He has also'+
      'presented and published technical papers in various international and national forums and is'+
      'an active member of the Society of Petroleum Engineers (SPE), USA and Association of'+
      'Petroleum Geologists (APG).'
      },
      {
        'name': 'Shri Abhijit Majumder',
        'title': 'Director (Finance)',
        'image':
        'images/DF.webp',
        'bio': 'Shri Abhijit Majumder took over charge as Director'+
      '(Finance) on the Board of Oil India Limited (OIL) on 20th November, 2024. He is a'+
      'distinguished member of the Institute of Cost & Management Accountants of India, holder of a'+
      'Bachelor’s degree in Economics, Law, a post graduate diploma in Forex Management, ICFAI and'+
      'an alumni of IICA Valuation Certificate Program. He is an eminent senior finance'+
      'professional with an illustrious career spanning over 32 years. His expertise encompasses'+
      'Financial Management, Corporate Governance & Compliances, Risk Management, Project'+
      'Management, Corporate Business Development etc. His journey as a finance professional began'+
      'in 1992. He joined OIL as Senior Officer in 1998. He headed the Project Finance Department'+
      'in OIL’s Bay Exploration Project, served on deputation at Directorate General of'+
      'Hydrocarbons (Country’s upstream Regulator), Finance & Accounts Department of OIL’s Field'+
      'Headquarter, Duliajan. He also played a pivotal role as CFO at HPOIL Gas Private Limited, a'+
      'Joint Venture CGD (City Gas Distribution) entity of OIL and HPCL.'
      },
      {
        'name': 'Shri Trailukya Borgohain',
        'title': 'Director (Operations)',
        'image':
        'images/DO.webp',
        'bio': 'Shri Trailukya Borgohain is an Oil & Gas and E&P'+
      'professional with M.Sc. in Applied Geology from IIT, Roorkee and MBA in Energy Leadership'+
      'from Texas A&M University, Texarkana, USA. He joined Oil India Limited in March 1995. Prior'+
      'to his appointment as Director (Operations), he was serving as the Chief General Manager'+
      '(Geology & Reservoir) where he was instrumental in working towards accelerating development'+
      'of Oil & Gas fields and production in OIL’s operational areas in Upper Assam. He has been'+
      'associated with discovery of number of Oil & Gas fields in Assam, Rajasthan and Gabon. He'+
      'has also presented several technical papers in National/ International forums and authored'+
      'more than 36 explorations evaluation reports. In addition to his professional role, he is'+
      'also actively involved in Association of Petroleum Geologist (APG India), American'+
      'Association of Petroleum Geologist (AAPG) and Society of Petroleum Engineers (SPE). Amongst'+
      'others, his academic achievements also include membership in Delta-Mu-Delta for scholastic'+
      'excellence during his MBA at Texas A&M University, Texarkana, United States.'
      },
      {
        'name': 'Dr. Ankur Baruah',
        'title': 'Director (Human Resources)',
        'image':
        'images/DH.webp',
        'bio': 'Dr. Ankur Baruah is the Director Human Resources (HR)'+
      'of Oil India Limited, a leading Maharatna energy company in India. An engineer turned HR'+
      'leader, Dr. Baruah holds an MBA degree in Human Resources, a PhD in Business Administration'+
      'and prestigious certifications, including IPMA Project Management and Psychometric Testing'+
      'accreditation. Prior to his appointment as Director (Human Resources), he was serving as the'+
      'Executive Director (Human Resources) in Oil India Ltd. With three decades of professional'+
      'experience spanning the full spectrum of HR and corporate leadership, Dr. Baruah is a'+
      'recognized expert in manpower planning, talent acquisition, performance management,'+
      'stakeholder engagement and change management. His strategic and innovative approaches have'+
      'strengthened Oil India Limited’s reputation as an industry leader in HR excellence. A'+
      'distinguished thought leader, Dr. Baruah has delivered keynote addresses and participated in'+
      'high-profile panels at national and international forums. His contributions to the HR domain'+
      'have earned him numerous prestigious accolades, including the Most Iconic HR Leader, the'+
      'Topmost HR Leader in Asia and the HR Excellence Award. A permanent resident of Kushal Nagar,'+
      'Jorhat, Assam, Dr. Baruah is a passionate believer of human centric leadership in creating'+
      'better workplaces and organizations.'
      },
      {
        'name': 'Shri Shalabh Tyagi',
        'title': 'CVO, OIL',
        'image': 'images/cvo.png',
        'bio': 'Shri Shalabh Tyagi is a distinguished member of the'+
      '1997 batch (1996 exam batch) of Indian Railway Services of Electrical Engineers (IRSEE) and'+
      'a graduate in Electrical Engineering from IIT Kharagpur. He has served in various capacities'+
      'across the Public sector, Railways, Defence and other ministries in the areas for'+
      'production, development and induction of new technologies, standardization of'+
      'specifications, design, development and commissioning of rolling stock, Safety Certification'+
      'and Audits, administrative matters of Defence PSUs, Defence production related policy'+
      'matters etc. He has international exposure of various manufacturing and testing facilities'+
      'related to Railway infrastructure in Germany, China, Denmark and Belgium.While working with'+
      'Railways, he was instrumental in successful designing and commissioning of first'+
      'Air-Conditioned Metro Rake for Kolkata Metro. He also played crucial role in Hon’ble Prime'+
      'Minister vision of “Mission 100% Electrification” of Indian Railways broad gauge network. As'+
      'Joint Secretary (Personnel & Coordination) in the Department of Defence Production, Ministry'+
      'of Defence, he has served as Govt. nominee Director for Hindustan Aeronautics Limited,'+
      'Hindustan Shipyard Limited, India Optel Limited, Armoured Vehicles Nigam Limited & Mishra'+
      'Dhatu Nigam Limited (MIDHANI). He was instrumental in steering Defence Testing'+
      'Infrastructure Scheme (DTIS) for setting up green field test facilities in Defence sector.'
      },
    ];

    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        title:Image.asset('images/oil_logo_with_background.png',height:55),
        centerTitle: true,
        backgroundColor: Color(0xFFE5E5E5),
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
      ),

      /*PlatformAppBar(
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
        automaticallyImplyLeading: true,
      ),*/
      body: SafeArea(child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color:Color(0xFF333333),
            ),
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('Our Leadership', style: TextStyle(fontSize: 24,color: Colors.white)),
              ),
            ),

          ),
          Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: leaders.length,
                itemBuilder: (context, index) {
                  final leader = leaders[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      leader['name']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF003366),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      leader['title']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ClipOval(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  //color: Colors.white,
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    leader['image']!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),

                            ],
                          ),

                          PlatformElevatedButton(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            color: const Color(0xFF71777d),
                            child: Text(
                              _isExpanded[index] ? 'Hide Profile' : 'View Profile',
                              style: const TextStyle(fontSize: 14,color: Colors.white,),
                            ),
                            onPressed: () {
                              setState(() {
                                _isExpanded[index] = !_isExpanded[index];
                              });
                            },
                          ),
                          if (_isExpanded[index])
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                leader['bio']!,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF444444),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ),
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
      ),)
    );
  }
}

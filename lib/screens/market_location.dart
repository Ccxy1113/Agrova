import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketLocations extends StatefulWidget {
  const MarketLocations({Key? key}) : super(key: key);

  @override
  _MarketLocationsState createState() => _MarketLocationsState();
}

class _MarketLocationsState extends State<MarketLocations> {
  // Sample market data with just address information
  final List<Map<String, dynamic>> markets = [
    {
      'name': 'ÆEON Mall Ipoh Station 18',
      'hours': '10:00 - 22:30',
      'distance': 2.5,
      'rating': 4.6,
      'promotion': 'Weekend Treats',
      'address':
          'AEON Ipoh Station 18 Shopping Centre, No. 2, Susuran Stesen 18 31650 Ipoh Perak',
    },
    {
      'name': 'Lotus\'s Ipoh Garden',
      'hours': '08:00 - 22:00',
      'distance': 5.1,
      'rating': 4.6,
      'promotion': 'LotussLebihMurah',
      'address': '35, Jalan Medan Ipoh 1A 31400 Ipoh Perak',
    },
    {
      'name': 'Econsave Angsana Ipoh Mall',
      'hours': '9:30 - 22:00',
      'distance': 2.5,
      'rating': 4.6,
      'promotion': 'Salam Ramandan',
      'address':
          'Greentown Mall, Lot F20, Tingkat Satu, Angsana, Jalan Raja Ashman Shah 30450 Ipoh Perak',
    },
  ];

  // Function to launch maps
  Future<void> _launchMaps(String address) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main content section
        Expanded(
          child: Container(
            color: const Color(0xFFD1F5E4), // Light mint background
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // All Markets section
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF00A651)),
                    const SizedBox(width: 8),
                    const Text(
                      'All Markets',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Market cards
                ...markets.map(
                  (market) => _buildMarketCard(
                    market['name'],
                    market['hours'],
                    market['distance'],
                    market['rating'],
                    market['promotion'],
                    market['address'],
                  ),
                ),

                const SizedBox(height: 24),

                // Market Events Calendar header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF00A651),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Market Events Calendar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Events list
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildEventItem(
                        'Weekend Farmers Market',
                        'Sat, 9:00-14:00',
                      ),
                      const SizedBox(height: 12),
                      _buildEventItem('Organic Produce Fair', 'Mar 15, 10:00'),
                      const SizedBox(height: 12),
                      _buildEventItem('Spring Produce Sale', 'Mar 20-25'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketCard(
    String name,
    String hours,
    double distance,
    double rating,
    String promotion,
    String address,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Market name and distance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$distance km',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              Text(
                ' $rating',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Hours
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.grey, size: 18),
              const SizedBox(width: 4),
              Text('Hours: $hours', style: TextStyle(color: Colors.grey[600])),
            ],
          ),

          const SizedBox(height: 8),

          // Promotion tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              promotion,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Direction button only
          TextButton.icon(
            onPressed: () {
              _showDirections(context, name, address);
            },
            icon: const Icon(Icons.directions, color: Color(0xFF00A651)),
            label: const Text(
              'Get Directions',
              style: TextStyle(color: Color(0xFF00A651)),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _showDirections(
    BuildContext context,
    String marketName,
    String address,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Directions to $marketName'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _launchMaps(address);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A651),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'OPEN IN MAPS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CLOSE'),
              ),
            ],
          ),
    );
  }
}

Widget _buildEventItem(String name, String time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      Text(time, style: TextStyle(color: Colors.grey[600])),
    ],
  );
}

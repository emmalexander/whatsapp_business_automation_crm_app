import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whatsapp_business_automation_crm_app/widgets/app_drawer.dart';

import 'package:whatsapp_business_automation_crm_app/screens/leads/lead_profile_screen.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  // Mock State
  List<Map<String, dynamic>> mockLeads = [
    {
      "name": "Alexander Wright",
      "phone": "+1 (555) 012-3456",
      "time": "2H AGO",
      "borderColor": const Color(0xFFB54D31),
      "chips": [
        {"label": "NEGOTIATING", "bgColor": const Color(0xFFFBDFD9), "textColor": const Color(0xFF7A2011)},
        {"label": "ENTERPRISE", "bgColor": const Color(0xFFE5ECFB), "textColor": const Color(0xFF3B507C)},
      ],
      "followUpText": "Follow-up: Oct 24",
      "followUpColor": const Color(0xFF141A25),
      "followUpIcon": Icons.calendar_today,
      "isFollowUpBold": false,
    },
    {
      "name": "Sarah Chen",
      "phone": "+1 (555) 987-6543",
      "time": "YESTERDAY",
      "borderColor": const Color(0xFF0F9D58),
      "chips": [
        {"label": "NEW LEAD", "bgColor": const Color(0xFFCCEFD9), "textColor": const Color(0xFF0F9D58)},
      ],
      "followUpText": "Follow-up: Today",
      "followUpColor": const Color(0xFF0F9D58),
      "followUpIcon": Icons.alarm,
      "isFollowUpBold": true,
    },
    {
      "name": "Jordan Mikealson",
      "phone": "+44 20 7946 0123",
      "time": "3D AGO",
      "borderColor": const Color(0xFFD4DBF3),
      "chips": [
        {"label": "INTERESTED", "bgColor": const Color(0xFFE5ECFB), "textColor": const Color(0xFF3B507C)},
        {"label": "LOW PRIORITY", "bgColor": const Color(0xFFF3F5FA), "textColor": const Color(0xFF5A6678)},
      ],
      "followUpText": "Follow-up: Nov 02",
      "followUpColor": const Color(0xFF5A6678),
      "followUpIcon": Icons.calendar_today,
      "isFollowUpBold": false,
    },
    {
      "name": "Elena Rodriguez",
      "phone": "+1 (555) 234-5678",
      "time": "5H AGO",
      "borderColor": const Color(0xFF3B507C),
      "chips": [
        {"label": "NEGOTIATING", "bgColor": const Color(0xFFFBDFD9), "textColor": const Color(0xFF7A2011)},
      ],
      "followUpText": "Follow-up: Oct 28",
      "followUpColor": const Color(0xFF141A25),
      "followUpIcon": Icons.calendar_today,
      "isFollowUpBold": false,
    },
  ];

  String searchQuery = '';

  void _addLead(String name, String phone) {
    setState(() {
      mockLeads.insert(0, {
        "name": name,
        "phone": phone,
        "time": "JUST NOW",
        "borderColor": const Color(0xFF0F9D58),
        "chips": [
          {"label": "NEW LEAD", "bgColor": const Color(0xFFCCEFD9), "textColor": const Color(0xFF0F9D58)},
        ],
        "followUpText": "Follow-up: Today",
        "followUpColor": const Color(0xFF0F9D58),
        "followUpIcon": Icons.alarm,
        "isFollowUpBold": true,
      });
    });
  }

  void _deleteLead(int index) {
    setState(() {
      mockLeads.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredLeads = mockLeads
        .where((lead) => lead['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      drawer: const AppDrawer(currentIndex: 1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9FB),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF141A25)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Text(
              'LedgeCRM',
              style: GoogleFonts.inter(
                color: const Color(0xFF0F9D58),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF141A25)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFF141A25),
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Leads',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF141A25),
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ACTIVE PIPELINE • ${mockLeads.length} CONTACTS',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF5A6678),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 24),
            
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFE6F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          searchQuery = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search contacts...',
                        hintStyle: GoogleFonts.inter(color: const Color(0xFF5A6678), fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF5A6678), size: 18),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Filter By Status', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16),
                              ListTile(title: const Text('New Lead'), leading: const Icon(Icons.fiber_new), onTap: () => Navigator.pop(context)),
                              ListTile(title: const Text('Negotiating'), leading: const Icon(Icons.sync_alt), onTap: () => Navigator.pop(context)),
                              ListTile(title: const Text('Interested'), leading: const Icon(Icons.thumb_up), onTap: () => Navigator.pop(context)),
                              ListTile(title: const Text('Low Priority'), leading: const Icon(Icons.low_priority), onTap: () => Navigator.pop(context)),
                            ],
                          ),
                        );
                      }
                    );
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Color(0xFF141A25)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Lead Items List
            if (filteredLeads.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      const Icon(Icons.group_off, size: 64, color: Color(0xFFD3DCF6)),
                      const SizedBox(height: 16),
                      Text('No leads found', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xFF5A6678))),
                      const SizedBox(height: 8),
                      Text('Try adjusting your search or add a new lead.', textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFF8C95A6))),
                    ],
                  ),
                ),
              )
            else
              ...filteredLeads.asMap().entries.map((entry) {
                final int originalIndex = mockLeads.indexOf(entry.value);
                final lead = entry.value;
                List<Widget> chipWidgets = (lead['chips'] as List).map((c) => _buildChip(c['label'], bgColor: c['bgColor'], textColor: c['textColor'])).toList();
                
                return _buildLeadCard(
                  context,
                  index: originalIndex,
                  name: lead['name'],
                  phone: lead['phone'],
                  time: lead['time'],
                  borderColor: lead['borderColor'],
                  chips: chipWidgets,
                  followUpText: lead['followUpText'],
                  followUpColor: lead['followUpColor'],
                  followUpIcon: lead['followUpIcon'],
                  isFollowUpBold: lead['isFollowUpBold'],
                );
              }),
            
             const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nameCtrl = TextEditingController();
          final phoneCtrl = TextEditingController();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20, right: 20, top: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add New Lead', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: phoneCtrl,
                      decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameCtrl.text.isNotEmpty && phoneCtrl.text.isNotEmpty) {
                            _addLead(nameCtrl.text, phoneCtrl.text);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lead Added Successfully!')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF13BA5E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('SAVE LEAD', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: const Color(0xFF13BA5E),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildChip(String label, {required Color bgColor, required Color textColor}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildLeadCard(BuildContext context, {
    required int index,
    required String name,
    required String phone,
    required String time,
    required Color borderColor,
    required List<Widget> chips,
    required String followUpText,
    required Color followUpColor,
    required IconData followUpIcon,
    bool isFollowUpBold = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const LeadProfileScreen()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(color: borderColor, width: 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF141A25),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        phone,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF5A6678),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF8C95A6),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Color(0xFF8C95A6), size: 18),
                        onSelected: (value) {
                          if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Lead'),
                                content: Text('Are you sure you want to delete "$name"?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _deleteLead(index);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lead Deleted')));
                                    },
                                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(children: chips),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFF3F5FA), height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(followUpIcon, color: followUpColor, size: 12),
                  const SizedBox(width: 8),
                  Text(
                    followUpText,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: isFollowUpBold ? FontWeight.w700 : FontWeight.w600,
                      color: followUpColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

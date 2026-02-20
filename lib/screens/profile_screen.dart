
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/user_provider.dart';
// import '../widgets/address_list_screen.dart';
// import '../widgets/phone_edit_screen.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = context.watch<UserProvider>();

//     // Show loading indicator if data is being fetched
//     if (userProvider.isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: Text("My Profile")),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     // Show message if user details are missing
//     if (userProvider.userDetails == null) {
//       return Scaffold(
//         appBar: AppBar(title: Text("My Profile")),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     // Once data is loaded
//     final user = userProvider.userDetails!;

//     return Scaffold(
//       appBar: AppBar(title: const Text("My Profile")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user.name ?? 'No Name',
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Email: ${user.email}"),
//                     const SizedBox(height: 4),
//                     Text("Phone: ${user.phone}"),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ListTile(
//               leading: const Icon(Icons.phone),
//               title: const Text("Edit Phone Number"),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const PhoneEditScreen(),
//                   ),
//                 );
//               },
//             ),
//             const Divider(),

//                         ListTile(
//               title:  Text(user.userStatus ?? 'Unknown'),
//               leading: const Text("Status"),
        
              
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.location_on),
//               title: const Text("My Addresses"),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const AddressListScreen(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/address_list_screen.dart';
import '../widgets/phone_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    // Loading state
    if (userProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("My Profile")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final user = userProvider.userDetails;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("My Profile")),
        body: const Center(child: Text("No user details available.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoCard(user: user),
            const SizedBox(height: 16),
            InfoTileCard(
              icon: Icons.info_outline,
              title: "Status",
              trailingText: user.userStatus ?? "Unknown",
            ),
            const SizedBox(height: 16),
            NavigationTileCard(
              icon: Icons.location_on,
              title: "My Addresses",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddressListScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            NavigationTileCard(
              icon: Icons.phone,
              title: "Edit Phone Number",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PhoneEditScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// User info card with avatar and edit button
class UserInfoCard extends StatelessWidget {
  final dynamic user; // Replace dynamic with your user model

  const UserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                (user.name != null && user.name.isNotEmpty)
                    ? user.name[0].toUpperCase()
                    : "U",
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? 'No Name',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text("Email: ${user.email ?? '-'}"),
                  const SizedBox(height: 4),
                  Text("Phone: ${user.phone ?? '-'}"),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PhoneEditScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

/// Simple info tile with trailing text
class InfoTileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String trailingText;

  const InfoTileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(
          trailingText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Navigation tile card for sections that navigate to another screen
class NavigationTileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const NavigationTileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

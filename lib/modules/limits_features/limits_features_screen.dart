part of 'limits_features.dart';

class LimitsFeaturesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Limits & Features"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GrayContainer(title: "Invite and Earn"),
            const ListTile(
              title: Text("Invite/Refer"),
              subtitle: Row(
                children: [Text("Disable"), Text("Verify E-mail")],
              ),
            ),
            const ListTile(
              title: Text("Withdraw"),
              subtitle: Row(
                children: [Text("Disable"), Text("Verify E-mail")],
              ),
            ),
            const GrayContainer(title: "Upload Limits"),
            const ListTile(
              title: Text("Weekly"),
              subtitle: Row(
                children: [
                  Text("0.0 MB of"),
                  Text(
                    "5.00GB",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
            const ListTile(
              title: Text("Total Limit"),
              subtitle: Row(
                children: [
                  Text("0.0 MB of"),
                  Text(
                    "50.00GB",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
            const GrayContainer(title: "Account Levels"),
            const VerificationLevels(),
            const SizedBox(height: 10),
            Visibility(
              child: Column(
                children: [
                ElevatedButton(
                  onPressed: () => null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: DottedBorder(
                    color: Colors.blue,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            "VERIFY YOUR EMAIL",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(height: 5),
            Visibility(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () => null,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.perm_identity_outlined),
                        Text("CONFIRM YOUR IDENTITY"),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

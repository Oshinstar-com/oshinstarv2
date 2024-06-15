part of 'finance.dart';

class FinanceAuthenticateScreen extends StatefulWidget {
  const FinanceAuthenticateScreen({super.key});

  @override
  _FinanceAuthenticateScreenState createState() =>
      _FinanceAuthenticateScreenState();
}

class _FinanceAuthenticateScreenState extends State<FinanceAuthenticateScreen> {
  bool _isPasswordVisible = false;
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricSupported = false;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    bool isSupported = await _localAuth.isDeviceSupported();
    bool isAvailable = await _localAuth.canCheckBiometrics;
    setState(() {
      _isBiometricSupported = isSupported;
      _isBiometricAvailable = isAvailable;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    if (!_isBiometricSupported || !_isBiometricAvailable) return;

    try {
      bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your wallet',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        context.read<MetaCubit>().setMetadata({'biom-fin': 'true:${DateTime.now().add(Duration(hours: 12)).toIso8601String()}'});
        _navigateBasedOnUnlockTime();
      }
    } catch (e) {
      print(e);
    }
  }

  void _navigateBasedOnUnlockTime() {
    final meta = context.read<MetaCubit>().state;
    final biomFin = meta['biom-fin'];
    if (biomFin != null) {
      final parts = biomFin.split(':');
      if (parts.length == 2 && parts[0] == 'true') {
        final expiry = DateTime.parse(parts[1]);
        if (DateTime.now().isBefore(expiry)) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => FinanceOverview()),
          // );
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    _navigateBasedOnUnlockTime();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkpoint"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi ${user['firstName']},"),
            const SizedBox(height: 8),
            const Text(
                "For your security, please authenticate to access your wallet"),
            const SizedBox(height: 16),
            if (_isBiometricAvailable) ...[
              ElevatedButton(
                onPressed: _authenticateWithBiometrics,
                child: const Text("Authenticate with Biometrics"),
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Add your help action here
              },
              child: const Text(
                "Need help?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your continue action here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oil_erp/main.dart';
import 'package:pinput/pinput.dart';

class OTPLogin extends StatefulWidget {
  const OTPLogin({super.key});

  @override
  State<OTPLogin> createState() => _OTPLoginState();
}

class _OTPLoginState extends State<OTPLogin> {
  final _oilIdCtrl = TextEditingController();
  bool _loading = false;
  bool _otpSent = false;
  String _smsId = '';
  String _pernr = '';
  String _mobile = '';
  
  //late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    //smsRetriever = SmsRetrieverImpl(SmartAuth.instance);
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final apiUrl = '${serverBaseUrl}auth/initotp';
    setState(() {
      _loading = true;
    });
    try {
      final res = await http
          .post(
            Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'pernr': _oilIdCtrl.text.trim()}),
          )
          .timeout(const Duration(seconds: 15));
      /* if (res.statusCode != 200) {
        final err = jsonDecode(res.body);
        throw Exception(err['message'] ?? 'OTP initiation failed');
      } */
      final data = jsonDecode(res.body);

      if (data['success'] == true) {
        setState(() {
          _otpSent = true;
          _smsId = data['smsid']; // save for verify step
          _pernr = data['pernr']; // set pernr received from backend
          _mobile = data['mobile'];
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid OIL Id")));
      }
    } catch (e) {
      //_showError(e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _verifyOtp(String otp) async {
    final apiUrl = '${serverBaseUrl}auth/verifyotp';
    setState(() => _loading = true);
    try {
      final res = await http
          .post(
            Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'pernr': _pernr, 'smsID': _smsId, 'otp': otp}),
          )
          .timeout(const Duration(seconds: 15));
      /* if (res.statusCode != 200) {
        final err = jsonDecode(res.body);
        throw Exception(err['message'] ?? 'OTP initiation failed');
      } */
      final data = jsonDecode(res.body);

      if (data['success'] == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("OTP verified successfully")));

        String jwtToken = data['access_token'];
        //Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
        //String pernr = decodedToken["sub"];
        setState(() {
          JWT = jwtToken; // save for verify step
          EmpRegistered = true;
          OILId = _pernr;
        });
        await storage.write(key: "JWT", value: data['access_token']);
        await storage.write(key: "EmpReg", value: EmpRegistered.toString());
        await storage.write(key: "OILId", value: OILId);
        context.go('/offline');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("OTP verification failed")));
      }
    } catch (e) {
      //_showError(e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        title: Image.asset('images/oil_logo_with_background.png', height: 55),
        centerTitle: true,
        backgroundColor: Color(0xFFE5E5E5),
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFFE5E5E5)),
          child: Column(
            children: <Widget>[
              PlatformText(
                'OIL ERP Mobile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color
                  letterSpacing: 1.2, // Optional: spacing between letters
                ),
              ),
              Image.asset('images/banner.gif'),

              //SizedBox(height: 50),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : !_otpSent
                  ? Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 24),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: _buildRegistrationUI(),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _buildOtpUI(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: PlatformText(
            'Register for Offline Services',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  PlatformText(
                    'Enter OIL ID',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  //const SizedBox(height: 5),
                  TextField(
                    controller: _oilIdCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8), // PERNR length
                    ],
                    decoration: const InputDecoration(
                      labelText: "OIL ID",
                      //hintText: "Enter 8-digit Employee ID",
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: _sendOtp,
                    child: const Text('Get OTP'),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 40),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          child: PlatformText(
            '© 2025 Oil India Limited. All rights reserved',
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpUI() {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),

            PlatformText(
              'Verification',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            PlatformText(
              'Enter the 4 digit code sent to your registered mobile number $_mobile',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            Center(
              child: Pinput(
                controller: pinController,
                focusNode: focusNode,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (_) => const SizedBox(width: 8),
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),

            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
              child: ElevatedButton(
                onPressed: () {
                  focusNode.unfocus();
                  if (formKey.currentState?.validate() ?? false) {
                    _verifyOtp(pinController.text);
                  }
                },
                child: const Text('Validate'),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

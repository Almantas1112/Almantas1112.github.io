import 'package:flutter/material.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  late TextEditingController _name;
  late TextEditingController _address;
  late TextEditingController _job;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _address = TextEditingController();
    _job = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _address.dispose();
    _job.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitle(),
          _buildForms(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.3)),
              child: const Text(
                'Pateikti',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForms() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTextForm(
            text: 'Vardas ir pavardė',
            controller: _name,
          ),
          _buildTextForm(
            text: 'Adresas',
            controller: _address,
          ),
          _buildTextForm(
            text: 'Reikiamas darbas',
            controller: _job,
          ),
        ],
      ),
    );
  }

  Widget _buildTextForm({
    required String text,
    TextStyle? style,
    required TextEditingController controller,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: text,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Užsakyti paslaugą',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _buildText({
    required String text,
    TextStyle? style,
  }) {
    return Text(
      text,
      style: style,
    );
  }
}

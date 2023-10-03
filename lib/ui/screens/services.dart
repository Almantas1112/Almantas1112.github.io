import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gov_tech/blocs/services/services_cubit.dart';
import 'package:gov_tech/constants/app_colors.dart';
import 'package:gov_tech/ui/screens/add_service.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late ServicesCubit _servicesCubit;
  late AnimationController controller;

  bool _isHoovered = false;

  @override
  void initState() {
    super.initState();
    _servicesCubit = BlocProvider.of<ServicesCubit>(context)..getServices();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 20),
          _buildServicesList(),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoadedState) {
          return _buildLoadedContent(state);
        } else if (state is ServicesErrorState) {
          return _buildError(state.errorMsg);
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoadedContent(ServicesLoadedState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildMainTitleRow(),
            _buildContentList(state),
            const SizedBox(height: 20),
            _buildMainMenuIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainMenuIcon() {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25),
        ),
        child: _buildHooveredRow(),
      ),
      onTap: () => _addService(),
      onHover: (isHovering) {
        setState(() {
          _isHoovered = isHovering;
        });
      },
    );
  }

  Widget _buildHooveredRow() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isHoovered ? 200 : 25,
          child: Row(
            mainAxisAlignment: _isHoovered
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(_isHoovered ? 1.0 : 0.0, 0.0),
                        end: Offset(_isHoovered ? 0.0 : 1.0, 0.0))
                    .animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              _isHoovered ? _buildSelections() : const SizedBox(),
              const Icon(Icons.add),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelections() {
    return TextButton(
      onPressed: () => _addService(),
      child: const Text(
        'Pridėti paslaugą',
        style: TextStyle(
          color: AppColors.scaffoldColor,
        ),
      ),
    );
  }

  Widget _buildContentList(ServicesLoadedState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        itemCount: state.data.length,
        itemBuilder: (context, i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildContainer(
                text: state.data[i].whoOrdered,
                color: AppColors.scaffoldColor,
              ),
              _buildContainer(
                text: state.data[i].orderTime.toString(),
                color: Colors.grey.withOpacity(0.5),
                textColor: AppColors.scaffoldColor,
              ),
              _buildContainer(
                text: state.data[i].orderCompletedTime != null
                    ? state.data[i].orderCompletedTime.toString()
                    : '----',
                color: AppColors.scaffoldColor,
              ),
              _buildContainer(
                text: state.data[i].orderJob,
                color: Colors.grey.withOpacity(0.5),
                textColor: AppColors.scaffoldColor,
              ),
              _buildContainer(
                text: state.data[i].orderStreet,
                color: AppColors.scaffoldColor,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildContainer(
          text: 'Kas užsakė',
          color: Colors.grey.withOpacity(0.5),
          textColor: AppColors.scaffoldColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
          ),
        ),
        _buildContainer(
          text: 'Užsakymo pateikimo data',
          color: AppColors.scaffoldColor,
        ),
        _buildContainer(
          text: 'Užsakymo atlikimo data',
          color: Colors.grey.withOpacity(0.5),
          textColor: AppColors.scaffoldColor,
        ),
        _buildContainer(
          text: 'Užsakymo darbo tipas',
          color: AppColors.scaffoldColor,
        ),
        _buildContainer(
          text: 'Užsakymo adresas',
          color: Colors.grey.withOpacity(0.5),
          textColor: AppColors.scaffoldColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer({
    required String text,
    required Color color,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildError(String text) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 60,
      child: Center(
        child: _buildText(text: text),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 60,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildTitle() {
    return _buildText(
      text: 'Paslaugos',
      style: const TextStyle(
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

  void _addService() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddServiceScreen(),
      ),
    );
  }
}

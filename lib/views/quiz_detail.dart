import 'package:final_620710666/models/quizgames.dart';
import 'package:final_620710666/services/api.dart';
import 'package:flutter/material.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({Key? key}) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  int index = 0;
  List<quiz>? choice_list;
  bool loading = true;

  List<String> option = ['ZEBRA', 'CHIMPANZEE', 'MEERKAT', "HIPPO"];

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  void _fetchFood() async {
    List list = await Api().fetch('quizzes');
    setState(() {
      choice_list = list.map((item) => Food.fromJson(item)).toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: choice_list != null ? Text(choice_list![index].name) : const Text(''),
      ),
      body: Stack(
        children: [
          _buildFood(),
          _buildPagination()
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return choice_list != null ? Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _previous(),
            Text(' ${index+1}/${choice_list!.length}'),
            _next(),
          ],
        ),
      ),
    ) : const SizedBox.shrink();
  }

  void _handleClickButton(int page) {
    setState(() {
      index += page;
    });
  }

  Widget _previous() {
    return index > 0 ? Container(
      width: 150,
      child: ElevatedButton.icon(
        onPressed: () => _handleClickButton(-1),
        label: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('ก่อนหน้า'),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
        ),
      ),
    ) : const SizedBox(width: 150.0, height: 10.0,);
  }

  Widget _next() {
    return index < choice_list!.length-1 ? Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 150.0,
        child: ElevatedButton.icon(
          onPressed: () => _handleClickButton(1),
          label: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('ถัดไป'),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
          ),
        ),
      ),
    ) : Container(
      width: 150.0,
      child: ElevatedButton(
        onPressed: (){},
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text('Submit'),
        ),
      ),
    );
  }

  Widget _buildFood() {
    return loading ? const Center(child: CircularProgressIndicator())
        : choice_list != null
        ? ListView(
      children: [
        _buildFoodDetail(_foodList![index]),
        const SizedBox(height: 65.0, width: 10.0),
      ],
    ) : _buildTryAgainButton();
  }

  Center _buildTryAgainButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(''),
          ElevatedButton(
            onPressed: () => _fetchFood(),
            child: const Text(''),
          ),
        ],
      ),
    );
  }

  Column _buildFoodDetail(quiz quizgames) {
    return Column(
      children: [
        Image.network(quizgames.image, fit: BoxFit.cover),
        Center(child: Text(quizgames.name)),
        for(int i=0; i<option.length; i+=2)
          _buildRadioOption(i),
      ],
    );
  }

  Widget _buildRadioOption(int optionIndex) {
    return Row(
      children: [
        for(int i=optionIndex; i<optionIndex+2; i++)
          Expanded(
            child: Row(
              children: [
                Radio(
                  value: option[i],
                  groupValue: _foodList![index].option,
                  onChanged: (value){
                    setState(() {
                      _foodList![index].option = value.toString();
                    });
                  },
                ),
                Text(option[i]),
              ],
            ),
          ),
      ],
    );
  }
}
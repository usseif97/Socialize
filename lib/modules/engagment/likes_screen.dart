import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/engagment_states.dart';
import 'package:socialize/shared/cubit/engagmnet_cubit.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EngagmentCubit, EngagmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var likeList = EngagmentCubit.get(context).likes;

        return state is EngagmnetGetLikesLoadingState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : likeList.length > 0
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return _buildItem(likeList[index]);
                    },
                    separatorBuilder: (context, index) {
                      return defaultSeperator();
                    },
                    itemCount: likeList.length,
                  )
                : Center(
                    child: Text('No Likes !!'),
                  );
      },
    );
  }

  Widget _buildItem(model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(model.image),
            ),
            SizedBox(width: 10.0),
            Text(
              model.name,
              style: TextStyle(fontSize: 20.0),
            ),
            Spacer(),
            Icon(IconBroken.Heart),
          ],
        ),
      );
}

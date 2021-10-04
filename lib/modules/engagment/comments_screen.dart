import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/engagment_states.dart';
import 'package:socialize/shared/cubit/engagmnet_cubit.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EngagmentCubit, EngagmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var commentList = EngagmentCubit.get(context).comments;

        return state is EngagmnetGetLikesLoadingState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : commentList.length > 0
                ? ListView.separated(
                    itemBuilder: (context, index) =>
                        _buildItem(commentList[index], context),
                    separatorBuilder: (context, index) => defaultSeperator(),
                    itemCount: commentList.length,
                  )
                : Center(
                    child: Text('No Comments !!'),
                  );
      },
    );
  }

  Widget _buildItem(model, context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(model.image),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  model.comment,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 15),
                ),
              ],
            ),
            Spacer(),
            Icon(IconBroken.Chat),
          ],
        ),
      );
}

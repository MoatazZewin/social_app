import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_simple_app/shared/components/components.dart';
import 'package:social_simple_app/shared/styles/colors.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            elevation: 5.0,
            margin: const EdgeInsets.all(8.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
              const Image(
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                  image: NetworkImage(
                      'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg')),
              Text(
                'communicate with friends ',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ]),
          ),
          ListView.separated(itemBuilder: (context, index)=>buildPostItem(context),
              separatorBuilder: (context, index)=> const SizedBox(
                height: 2.0,
              ),
              itemCount: 10,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
          const SizedBox(
            height: 8.0,
          )
        ],
      ),
    );
  }

  Widget buildPostItem(context)=>Card(
    elevation: 5.0,
    margin: const EdgeInsets.all(8.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Moataz Ahemd',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      'january 21,2021 at 11 am',
                      style:
                      Theme.of(context).textTheme.caption?.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              top: 5.0,
            ),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 6.0,
                    ),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#software',
                          style:Theme.of(context).textTheme.caption?.copyWith(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text('1200',
                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          Text('120 Comment',
                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:  [
              Expanded(
                child: InkWell(
                  onTap:(){},
                  child: Row(
                    children: const [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                      ),
                      SizedBox(width: 5.0,),
                      Text('write a comment....'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      Text('Like',
                        style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    ),
  );
}

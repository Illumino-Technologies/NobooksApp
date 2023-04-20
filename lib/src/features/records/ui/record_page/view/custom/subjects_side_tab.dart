part of '../record_page.dart';

class _SubjectsSideTab extends StatelessWidget {
  const _SubjectsSideTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Subjects Taken Up',
              style: TextStyles.paragraph3.withSize(14).copyWith(
                color: AppColors.neutral200,
              ),
            ),
            SizedBox(
              height: context.screenHeight * 0.85,
              width: 320.w,
              child: ListView.builder(
                itemCount: FakeSubjects.subjects.length,
                itemBuilder: (context, index) => 
                ExpansionTile(
                  leading: SubjectWidget(
                    subject: FakeSubjects.subjects[index],
                    boxSize: 60.r,
                    fontSize: 30.sp,
                  ),
                  title: Text(
                    FakeSubjects.subjects[index].name,
                    style: TextStyles.paragraph1.asSemibold,
                  ),
                  childrenPadding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 30.h,
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Continuous Assessment',
                          style: TextStyles.paragraph1.withSize(10),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.neutral100,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal:15.w,
                             vertical: 5.h,),
                            child:  Text('40', style:TextStyles.
                            headline6.withSize(10).withBlack,),
                          ),
                        ),
                      ],
                    ),
                    20.boxHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Examination',
                          style: TextStyles.paragraph1.withSize(10),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.neutral100,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal:15.w,
                             vertical: 5.h,),
                            child: Text('40', style:TextStyles.
                            headline6.withSize(10).withBlack,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
              style: TextStyles.headline3.withSize(18),
            ),
            SizedBox(
              height: context.screenHeight * 0.85,
              width: 320.w,
              child: ListView.builder(
                itemCount: FakeSubjects.subjects.length,
                itemBuilder: (context, index) => ExpansionTile(
                  leading: SubjectWidget(
                    subject: FakeSubjects.subjects[index],
                    boxSize: 40.r,
                    fontSize: 25.sp,
                  ),
                  title: Text(
                    FakeSubjects.subjects[index].name,
                    style: TextStyles.paragraph1.asSemibold,
                  ),
                  childrenPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 20.h,
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Continuous Assessment',
                          style: TextStyles.paragraph1.withSize(10),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: const Text('40'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Examination',
                          style: TextStyles.paragraph1.withSize(10),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: const Text('40'),
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

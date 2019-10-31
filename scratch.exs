s = Gradely.Students.get_student! 1
c = Gradely.Courses.list_courses

Gradely.Enrollments.enroll_student s, c
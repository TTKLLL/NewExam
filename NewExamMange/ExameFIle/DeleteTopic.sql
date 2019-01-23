
use NewExam
delete from Invigilate
delete from StuExam
delete from TheExam
delete from StuPaper

delete from Exam
delete from Paper
delete from topic

delete from student 

use NewExam

select * from theExam
select * from exam

select * from StuExam
select * from stupaper

select * from StuExam where StudentId = '201640450102' and PaperId in (select  PaperId from Paper where ExamId in (select ExamId from exam where theExamId = 1))

--根据paperId获取次考试Id
select * from theExam where theExamId in (select * from paperId )

select * from StuExam where StudentId = '201640450102' and PaperId in (select  PaperId from Paper where ExamId in (select ExamId from exam where theExamId = 1)  )
go

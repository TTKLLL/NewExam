alter table exam alter column ExamPeriod int

  delete from TheExam
  delete from Exam
  delete from Paper
   delete from PaperDetail
   delete from Invigilate
   
   alter table stuexam drop column position
   select * from topic 
   select * from Paper where ExamId in (select ExamId from Exam, TheExam where Exam.TheExamId = TheExam.TheExamId
   and TheExamName like '%数据库系统概论第三次考试%' and ExamPeriod = '1')

   select * from Paper where ExamId in (select ExamId from Exam where TheExamId = '90')
  
  select * from Student where StudentId in 
  (select StudentId from StuExam where PaperId in 
	(select paperId from Paper where ExamId = '105'))
  order by 


   
  select * from paper where 

  select * from PaperDetail where PaperId = 466 

  select ReplyEndTime from StuExam where StudentId = '201540450119'
  and PaperId in (select PaperId from Paper where ExamId in 
  (select ExamId from Exam where TheExamId = '89'))

  select * from StuExam

  update StuExam set ReplyEndTime = '2015/02/03'
  update StuExam set beginexamtime = '2015/02/03'

    update student set StuExamState = 0

	select top 1 * from  paper where ExamId = 105 order by NEWID()

	select count(1) from StuExam where TId = '01' and PaperId = 662

	alter table StuPaper add ExamId numeric(18, 0)
	alter table stupaper add constraint a_fk foreign key(ExamId) references exam(ExamId)

	select * from StuExam where StudentId = '201540450119' and PaperId in
	(select PaperId from Paper where ExamId = '104')

	select * from StuPaper

	  select * from StuExam


	  --检查有无重复的卷子
  select * from Student, StuExam, Invigilate where

  select Student.StudentId, StudentName, StudentPhone, Class, ExamRoomPosition, IPAddress, StuExamState,
  StudentState, StuExam.PaperId, Invigilate.TId,  StuExam.Score,  StuExam.ReplyEndTime, StuExam.BeginExamTIme
  from Student 
  left join StuExam on  Student.StudentId = StuExam.StudentId 
  and PaperId in (select paperId from Paper where ExamId = '117')
  left join Invigilate on  StuExam.TId = Invigilate.TId and Invigilate.ExamId = '117'
  where (studentName like '%w%' and Class like '%%')
  order by ExamRoomName,  ReplyEndTime desc, Student.StudentId 
  go

  select * from Student left join StuExam on Student.StudentId = StuExam.StudentId

  select * from student

   select * from Student where StudentId in 
                        (select StudentId from StuExam where PaperId in
                             (select paperId from Paper where ExamId = '105'))

select * from StuExam where StudentId = '201540450119'
and PaperId in (select  PaperId from Paper where ExamId = '117')

update stuexam set ipaddress = '172.16.25.2'

select count(1) from StuExam where TId = '01' and PaperId in 
	(select PaperId from Paper where ExamId = 105)

	select * from Exam where ExamId = 117

	  select count(1) from Paper where ExamId = 117

	   select * from StuExam where StudentId = '01'
        and PaperId in (select PaperId from Paper where ExamId in 
        (select ExamId from Exam where TheExamId = 92))

		select * from StuExam where StudentId = '201540450119'
		and PaperId in (select PaperId from Paper where ExamId = 117)

-*

		select TopicId from StuPaper where StuPaper.StudentId = '201540450119' and  ExamId = 117
		
		update Student set StuExamState =  0 where StudentId = '201540450119'

		update StuExam set Score = 0 where  PaperId =  2017 and StudentId = '201540450119'

		select * from StuExam where StudentId = '201540450119'
        and PaperId in (select PaperId from Paper where ExamId in 
        (select ExamId from Exam where TheExamId = 92))

		select SortId, SortName  from Sort where SortId in ( select Sort.SortId from Topic, Sort 
		where Topic.SortId = Sort.SortId and TopicId in 
			(select TopicId from StuPaper where StuPaper.StudentId = '201540450119' and  ExamId = 117))
			order by SortOrder 

		select TopicTitle, StuAnswer from StuPaper, Topic  where StuPaper.TopicId = Topic.TopicId and
		 StudentId = '201540450119'and  ExamId = 117 
		 

		 select * from StuExam, Topic where Topic.TopicId = 
		  StudentId = '201540450119' 
           and PaperId = 1930 in (select top 1 PaperId from Paper where ExamId = 117)

		    in 
           (select ExamId from Exam where TheExamId = '92'))

		   select  from StuPaper, Topic where StuPaper.TopicId = Topic.TopicId
		   and StudentId = '201540450119' and StuPaper.ExamId = 117

		   select * from StuPaper, Topic, Sort  where Topic.SortId = Sort.SortId  
            and StuPaper.TopicId = Topic.TopicId and 
             StudentId = '201540450119' and  ExamId = 117


		select SortId, SortName from Sort where SortId in ( select Sort.SortId from Topic, Sort 
             where Topic.SortId = Sort.SortId and TopicId in  
             (select TopicId from StuPaper where StuPaper.StudentId = '201540450119' and  ExamId = 117))
			 and TopicSortNumber > 10
           order by SortOrder 

		   select * from StuExam where PaperId in
		   (select PaperId from Paper where ExamId = 121)

		    select Student.StudentId, StudentName, StudentPhone, Class, ExamRoomPosition, IPAddress, StuExamState, 
  StudentState, StuExam.PaperId, Invigilate.TId,  StuExam.Score,  StuExam.ReplyEndTime, StuExam.BeginExamTIme 
  from Student  
   left join StuExam on  Student.StudentId = StuExam.StudentId  
   and PaperId in (select paperId from Paper where ExamId = 121) 
   left join Invigilate on  StuExam.TId = Invigilate.TId and Invigilate.ExamId =122 
   order by ExamRoomName,  ReplyEndTime desc, Student.StudentId  

    select * from StuExam where StudentId = '01'
            and PaperId in (select PaperId from Paper where ExamId in 
            (select ExamId from Exam where TheExamId = 93 )
			
			
			alter table stupaper alter column examid numeric(18, 0) not null
			alter table stupaper add constraint primary_key primary key(topicId, studentId, examId)

			select * from StuPaper, Topic, Sort, FirstPoint, SecondPoint, TopicSource  
			where FirstPoint.FirstPointId = SecondPoint.FIrstPointId and SecondPoint.SecondPointId = Topic.SecondPointId
			and Topic.TopicSourceId = TopicSource.TopicSourceId and Topic.SortId = Sort.SortId  
            and StuPaper.TopicId = Topic.TopicId and 
             StudentId = '2015' and  ExamId = {1} and Sort.SortId = {2}

			 select * from paper where Examid = 122 and rownum>0
			 minus   
select   *   from   table1   where   rownum   <=   m;

				select   top  1  *   from   
			(select   top   8  *   from   paper where Examid = 122   )  temp_paper 
				

			select distinct Sort.SortId, SortName, SortOrder from  Topic, Sort, PaperDetail
			where  Topic.TopicId = PaperDetail.TopicId and Sort.SortId = Topic.SortId and PaperId = 2538
			order by SortOrder
			
			 select * from Paper, PaperDetail, Topic, Sort, FirstPoint, SecondPoint, TopicSource  
			where FirstPoint.FirstPointId = SecondPoint.FIrstPointId and SecondPoint.SecondPointId = Topic.SecondPointId
			and Topic.TopicSourceId = TopicSource.TopicSourceId and Topic.SortId = Sort.SortId and Paper.PaperId = PaperDetail.PaperId
			and  PaperDetail.TopicId = Topic.TopicId   and Paper.PaperId = 2538 and Sort.SortId = 1

			select * from Topic
			where Topic.TopicId in (select TopicId from PaperDetail where PaperId = 2538) and SortId = 1
			
			select * from sort where SortId in (
			 select distinct Sort.SortId from  Topic, Sort, PaperDetail 
             where  Topic.TopicId = PaperDetail.TopicId and Sort.SortId = Topic.SortId and PaperId = 3345  
            )order by SortOrder




			select Student.StudentId, StudentName, StudentPhone, Class, ExamRoomPosition, IPAddress, StuExamState,
  StudentState, StuExam.PaperId, Invigilate.TId,  StuExam.Score,  StuExam.ReplyEndTime, StuExam.BeginExamTIme 
  from Student  
  left join StuExam on  Student.StudentId = StuExam.StudentId  
   and PaperId in (select paperId from Paper where ExamId in (select ExamId from TheExam where TheExamId = 95 )) 
   left join Invigilate on  StuExam.TId = Invigilate.TId and Invigilate.ExamId in (select ExamId from TheExam where TheExamId = 95 )
  
  where StudentState = 2
   order by ExamRoomPosition ,  ReplyEndTime desc, Student.StudentId  


   select * from StuExam where PaperId in (select PaperId from Paper where ExamId 
		in (select ExamId from Exam where TheExamId = 95))

		select * from Student 
		left join StuExam on Student.StudentId = StuExam.StudentId   
		left join Invigilate on StuExam.TId = Invigilate.TId  
	--	 in (select ExamId from Exam where TheExamId = 95)) -- and Invigilate.ExamId = 125 
		 left join Exam on Invigilate.ExamId = Exam.ExamId
		where StudentState = 2 and Invigilate.TId = 'admin' 
		and PaperId in (select PaperId from Paper where ExamId 
		 in (select ExamId from Exam where TheExamId = 95)) 
	//	order by ExamPeriod desc

	



	left join Invigilate on StuExam.TId = Invigilate.TId
	where Invigilate.ExamId in (select ExamId from Exam where TheExamId = 95)
		 and StuExam.TId = 'admin'
		  and StudentName like '%强%'

		  select * from StuExam where StudentId = '201540450119' and  PaperId in (select PaperId from Paper where ExamId 
		 in (select ExamId from Exam where TheExamId = 95))  






		 select * from Student
	left join StuExam on Student.StudentId = StuExam.StudentId  
	left join  Invigilate on StuExam.TId  = Invigilate.TId and StuExam.PaperId 
	 in (select PaperId from Paper where ExamId = Invigilate.ExamId)
	left join  Exam on StuExam.PaperId in (select PaperId from Paper where ExamId = Exam.ExamId)
	where   PaperId in (select PaperId from Paper where ExamId 
		 in (select ExamId from Exam where TheExamId = 95)) 
	and StuExam.TId = 'admin' and StuExam.PaperId in (select PaperId from Paper where ExamId = '125')
	order by ExamPeriod , ReplyEndTime 

		

		
			 
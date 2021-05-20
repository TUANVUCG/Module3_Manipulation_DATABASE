USE STUDENTMNG;

INSERT INTO CLASS
VALUE (1,'A1',20/12/2008,1);
INSERT INTO CLASS
VALUE (2,'A2',22/12/2008,1);
INSERT INTO CLASS
VALUE (3,'B3',CURRENT_DATE,1);

INSERT INTO STUDENT
VALUE (1,'Hung', 'Ha Noi', '0328329487847',1,1);
INSERT INTO STUDENT
VALUE (2,'Hoa', 'Hai Phong', NULL,1,1);
INSERT INTO STUDENT
VALUE (3,'Manh', 'HCM', '098332938',0,2);

INSERT INTO SUBJECT
VALUE (1,'CF',5,1);
INSERT INTO SUBJECT
VALUE (2,'C',6,1);
INSERT INTO SUBJECT
VALUE (3,'HDJ',5,1);
INSERT INTO SUBJECT
VALUE (4,'RDBMS',10,1);

INSERT INTO MARK
VALUE( 1,1,1,8,1);
INSERT INTO MARK
VALUE( 2,1,2,10,2);
INSERT INTO MARK
VALUE( 3,2,1,12,1);

-- Hiển thị danh sách tất cả các học viên
SELECT*
FROM student;

-- Hiển thị danh sách các học viên đang theo học.
SELECT*
FROM student
WHERE Status = 1;

-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.
SELECT*
FROM subject
WHERE Credit < 10;

-- Hiển thị danh sách học viên lớp A1
SELECT S.StudentID, S.StudentName, C.ClassName
FROM student S
JOIN class C ON S.ClassID = C.ClassID
WHERE C.ClassName = 'A1';

-- Hiển thị điểm môn CF của các học viên.
SELECT S.StudentID, S.StudentName,Sub.SubName, M.Mark
FROM student S
JOIN mark M ON S.StudentID = M.StudentID
JOIN Subject Sub ON M.SubID = Sub.SubID
WHERE Sub.SubName = 'CF';

-- Hiển thị điểm môn CF của các học viên lớp A1
SELECT S.StudentID, S.StudentName, Sub.SubName, M.mark,C.ClassName
FROM student S
JOIN mark M ON S.StudentID = M.StudentID
JOIN subject Sub ON M.SubID = Sub.SubID
JOIN class C ON S.ClassID = C.ClassID
WHERE Sub.SubName = 'CF' AND C.CLassName = 'A1';

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT*
FROM student S
WHERE S.StudentName LIKE 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
SELECT*
FROM class C
WHERE MONTH(C.StartDate) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
SELECT*
FROM subject S
WHERE S.Credit BETWEEN 3 AND 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
SET SQL_SAFE_UPDATES = 0;
UPDATE  student
SET ClassID = 2
WHERE StudentName = 'Hung';

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
USE studentmng;
SELECT S.StudentName, Sub.SubName, M.Mark
FROM student S
LEFT JOIN mark M ON S.StudentID = M.StudentID
left JOIN Subject Sub ON M.SubID = Sub.SubID
ORDER BY M.mark DESC, S.StudentName ASC;


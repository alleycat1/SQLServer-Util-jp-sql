 SET NOCOUNT ON
 GO

 DROP TABLE IF EXISTS Station
 DROP TABLE IF EXISTS Route
 GO
 
 CREATE TABLE dbo.Station (
	name varchar(50),
	INDEX IX_Station UNIQUE ($node_id),
	INDEX IX_Station_Name(name)
) AS NODE

 CREATE TABLE dbo.Route (
	Time int,
	IsExpress bit,
	IsLocal bit,
	IsUp bit,
	IsDown bit,
    INDEX IX_Route UNIQUE ($edge_id),
    INDEX IX_Route_From ($from_id),
    INDEX IX_Route_To ($to_id)
)AS EDGE
GO

 INSERT INTO dbo.Station VALUES 
('���c��'),
	('����'),('壓c'),('�x��'),('���R'),('�J��'),
('�V���c'),
('�a��'),
('�`��'),
('���C��w�O'),
('�ߊ�����'),
('�ɐ���'),
('���b�Γc'),
('�{����'),
	('����'),
('�C�V��'),
	('����'),('������O'),('���c�}���͌�'),
('���͑��'),
('���c'),
	('�ʐ�w���O'),('�ߐ�'),('�`��'),
('�V�S�����u'),
	('�S���P�u'),('�ǔ������h�O'),('���c'),
('�����u�V��'),
('�o��'),
	('�a�򑽖���'),('���]'),('�쑽��'),
('����w���O'),
	('�c�t���J�呠'),('��ΑD��'),
('�o��'),
	('������'),('�~���u'),('���c�J��c'),
('���k��'),
	('���k��'),
('��X�؏㌴'),
	('��X�ؔ���'),('�Q�{��'),('��V�h'),
('�V�h')
GO

INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���c��'),
    (SELECT $node_id FROM Station WHERE name = '����'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���c��'),
    (SELECT $node_id FROM Station WHERE name = '�V���c'), 
	8, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����'),
    (SELECT $node_id FROM Station WHERE name = '壓c'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '壓c'),
    (SELECT $node_id FROM Station WHERE name = '�x��'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�x��'),
    (SELECT $node_id FROM Station WHERE name = '���R'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���R'),
    (SELECT $node_id FROM Station WHERE name = '�J��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�J��'),
    (SELECT $node_id FROM Station WHERE name = '�V���c'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�V���c'),
    (SELECT $node_id FROM Station WHERE name = '�a��'), 
	6, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�a��'),
    (SELECT $node_id FROM Station WHERE name = '�`��'), 
	4, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�`��'),
    (SELECT $node_id FROM Station WHERE name = '���C��w�O'), 
	5, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���C��w�O'),
    (SELECT $node_id FROM Station WHERE name = '�ߊ�����'), 
	1, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�ߊ�����'),
    (SELECT $node_id FROM Station WHERE name = '�ɐ���'), 
	4, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�ɐ���'),
    (SELECT $node_id FROM Station WHERE name = '���b�Γc'), 
	4, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���b�Γc'),
    (SELECT $node_id FROM Station WHERE name = '�{����'), 
	3, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�{����'),
    (SELECT $node_id FROM Station WHERE name = '�C�V��'), 
	4, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�{����'),
    (SELECT $node_id FROM Station WHERE name = '����'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����'),
    (SELECT $node_id FROM Station WHERE name = '�C�V��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�C�V��'),
    (SELECT $node_id FROM Station WHERE name = '���͑��'), 
	12,	1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�C�V��'),
    (SELECT $node_id FROM Station WHERE name = '����'), 
	4, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����'),
    (SELECT $node_id FROM Station WHERE name = '������O'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '������O'),
    (SELECT $node_id FROM Station WHERE name = '���c�}���͌�'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���c�}���͌�'),
    (SELECT $node_id FROM Station WHERE name = '���͑��'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���͑��'),
    (SELECT $node_id FROM Station WHERE name = '���c'), 
	2, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���c'),
    (SELECT $node_id FROM Station WHERE name = '�V�S�����u'), 
	11,	1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���c'),
    (SELECT $node_id FROM Station WHERE name = '�ʐ�w���O'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�ʐ�w���O'),
    (SELECT $node_id FROM Station WHERE name = '�ߐ�'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�ߐ�'),
    (SELECT $node_id FROM Station WHERE name = '�`��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�`��'),
    (SELECT $node_id FROM Station WHERE name = '�V�S�����u'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�V�S�����u'),
    (SELECT $node_id FROM Station WHERE name = '�����u�V��'), 
	5, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�V�S�����u'),
    (SELECT $node_id FROM Station WHERE name = '�S���P�u'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�S���P�u'),
    (SELECT $node_id FROM Station WHERE name = '�ǔ������h�O'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�ǔ������h�O'),
    (SELECT $node_id FROM Station WHERE name = '���c'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���c'),
    (SELECT $node_id FROM Station WHERE name = '�����u�V��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�����u�V��'),
    (SELECT $node_id FROM Station WHERE name = '�o��'), 
	1, 1, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�o��'),
    (SELECT $node_id FROM Station WHERE name = '����w���O'), 
	6, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�o��'),
    (SELECT $node_id FROM Station WHERE name = '�a�򑽖���'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�a�򑽖���'),
    (SELECT $node_id FROM Station WHERE name = '���]'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���]'),
    (SELECT $node_id FROM Station WHERE name = '�쑽��'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�쑽��'),
    (SELECT $node_id FROM Station WHERE name = '����w���O'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����w���O'),
    (SELECT $node_id FROM Station WHERE name = '�o��'), 
	4, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����w���O'),
    (SELECT $node_id FROM Station WHERE name = '�c�t���J�呠'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�c�t���J�呠'),
    (SELECT $node_id FROM Station WHERE name = '��ΑD��'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��ΑD��'),
    (SELECT $node_id FROM Station WHERE name = '�o��'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�o��'),
    (SELECT $node_id FROM Station WHERE name = '���k��'), 
	3, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�o��'),
    (SELECT $node_id FROM Station WHERE name = '������'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '������'),
    (SELECT $node_id FROM Station WHERE name = '�~���u'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�~���u'),
    (SELECT $node_id FROM Station WHERE name = '���c�J��c'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���c�J��c'),
    (SELECT $node_id FROM Station WHERE name = '���k��'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���k��'),
    (SELECT $node_id FROM Station WHERE name = '��X�؏㌴'), 
	2, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���k��'),
    (SELECT $node_id FROM Station WHERE name = '���k��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���k��'),
    (SELECT $node_id FROM Station WHERE name = '��X�؏㌴'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��X�؏㌴'),
    (SELECT $node_id FROM Station WHERE name = '�V�h'), 
	5, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��X�؏㌴'),
    (SELECT $node_id FROM Station WHERE name = '��X�ؔ���'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��X�ؔ���'),
    (SELECT $node_id FROM Station WHERE name = '�Q�{��'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�Q�{��'),
    (SELECT $node_id FROM Station WHERE name = '��V�h'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��V�h'),
    (SELECT $node_id FROM Station WHERE name = '�V�h'), 
	2, 0, 1, 1, 0)







 INSERT INTO dbo.Station VALUES 
	('���ъ�'),
('�����ъ�'),
	('��ъ�'),('�ߊ�'),
('��a'),
	('�����u'),('�����a�J'),('����'),
('�Ó��'),
	('�Z�����O'),('�P�s'),('����{��'),
('����'),
	('�{����'),('�����C��'),
('�А��]�m��')
GO

INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���͑��'),
    (SELECT $node_id FROM Station WHERE name = '���ъ�'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���ъ�'),
    (SELECT $node_id FROM Station WHERE name = '�����ъ�'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '���͑��'),
    (SELECT $node_id FROM Station WHERE name = '�����ъ�'), 
	5, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�����ъ�'),
    (SELECT $node_id FROM Station WHERE name = '��a'), 
	6, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�����ъ�'),
    (SELECT $node_id FROM Station WHERE name = '��ъ�'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��ъ�'),
    (SELECT $node_id FROM Station WHERE name = '�ߊ�'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�ߊ�'),
    (SELECT $node_id FROM Station WHERE name = '��a'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��a'),
    (SELECT $node_id FROM Station WHERE name = '�Ó��'), 
	10, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '��a'),
    (SELECT $node_id FROM Station WHERE name = '�����u'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�����u'),
    (SELECT $node_id FROM Station WHERE name = '�����a�J'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�����a�J'),
    (SELECT $node_id FROM Station WHERE name = '����'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����'),
    (SELECT $node_id FROM Station WHERE name = '�Ó��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�Ó��'),
    (SELECT $node_id FROM Station WHERE name = '����'), 
	10, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�Ó��'),
    (SELECT $node_id FROM Station WHERE name = '�Z�����O'), 
	1, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�Z�����O'),
    (SELECT $node_id FROM Station WHERE name = '�P�s'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�P�s'),
    (SELECT $node_id FROM Station WHERE name = '����{��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����{��'),
    (SELECT $node_id FROM Station WHERE name = '����'), 
	3, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����'),
    (SELECT $node_id FROM Station WHERE name = '�А��]�m��'), 
	7, 1, 0, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '����'),
    (SELECT $node_id FROM Station WHERE name = '�{����'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�{����'),
    (SELECT $node_id FROM Station WHERE name = '�����C��'), 
	2, 0, 1, 1, 0)
INSERT INTO Route VALUES (
	(SELECT $node_id FROM Station WHERE name = '�����C��'),
    (SELECT $node_id FROM Station WHERE name = '�А��]�m��'), 
	3, 0, 1, 1, 0)
INSERT INTO connections(id, nickname, date_of_birth)
    VALUES (1, 'Jakes', '2003-03-10'),
(2, 'Mike', '2016-07-22'),
(3, 'Izzy', '2006-04-10');

INSERT INTO gems(id, created_at, number, occurred_at)
    VALUES ('8a9a6685-6dce-4c94-ad0b-76b65b0ab48f', '2024-05-23 15:48:44.426473+00', 2, '2024-03-15');

INSERT INTO lines(id, connection_id, text, gem_id)
    VALUES (6, 3, 'Yep! Tis.', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f'),
(7, 2, 'That''s soooo unhealthy! No wonder you''ve shrunk!', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f'),
(4, 2, 'Mike''s in Izzy''s room and sees all the chocolate wrappers on her desk.', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f'),
(5, 2, 'Gosh Izzy! That''s a lot of chocolate!', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f');


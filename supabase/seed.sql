--INSERT INTO chests(id, name)
--    VALUES ('01a49ad4-9785-4a56-8b11-0edff1f3212c', 'Drew Family Chest');
--
--INSERT INTO people(id, nickname, date_of_birth, chest_id)
--    VALUES (1, 'Jakes', '2003-03-10', '01a49ad4-9785-4a56-8b11-0edff1f3212c'),
--(2, 'Mike', '2016-07-22', '01a49ad4-9785-4a56-8b11-0edff1f3212c'),
--(3, 'Izzy', '2006-04-10', '01a49ad4-9785-4a56-8b11-0edff1f3212c');
--
--INSERT INTO gems(id, created_at, number, occurred_at, chest_id)
--    VALUES ('8a9a6685-6dce-4c94-ad0b-76b65b0ab48f', '2024-05-23 15:48:44.426473+00', 2, '2024-03-15', '01a49ad4-9785-4a56-8b11-0edff1f3212c');
--
--INSERT INTO lines(id, person_id, text, gem_id, chest_id)
--    VALUES (6, 3, 'Yep! Tis.', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f', '01a49ad4-9785-4a56-8b11-0edff1f3212c'),
--(7, 2, 'That''s soooo unhealthy! No wonder you''ve shrunk!', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f', '01a49ad4-9785-4a56-8b11-0edff1f3212c'),
--(4, NULL, 'Mike''s in Izzy''s room and sees all the chocolate wrappers on her desk.', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f', '01a49ad4-9785-4a56-8b11-0edff1f3212c'),
--(5, 2, 'Gosh Izzy! That''s a lot of chocolate!', '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f', '01a49ad4-9785-4a56-8b11-0edff1f3212c');
--
-- DO NOT DELETE --
-- DO NOT DELETE --
-- DO NOT DELETE --
INSERT INTO role_permissions(ROLE, permission)
    VALUES ('owner', 'chests.insert'),
('collaborator', 'chests.insert'),
('viewer', 'chests.insert'),
('owner', 'chests.select'),
('collaborator', 'chests.select'),
('viewer', 'chests.select'),
('owner', 'chests.update'),
('owner', 'chests.delete'),
('owner', 'collections.insert'),
('collaborator', 'collections.insert'),
('owner', 'collections.select'),
('collaborator', 'collections.select'),
('viewer', 'collections.select'),
('owner', 'collections.update'),
('collaborator', 'collections.update'),
('owner', 'collections.delete'),
('collaborator', 'collections.delete'),
('owner', 'people.insert'),
('collaborator', 'people.insert'),
('owner', 'people.select'),
('collaborator', 'people.select'),
('viewer', 'people.select'),
('owner', 'people.update'),
('collaborator', 'people.update'),
('owner', 'people.delete'),
('collaborator', 'people.delete'),
('owner', 'person_avatar_urls.insert'),
('collaborator', 'person_avatar_urls.insert'),
('owner', 'person_avatar_urls.select'),
('collaborator', 'person_avatar_urls.select'),
('viewer', 'person_avatar_urls.select'),
('owner', 'person_avatar_urls.update'),
('collaborator', 'person_avatar_urls.update'),
('owner', 'person_avatar_urls.delete'),
('collaborator', 'person_avatar_urls.delete'),
('owner', 'gems.insert'),
('collaborator', 'gems.insert'),
('owner', 'gems.select'),
('collaborator', 'gems.select'),
('viewer', 'gems.select'),
('owner', 'gems.update'),
('collaborator', 'gems.update'),
('owner', 'gems.delete'),
('collaborator', 'gems.delete'),
('owner', 'lines.insert'),
('collaborator', 'lines.insert'),
('owner', 'lines.select'),
('collaborator', 'lines.select'),
('viewer', 'lines.select'),
('owner', 'lines.update'),
('collaborator', 'lines.update'),
('owner', 'lines.delete'),
('collaborator', 'lines.delete'),
('owner', 'invitations.insert'),
('owner', 'invitations.select'),
('owner', 'invitations.update'),
('owner', 'invitations.delete');


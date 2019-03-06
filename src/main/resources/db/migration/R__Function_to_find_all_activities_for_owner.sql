CREATE OR REPLACE FUNCTION find_all_activities_for_owner(name varchar(500)) RETURNS SETOF activity AS $$
	SELECT activity.*
	FROM activity 
	JOIN "user" 
	ON "user".id = owner_id
	WHERE username = name;
$$ LANGUAGE SQL; 
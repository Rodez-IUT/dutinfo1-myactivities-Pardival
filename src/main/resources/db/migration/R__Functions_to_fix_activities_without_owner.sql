CREATE OR REPLACE FUNCTION get_default_owner() RETURNS "user" AS $$
DECLARE	
	line_user "user"%ROWTYPE;
	
BEGIN
		SELECT *
		INTO line_user
		FROM "user"
		WHERE username = 'Default Owner';
		
		IF FOUND THEN
			RETURN line_user;
		ELSE 
			INSERT INTO "user" (id, username)
			VALUES (1, 'Default Owner');
			
			SELECT * 
			INTO line_user
			FROM "user"
			WHERE username = 'Default Owner';
			
			RETURN line_user;
		END IF;
END

$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fix_activities_without_owner() RETURNS SETOF activity AS $$

DECLARE 

BEGIN
	
		UPDATE activity
		SET owner_id = (SELECT id FROM "user" WHERE username = 'Default Owner')
		WHERE owner_id IS NULL;
		 
		RETURN QUERY SELECT * FROM activity WHERE owner_id = (SELECT id FROM "user" WHERE username = 'Default Owner');
		RETURN;
END;

$$ LANGUAGE plpgsql;
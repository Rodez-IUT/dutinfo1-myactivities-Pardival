CREATE OR REPLACE FUNCTION delete_activities_older_than(old_date date) RETURNS int AS $$
   DELETE FROM activity WHERE  modification_date < '2019-01-10';
   SELECT 1;
$$ LANGUAGE SQL; 
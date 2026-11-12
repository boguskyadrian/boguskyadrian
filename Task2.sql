--- TASK 2

--- 2.1 Triggers
CREATE TABLE IF NOT EXISTS UserAudit (
    AuditID INTEGER PRIMARY KEY,
    UserID INTEGER,
    Action TEXT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER UserUpdateAuditTrigger
	AFTER UPDATE ON Users
	BEGIN
    	INSERT INTO UserAudit (UserID, Action)
    	VALUES (OLD.UserID, 'UPDATE');
	END;
    
CREATE TRIGGER PreventDeleteCascadeTrigger
    Before delete on Weddings
    BEGIN
       	if OLD.Groom != NEW.Groom or OLD.Bride != NEW.Bride then 
       	RAISE_APPLICATION_ERROR('Cant delete Groom or Bride!')
    END;

CREATE TRIGGER EventConflictCheckTrigger
    Before INSERT on WeddingEvents
    BEGIN
    for EACH ROW CHECK
        if NEW.EventDate = EventDate then 
        NEW.eventstarttime < eventstarttime
        NEW.eventendtime < eventendtime
        ELSE
       	RAISE_APPLICATION_ERROR('Time slot already filled')
    END;
    
--- 2.2 Views

CREATE VIEW WeddingDetails AS
	SELECT w.WeddingID,
       		g.Name AS GroomName,
       		b.Name AS BrideName   
	FROM Weddings w
	JOIN Users g ON w.Groom = g.UserID
	JOIN Users b ON w.Bride = b.UserID;
    
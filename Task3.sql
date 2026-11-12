---TASK 3

SELECT u.Name, h.Location, h.Capacity
    FROM Users u
    JOIN Weddings w 
        ON u.UserID = w.Groom OR u.UserID = w.Bride
    JOIN WeddingEvents e 
        ON w.WeddingID = e.WeddingID
    JOIN WeddingHalls h 
        ON e.HallID = h.HallID
    WHERE e.EventType = 'Main';

SELECT u.Name AS UserName, mb.Name AS BandName
    FROM Users u
    JOIN Weddings w 
        ON u.UserID = w.Groom OR u.UserID = w.Bride
    JOIN WeddingEvents e 
        ON w.WeddingID = e.WeddingID
    JOIN MusicBands mb 
        ON e.MusicBandID = mb.MusicBandID
    WHERE e.EventType = 'Reception';
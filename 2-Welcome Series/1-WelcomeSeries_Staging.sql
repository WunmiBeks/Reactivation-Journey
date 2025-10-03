SELECT          Mem.MemberID, 
                Mem.FirstName, 
                Mem.EmailAddress, 
                Mem.MembershipTier, 
                Mem.LoyaltyPoint, 
                Mem.Consent_Email, 
                Mem.JoinDate, 
                CASE 
                    WHEN App.MemberID IS NOT NULL THEN 1
                    ELSE 0
                END AS HasDownloaded, 
                GETDATE() AS JourneyEntryDate
FROM            [Member] Mem

LEFT JOIN       [Customer_App] App
ON              Mem.MemberID = App.MemberID
AND             App.DownloadDate IS NOT NULL

/* JOINED LOYALTY PROGRAM IN THE LAST 7 DAYS */
WHERE           Mem.JoinDate >= DATEADD(D, -7, GETDATE())

/* OPTED IN TO EMAIL COMMS */
AND             Mem.Consent_Email = 1

/* EXCLUDE MEMBERS ALREADY IN THE JOURNEY */                            
AND             NOT EXISTS ( SELECT      1
                             FROM        [WelcomeSeries-JourneyEntry] Journey
                             WHERE        Mem.MemberID = Journey.MemberID)

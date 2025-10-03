SELECT          Journey.MemberID, 
                Mem.Consent_Email,
                 CASE
                    WHEN App.MemberID IS NOT NULL THEN 1
                    ELSE 0
                END AS HasDownloaded
FROM            [WelcomeSeries-JourneyEntry] Journey
INNER JOIN      [Member] Mem
ON              Journey.MemberID = Mem.MemberID

     /* CHECKS IF MEMBER HAS DOWNLOADED APP */
LEFT JOIN       [Customer_App] App
ON              Journey.MemberID = App.MemberID
AND             App.DownloadDate IS NOT NULL

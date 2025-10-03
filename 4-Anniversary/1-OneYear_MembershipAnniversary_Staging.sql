SELECT       Mem.*,
             CASE 
                 WHEN X.TotalSpent > 0 AND X.TotalSpent <= 500 THEN '10%'
                 WHEN X.TotalSpent > 500 AND X.TotalSpent <= 1000 THEN '15%'
                 ELSE '20%'
                 END AS MembershipDiscount,
             X.TotalSpent, 
             DATEADD(M, 1, GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'Mountain Standard Time') AS DiscountExpiration,
             GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'Mountain Standard Time' AS JourneyEntryDate,
             DATEADD(Year, 1, Mem.JoinDate) AS AnniversaryDate
FROM         [Membership_Master] Mem

            /* Total Spent with the last year Calculation */ 
INNER JOIN    ( 
                 SELECT      MemberID,
                             SUM(Amount) AS TotalSpent
                 FROM        [Transactions_DE]
                 WHERE       TransactionDate >= DATEADD(Year, -1, GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'Mountain Standard Time')
                 GROUP BY    MemberID
                 ) X
ON               Mem.MemberID = X.MemberID

/* Campaign Criteria */
WHERE        Mem.OptInStatus = 1

AND           CAST(DATEADD(Year, 1, Mem.JoinDate) AS DATE) = CAST(GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'Mountain Standard Time' AS DATE)

AND             EXISTS ( SELECT     1
                         FROM       [Transactions_DE] Txn
                         WHERE       Mem.MemberID = Txn.MemberID
                         AND         Txn.TransactionDate >= DATEADD(Year, -1, GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'Mountain Standard Time')
                         ) 
 
AND              NOT EXISTS (SELECT      1
                              FROM       [OneYear_Anniversary_JourneyEntry] Journey
                              WHERE      Mem.MemberID = Journey.MemberID ) 
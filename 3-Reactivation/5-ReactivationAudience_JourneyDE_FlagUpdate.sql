SELECT      Journey.SubscriberKey,
            Journey.PhoneID,
            Journey.JourneyEntryDate,
            Journey.EmailConsent,
            CASE
                WHEN Reactivated.PhoneID IS NOT NULL THEN 1
                ELSE 0
                END AS HasReactivated
FROM        [ReactivationAudience_JourneyDE] Journey

INNER JOIN  [master_customer] Mast
ON          Journey.SubscriberKey = Mast.SubscriberKey
AND         Journey.PhoneID = Mast.PhoneID

LEFT JOIN   [Reactivated_Customers] Reactivated
ON          Journey.SubscriberKey = Reactivated.SubscriberKey
AND         Journey.PhoneID = Reactivated.PhoneID
AND         Reactivated.ReactivatedDate >= DATEADD(D, -90, GETDATE())
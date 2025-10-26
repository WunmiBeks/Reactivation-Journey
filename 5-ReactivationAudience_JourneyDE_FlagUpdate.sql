SELECT      journey.SubscriberKey,
            journey.PhoneID,
            journey.JourneyEntryDate,
            mast.EmailConsent,
            CASE
                WHEN Reactivated.PhoneID IS NOT NULL THEN 1
                ELSE 0
            END AS HasReactivated
FROM        [ReactivationAudience_JourneyDE] journey

INNER JOIN  [master_customer] mast
ON          journey.SubscriberKey = mast.SubscriberKey
AND         journey.PhoneID = mast.PhoneID

LEFT JOIN   [Reactivated_Customers] reactivated
ON          journey.SubscriberKey = reactivated.SubscriberKey
AND         journey.PhoneID = reactivated.PhoneID
AND         reactivated.ReactivatedDate >= DATEADD(D, -90, GETDATE())
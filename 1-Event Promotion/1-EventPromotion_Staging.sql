SELECT            mast.SubscriberKey, 
                  mast.FirstName, 
                  mast.LastName, 
                  mast.EmailAddress, 
                  mast.City, 
                  mast.Consent_Email, 
                  cust.Tier, 
                  event.EventName, 
                  event.EventDate,
                  mast.City AS NearestLocation, 
                  GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'Eastern Standard Time' AS JourneyEntryDate 
FROM              [master_subscribers] mast
INNER JOIN        [Customer Tier] cust
ON                mast.SubscriberKey = cust.SubscriberKey
INNER JOIN        [gala_dinner_event] event
ON                event.City = mast.City

/* Campaign criteria*/
WHERE             cust.Tier IN ('Platinum', 'Gold')
AND               mast.Consent_Email = 1
AND               mast.City IS NOT NULL

/* Exclude subscribers that attended Gala Events Previously in the Last 12 Months */
AND               NOT EXISTS ( 
                                       SELECT     1
                                       FROM       [event-attendance] attendance
                                       WHERE      mast.SubscriberKey = attendance.SubscriberKey
                                       AND        attendance.EventDate >= DATEADD(M, -12, GETDATE() AT TIME ZONE 'Central Standard Time' AT TIME ZONE 'Eastern Standard Time')
                                       AND        attendance.EventName LIKE '%gala%'
                               )
                               
/* Exclude any record that have entered the journey */
AND                 NOT EXISTS ( 
                                   SELECT      1
                                   FROM        [EventPromotionAudience_JourneyEntry] Journey
                                   WHERE        mast.SubscriberKey = Journey.SubscriberKey)


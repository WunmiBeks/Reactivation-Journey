SELECT            mast.SubscriberKey, 
                  mast.PhoneID, 
                  mast.FirstName, 
                  mast.LastName, 
                  mast.Email, 
                  mast.PhoneNo,
                  mast.EmailConsent, 
                  mast.InactiveTenureDays, 
                  mast.LastPlanID, 
                  GETDATE() AS JourneyEntryDate, 
                  /* UPGRADE PLAN A DETAILS */
                  matrix.UpgradePlanA, 
                  matrix.PromoCodeA_50 AS UpgradePlanA_50PromoCode,
                  /* UPGRADE PLAN B DETAILS */
                  matrix.UpgradePlanB, 
                  matrix.PromoCodeB_50 AS UpgradePlanB_50PromoCode,
                  0 AS HasReactivated
FROM              [master_customer] mast
INNER JOIN        [plans_matrix] matrix
ON                mast.LastPlanID = matrix.PlanID

/* CAMPAIGN CRITERIA */
WHERE             mast.EmailConsent = 'Opted In'
AND               mast.InactiveTenureDays > 10 
AND               mast.InactiveTenureDays < 180
AND               matrix.UpgradePlanA <> 'N/A'
AND               matrix.UpgradePlanB <> 'N/A'

/* RE-ENTRY CRITERIA - NOT RE-ENTERED IN THE LAST 90 DAYS */
AND                NOT EXISTS ( SELECT     1
                                FROM        [ReactivationAudience_JourneyDE] journey
                                WHERE       mast.SubscriberKey = journey.SubscriberKey
                                AND         mast.PhoneID = journey.PhoneID
                                AND         journey.JourneyEntryDate >= DATEADD(D, -90, GETDATE()))
 
 /* REACTIVATION EXCLUSION CRITERIA */                               

AND                NOT EXISTS ( SELECT      1
                                FROM        [Reactivated_Customers] reactivated
                                WHERE       mast.SubscriberKey = reactivated.SubscriberKey
                                AND         mast.PhoneID = reactivated.PhoneID
                                AND         reactivated.ReactivatedDate >= DATEADD(D, -90, GETDATE()))    
                                
 /* EXCLUDING CONTROL RECORDS */
 AND               NOT EXISTS (SELECT      1
                               FROM       [ReactivationAudience_ControlLog] control
                               WHERE      mast.SubscriberKey = control.SubscriberKey)


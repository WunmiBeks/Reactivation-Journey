SELECT       TOP 10 PERCENT Staging.*
FROM         [ReactivationAudience_staging] Staging
WHERE        NOT EXISTS (SELECT   1
                         FROM     [ReactivationAudience_ControlLog] Control
                         WHERE    Staging.SubscriberKey = Control.SubscriberKey) 
                       
ORDER BY      NEWID()
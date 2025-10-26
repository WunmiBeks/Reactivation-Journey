SELECT      Staging.*
FROM        [ReactivationAudience_staging] staging
WHERE       NOT EXISTS (SELECT    1
                        FROM      [ReactivationAudience_ControlLog] control
                        WHERE      staging.SubscriberKey = control.SubscriberKey)
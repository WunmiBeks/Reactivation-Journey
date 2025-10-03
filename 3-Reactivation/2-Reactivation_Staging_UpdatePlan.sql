SELECT       staging.SubscriberKey,
             staging.PhoneID,
             staging.JourneyEntryDate,
             
             staging.UpgradePlanA, 
             matrix_A.PlanName AS UpgradePlanA_PlanName, 
             matrix_A.PlanPrice AS UpgradePlanA_PlanPrice, 
             matrix_A.PlanGB AS UpgradePlanA_PlanGB,
             
             staging.UpgradePlanB, 
             matrix_B.PlanName AS UpgradePlanB_PlanName, 
             matrix_B.PlanPrice AS UpgradePlanB_PlanPrice, 
             matrix_B.PlanGB AS UpgradePlanB_PlanGB
FROM         [ReactivationAudience_Staging] Staging

INNER JOIN   [plans_matrix] matrix_A
ON           staging.UpgradePlanA = matrix_A.PlanID

INNER JOIN   [plans_matrix] matrix_B
ON           Staging.UpgradePlanB = matrix_B.PlanID
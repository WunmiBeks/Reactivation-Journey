SELECT      Journey.MemberID,
            1 AS HasClaimedDiscount
FROM        [OneYear_Anniversary_JourneyEntry] Journey

/* Members who have Redeemed */
INNER JOIN  [Redemption_Log] Redeem 
ON          Journey.MemberID = Redeem.MemberID

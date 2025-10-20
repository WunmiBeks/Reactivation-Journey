# SQL Projects

This repository contains SQL case studies designed for Salesforce Marketing Cloud (SFMC).  
Each project demonstrates how SQL queries can be used in Automation Studio and Query Activities to create and manage audiences, drive personalization, and power journeys with the right data.

---

## Case Studies

### 1. Event Promotion Audience Segmentation – Velloria Events
A one-time promotional automation for an exclusive gala dinner.  
- Includes only opted-in subscribers.  
- Excludes subscribers who attended a gala event in the last 12 months.  
- Filters for Platinum and Gold-tier members.  
- Final Data Extension contains dynamic content fields: **NearestLocation** and **EventName** to drive personalization in the promotional email.  

---

### 2. Welcome Series Audience – Lifestyle Brand
An ongoing three-part welcome journey for a new membership/loyalty program.  
- Identifies newly opted-in members using **JoinDate**.  
- Ensures unique entries by excluding members who have already entered the journey.  
- Daily automation refreshes the audience for new members.  
- Supports email journey with content around benefits, perks, and app download prompts.  

---

### 3. Reactivation Audience Segmentation – Gee Mobile
A reactivation campaign for inactive mobile customers with multiple phone lines.  
- Targets phone IDs inactive for **10–180 days**.  
- Prevents re-entry within 90 days.  
- Excludes reactivated phone IDs from the past 90 days.  
- Journey exits customers immediately upon reactivation.  
- Includes 10% control group for campaign performance measurement.  
- Final DE fields: **UpgradePlanA**, **UpgradePlanB**, promocodes, and plan names.  

---

### 4. Anniversary Audience Segementation – Golden Table Restaurants
A personalized anniversary campaign celebrating one year of membership.  
- Selects members on their exact **1-year join date**.  
- Filters to only opted-in members with at least one transaction in the first year.  
- Dynamic discounts based on spend ranges:  
  - $0–$500 → 10%  
  - $501–$1,000 → 15%  
  - $1,001+ → 20%
- Adds dynamic fields for **Discount Percentage**, **Expiration Date (1 month from send)**, and **Last Store Visited**.  
- Reminder email sent after 2 weeks if the discount is not redeemed.  

---

## Skills Demonstrated
- Audience segmentation with SQL queries in Automation Studio  
- Deduplication and exclusion logic for clean targeting.  
- Dynamic field population for personalization.  
- Support for journey entry criteria and eligibility rules.  
- Control group setup for campaign performance measurement.  

---

## About SQL in SFMC
SQL in Salesforce Marketing Cloud is used to query Data Extensions and build target audiences for journeys, campaigns, and automations. These case studies show practical, real-world examples of using SQL for data-driven marketing at scale.



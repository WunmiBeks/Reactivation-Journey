# Reactivation Campaign - End-to-End Journey

![Reactivation Screenshot](Image/reactivate.png)


## Project Overview

GeeMobile, a leading telecommunications company wants to launch an ongoing Reactivation Campaign to target inactive customers by offering personalized discounts on upgraded mobile plans. A key challenge is that customers can have multiple phone lines under their account, requiring tailored reactivation campaigns for each inactive phone.

This project is an end-to-end journey right from audience segmentation using SQL to customer journey using Journey Builder

The journey includes three emails:
- Email 1: Introduction to the reactivation offer.
- Email 2: Reminder to take action on the discounted plans.
- Email 3: Last chance to reactivate.

Ensure customers who reactivate do not receive subsequent emails.
Gee Mobile also wants a 10% control group to be set up to measure the uplift of the campaign.

The campaign’s target audience criteria are as follows:

- Target phone numbers that have been inactive for more than 10 days but less than 180 days
- Only phone IDs that have not re-entered the campaign within the past 90 days are eligible to prevent frequent re-entries.
- Exclude phone IDs that are present in the Reactivated Customers DE (customers who have taken up the offer) within the past 90 days
- If the customer has taken up the offer for their phone service, exit them out of the journey before receiving following emails



## SFMC Features & Languages Used

### SFMC Features
- Contact Builder   
- Automation Studio   
- Email Studio  
- Content Builder  
- Journey Builder   


### Languages
- SQL
- AMPscript   
- HTML/CSS  

---

## Author
Wunmi Ogunbekun








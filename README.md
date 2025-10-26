# REACTIVATION CAMPAIGN

## Project Overview

GeeMobile, a leading telecommunications company wants to launch an ongoing Reactivation Campaign (consisting of 3 emails) to target inactive customers by offering personalized discounts on upgraded mobile plans. A key challenge is that customers can have multiple phone lines (Phone IDs) under their account, requiring tailored reactivation campaigns for each inactive phone.

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

---

## Tools & Languages Used

### SFMC Tools
- Contact Builder  
- Data Extensions  
- Automation Studio   
- Email Studio  
- Content Builder  
- Journey Builder   


### Languages
- SQL  
- AMPscript   
- HTML/CSS  

---

## Email Template

### Email 1: 
Subject Line: We’ve been missing you — here’s 50% off your plan!
Preheader: Reactivate your line and grab your half-price offer today 💥

**Body:**
Hey **`<FirstName>`**,  

We noticed your line **`<PhoneNo>`** has been a bit quiet lately. So, we thought we’d give you two exciting ways to get back online — at a discount! 🎉  

Here’s what’s waiting for you: 
🚀 **`<Plan A upgrade name>`** — just **$`<UpgradePlanA_Price>`**! Use code **`<UpgradePlanA_50PromoCode>`**  
🔥 **`<Plan B upgrade name>`** — only $**`<UpgradePlanB_Price>`**! Use code **`<PromoCodeB_50romoCode>`** 

Don’t wait too long — these offers won’t last forever!
[Reactivate Now]

Let’s get you back to enjoying all the perks of being connected! 💙

Your GeeMobile Team

### Email 2: 

**Subject Line:** Don’t leave your 50% discount hanging!
**Preheader:** Your discount is still live — but not for long! ⏳

**Body:**

Hi **`<FirstName>`**,  

Just a friendly nudge — your reactivation offer for **`<PhoneNo>`** is still active, and we’d hate for you to miss it! 💌 

Take your pick 👇🏽  
💫 Upgrade to **`<Plan A upgrade name>`** for only **$`<UpgradePlanA Price>`** — grab it with **`<UpgradePlanA_50PromoCode>`**!  
🔥 Or pick **`<Plan B upgrade name>`** at $**`<UpgradePlanB Price>`** using **`<UpgradePlanB_50PromoCode>`**!

Reconnect and enjoy better data, better deals, and all the fun that comes with it!
[Reactivate My Line]

We’re saving your spot… but not for much longer. 😉

Your GeeMobile Team

### Email 3:

Subject Line: Last call, 🚨 Your 50% off disappears tonight!
Preheader: This is your last chance to reactivate with a special deal.

**Body:**

Hey **`<FirstName>`**,  

This is it — your final reminder to bring back your line **`<PhoneNo>`** and grab these exclusive deals before they disappear! ⏳  

We’ve got two awesome plans waiting for you 👇🏽  
🚀 **`<Plan A upgrade name>`** — just $**`<UpgradePlanA_Price>`**! Use code **`<UpgradePlanA_50PromoCode>`**  
🚀 **`<Plan A upgrade name>`** — just $**`<UpgradePlanA_Price>`**! Use code **`<UpgradePlanA_50PromoCode>`**  
🚀 **`<Plan A upgrade name>`** — just $**`<UpgradePlanA_Price>`**! Use code **`<UpgradePlanA_50PromoCode>`**  
🔥 **`<Plan B upgrade name>`** — only $**`<UpgradePlanB_Price>`**! Use code **`<PromoCodeB_50romoCode>`**

Don’t let your special offer slip away — it’s your last chance to reconnect and enjoy the perks you love!
[Reactivate Before It’s Gone]

We can’t wait to have you back. 💙

Your GeeMobile Team

---

## Author
Wunmi Ogunbekun








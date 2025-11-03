# Reactivation Campaign – End-To-End Journey  

<p align="center">
  <img src="https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/Thumbnail.png" alt="Hero Image" width="800"/>
</p>

<p align="center"><em>
End-to-end Salesforce Marketing Cloud journey for re-engaging inactive subscribers with personalized offers.
</em></p>

<p align="center">
  <a href="https://github.com/WunmiBeks/Reactivation-Journey">
    <img src="https://img.shields.io/badge/View%20on%20GitHub-181717?style=for-the-badge&logo=github&logoColor=black" alt="GitHub Repo"/>
  </a>
</p>

<br><br>

---

<br>

## Project Description  
Reactivation campaign using **SQL**, **AMPscript**, and **HTML/CSS** to personalize discounts for each inactive phone line and boost customer re-engagement.  
<br>

### Scenario  
GeeMobile launched a Reactivation Campaign to re-engage inactive customers with personalized discounts on upgraded plans. Because customers may have multiple phone lines under one account, each inactive line required its own personalized journey — adding complexity to the campaign.  
<br>

### Campaign Journey  
- Three-email journey: introduction, reminder, and final-chance offer  
- Customers who reactivated stopped receiving further emails  
- Exit customers immediately once they take up the offer  
- 10% control group set up to measure uplift  
<br>

### Target Audience  
- Include phone numbers inactive for 10–180 days  
- Exclude phone IDs that re-entered within 90 days  
- Exclude phone IDs in the Reactivated_Customers DE within 90 days  
<br>

### SFMC Features  
- Contact Builder  
- Automation Studio  
- Email Studio  
- Content Builder  
- Journey Builder  
<br>

### Languages  
- SQL  
- AMPscript  
- HTML/CSS  

<br><br>
---
<br>

## Solution Walkthrough  
This is the step-by-step implementation of the Reactivation Campaign, covering Data Extensions (DE), segmentation logic, personalization, and journey design.  
<br>

---

### Step 1: Data Extension Setup  
<br>

The required Data Extensions were created and assigned primary keys to store subscriber details, plan information, and reactivation history.  
<br>

#### Master_Customer Data Extension  
Holds details of all subscribers, both active and inactive.  
<br>

![MasterCustomerDE](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/MasterCustomerDE.png)  
*Master_Customer DE showing subscriber account and phone-level details.*  

<br><br>
---
<br>

#### Plan_Matrix Data Extension  
Contains available plans, upgrade options, plan names, prices, data allowance, and promo codes.  
<br>

![Plan_Matrix](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/plans_matrix.png)  
*Plan_Matrix DE listing available plans and promo offers.*  

<br><br>
---
<br>

#### Reactivated_Customers Data Extension  
Tracks subscribers who have accepted the offer and reactivated within the last 90 days. (This DE will be populated later once the journey is live, so its screenshot will be shown in the Journey section.)  
<br>

<br><br>
---
<br>

### Step 2: Audience Segmentation  
<br>

Audience segmentation was performed in **Automation Studio** using a staging approach to improve query efficiency and simplify troubleshooting.  
<br>

![Query Overview](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_1.png)  
*Overview of Automation Studio queries used for audience segmentation.*  

<br><br>
---
<br>

#### 2.1 SQL Queries  
<br>

- **SQL Query 1:** Writes data into `Reactivation_Staging` DE by partially filling fields and updating old records with new ones each time the query runs.  
  [View SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/1-ReactivationCampaign_Staging.sql)  
  ![Query 1](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_2.png)  
  <br><br>

- **SQL Query 2:** Updates empty fields in `ReactivationAudience_Staging` and replaces records when changes occur.  
  [View SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/2-Reactivation_Staging_UpdatePlan.sql)  
  ![Query 2](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_3.png)  
  <br><br>

- **SQL Query 3:** Selects 10% of the target audience from `ReactivationAudience_Staging` (excluding Control Log) as the control group for measuring campaign uplift.  
  [View SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/3-ReactivationAudience_ControlLog.sql)  
  ![Query 3](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_5.png)  
  <br><br>

- **SQL Query 4:** Moves records from the staging DE to the journey DE while excluding the 10% control group.  
  [View SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/4-ReactivationAudience_JourneyDE.sql)  
  ![Query 4](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_4.png)  
  <br><br>

- **SQL Query 5:** Checks for customers who reactivated in the last 90 days and flags them in the journey DE.  
  [View SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/5-ReactivationAudience_JourneyDE_FlagUpdate.sql)  
  ![Query 5](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AStudio_UpdateFlag.png)  
  <br><br>

#### 2.2 Final Audience Output  
![Journey Audience](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ReactivationAudience_JourneyDE.png)  
*Resulting audience after segmentation queries — 90% of eligible inactive subscribers ready to enter the journey (excluding the 10% control group).*  

<br><br>

---

### Step 3: Journey Design  
<br>

The Reactivation Journey was designed in **Journey Builder** to target the 90% of eligible inactive subscribers while excluding the 10% control group.  
<br>

#### 3.1 Connect Journey DE in Contact Builder  
Connected `Reactivation_JourneyDE` in Contact Builder by mapping **Contact Key = SubscriberKey**, ensuring each phone line is tracked and enters the journey only once.  
<br>

![ContactBuilder 1](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ContactBuilder_1.png)  
![ContactBuilder 2](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ContactBuilder_2.png)  
<br>

#### 3.2 Journey Entry Source  
Configured `Reactivation_JourneyDE` as the entry source for the journey to allow eligible subscribers to flow into the campaign.  
<br>

![Journey Entry Source](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/EntrySource.png)  
<br>

#### 3.3 Journey Schedule & Contact Evaluation  
The entry DE is refreshed daily through **Automation Studio**, ensuring that newly eligible subscribers are evaluated and entered into the journey automatically.  
<br>

- Automation Studio runs a daily automation to refresh and update the `Reactivation_JourneyDE`.  
- Contact Evaluation set to *Evaluate new records only* — prevents duplicates and outdated re-entries.  
<br>

![Journey Schedule](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/JourneySchedule_ContactEvaluation.png)  
*Automation Studio schedule ensuring daily refresh of eligible contacts.*  
<br>

#### 3.4 Contact Entry Settings  
**Contact Entry Mode: Re-entry Anytime** — allows subscribers with multiple phone lines to re-enter the journey when another eligible line becomes inactive.  
<br>

![Contact Entry](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ContactEntry.png)  
*Contact entry configuration ensuring clean audience control and re-entry logic.*  
<br>

#### 3.5 Journey Flow  
Designed the journey flow to include three emails:  
- **Email 1:** Introduction to the reactivation offer  
- **Email 2:** Reminder to take action  
- **Email 3:** Final chance before expiration  

Subscribers who reactivated were automatically removed from receiving further emails.  
<br>

![Journey Flow](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/JourneyFlow.png)  
*Three-email reactivation sequence showing offer introduction, reminder, and final chance.*  
<br>

#### 3.6 Exit Criteria  
Exit criteria combined Journey Data and Contact Data to ensure subscribers exited the journey at the right time.  
<br>

- **SubscriberKey (Journey)** = **SubscriberKey (Contact)**  
- **PhoneID (Journey)** = **PhoneID (Contact)**  
- **HasReactivated = True** or **EmailConsent = Opted Out**  

These conditions ensured immediate exit once subscribers reactivated or opted out.  
<br>

![Exit Criteria](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/Journey_ExitCriteria.png)  
*Journey flow showing the three-email reactivation sequence and exit conditions.*  
<br>

---

### Step 4: Journey Outcomes  
<br>

As the journey ran, subscriber status updated in real time based on contact data, ensuring accurate exits for reactivated or opted-out subscribers.  
<br>

#### 4.1 Reactivated Customers   
Captures subscribers who accepted the offer within 90 days.  
<br>

![Reactivated Customers](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ReactivatedCustomers.png)  
*Subscriber CID005 accepted the offer.*  
<br>

#### 4.2 Journey Data Update (HasReactivated Flag)
When the automation ran again, the **HasReactivated** field in `Reactivation_JourneyDE` updated from False to True.  
Because Journey Data and Contact Data were linked, this triggered an automatic exit.  
<br>

![Journey Data Update](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/UpdatedReactivaton.png)  
*Journey DE showing the HasReactivated field updated for subscribers who accepted the offer.*  
<br>

---

## Personalized Email Previews  
This section showcases the personalized emails generated from the Reactivation Journey, demonstrating how AMPscript-driven data is transformed into personalized subscriber experiences.

<br>

### **1. AMPscript Personalization Preview**  
![Personalization Preview](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/Preview1.png)  
*Salesforce Marketing Cloud subscriber preview showing AMPscript-driven personalization and dynamic field mapping.*  

**Description:**  
This preview demonstrates how **AMPscript** retrieves subscriber-specific attributes from the **Master_Customer** Data Extension and injects them directly into the email content.  

Each numbered field corresponds to a dynamic value displayed in the personalized email:  
1. **First Name (Bob)** — personalized greeting.  
2. **UpgradePlanA_PlanName (Ultra Plan)** — plan A name.  
3. **UpgradePlanA_PlanPrice (90)** — personalized price.  
4. **UpgradePlanA_50PromoCode (FLS94)** — unique discount code for Plan A.  
5. **UpgradePlanB_PlanName (Unlimited Plan)** — plan B name.  
6. **UpgradePlanB_PlanPrice (70)** — personalized price.  
7. **UpgradePlanB_50PromoCode (BYN32)** — discount code for Plan B.  
8. **Phone Number (5550129903)** — formatted dynamically per subscriber.  

**Purpose:**  
Demonstrates how subscriber data is dynamically transformed into personalized email content, ensuring each recipient receives accurate, real-time plan details and promo offers.  
<br>

---

### **2. Introductory Offer Email**  
![Intro Email Preview](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/IntroEmail.png)  
*First email in the reactivation journey introducing personalized offers and promo codes.*  

**Purpose:**  
This is the initial reactivation message triggered for inactive subscribers. It dynamically personalizes:  
- **Subscriber’s name** (e.g., “Hey Bob”)  
- **Inactive phone line** (e.g., `(555) 012-9903`)  
- **Plan offers, prices, and promo codes** (e.g., *Ultra Plan – $90 (FLS94)*, *Unlimited Plan – $70 (BYN32)*)  

It encourages subscribers to re-engage through a single **“Reactivate Now”** call-to-action button.  
<br>

---

### **3. Reminder Email**  
![Reminder Email Preview](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ReminderEmail.png)  
*Second email in the reactivation sequence reminding inactive subscribers to take advantage of their personalized offer before it expires.*  

**Purpose:**  
This mid-journey email serves as a friendly reminder for subscribers who haven’t yet reactivated their line.  
It reinforces urgency with dynamic expiration text and reuses the same personalization fields — including name, plan, price, and promo codes — to keep the message relevant.  

<br>

---

### **4. Final-Chance Reactivation Email**  
![Final Chance Email Preview](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/FinalEmail.png)  
*Final email in the reactivation journey encouraging subscribers to take last-minute action before the campaign closes.*  

**Purpose:**  
This is the last touchpoint in the three-email journey. It uses influential language and urgency to encourage final conversions before the offer expires.  

<br>

---

<br>
## Results & Key Learnings  
<br>

**Results:**  
- Reactivated customers were seamlessly excluded from further sends.  
- Compliance safeguards ensured opted-out subscribers were respected.  
<br>

**Key Learnings:**  
- Staging DEs improved efficiency and reliability.  
- Real-time contact data updates made the journey adaptive.  
<br>

---

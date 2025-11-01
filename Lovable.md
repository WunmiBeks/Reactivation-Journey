# Reactivation Campaign- End-To-End Journey  

## Project Description  
Reactivation campaign using SQL, AMPscript, and HTML/CSS to personalize discounts for each inactive phone line and boost customer re-engagement.  

### Scenario  
GeeMobile is launching a Reactivation Campaign to re-engage inactive customers with personalized discounts on upgraded plans. Because customers may have multiple phone lines under one account, each inactive line requires its own personalized journey, adding complexity to the campaign.  

### Campaign Journey  
- Three-email journey: introduction, reminder, and last-chance offer  
- Customers who reactivate should not receive further emails  
- Exit customers immediately once they take up the offer  
- 10% control group set up to measure uplift  

### Target Audience  
- Include phone numbers inactive for 10–180 days  
- Exclude phone IDs that re-entered within 90 days  
- Exclude phone IDs in the Reactivated Customers DE within 90 days  

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

## Solution Walkthrough  
This is the step-by-step implementation of the Reactivation Campaign, covering Data Extensions (DE), segmentation logic, personalization, and journey design.

--- 

### Step 1: Data Extension Setup

The required Data Extensions were created and assigned primary keys to store subscriber details, plan information, and reactivation history. 

#### Master_Customer Data Extension
Holds details of all subscribers, both active and inactive.

Image: MasterCustomerDE.png 
**Master_Customer DE showing subscriber account and phone-level details**

---

#### Plan_Matrix Data Extension
Contains available plans, upgrade options, plan names, prices, data allowance, and promo codes. 

Image: plans_matrix.png

--- 

#### Reactivated_Customers Data Extension 
Tracks subscribers who have accepted the offer and reactivated within the last 90 days. (This DE will be populated later once the journey is live, so its screenshot will be shown in the Journey section.)


### Step 2: Audience Segmentation
Audience segmentation was performed in Automation Studio using a staging approach to improve query efficiency and simplify troubleshooting.

![Query Overview](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_1.png)

#### 2.1. SQL Queries

- **SQL Query 1:** Writes data into Reactivation_Staging Data Extension by partially filling in fields and updating old records with new ones each time the query runs. 

[View SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/1-ReactivationCampaign_Staging.sql)

![Query 1](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_2.png)


- **SQL Query 2:** this updates empty fields in ReactivationAudience_Staging and replaces records when changes occur.

[View the SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/2-Reactivation_Staging_UpdatePlan.sql)

![Query 2](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_3.png)

---

- **SQL Query 3:** selects 10% of the target audience from ReactivationAudience_Staging (excluding Control Log) as the control group for measuring campaign uplift.

[View the SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/3-ReactivationAudience_ControlLog.sql)

![Query 3](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_5.png)

---

**SQL Query 4:** this moves records frm the staging DE to the journey DE while making sure that the 10% control group is excluded

[View the SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/4-ReactivationAudience_JourneyDE.sql)

![Query 4](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AutomationStudio_4.png)

---

**SQL Query 5:** this checks for customers who reactivated in the last 90 days and flags them in the journey DE

[View the SQL Query](https://github.com/WunmiBeks/Reactivation-Journey/blob/main/5-ReactivationAudience_JourneyDE_FlagUpdate.sql)

![Query 5](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/AStudio_UpdateFlag.png)



---

#### 2.1 Final Audience Output  
![Journey Audience](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ReactivationAudience_JourneyDE.png)  
*Resulting audience after segmentation queries — 90% of eligible inactive subscribers ready to enter the journey (excluding the 10% control group).*


---

### Step 3: Journey Design  
The Reactivation Journey was designed in Journey Builder to target the 90% of eligible inactive subscribers while excluding the 10% control group.  

---

#### 3.1 Connect Journey DE in Contact Builder  
Connected the Reactivation_JourneyDE in Contact Builder by mapping **Contact Key** with **SubscriberKey**, ensuring each phone line is tracked and enters the journey only once.  

![ContactBuilder 1](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ContactBuilder_1.png)

![ContactBuilder 2](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ContactBuilder_2.png) 

---

#### 3.2 Journey Entry Source  
Configured Reactivation_JourneyDE as the entry source for the journey to allow eligible subscribers to flow into the campaign.  

![Journey Entry Source](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/EntrySource.png) 


#### 3.3 Journey Schedule & Contact Evaluation  
The entry Data Extension is refreshed daily through **Automation Studio**, ensuring that newly eligible subscribers are evaluated and entered into the journey automatically without manual intervention.  

- Automation Studio runs a daily automation to refresh and update the Reactivation_JourneyDE with the latest qualified records.  
- Contact Evaluation is set to *Evaluate new records only*, so that only newly added or updated records are considered for entry, preventing duplicates and re-entry of outdated data.  

![JourneySchedule](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/EntrySource.png)
 
*Automation Studio schedule ensuring daily refresh of eligible contacts for the journey.*  

---

#### 3.4 Contact Entry Settings  
Under Journey Settings, the entry configuration was set to control how contacts can enter or re-enter the journey:  

- **Contact Entry Mode (Re-entry anytime:**) — allows subscribers with multiple phone lines to re-enter the journey when another eligible line becomes inactive.  

![Contact Entry](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/ContactEntry.png) 
*Contact entry configuration ensuring clean audience control and re-entry logic.*  

---

#### 3.5 Journey Flow  
Designed the journey flow to include three emails:  

- **Email 1:** Introduction to the reactivation offer  
- **Email 2:** Reminder to take action  
- **Email 3:** Final chance before expiration  

Subscribers who reactivated were removed from receiving further emails.  

![Journey Flow](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/JourneyFlow.png)  

---

#### 3.6 Exit Criteria  
Exit criteria were configured by combining Journey Data with Contact Data to ensure subscribers exited the journey at the right time.  

- **SubscriberKey (Journey Data)** = **SubscriberKey (Contact Data)**  
- **PhoneID (Journey Data)** = **PhoneID (Contact Data)**  
  *This mapping uniquely identifies each phone line while the subscriber is in the journey.*  

- HasReactivated = True *(from Contact Data)*  
- EmailConsent = Opted Out *(from Contact Data)*  
  *These conditions ensured subscribers were removed if they reactivated or opted out, maintaining both privacy and compliance standards.*  

By aligning Journey Data with Contact Data, the journey remained responsive to subscriber actions in real time.  

![Exit Criteria](https://github.com/WunmiBeks/Reactivation-Journey/raw/main/Image/Journey_ExitCriteria.png) 
*Journey flow showing the three-email reactivation sequence.*

---

### Step 4: Journey Outcomes  
As the journey ran, subscriber status was updated based on real-time contact data, ensuring accurate exits for reactivated or opted-out subscribers.

For demonstration, a record was manually added to the **Reactivated_Customers** DE to simulate a subscriber accepting the reactivation offer.  

---

#### 4.1 Reactivated_Customers DE  
This DE captures subscribers who accept the offer within the last 90 days. For testing, a record was manually added to simulate a subscriber reactivating. 

![Reactivated_CustomersDE](Reactivated_CustomersDE.png)  


#### 4.2 Reactivation_JourneyDE  
When the automation ran again, the **HasReactivated** field in the **Reactivation_JourneyDE** was automatically updated from False to True.  
Because Journey Data (SubscriberKey and PhoneID) was mapped to Contact Data, the exit criteria detected this change and triggered the exit.

This confirmed that the exit logic worked exactly as intended:
- Reactivated subscribers exited the journey immediately once Contact Data was updated.
- Subscribers who opted out of email were also removed, meeting compliance and regulatory standards.

![JourneyDE_HasReactivated](Reactivation_JourneyDE.png)  


### Results & Key Learnings  

The campaign achieved its technical objectives while strengthening best practices in compliance, efficiency, and customer trust. 

**Results:**   
- Reactivated customers were seamlessly excluded from further sends, ensuring a positive customer experience.  
- Compliance safeguards ensured that opted-out subscribers were respected throughout the journey.  

**Learnings:**  
- Staging Data Extensions improved efficiency and reliability of automation runs.  
- Leveraging contact data updates made the journey adaptive to real-time subscriber actions.  




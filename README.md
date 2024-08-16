# COVID19 ANALYSIS

## OVERVIEW
This is a covid19 analysis projected to look into its cases, people vaccinated, people infected and countries infected, as well as people killed within that year, using _United States_ as case study.

---
### Data Source
The datasets used are the 'CovidDeaths.xlsx' [CovidDeaths](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/CovidDeaths.xlsx) and 'CovidVaccinations.xlsx' [CovidVaccinations](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/CovidVaccinations.xlsx) files

### Tools Used

- **EXCEL** : was used to sort both data files since they were both contained in one bigger file. Therefore, excel was used to split these files to be individual files inorder to work on.

- **MS SQL** : was used to query the table inorder to get the appropriate information needed.
  
- **TABLEAU Public**: was used for final visualizations of the problem statements as concerned to me.

### Data Cleaning/Preparation
 The following tasks were carried out;
 - Data Loading and inspection in EXCEL
 - Spliting of the whole data into two(2) different files for CovidDeaths and CovidVaccinations respectively. This was done because both files were contained in a single file to be used in SQL for data extractions.

### Exploratory Data Analysis

EDA involved the Covid19 data to answer some key questions, such as;

i. What are the Overall Cases Globally? (Global Numbers)?

ii. What are the **Total Death Counts Per Continent**?

iii. What is the **Percentage Population Infected Per Country**?

iv. What is the **Average Infected Population Percentage Overtime**?

### Data Analysis

I. **Global Numbers**

   - Looking At Total Cases Vs Total Deaths Globally
   - Shows the likelihood of dying if it's contracted.

   ```SQL
SELECT 
      SUM(new_cases) AS total_cases,
      SUM(CAST(new_deaths AS INT)) AS total_deaths,
      SUM(CAST(new_deaths AS INT)) / SUM(New_Cases) * 100 AS Death_Percentage
FROM 
    Covid_Deaths
WHERE
     continent IS NOT NULL
ORDER BY 1,2;
   ```
![Total_Deaths_Globally](https://github.com/user-attachments/assets/c514534d-83b0-495f-989d-14af82649b2d)

- **Total Cases:**
The figure of **150,574,977** represents the cumulative number of confirmed COVID-19 cases worldwide up to the date of this report.
This number includes all confirmed cases, from mild to severe, across all countries.

- **Total Deaths:**
The total death toll of **3,180,206** indicates the number of people who have died due to COVID-19.
The significant number of deaths highlights the global impact and severity of the pandemic.
Death Percentage:

- The death percentage of **2.11%** is calculated by dividing the total number of deaths by the total number of confirmed cases.
This figure suggests that approximately 2.11% of the confirmed COVID-19 cases globally have resulted in death.
While this percentage is significant, it is important to note that it varies by region, depending on factors like healthcare quality, population demographics, and public health responses.

---

II. **Total Death Counts Per Continent**

```SQL
SELECT
      continent,
   MAX(cast(Total_deaths AS INT)) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE 
     continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_Count DESC;
```
![Death_Per_Continent](https://github.com/user-attachments/assets/660d52db-a867-4b2b-950d-2eb68d2ec5d0)

- **Europe:**

**Deaths: 1,016,750**

Europe has the highest total death count among all continents. This may be due to factors like the early and widespread outbreak in several European countries, aging populations, and varying levels of healthcare response.

- **North America:**

**Deaths: 847,942**

North America follows closely behind Europe in terms of total deaths. The high death toll can be attributed to the significant impact of the virus in the United States and Mexico, with both countries experiencing large outbreaks.

- **South America:**

**Deaths: 672,415**

South America has also been heavily impacted by the pandemic, with countries like Brazil and Argentina facing severe outbreaks. The death toll reflects the challenges faced by healthcare systems in these regions.

- **Asia:**

**Deaths: 520,269**

Asia has a lower death count compared to Europe, North America, and South America, despite having the largest population. The variations in the death toll can be linked to the diverse responses across the continent, ranging from strict lockdowns to varying levels of healthcare infrastructure.

- **Africa:**

**Deaths: 121,784**

Africa has a significantly lower death toll compared to other continents. This might be due to a younger population on average, less international travel, and different reporting methods. However, underreporting and limited healthcare infrastructure could also play a role.

- **Oceania:**

**Deaths: 1,046**

Oceania has the lowest death count, which is likely due to its geographic isolation, strict border controls, and successful early intervention measures in countries like Australia and New Zealand.

**Summary:**

The distribution of deaths per continent highlights the varying impact of COVID-19 across the globe. Europe and North America have borne the brunt of the pandemic in terms of total deaths, likely due to earlier and more widespread outbreaks, older populations, and differing public health responses. In contrast, Africa and Oceania have reported significantly lower death tolls, although factors like underreporting, younger populations, and geographical advantages may contribute to these lower figures. This data underscores the importance of context in understanding the global impact of the pandemic, as local factors such as healthcare capacity, government response, and population demographics play crucial roles in the outcomes observed.

---

III. **Percentage Population Infected Per Country**

```SQL
SELECT 
      location,
      Population, 
   MAX(total_cases) AS Highest_Infection_Count, 
   MAX(total_cases / Population)*100 AS Percentage_Population_Infected
FROM 
    Covid_Deaths
--WHERE location = 'United States'
GROUP BY location, Population
ORDER BY Percentage_Population_Infected desc;
```

![%_Infected_Population_Per_Country](https://github.com/user-attachments/assets/84497767-120f-4da9-a150-19ab56cb8fb4)

- **United States:**

**Infected Percentage: 9.77%**

The United States shows one of the highest percentages of infection relative to its population, reflecting the significant spread of the virus across the country.

- **South America:**

Brazil: 6.90%

Argentina: 6.59%

Paraguay: 3.91%

South America, particularly Brazil and Argentina, have high infection percentages, indicating widespread transmission in these regions.

- **Europe:**

United Kingdom: 6.53%

Sweden: 8.64%

Lithuania: 8.05%

Bosnia and Herzegovina: 2.62%

Europe has varying infection percentages, with some countries like Sweden and Lithuania experiencing higher rates of infection.

- **Asia:**

Kazakhstan: 2.00%

Afghanistan: 1.09%

United Arab Emirates: 2.26%

Infection rates in Asian countries vary, with some regions like the UAE showing moderate percentages.

- **Africa:**

South Africa: 2.67%
   
Namibia: 1.90%
   
Nigeria: 0.09%
   
Egypt: 0.03%

Africa generally has lower infection percentages, though South Africa is a notable exception with a higher rate compared to other countries on the continent.

- **Oceania:**

Australia and New Zealand are not clearly marked, but given Oceania's overall low case numbers historically, it is likely that their percentages are very low or unmarked.

**Analysis:**

- **High-Infection Regions:**

The United States, parts of Europe (e.g., Sweden, Lithuania), and South America (e.g., Brazil, Argentina) have some of the highest infection rates relative to their populations. This could be due to various 
factors such as higher population density, more extensive testing and reporting, and earlier or more widespread outbreaks.

- **Moderate-Infection Regions:**

Countries like South Africa, Kazakhstan, and some Middle Eastern nations have moderate infection rates. These figures suggest significant but somewhat contained spread, possibly influenced by effective public health measures or less dense populations.

- **Low-Infection Regions:**

Many African countries, as well as some Asian nations, show very low infection percentages. This could be due to a combination of factors, including underreporting, less testing, younger populations, or 
geographic advantages that limited the spread of the virus.

---

IV. **Average Infected Population Percentage Overtime**

```SQL
SELECT 
      location,
      date, 
      total_cases, 
      Population, 
     (total_cases / Population)*100 AS Percentage_Population_Infected
FROM 
    Covid_Deaths
--WHERE location = 'United States'
ORDER BY 1,2;
```
![Avg_Population_Infected](https://github.com/user-attachments/assets/009ab290-6b7c-4410-a0eb-cff3ee7d4f57)

**Key Observations:**

- **United States:**

_March 2020 to March 2021:_

The percentage of the population infected increased steadily, reaching about 8.93% by March 2021.

_March 2021 to September 2021:_

The infection rate surged, reaching 19.11% by September 2021, indicating a significant increase in the spread of the virus during this period.

- **United Kingdom:**

_March 2020 to March 2021:_

Similar to the United States, the UK saw a steady increase, with around 6.31% of the population infected by March 2021.

_March 2021 to September 2021:_

The infection rate continued to rise, reaching 14.93% by September 2021, although at a slightly slower pace compared to the United States.

- **Mexico:**

_March 2020 to March 2021:_

The infection rate was relatively low but showed a gradual increase, reaching 1.68% by March 2021.

_March 2021 to September 2021:_

The rate increased to 3.32% by September 2021, indicating a moderate spread of the virus compared to the US and UK.

- **India:**

_March 2020 to March 2021:_

The infection rate in India remained relatively low, with 0.84% of the population infected by March 2021.

_March 2021 to September 2021:_

The rate increased to 1.27% by September 2021, reflecting a slower spread compared to the other countries analyzed.

**Analysis:**

   - Sharp Increases in the US and UK:

The **United States** and the **United Kingdom** experienced significant increases in the percentage of their populations infected, especially between March and September 2021. This could be due to the spread of more contagious variants of the virus, changes in public health measures, or increased testing and reporting.

   - Slower Spread in Mexico and India:

Mexico and India had lower infection rates compared to the US and UK, with a more gradual increase in the percentage of the population infected. Factors such as differences in population density, public health responses, and testing capacity could contribute to these trends.


### Results/Findings

The following were dully observed from the analysis results;

This data underscores the importance of context in understanding the global impact of the pandemic, as local factors such as healthcare capacity, government response, and population demographics play crucial roles in the outcomes observed.

   - **United States and United Kingdom:**

The forecast shows a continued rise in infection rates, with the US potentially reaching over 25% and the UK approaching 20% if current trends continue. The shaded regions indicate a range of possible outcomes, with the potential for the actual rate to be slightly lower or higher.

   - **Mexico and India:**

Both countries are forecasted to see a more gradual increase in infection rates. By the end of the forecast period, Mexico may reach around 5%, while India might approach 2%.

---

### Recommendations

**1. Strengthen Vaccination Campaigns:**
   
- **Target High-Infection Regions:** The United States and the United Kingdom show rapidly increasing infection rates. Intensifying vaccination efforts in these areas, especially targeting unvaccinated populations and vulnerable groups, could help curb the spread.

- **Boosters and New Variants:** As new variants emerge, it may be necessary to roll out booster shots or vaccines specifically targeting these variants to maintain immunity levels and prevent a resurgence of cases.

**2. Implement and Maintain Public Health Measures:**

- **Localized Restrictions:** In areas with rising infection rates, such as the US and UK, reintroducing or maintaining public health measures like mask mandates, social distancing, and limits on large gatherings could slow the spread. These measures should be adjusted based on real-time data and infection rates.

- **Targeted Interventions:** Focus on high-risk settings such as schools, workplaces, and public transport by implementing regular testing, improving ventilation, and ensuring compliance with health guidelines.

**3. Increase Global Collaboration and Support:** Support Lower-Infection Countries: Countries like Mexico and India are seeing slower increases in infection rates. Providing these countries with the resources needed for robust testing, contact tracing, and vaccination can help prevent a sharp rise in cases.

- **Share Data and Best Practices:** Encourage global sharing of data, including the effectiveness of interventions and vaccine responses to new variants, to ensure that countries can learn from each other’s experiences and respond more effectively.

By combining these strategies, governments and health authorities can more effectively manage and reduce the spread of COVID-19, preventing further increases in infection rates and mitigating the impact of future outbreaks.

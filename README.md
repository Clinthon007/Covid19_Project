# COVID19 ANALYSIS

## OVERVIEW
This is a covid19 analysis projected to look into its cases, people vaccinated, people infected and countries infected, as well as people killed within that year, using _United States_ as case study.

---
### Data Source
The datasets used are the 'CovidDeaths.xlsx' [CovidDeaths](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/CovidDeaths.xlsx) and 'CovidVaccinations.xlsx' [CovidVaccinations](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/CovidVaccinations.xlsx) files

### Tools Used

- EXCEL : was used to sort both data files since they were both contained in one bigger file. Therefore, excel was used to split these files to be individual files inorder to work on.
- MS SQL : was used to query the data inorder to get the appropriate information needed.
- TABLEAU Public: was used for final visualizations of the problem statements as concerned to me.

### Data Cleaning/Preparation
 The following tasks were carried out;
 - Data Loading and inspection in EXCEL
 - Spliting of the whole data into two(2) different files for CovidDeaths and CovidVaccinations respectively. This was done because both files were contained in a single file to be used in SQL for data extractions.

### Exploratory Data Analysis

EDA involved the Covid19 data to answer some key questions, such as;

i. What are the **Total Cases Vs Total Deaths** (Global Numbers)?

ii. What are the **Total Death Counts Per Continent**?

iii. What is the **Percentage Population Infected Per Country**?

iv. What is the **Average Infected Population Percentage**?

### Data Analysis

i. **Total Cases Vs Total Deaths**

   - Looking At Total Cases Vs Total Deaths Globally
   - Shows the likelihood of dying if it's contracted.

   ```SQL
SELECT 
      location,
	  date, 
	  total_cases, 
	  total_deaths, 
	  (CONVERT(FLOAT, total_deaths) / NULLIF(CONVERT(FLOAT, total_cases),0))*100 AS Death_Percentage
FROM 
    Covid_Deaths
WHERE
     location like '%states%'
AND continent IS NOT NULL
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

ii. **Total Death Counts Per Continent**

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
![Death_Per_Continent](https://github.com/user-attachments/assets/f3dad836-23fc-4ae6-afe0-742d779ad4c1)

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

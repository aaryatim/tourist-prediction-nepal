
# Tourist Arrival Prediction Model for Nepal

## Introduction
Nepal, renowned for its breathtaking natural beauty and rich cultural heritage, faces significant challenges in effectively allocating resources and maximizing the benefits of its tourism potential. The tourism industry struggles with inefficient resource utilization, resulting in missed opportunities for revenue generation and job creation.

This project focuses on creating a predictive model for tourist arrivals in Nepal using data from 1994 to 2022. The model can assist businesses and the government in resource allocation and planning. The model can also be adjusted for similar purposes, such as forecasting tourism demand for specific regions, optimizing marketing strategies, and planning for infrastructure development. By understanding tourist trends, tour operators and travel agencies can tailor their offerings, optimize pricing strategies, and improve customer satisfaction. Accommodation providers can plan for peak seasons, optimize pricing, and manage inventory better, enhancing overall profitability.

By understanding tourist trends and preferences, stakeholders can make informed decisions to improve the tourism experience, ensuring sustainable growth and efficient utilization of Nepal's landscapes and cultural heritages.

## Table of Contents
1. [Installation](#installation)
2. [Usage](#usage)
3. [Project Structure](#project-structure)
4. [Data](#data)
5. [Features](#features)
6. [Models](#models)
7. [Results](#results)
8. [License](#license)
9. [Acknowledgements](#acknowledgements)
10. [Contact Information](#contact-information)

## Installation
Follow these steps to set up the environment and install necessary dependencies.


## Clone the repository
`git clone https://github.com/aaryatim/tourist-prediction-nepal.git`

## Navigate to the project directory
`cd tourist-prediction-nepal`

### Usage

Follow these steps to use the project.

**Step 1:** Import Raw Data to MySQL

Open import_data.ipynb:

Open the import_data.ipynb Jupyter notebook.


Replace Database Credentials:
Replace the placeholders for database credentials with your actual MySQL credentials in the notebook.

Run the Notebook:
Execute the cells in the notebook to import the raw data tables into MySQL.

**Step 2:** Remove Unnamed Columns

Run the provided SQL script to remove unnamed columns from all tables in the database:

`mysql -u your_username -p your_database < sql/remove_unnamed_cols.sql`

**Step 3:** Clean the Data in MySQL

Run the provided SQL script to clean the data:

`mysql -u your_username -p your_database < sql/clean_data.sql`

**Step 4:** Further Clean the Main Table, Perform EDA, and Create Models

Open EDA.ipynb:

Open the EDA.ipynb Jupyter notebook.


## Project Structure
Here is an overview of the project directory and files.

```
project-root/
│
├── data/
│   ├── raw/                      # Raw data files
│   ├── processed/                # Processed data files
│
├── notebooks/
│   ├── import_data.ipynb         # Notebook to import raw data into MySQL
│   ├── EDA.ipynb                 # Notebook for EDA and model creation
│
├── sql/
│   ├── remove_unnamed_cols.sql   # SQL script to remove unnamed columns
│   ├── clean_data.sql            # SQL script to clean the data
│
├── README.md                     # This README file

```

## Data
The dataset used in this project is sourced from the Nepal Tourism Statistics Report 2022, uploaded by the Nepal government. 
https://www.tourism.gov.np/files/NOTICE%20MANAGER_FILES/Setting_Nepal%20Tourism%20Statistic_2022.pdf 

## Data Cleaning
The data was initially cleaned using MySQL to handle missing values, inconsistencies, and to transform it into a suitable format for analysis. The cleaned data was then imported into Python for further cleaning and preprocessing.

## Exploratory Data Analysis
Conducted exploratory data analysis (EDA) to understand the data distribution, identify patterns, and detect outliers.

## Features
Key features of this project include:

Data Cleaning: Ensuring data quality through multiple stages of cleaning. 

Exploratory Data Analysis: Understanding the underlying patterns and relationships in the data.  

Model Training: Trying out different models to identify the best predictive model.

Model Tuning: Fine-tuning the model parameters to improve performance.

Prediction: Forecasting future tourist arrivals to aid in decision-making.

## Models
The following models were evaluated in this project:

Linear Regression

Decision Tree Regressor

Random Forest Regressor

Gradient Boosting Regressor

Support Vector Regressor (SVR)

K-Neighbors Regressor

## Results
The performance of the models was evaluated using metrics such as Root Mean Squared Error (RMSE) and R-squared.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements
Special thanks to the Nepal Tourism Board for providing the data.
Thanks to the open-source community for providing the tools and libraries used in this project.

## Contact Information
For any questions or collaboration opportunities, please contact me at:

Email: atimilsina@smith.edu
LinekdIn: https://www.linkedin.com/in/aarya-timilsina/

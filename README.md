# DSCI 310 Group 3: Predicting Canada's Community Well-Being Index Scores
This project repository was created for UBC's DSCI 310 class.

## Authors: Shawn Li, Selena Shew, Sri Chaitanya Bonthula, & Lesley Mai

### Project Summary
In Canada, the Community Well-Being Index, or CWB for short, is a way for the Canadian government to assess and quantify the the socio-economic well-being in various communities. Each community is assessed in how well they are doing across four different fields: labour force activity, income, housing, and education. Scores are assigned to each of those categories, and are then used to calculate an overall index score to summarize how well the community is doing across all four areas. For more information, please go here: https://open.canada.ca/data/en/dataset/56578f58-a775-44ea-9cc5-9bf7c78410e6.

The CWB index scores are updated every year. While the data is publicly available on Canada's Open Governmental Data Portal, the actual analysis and model used to make these scores have not been released. Therefore, our group aims to create a linear regression model that can be used to predict the CWB scores, using values from the four categories as predictors.

### Dependencies
The main programming language for this project is R (version 4.3 or greater). The IDE used to run the analysis was Jupyter Notebook. The packages required are listed in the environment.yml file.

### Usage 

#### From the Environment File:
1) First, clone the repository onto your local computer. In the terminal, via Git, create the environment by typing:

conda env create --file environment.yml


2) Then, to open up Jupyter Notebook, type:

jupyter lab 

#### From the Dockerfile:
1) Sign into Docker and have it running on your computer
2) Clone the repository: git clone <https://github.com/DSCI-310-2024/DSCI_310_Milestone_1_Group_3.git>
3) Open your preferred terminal and navigate to the directory containing the Dockerfile
4) Build the Docker Image: docker build -tag dsci310_group3_df .
5) Start the container & mount the correct volume: docker run --rm -it -v /$(pwd):/home/project dsci310_group3_df bash
6) navigate to the correct directory on the container: cd /home/project
7) exit when finished

### License
Our project code is licensed under the MIT license and covers all of the original code used for this project. Our project report is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0) license. 

### Reference
Indigenous Services Canada. (2015, April 2). Community Well-Being Index. Open Government Portal. https://open.canada.ca/data/en/dataset/56578f58-a775-44ea-9cc5-9bf7c78410e6 



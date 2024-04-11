# DSCI 310 Group 3: Predicting Canada's Community Well-Being Index Scores
This project repository was created for UBC's DSCI 310 class.

## Authors: Shawn Li, Selena Shew, Sri Chaitanya Bonthula, & Lesley Mai

### Project Summary
In Canada, the Community Well-Being Index, or CWB for short, is a way for the Canadian government to assess and quantify the the socio-economic well-being in various communities. Each community is assessed in how well they are doing across four different fields: labour force activity, income, housing, and education. Scores are assigned to each of those categories, and are then used to calculate an overall index score to summarize how well the community is doing across all four areas. For more information, please go here: https://open.canada.ca/data/en/dataset/56578f58-a775-44ea-9cc5-9bf7c78410e6.

The CWB index scores are updated every year. While the data is publicly available on Canada's Open Governmental Data Portal, the actual analysis and model used to make these scores have not been released. Therefore, our group aims to create a linear regression model that can be used to predict the CWB scores, using values from the four categories as predictors.

### Dependencies
The main programming language for this project is R (version 4.3 or greater). The IDE used to run the analysis was Jupyter Notebook. The packages required are as listed:

  - r-base=4.1.3
  - r-cowplot=1.1.1
  - r-essentials=4.1
  - r-ggally=2.1.2
  - r-islr=1.4
  - r-kknn=1.3.1
  - r-repr=1.1.6
  - r-tidymodels=1.1.0
  - r-tidyverse=2.0.0
  - G3package=0.0.0.9000

  The G3package is a custom package created by the project authors that contains functions to help run the analysis. 

  To download the package, insert the following command into the terminal/RStudio console:

  ````{r}
  devtools::install_github("DSCI-310-2024/DSCI310_Group_3_Package")
  ````

  Then to load the package, type the following command in Jupyter Notebook or RStudio:
   ````{r}
  library(G3package)
  ```` 

  For more information on G3package, please refer to https://github.com/DSCI-310-2024/DSCI310_Group_3_Package. 

### Usage 

#### From the Environment File:
1) Open your terminal
2) In the command line, clone the repository onto your local computer: 
````
git clone https://github.com/DSCI-310-2024/DSCI_310_Milestone_1_Group_3.git
```` 
2) In the terminal, via Git, create the environment by typing: 
```` 
conda env create --file environment.yml
```` 
2) Then, to open up Jupyter Notebook, type: 
```` 
jupyter lab 
```` 

#### From the Dockerfile:
1) Sign into Docker and have it running on your computer
2) Open the terminal
3) In the terminal command line, clone the repository: 
```` 
git clone <https://github.com/DSCI-310-2024/DSCI_310_Milestone_1_Group_3.git>
```` 
4) In the terminal, navigate to the directory containing the Dockerfile:
```` 
cd "<insert path to the Dockerfile on your computer>
```` 
4) In the terminal, build the Docker Image: 
```` 
docker build -tag dsci310_group3_df .
```` 
5) In the terminal, start the container & mount the correct volume: 
```` 
docker run --rm -it -v /$(pwd):/home/project dsci310_group3_df bash
```` 
6) In the terminal, navigate to the correct directory on the container: 
```` 
cd /home/project
```` 
7) When finished, type the following in the terminal:
```` 
exit
```` 

#### To Run the Entire Analysis Yourself:
1) Open up the terminal and navigate to the directory containing the Makefile:
```` 
cd "<insert path on your computer leading to the Makefile>"
```` 
2) In the terminal, type:
```` 
make all
```` 
3) After running the analysis, you can remove the generated files by typing in the terminal:
```` 
make clean
```` 

### License
Our project code is licensed under the MIT license and covers all of the original code used for this project. Our project report is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0) license. 

### Reference
Indigenous Services Canada. (2015, April 2). Community Well-Being Index. Open Government Portal. https://open.canada.ca/data/en/dataset/56578f58-a775-44ea-9cc5-9bf7c78410e6 



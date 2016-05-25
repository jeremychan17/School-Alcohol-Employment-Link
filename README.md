# School-Alcohol-Employment-Link
ECN 140 Project Investigating Link Between Alcohol and Employment Measures

This is a school project in which in investigate the link between alcohol usage and employment measures. Specifically, this project intends to create a link between a person's frequency of high alcohol usage (designated as the frequency of 6 or more drinks in one sitting) and the probability of that person being employed. The ultimate goal is to create a model which will assign a probability for a person being employed given a number of demograhpic factors. The project was coded in stata with the report being written in Microsoft Word. 

I started with four conceptual models:
1) P(employment|frequency of high alcohol usage)
2) P(employment|frequency of high alcohol usage, individual demographics)
3) P(employment|frequency of high alcohol usage, geographic demographics)
4) P(employment|frequency of high alcohol usage, individual demographics, geographic demographics)

The first model was used to establish that there are some effects at all between different frequencies of high alcohol consumption.
The second model was used to examine effects between frequencies of high alcohol consumption controlling for individual demographics.
The third model was used to examine effects between frequencies of high alcohol consumption controlling for geographic demographics.
The fourth model was used to model the full probability on both geographic and individual demographic factors. 

Individual demographic factors:
  age (coded in years)
  gender (coded in terms of male and female)
  race (coded in terms of Hispanic, Black, or other)
  health (coded in a binary variable where 1 means that a person has a health problem limiting the amount of kind of work done)
  highest grade achieved (coded in terms of 0-20)
  family size (coded in integer form)
  marital status (coded in terms of married, never married, or other)

Geographic demographic factors:
  region (coded in terms of Northeast, North Central, South, or West as 1, 2, 3, and 4, respectively)
  local employment rate (coded as the midpoint of a range to avoid identifying specific observations)
  
The regrssions were run using the probit command with robust standard errors. The marginal effects were then computed using the mfx compute command. 
  
  

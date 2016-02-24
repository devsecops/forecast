Architecture
===========
Forecast is a data ecosystem that allows for information to be catalogued, mined, and utilized to support an end to end operational CICD pipeline.

#Design Principles
We've developed the following principles for working on Forecast to help us iterate and extend our work to the community.

##Use Cheap Storage 
We've learned that security is the biggest, big data problem an organization has.  Understanding security issues and arriving at high fidelity action items takes a lot of context and can require a vast amount of data.  We'll use cheap storage to ingest, transform and store data used by Forecast.

##Humans are Optional
Too many security tools require a lot of human intervention, we'll start with a design that makes it possible to reduce human effort from the inception of the project.

##Simple Alert Workflow
Avoid building complicated workflows in Forecast, it should be kept simple to achieve its purpose and hand-off alerts to other tools for escalated correlation and handling.


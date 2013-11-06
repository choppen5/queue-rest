queue-rest
==========

This example does the following:
### 1st
-- sends incomming calls to a Queuue - "WelcomeQueue" 
-- They are sent there by sending calls to /voice


### 2nd
A get request to /connect-to-agent?agent_num=44343434343434 will cause

1. rest call to 44343434343434
2. agent 44343434343434 is reserved, if they press 1
3. agent calls queue 

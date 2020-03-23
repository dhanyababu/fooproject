*** Settings ***
Documentation   This is test suite of infotiv rental car webpage
Resource        keywords.robot
Library         SeleniumLibrary
Test Setup      Open Browser To Start Page
Test Teardown   End Web Test


*** Variables ***
${BROWSER} =  chrome
${URL} =     http://rental33.infotiv.net/


*** Test Cases ***
Verify infotiv home page
    [Documentation]             Test to verify that Home page contains Heading  'Infotiv Car Rental'
    ...                         and to verify the Logo is clickable
    [Tags]                      Test 1
    Given Browser is opened to Home page
    When Click the Logo
    Then Should be able to click Logo


Login with Invalid Credentials
    [Documentation]             Given that User Should not be able to loggin with Invalid Username and password
    ...                         When User is trying to loggin with wrong UserName and wrong Password
    ...                         Then Web page should display a warning text like 'Wrong e-mail or password'
    [Tags]                      Test 2
    Given Browser is opened to login page
    When Login with Invalid credentials
    Then Should not be able to login


Verify Start date Displayed By Using Boundary Value Analysis
    [Documentation]             Test to verify default date displayed in start date is current date
    ...                         And in this test case start date is validating by using Boundary Value Analysis
    [Tags]                      Test 3
    Verify Default Date is diplayed in start date is current date


Verify Minimum Date of Start Date
    [Documentation]             Test to verify minimun date is current date
    [Tags]                      Test 3.1
    Verify The Min Date For The Start Date


Verify Maximum Date of Start Date
    [Documentation]             Test to verify maximum date is one month after from the current date
    [Tags]                      Test 3.2
    Verify The Max Date For The Start Date


Verify Less A Day From Min Date of Start Date
    [Documentation]             Test to Less A Day From Min Date of Start Date(Invalid boundary value-minimum value)
    [Tags]                      Test 3.3
    Verify Less A Day From Min Date (Invalid) For The Start Date


Verify Add A Day To Max Date of Start Date
    [Documentation]             Test to Add A Day To Max Date of Start Date(Invalid boundary value-maximum value)
    [Tags]                      Test 3.4
    Verify Add A Day To Max Date (Invalid) For the Start Date


Verify Selecting Start date is in Between Boundary Value
    [Documentation]             Test to verify Selecting start date is betwen boundary value
     ...                        ie selecting start date is in between minimum and maximum of start date
    [Tags]                      Test 3.5
    Verify Selected Start Date Should Be Between Min and Max Values


Verify functionality of booking a car
     [Documentation]             Test to verify that should be able to book a car including logging in,Date selection,
     ...                         car selection,confirm booking and verified Booking in 'My Page' Table
     [Tags]                      Test 4
     Login Using Valid Credentials
     Verify User is Logged in Successfully
     Choose Start and End Date To Book A car
     Should Be Able to Select A car
     Should be able to enter Card deatails
     Verify whether car is booked or not
     Should be able to cancel Booking


Verify Navigation between Pages
     [Documentation]             Given that User Should be able to navigate to 'About' and 'Create User Page' From 'Home' Page
      ...                        When User Click onto the 'About' and 'create user page'  url
      ...                        Then the webpage should display 'About' page with 'Welcome' text And 'Create User Page' with 'Create a new user' text
     [Tags]                      Test 5
     Check Navigation Between Home And About And Create User Page


Checking Car booking functionality navigating between different pages
    [Documentation]             Given that user should be able to book a car by using proper credentials
     ...                        When the user entered  the data
     ...                        Then the web page should be able to book a car according to user preference and show a booked message
    [Tags]                      Test 6(VG)
    Given User should be able to login using proper credentials
    When User should be able to enter all the required for booking a car
    Then Should be able book a car succesfully























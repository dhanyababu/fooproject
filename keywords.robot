*** Settings ***
Library                                     SeleniumLibrary
Library                                     DateTime


*** Keywords ***
Open Browser To Start Page
        Open Browser                        about:blank                 ${BROWSER}
        Maximize Browser Window
        Go To                                                           ${URL}


Given Browser is opened to Home page
        ${link_text_header} =               Get Text                    xpath://*[@id="title"]
        Should Be Equal                     ${link_text_header}         Infotiv Car Rental
        Click Element                                                   id:questionText
        ${link_text_display} =              Get Text                    id:questionText
        Should Be Equal                     ${link_text_display}        When do you want to make your trip?


When Click the Logo
         Click Element                                                  xpath://*[@id="logo"]
         Click Element                                                  id:questionText


Then Should be able to click Logo
         ${link_text_logo} =                Get Text                    id:questionText
         Should Be Equal                    ${link_text_logo}           When do you want to make your trip?


Given Browser is opened to login page
        Element Should Be Visible                                       id:login



When Login with Invalid credentials
        Input Text                          id:email                    abcdefg123
        Input Text                          id:password                 abdefabcdefgh
        Click Button                                                    id:login



Then Should not be able to login
        Sleep                   2s
        ${link_text_error} =                Get Text                    id:signInError
        Should Be Equal                     ${link_text_error}          Wrong e-mail or password



Verify Default Date is diplayed in start date is current date
        Element Should Be Visible                                       id:start
        ${display_date} =                   Get Value                   id:start
        ${current_date} =                   Get Current Date            local                   result_format=%Y-%m-%d
        should be equal                     ${current_date}             ${display_date}


Verify The Min Date For The Start Date
        ${min_value_start} =                Get Element Attribute       id:start                attribute=min
        ${current_date} =                   Get Current Date            local                   result_format=%Y-%m-%d
        Should Be Equal                     ${current_date}             ${min_value_start}


Verify The Max Date For The Start Date
        ${min_value_start} =                Get Element Attribute           id:start            attribute=min
        ${max_value_start} =                Get Element Attribute           id:start            attribute=max
        ${new_date} =                       Add Time To Date                ${min_value_start}  31 days             result_format=%Y-%m-%d
        Should Be Equal                     ${new_date}                     ${max_value_start}


Verify Less A Day From Min Date (Invalid) For The Start Date
        ${min_value_start} =                Get Element Attribute          id:start             attribute=min
        ${current_date} =                   Get Current Date               local                result_format=%Y-%m-%d
        ${current_date_less_A_day} =        Subtract Time From Date        ${current_date}      1 days
        Should Not Be Equal                 ${current_date_less_A_day}     ${min_value_start}


Verify Add A Day To Max Date (Invalid) For the Start Date
        ${min_value_start} =                Get Element Attribute           id:start            attribute=min
        ${max_value_start} =                Get Element Attribute           id:start            attribute=max
        ${new_max_value_add_A_day} =        Add Time To Date                ${min_value_start}  30 days
        Should Not Be Equal                 ${new_max_value_add_A_day}      ${max_value_start}


Verify Selected Start Date Should Be Between Min and Max Values
       Click Element                        id:start
       Sleep                                2s
       ${Start_date} =                      Get Time                        day month           now+3 day
       Input Text                           id:start                        ${Start_date}
       Sleep                                2s
       ${link_text} =                       Get Value                       id:start
       ${min_value_start} =                 Get Element Attribute           id:start           attribute=min
       ${max_value_start} =                 Get Element Attribute           id:start           attribute=max
       Sleep                                2s
       Should Be True                       '${link_text}'<='${max_value_start}'
       Should Be True                       '${link_text}'>='${min_value_start}'


Login Using Valid Credentials
        Input Text                          id:email                        Dhanya.Babu@iths.se
        Input Text                          id:password                     karthu
        Click Button                        id:login


Verify User is Logged in Successfully
        ${link_text} =                      Get Text                        id:welcomePhrase
        Should Be Equal                     ${link_text}                    You are signed in as dhanya
        ${link_text} =                      Get Text                        id:questionText
        Should Be Equal                     ${link_text}                    When do you want to make your trip?


Choose Start and End Date To Book A car
        Click Element                        id:start
        ${Book_Start_date} =                 Get Time                       day month           now+4 day
        Input Text                           id:start                       ${Book_Start_date}
        Sleep                                2s
        Click Element                        id:end
        ${Book_End_date} =                   Get Time                       day month           now+6 day
        Input Text                           id:end                         ${Book_End_date}
        Sleep                                3s
        Click Button                         id:continue



Should Be Able to Select A car
        Click Button                         xpath://*[@id="ms-list-1"]/button
        Select Checkbox                      id:ms-opt-4
        Click Button                         xpath://*[@id="ms-list-2"]/button
        Select Checkbox                      id:ms-opt-6
        Click Element                        id:rightpane
        Sleep                                5s
        Click Element                        id:carSelect1


Should be able to enter Card deatails
        Input Text                           id:cardNum                     202130314041505160617071
        Input Text                           id:fullName                    DhanyaBabu
        Select From List By Index            xpath://*[@id="confirmSelection"]/form/select[1]       3
        Select From List By Index            xpath://*[@id="confirmSelection"]/form/select[2]       4
        Input Text                           id:cvc                         222
        Click Button                         id:confirm


Verify whether car is booked or not
        Click Button                                                        id:mypage
        Sleep                                3s
        ${Booked_Car} =                      Get Text                       id:make1
        Should Be Equal                      ${Booked_Car}                  Volvo
        ${Booked_Start_Date} =               Get Text                       id:startDate1
         ${current_date} =                   Get Current Date               local                             result_format=%Y-%m-%d
        ${Book_Start_date} =                 Add Time To Date               ${current_date}      4 days       result_format=%Y-%m-%d
        Should Be Equal                      ${Booked_Start_Date}           ${Book_Start_date}
        ${Booked_End_Date} =                 Get Text                       id:endDate1
        ${current_date} =                    Get Current Date               local                             result_format=%Y-%m-%d
        ${Book_End_date} =                   Add Time To Date               ${current_date}      6 days       result_format=%Y-%m-%d
        Should Be Equal                      ${Booked_End_Date}             ${Book_End_date}
        ${Passengers} =                      Get Text                       id:passengers1
        should be equal                      ${Passengers}                  5

Should be able to cancel Booking
        Click Element                       id:rightpane
        Sleep                               5s
        Click Element                       xpath://*[@id="unBook1"]
        sleep                               3s
        Handle Alert                        ACCEPT



Check Navigation Between Home And About And Create User Page
        Go To                               http://rental33.infotiv.net/webpage/html/gui/about.php
        ${link_text} =                      Get Text                        id:questionText
        Should Be Equal                     ${link_text}                    Welcome

        Go Back
        ${link_text} =                      Get Text                        id:questionText
        Should Be Equal                     ${link_text}                    When do you want to make your trip?

        Go To                               http://rental33.infotiv.net/webpage/html/gui/userRegistration.php
        ${link_text} =                      Get Text                        id:questionText
        Should Be Equal                     ${link_text}                    Create a new user

        Go Back
        ${link_text} =                      Get Text                        id:questionText
        Should Be Equal                     ${link_text}                    When do you want to make your trip?


Given User should be able to login using proper credentials
        Input Text                          id:email                        Dhanya.Babu@iths.se
        Input Text                          id:password                     karthu
        Click Button                        id:login
        ${link_text_login} =                Get Text                        id:welcomePhrase
        Should Be Equal                     ${link_text_login}              You are signed in as dhanya


When User should be able to enter all the required for booking a car
        ${link_text_trip} =                 Get Text                        id:questionText
        Should Be Equal                     ${link_text_trip}               When do you want to make your trip?
        Click Element                       id:start
        ${Book_Start_date} =                Get Time                       day month           now+4 day
        Input Text                          id:start                       ${Book_Start_date}
        Sleep                               2s
        Click Element                       id:end
        ${Book_End_date} =                  Get Time                       day month           now+6 day
        Input Text                          id:end                         ${Book_End_date}
        Sleep                               3s
        Click Button                        id:continue
        Click Button                        xpath://*[@id="ms-list-1"]/button
        Select Checkbox                     id:ms-opt-1
        Click Button                        xpath://*[@id="ms-list-2"]/button
        Select Checkbox                     id:ms-opt-5
        Click Element                       id:rightpane
        Sleep                               3s
        Click Element                       id:carSelect1
        Wait Until Page contains            Confirm booking
        Input Text                          id:cardNum                      202130314041505160617071
        Input Text                          id:fullName                     Maria
        Select From List By Index           xpath://*[@id="confirmSelection"]/form/select[1]    2
        Select From List By Index           xpath://*[@id="confirmSelection"]/form/select[2]    5
        Input Text                          id:cvc                          789
        Click Button                        id:confirm

Then Should be able book a car succesfully
        Click Button                                                        id:mypage
        Sleep                                3s
        ${Booked_Car} =                      Get Text                       id:make1
        Should Be Equal                      ${Booked_Car}                  Audi
        ${Booked_Start_Date} =               Get Text                       id:startDate1
        ${current_date} =                    Get Current Date               local                             result_format=%Y-%m-%d
        ${Book_Start_date} =                 Add Time To Date               ${current_date}      4 days       result_format=%Y-%m-%d
        Should Be Equal                      ${Booked_Start_Date}           ${Book_Start_date}
        ${Booked_End_Date} =                 Get Text                       id:endDate1
        ${current_date} =                    Get Current Date               local                             result_format=%Y-%m-%d
        ${Book_End_date} =                   Add Time To Date               ${current_date}      6 days       result_format=%Y-%m-%d
        Should Be Equal                      ${Booked_End_Date}             ${Book_End_date}
        ${Passengers} =                      Get Text                       id:passengers1
        should be equal                      ${Passengers}                  2
        Click Element                       id:rightpane
        Sleep                               5s
        Click Element                       xpath://*[@id="unBook1"]
        sleep                               3s
        Handle Alert                        ACCEPT
        Sleep                               2s


End Web Test
        Close Browser



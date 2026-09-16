*** Settings ***
Documentation    Shared setup/teardown and helper keywords used by every suite.
Resource         variables.resource
Resource         locators.resource
Library          SeleniumLibrary    implicit_wait=2s


*** Keywords ***
Open GNSS Decoded Browser
    [Documentation]    Opens the configured browser, maximised (or with a fixed
    ...    window size when headless), pointed at the site's homepage.
    IF    '${HEADLESS}' == 'True'
        Open Browser    ${BASE_URL}${PATH_HOME}    ${BROWSER}    options=add_argument("--headless=new");add_argument("--window-size=1920,1080");add_argument("--disable-dev-shm-usage");add_argument("--no-sandbox")
    ELSE
        Open Browser    ${BASE_URL}${PATH_HOME}    ${BROWSER}
        Maximize Browser Window
    END
    Set Selenium Speed    ${DELAY}
    Set Selenium Implicit Wait    2s
    Set Selenium Timeout    ${TIMEOUT}

Close GNSS Decoded Browser
    [Documentation]    Closes all open browser instances at the end of a suite.
    Close All Browsers

Go To Page
    [Documentation]    Navigates to a path relative to BASE_URL and waits for
    ...    the page <body> to be present.
    [Arguments]    ${path}=${PATH_HOME}
    Go To    ${BASE_URL}${path}
    Wait Until Page Contains Element    tag:body    timeout=${TIMEOUT}

Element Should Be Visible And Enabled
    [Documentation]    Convenience assertion combining visibility + enabled checks.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    Element Should Be Enabled    ${locator}

Click Link And Verify Url Contains
    [Documentation]    Clicks a link locator and asserts the resulting URL
    ...    contains the given fragment, waiting for navigation to complete.
    [Arguments]    ${link_locator}    ${expected_url_fragment}
    Wait Until Element Is Visible    ${link_locator}    timeout=${TIMEOUT}
    Click Element    ${link_locator}
    Wait Until Location Contains    ${expected_url_fragment}    timeout=${TIMEOUT}
    Location Should Contain    ${expected_url_fragment}

Capture Failure Screenshot
    [Documentation]    Run on test teardown to grab a screenshot only when the
    ...    test failed, keeping the results folder lean on green runs.
    Run Keyword If Test Failed    Capture Page Screenshot

*** Settings ***
Documentation    Central configuration for the GNSS Decoded test suite.
...              All values can be overridden on the CLI with -v NAME:value,
...              e.g. `robot -v BASE_URL:https://staging.gnssdecoded.com tests/`


*** Variables ***
${BASE_URL}                 https://gnssdecoded.com
${BROWSER}                  chrome
${HEADLESS}                 True
${TIMEOUT}                  15s
${DELAY}                    0s
${WINDOW_SIZE}              1920x1080

# Key page paths (relative to BASE_URL)
${PATH_HOME}                /
${PATH_ISS_TRACKER}         /iss-tracker/
${PATH_GNSS_CALENDAR}       /gnss-calendar/
${PATH_GPS_TIME_CONVERTER}  /gps-time-converter/
${PATH_ECEF_LLA_TOOL}       /ecef-lla-enu-conversion-tool/
${PATH_QA}                  /gnss-interview-questions/
${PATH_GLOSSARY}            /satellite-gnss-glossary/
${PATH_CONTACT}             /contact/
${PATH_ALL_ARTICLES}        /all-articles/

${EXPECTED_SITE_TITLE}      GNSS Decoded - Space and Beyond

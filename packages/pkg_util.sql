-- Defining the package and creating the body
CREATE OR REPLACE PACKAGE PKG_UTIL AS
    FUNCTION ADD_TAB(MSG IN VARCHAR2) RETURN VARCHAR2;
    PROCEDURE ADD_NEW_LINE(MSG IN VARCHAR2);
END PKG_UTIL;
/

CREATE OR REPLACE PACKAGE BODY PKG_UTIL AS
    FUNCTION ADD_TAB(MSG IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        RETURN CHR(9) || MSG;
    END ADD_TAB;

    PROCEDURE ADD_NEW_LINE(MSG IN VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(MSG || CHR(10));
    END ADD_NEW_LINE;
END PKG_UTIL;
/


-- CREATE SYNONYMS 
CREATE OR REPLACE SYNONYM UTIL_PKG FOR ADMIN_SUPER_USER.PKG_UTIL;

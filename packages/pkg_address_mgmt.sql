CREATE OR REPLACE PACKAGE PKG_ADDRESS_MANAGEMENT AS
    FUNCTION CREATE_ADDRESS(
        PI_ST1 IN ADDRESS.STREET1%TYPE,
        PI_ST2 IN ADDRESS.STREET2%TYPE,
        PI_CITY IN ADDRESS.CITY%TYPE,
        PI_STATE IN ADDRESS.STATE%TYPE,
        PI_ZIP IN ADDRESS.ZIPCODE%TYPE,
        PI_COUNTRY IN ADDRESS.COUNTRY%TYPE
    ) RETURN NUMBER;
END PKG_ADDRESS_MANAGEMENT;
/

CREATE OR REPLACE PACKAGE BODY PKG_ADDRESS_MANAGEMENT AS 
-- Function for creating address
    FUNCTION CREATE_ADDRESS(
        PI_ST1 IN ADDRESS.STREET1%TYPE,
        PI_ST2 IN ADDRESS.STREET2%TYPE,
        PI_CITY IN ADDRESS.CITY%TYPE,
        PI_STATE IN ADDRESS.STATE%TYPE,
        PI_ZIP IN ADDRESS.ZIPCODE%TYPE,
        PI_COUNTRY IN ADDRESS.COUNTRY%TYPE
    ) RETURN NUMBER IS
        V_ADDRESS_ID ADDRESS.ADDRESS_ID%TYPE;
    
        NULL_ST1_EXEC EXCEPTION;
        NULL_CITY_EXEC EXCEPTION;
        NULL_STATE_EXEC EXCEPTION;
        NULL_COUNTRY_EXEC EXCEPTION;
    BEGIN
        IF PI_ST1 IS NULL OR TRIM(PI_ST1) IS NULL THEN
            RAISE NULL_ST1_EXEC;
        END IF;
        
        IF PI_CITY IS NULL OR TRIM(PI_CITY) IS NULL THEN
            RAISE NULL_CITY_EXEC;
        END IF;
        
        IF PI_STATE IS NULL OR TRIM(PI_STATE) IS NULL THEN 
            RAISE NULL_STATE_EXEC;
        END IF;
        
        IF PI_COUNTRY IS NULL OR TRIM(PI_COUNTRY) IS NULL THEN
            RAISE NULL_COUNTRY_EXEC;
        END IF;
        
        -- Insert into ADDRESS table
        INSERT INTO ADDRESS
            (STREET1, STREET2, CITY, STATE, ZIPCODE, COUNTRY)
        VALUES
            (LOWER(PI_ST1), LOWER(PI_ST2), LOWER(PI_CITY), LOWER(PI_STATE), PI_ZIP, LOWER(PI_COUNTRY))
        RETURNING ADDRESS_ID INTO V_ADDRESS_ID;
            
        UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Address created successfully with Address ID: ' || V_ADDRESS_ID));
        RETURN V_ADDRESS_ID;
        
    EXCEPTION
        WHEN NULL_ST1_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating address: Street 1 cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_CITY_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating address: City cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_STATE_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating address: State cannot be empty.'));
            RETURN -1;
            
        WHEN NULL_COUNTRY_EXEC THEN
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating address: Country cannot be empty.'));    
            RETURN -1;
        
         WHEN OTHERS THEN 
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Error creating Address: ' || SQLERRM));
            ROLLBACK;
            UTIL_PKG.ADD_NEW_LINE(UTIL_PKG.ADD_TAB('Due to an error Transactions if any are rolled back'));
            RETURN -1;
                
    END CREATE_ADDRESS;
END PKG_ADDRESS_MANAGEMENT;
/
        
        
-- Create Synonym for the package        
CREATE OR REPLACE PUBLIC SYNONYM ADD_MGMT
FOR ADMIN_SUPER_USER.PKG_ADDRESS_MANAGEMENT;

--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


-- Enable Ad Hoc Distributed Queries
sp_configure 'show advanced options', 1;
RECONFIGURE;
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
create database PortfolioProject
-- Use the target database
USE PortfolioProject;

-- Define the table with appropriate data types and an identity column
drop table if exists NashvilleHousing 
CREATE TABLE NashvilleHousing (
    UniqueID INT IDENTITY(1, 1) PRIMARY KEY,
    ParcelID NVARCHAR(255),
    LandUse NVARCHAR(255),
    PropertyAddress NVARCHAR(255),
    SaleDate NVARCHAR(255), -- Consider using a suitable date format
    SalePrice numeric,
    LegalReference NVARCHAR(255),
    SoldAsVacant NVARCHAR(255), -- Adjust data type as needed
    OwnerName NVARCHAR(255),
    OwnerAddress NVARCHAR(255),
    Acreage FLOAT,
    TaxDistrict NVARCHAR(255),
    LandValue numeric,
    BuildingValue numeric,
    TotalValue numeric,
    YearBuilt DATE, -- Consider using DATE data type
    Bedrooms numeric,
    FullBath numeric,
    HalfBath numeric
);

-- Use TRY...CATCH for error handling
BEGIN TRY
    -- Use BULK INSERT to load data from the CSV file
    BULK INSERT NashvilleHousing 
    FROM 'C:\Users\lexxy\Downloads\Nashville Housing Data for Data Cleaning.csv'
    WITH (
        FIRSTROW = 2, -- If your CSV file includes a header row
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
		KEEPNULLS
    );
END TRY
BEGIN CATCH
    -- Handle errors here, e.g., log them or print a message
    PRINT 'Error occurred during bulk insert: ' + ERROR_MESSAGE();
END CATCH;



-- Using OPENROWSET
USE PortfolioProject;
GO
SELECT * INTO nashvilleHousing
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
    'Excel 12.0; Database=C:\Users\lexxy\Downloads\Nashville Housing Data for Data Cleaning.csv', [Sheet1$]);
GO


select *
from NashvilleHousing
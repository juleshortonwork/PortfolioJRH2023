--///-- DATA CLEANING IN SQL & EXCEL


select *
from housing

--- Standardize Date Format
	--- one click already complete in xl
		--- SQL script =

select SaleDate, convert(Date,SaleDate)
from housing

Update housing
set SaleDate = convert(Date,SaleDate)

--- OR...

alter table housing
add SaleDateConverted Date

update housing
set SaleDateConverted = convert(Date,SaleDate)

--- Populate Property Address Data

select PropertyAddress
from housing

select *
from housing
where PropertyAddress is null
order by UniqueID

select *
from housing
where PropertyAddress is null
order by ParcelID

select *
from housing a
join housing b
	on a.ParcelID = b.ParcelID
	and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null or b.PropertyAddress is null

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
from housing a
join housing b
	on a.[ParcelID] = b.[ParcelID]
	and a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null or b.PropertyAddress is null

update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from housing a
join housing b
	on a.[ParcelID] = b.[ParcelID]
	and a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null

--- Separate Address into Individual Columns: Address, City, State

select PropertyAddress
from housing
order by UniqueID

select
substring(PropertyAddress, 1, charindex(',', PropertyAddress) -1) as PropertyAddr
, substring(PropertyAddress, charindex(',', PropertyAddress) + 1, len(PropertyAddress)) as PropCity
from housing

alter table housing
add PropertyAddr nvarchar(255);

update housing
set PropertyAddr = substring(PropertyAddress, 1, charindex(',', PropertyAddress) -1);

alter table housing
add PropCity varchar(255);

update housing
set PropCity = substring(PropertyAddress, charindex(',', PropertyAddress) + 1 , len(PropertyAddress));

select *
from housing

select OwnerAddress
from housing
--where OwnerAddress is null

select
parsename(replace(OwnerAddress, ',', '.'), 3) as OwnerAddr
,parsename(replace(OwnerAddress, ',', '.'), 2) as OwnerCity
,parsename(replace(OwnerAddress, ',', '.'), 1) as OwnerState
from housing 

alter table housing
add OwnerAddr nvarchar(255);

update housing
set OwnerAddr = parsename(replace(OwnerAddress, ',', '.'), 3);

alter table housing
add OwnerCity varchar(255);

update housing
set OwnerCity = parsename(replace(OwnerAddress, ',', '.'), 2) as;

alter table housing
add OwnerState varchar(255);

update housing
set OwnerState = parsename(replace(OwnerAddress, ',', '.'), 1);

--- Change Y and N to Yes and No in SoldasVacant column
	--- 3 click EASY to complete in xl
		--- SQL script =

select distinct(SoldAsVacant), count(SoldAsVacant)
from housing
group by SoldAsVacant
order by 2

select SoldAsVacant
, case when SoldAsVacant = 'Y' THEN 'Yes'
	   when SoldAsVacant = 'N' THEN 'No'
	   else SoldAsVacant
	   end
from housing

update housing
set SoldAsVacant = 
case 
	when SoldAsVacant = 'Y' THEN 'Yes'
	when SoldAsVacant = 'N' THEN 'No'
	else SoldAsVacant
	end

select distinct(SoldAsVacant), count(SoldAsVacant)
from housing
group by SoldAsVacant
order by 2

--- Remove Duplicates
	--- 3 click EASY to complete in xl
		--- SQL script =
--

select *,
	row_number() 
	over 
	(partition by 
	ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	order by UniqueID) row_num
from housing
order by ParcelID, row_num

with DupRowCTE as (
select *,
	row_number() 
	over 
	(partition by 
	ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	order by UniqueID) row_num
from housing)

select *
from DupRowCTE
where row_num > 1
order by PropertyAddr

with DupRowCTE as (
select *,
	row_number() 
	over 
	(partition by 
	ParcelID,
	PropertyAddress,
	SalePrice,
	SaleDate,
	LegalReference
	order by UniqueID) row_num
from housing)

delete
from DupRowCTE
where row_num > 1

--- Delete Unused Columns

select *
from housing

alter table housing
drop column PropertyAddress, OwnerAddress

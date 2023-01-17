alter table NashvilleHousing 
add SaleDateConverted Date;

update NashvilleHousing 
set SaleDateConverted = convert(date,SaleDate)

select SaleDateConverted
from NashvilleHousing
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
select a.ParcelID,a.PropertyAddress, b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) 
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID=b.ParcelID
and a.[UniqueID ] <>b.[UniqueID ]
where a.PropertyAddress is null


update a 
set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID=b.ParcelID
and a.[UniqueID ] <>b.[UniqueID ]
where a.PropertyAddress is null
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
select
SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress)) as Address
from NashvilleHousing



alter table NashvilleHousing 
add PropertySplitAdress nvarchar(255);

update NashvilleHousing 
set PropertySplitAdress =SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress) -1) 

alter table NashvilleHousing 
add PropertySplitCity nvarchar(255);

update NashvilleHousing 
set PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress))  

select PropertySplitAdress,PropertySplitCity
from NashvilleHousing


select OwnerAddress
from NashvilleHousing
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select 
PARSENAME(Replace(OwnerAddress,',','.') , 3),  
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
from NashvilleHousing



alter table NashvilleHousing 
add OwnerSplitAdress nvarchar(255);

update NashvilleHousing 
set OwnerSplitAdress =  PARSENAME(Replace(OwnerAddress,',','.') , 3)


alter table NashvilleHousing 
add OwnerSplitCity nvarchar(255);

update NashvilleHousing 
set OwnerSplitCity =  PARSENAME(Replace(OwnerAddress,',','.') , 2)


alter table NashvilleHousing 
add OwnerSplitState nvarchar(255);

update NashvilleHousing 
set OwnerSplitState =  PARSENAME(Replace(OwnerAddress,',','.') , 2)


select OwnerSplitAdress,OwnerSplitCity,OwnerSplitState
from NashvilleHousing
----------------------------------------------------------------------------------------------------------------------
select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant
,Case when SoldAsVacant  = 'Y' Then 'Yes'
	  when SoldAsVacant  = 'N' Then 'No'
	  else SoldAsVacant
	  END
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant =  
Case  when SoldAsVacant  = 'Y' Then 'Yes' -- y yi Yes e  n yi No ya çevirdik 
	  when SoldAsVacant  = 'N' Then 'No'
	  else SoldAsVacant
	  END
from NashvilleHousing


select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2
--------------------------------------------------------------------------------------------------------
with RowNumCTE as (
select *,
	ROW_NUMBER() over (
	Partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by
					UniqueID
					)row_num
from NashvilleHousing
)
select * 
 from RowNumCTE
 ---------------------------------------------------------------------------------------------------------------
select *
from NashvilleHousing

alter table nashvilleHousing
drop column
OwnerAddress,TaxDistrict,PropertyAddress,SaleDate
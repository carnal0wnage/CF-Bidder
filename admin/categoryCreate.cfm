<!--- Emaze Auction version 2.1 / Wednessday, July 21, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<!---
Create a new subcategory requires the previous categories to already exist.

If edit category: If changing category name:
If new category:
1. Get level they want to create a category at
2. Check that category name is not already being used at that level for the higher level categories
3. If already being used, choose new name
--->

<HTML>
<HEAD><TITLE>Emaze Auction: Category</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF Form.categoryImageUpload NEQ "">
		<CFFILE ACTION=Upload FILEFIELD="categoryImageUpload"
			DESTINATION="#systemPath#\images\"
			NAMECONFLICT="MakeUnique">
		<CFSET categoryImage = "#systemURL#/images/#File.ServerFile#">
	<CFELSE>
		<CFSET categoryImage = Form.categoryImageText>
	</CFIF>

	<CFIF Form.categoryLogoUpload NEQ "">
		<CFFILE ACTION=Upload FILEFIELD="categoryLogoUpload"
			DESTINATION="#systemPath#\images\"
			NAMECONFLICT="MakeUnique">
		<CFSET categoryLogo = "#systemURL#/images/#File.ServerFile#">
	<CFELSE>
		<CFSET categoryLogo = Form.categoryLogoText>
	</CFIF>

	<!--- Date/time when category is created --->
	<CFSET nowDateTime = CreateODBCDateTime(Now())>

	<CFIF ListGetAt(Form.catID,2) EQ 1 AND NOT IsDefined("Form.categoryID")>
		<!--- CREATE CATEGORY 1 --->
		<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
			SELECT categoryID
			FROM Category
			WHERE categoryName1 = '#Form.categoryName#'
		</CFQUERY>
		<CFIF checkNameUnique.RecordCount NEQ 0>
			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used as a primary category. 
			 Please choose another category name.</H3>
			<CFSET badCategoryName = 1>
		<CFELSE>
			<CFSET catName1 = Form.categoryName>
			<CFSET storeName = Form.categoryName>
			<!--- Insert category into database --->
			<CFQUERY NAME=createCategory DATASOURCE="#EAdatasource#">
				INSERT INTO Category (categoryName1, categoryDescription, categoryNameX,
					categoryName, categoryDateTimeCreated, categoryDateTimeLastEdited,
					categoryLotCount, categoryViewCount, templateFile, categoryImage, categoryLogo,
					categoryID1, categoryID2, categoryID3, categoryID4, categorySubLotCount,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>categoryMarketCount, categorySubMarketCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>categoryProcureCount, categorySubProcureCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>forumID, </CFIF>
					categoryType)
				VALUES ('#Form.categoryName#', <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
					'#Form.categoryName#', '#storeName#', #nowDateTime#, #nowDateTime#, 0, 0, '#Form.templateFile#',
					<CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#', </CFIF>
					<CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#', </CFIF>
					0, 0, 0, 0, 0,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>0, </CFIF>
					#Form.categoryType#)
			</CFQUERY>
			<CFQUERY NAME=getCategoryID DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryDateTimeCreated = #nowDateTime#
			</CFQUERY>
			<CFSET categoryID = getCategoryID.categoryID>
			<CFQUERY NAME=updateCategoryIDx DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryID1 = #categoryID#
				WHERE categoryID = #categoryID#
			</CFQUERY>
			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> created as a primary category.</H3>
		</CFIF>
	<CFELSEIF ListGetAt(Form.catID,2) EQ 2 AND NOT IsDefined("Form.categoryID")>
		<!--- CREATE CATEGORY 2 --->
		<CFQUERY NAME="getSubcategoryNames" DATASOURCE="#EAdatasource#">
			SELECT categoryName1, categoryID1
			FROM Category
			WHERE categoryID = #ListGetAt(Form.catID,1)#
		</CFQUERY>
		<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
			SELECT categoryID
			FROM Category
			WHERE categoryName1 = '#getSubcategoryNames.categoryName1#'
				AND categoryName2 = '#Form.categoryName#'
		</CFQUERY>
		<CFIF checkNameUnique.RecordCount NEQ 0>
			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used in the <CFOUTPUT><I>#getSubcategoryNames.categoryName1#</I></CFOUTPUT> category. 
			 Please choose another category name.</H3>
			<CFSET badCategoryName = 1>
		<CFELSE>
			<CFSET catName1 = getSubcategoryNames.categoryName1>
			<CFSET storeName = "#getSubcategoryNames.categoryName1##subCategorySeparator##Form.categoryName#">
			<!--- Insert category into database --->
			<CFQUERY NAME=createCategory DATASOURCE="#EAdatasource#">
				INSERT INTO Category (categoryName1, categoryName2, categoryDescription, categoryNameX, categoryName,
					categoryDateTimeCreated, categoryDateTimeLastEdited, categoryLotCount, categoryViewCount,
					templateFile, categoryImage, categoryLogo,
					categoryID1, categoryID2, categoryID3, categoryID4, categorySubLotCount,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>categoryMarketCount, categorySubMarketCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>categoryProcureCount, categorySubProcureCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>forumID, </CFIF>
					categoryType)
				VALUES ('#getSubcategoryNames.categoryName1#', '#Form.categoryName#', <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
					'#Form.categoryName#', '#storeName#',	#nowDateTime#, #nowDateTime#, 0, 0, '#Form.templateFile#',
					<CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#', </CFIF>
					<CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#', </CFIF>
					#getSubcategoryNames.categoryID1#, 0, 0, 0, 0,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>0, </CFIF>
					#Form.categoryType#)
			</CFQUERY>

			<CFQUERY NAME=getCategoryID DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryDateTimeCreated = #nowDateTime#
			</CFQUERY>
			<CFSET categoryID = getCategoryID.categoryID>
			<CFQUERY NAME=updateCategoryIDx DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryID2 = #categoryID#
				WHERE categoryID = #categoryID#
			</CFQUERY>

			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> created in<BR>
			<CFOUTPUT><I>#getSubcategoryNames.categoryName1#</I></CFOUTPUT>.</H3>
		</CFIF>
	<CFELSEIF ListGetAt(Form.catID,2) EQ 3 AND NOT IsDefined("Form.categoryID")>
		<!--- CREATE CATEGORY 3 --->
		<CFQUERY NAME="getSubcategoryNames" DATASOURCE="#EAdatasource#">
			SELECT categoryName1, categoryName2, categoryID1, categoryID2
			FROM Category
			WHERE categoryID = #ListGetAt(Form.catID,1)#
		</CFQUERY>
		<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
			SELECT categoryID
			FROM Category
			WHERE categoryName1 = '#getSubcategoryNames.categoryName1#'
				AND categoryName2 = '#getSubcategoryNames.categoryName2#'
				AND categoryName3 = '#Form.categoryName#'
		</CFQUERY>
		<CFIF checkNameUnique.RecordCount NEQ 0>
			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used in the <CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2#</I></CFOUTPUT> category. 
			 Please choose another category name.</H3>
			<CFSET badCategoryName = 1>
		<CFELSE>
			<CFSET catName1 = getSubcategoryNames.categoryName1>
			<CFSET storeName = "#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2##subCategorySeparator##Form.categoryName#">
			<!--- Insert category into database --->
			<CFQUERY NAME=createCategory DATASOURCE="#EAdatasource#">
				INSERT INTO Category (categoryName1, categoryName2, categoryName3, 
					categoryDescription, categoryNameX, categoryName, categoryDateTimeCreated,
					categoryDateTimeLastEdited, categoryLotCount, categoryViewCount, templateFile,
					categoryImage, categoryLogo,
					categoryID1, categoryID2, categoryID3, categoryID4, categorySubLotCount,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>categoryMarketCount, categorySubMarketCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>categoryProcureCount, categorySubProcureCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>forumID, </CFIF>
					categoryType)
				VALUES ('#getSubcategoryNames.categoryName1#',
					'#getSubcategoryNames.categoryName2#', '#Form.categoryName#', <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
					'#Form.categoryName#', '#storeName#', #nowDateTime#, #nowDateTime#, 0, 0, '#Form.templateFile#',
					<CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#', </CFIF>
					<CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#', </CFIF>
					#getSubcategoryNames.categoryID1#, #getSubcategoryNames.categoryID2#, 0, 0, 0,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>0, </CFIF>
					#Form.categoryType#)
			</CFQUERY>

			<CFQUERY NAME=getCategoryID DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryDateTimeCreated = #nowDateTime#
			</CFQUERY>
			<CFSET categoryID = getCategoryID.categoryID>
			<CFQUERY NAME=updateCategoryIDx DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryID3 = #categoryID#
				WHERE categoryID = #categoryID#
			</CFQUERY>

			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> created in<BR>
			<CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2#</I></CFOUTPUT>.</H3>
		</CFIF>
	<CFELSEIF ListGetAt(Form.catID,2) EQ 4 AND NOT IsDefined("Form.categoryID")>
		<!--- CREATE CATEGORY 4 --->
		<!---
		Get N1/N2/N3
		Ensure N4 name is unique for N1/N2/N3
		If unique, insert
		Else choose new category name
		--->
		<CFQUERY NAME="getSubcategoryNames" DATASOURCE="#EAdatasource#">
			SELECT categoryName1, categoryName2, categoryName3,
				categoryID1, categoryID2, categoryID3
			FROM Category
			WHERE categoryID = #ListGetAt(Form.catID,1)#
		</CFQUERY>
		<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
			SELECT categoryID
			FROM Category
			WHERE categoryName1 = '#getSubcategoryNames.categoryName1#'
				AND categoryName2 = '#getSubcategoryNames.categoryName2#'
				AND categoryName3 = '#getSubcategoryNames.categoryName3#'
				AND categoryName4 = '#Form.categoryName#'
		</CFQUERY>
		<CFIF checkNameUnique.RecordCount NEQ 0>
			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used in the <CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2##subCategorySeparator##getSubcategoryNames.categoryName3#</I></CFOUTPUT> category. 
			 Please choose another category name.</H3>
			<CFSET badCategoryName = 1>
		<CFELSE>
			<CFSET catName1 = getSubcategoryNames.categoryName1>
			<CFSET storeName = "#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2##subCategorySeparator##getSubcategoryNames.categoryName3##subCategorySeparator##Form.categoryName#">
			<!--- Insert category into database --->
			<CFQUERY NAME=createCategory DATASOURCE="#EAdatasource#">
				INSERT INTO Category (categoryName1, categoryName2,
					categoryName3, categoryName4, categoryDescription, categoryNameX, categoryName,
					categoryDateTimeCreated, categoryDateTimeLastEdited, categoryLotCount,
					categoryViewCount, templateFile, categoryImage, categoryLogo,
					categoryID1, categoryID2, categoryID3, categoryID4, categorySubLotCount,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>categoryMarketCount, categorySubMarketCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>categoryProcureCount, categorySubProcureCount, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>forumID, </CFIF>
					categoryType)
				VALUES ('#getSubcategoryNames.categoryName1#',
					'#getSubcategoryNames.categoryName2#', '#getSubcategoryNames.categoryName3#',
					'#Form.categoryName#', <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
					'#Form.categoryName#', '#storeName#', #nowDateTime#, #nowDateTime#, 0, 0, '#Form.templateFile#',
					<CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#', </CFIF>
					<CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#', </CFIF>
					#getSubcategoryNames.categoryID1#, #getSubcategoryNames.categoryID2#, #getSubcategoryNames.categoryID3#, 0, 0,
					<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>0, 0, </CFIF>
					<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>0, </CFIF>
					#Form.categoryType#)
			</CFQUERY>

			<CFQUERY NAME=getCategoryID DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryDateTimeCreated = #nowDateTime#
			</CFQUERY>
			<CFSET categoryID = getCategoryID.categoryID>
			<CFQUERY NAME=updateCategoryIDx DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryID4 = #categoryID#
				WHERE categoryID = #categoryID#
			</CFQUERY>

			<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> created in<BR>
			<CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2##subCategorySeparator##getSubcategoryNames.categoryName3#</I></CFOUTPUT>.</H3>
		</CFIF>
	<CFELSEIF ListGetAt(Form.catID,2) EQ 1><!--- AND IsDefined("Form.categoryID") --->
		<!--- EDIT CATEGORY 1 --->
		<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
			UPDATE Category
			SET categoryDescription = <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
				categoryImage = <CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#',</CFIF>
				categoryLogo = <CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#',</CFIF>
				templateFile = '#Form.templateFile#',
				categoryType = #Form.categoryType#
			WHERE categoryID = #Form.categoryID#
		</CFQUERY>
		<H3>Category information updated.</H3>

		<CFIF Form.oldCategoryName NEQ Form.categoryName>
			<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryID <> #Form.categoryID#
					AND categoryName1 = '#Form.categoryName#'
			</CFQUERY>
			<CFIF checkNameUnique.RecordCount EQ 0>
				<CFSET catName1 = Form.categoryName>
				<CFSET storeName = Form.categoryName>
				<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryName1 = '#Form.categoryName#'
					WHERE categoryID1 = #Form.categoryID#
				</CFQUERY>
				<CFQUERY NAME=updateCategoryName DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryName = '#storeName#',
						categoryName1 = '#Form.categoryName#',
						categoryNameX = '#Form.categoryName#'
					WHERE categoryID = #Form.categoryID#
				</CFQUERY>

				<CFQUERY NAME=getUpCat DATASOURCE="#EAdatasource#">
					SELECT categoryID, categoryName1, categoryName2, categoryName3, categoryName4,
						categoryID1, categoryID2, categoryID3, categoryID4
					FROM Category
					WHERE categoryID1 = #Form.categoryID#
						AND categoryID <> #Form.categoryID#
				</CFQUERY>
				<CFLOOP QUERY=getUpCat>
					<CFIF getUpCat.categoryID4 NEQ 0>
						<CFSET storeName2 = "#getUpCat.categoryName2##subCategorySeparator##getUpCat.categoryName3##subCategorySeparator##getUpCat.categoryName4#">
						<CFSET categoryNameX = getUpCat.categoryName4>
					<CFELSEIF getUpCat.categoryName3 NEQ 0>
						<CFSET storeName2 = "#getUpCat.categoryName2##subCategorySeparator##getUpCat.categoryName3#">
						<CFSET categoryNameX = getUpCat.categoryName3>
					<CFELSE>
						<CFSET storeName2 = getUpCat.categoryName2>
						<CFSET categoryNameX = getUpCat.categoryName2>
					</CFIF>
					<CFQUERY NAME=updateCategoryName DATASOURCE="#EAdatasource#">
						UPDATE Category
						SET categoryName = '#storeName##subCategorySeparator##storeName2#',
							categoryName1 = '#Form.categoryName#'
						WHERE categoryID = #getUpCat.categoryID#
					</CFQUERY>
					<CFFILE ACTION=Append FILE="#systemPath#\category\#getUpCat.categoryID#CategoryInfo.cfm"
						OUTPUT="<CFSET categoryName1 = ""#Form.categoryName#"">
<CFSET categoryName = ""#storeName##subCategorySeparator##storeName2#"">">
				</CFLOOP>

				<H3>Category <CFOUTPUT><I>#Form.oldCategoryName#</I> updated to <I>#Form.categoryName#</I></CFOUTPUT> as a primary category.</H3>
			<CFELSE>
				<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used as a primary category. Please choose another name.</H3>
				<CFINCLUDE TEMPLATE="../program/copyright.cfm">
				</BODY></HTML><CFABORT>
			</CFIF>
		</CFIF>
 	<CFELSEIF ListGetAt(Form.catID,2) EQ 2><!--- AND IsDefined("Form.categoryID") --->
		<!--- EDIT CATEGORY 2 --->
		<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
			UPDATE Category
			SET categoryDescription = <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
				categoryImage = <CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#',</CFIF>
				categoryLogo = <CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#',</CFIF>
				templateFile = '#Form.templateFile#',
				categoryType = #Form.categoryType#
			WHERE categoryID = #Form.categoryID#
		</CFQUERY>
		<H3>Category information updated.</H3>

		<CFIF Form.oldCategoryName NEQ Form.categoryName>
			<CFQUERY NAME="getSubcategoryNames" DATASOURCE="#EAdatasource#">
				SELECT categoryName1, categoryID1
				FROM Category
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryID <> #Form.categoryID#
					AND categoryName1 = '#getSubcategoryNames.categoryName1#'
					AND categoryName2 = '#Form.categoryName#'
			</CFQUERY>
			<CFIF checkNameUnique.RecordCount EQ 0>
				<CFSET catName1 = getSubcategoryNames.categoryName1>
				<CFSET storeName = "#getSubcategoryNames.categoryName1##subCategorySeparator##Form.categoryName#">
				<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryName2 = '#Form.categoryName#'
					WHERE categoryID1 = #getSubcategoryNames.categoryID1#
						AND categoryID2 = #Form.categoryID#
				</CFQUERY>
				<CFQUERY NAME=updateCategoryName DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryName = '#storeName#',
						categoryNameX = '#Form.categoryName#'
					WHERE categoryID = #Form.categoryID#
				</CFQUERY>

				<CFQUERY NAME=getUpCat DATASOURCE="#EAdatasource#">
					SELECT categoryID, categoryName1, categoryName2, categoryName3, categoryName4,
						categoryID1, categoryID2, categoryID3, categoryID4
					FROM Category
					WHERE categoryName1 = '#getSubcategoryNames.categoryName1#'
						AND categoryName2 = '#Form.categoryName#'
						AND categoryID <> #Form.categoryID#
				</CFQUERY>
				<CFLOOP QUERY=getUpCat>
					<CFIF getUpCat.categoryID4 NEQ 0>
						<CFSET storeName2 = "#getUpCat.categoryName3##subCategorySeparator##getUpCat.categoryName4#">
						<CFSET categoryNameX = getUpCat.categoryName4>
					<CFELSE>
						<CFSET storeName2 = getUpCat.categoryName3>
						<CFSET categoryNameX = getUpCat.categoryName3>
					</CFIF>
					<CFQUERY NAME=updateCategoryName DATASOURCE="#EAdatasource#">
						UPDATE Category
						SET categoryName = '#storeName##subCategorySeparator##storeName2#',
							categoryName2 = '#Form.categoryName#'
						WHERE categoryID = #getUpCat.categoryID#
					</CFQUERY>
					<CFFILE ACTION=Append FILE="#systemPath#\category\#getUpCat.categoryID#CategoryInfo.cfm"
						OUTPUT="<CFSET categoryName2 = ""#Form.categoryName#"">
<CFSET categoryName = ""#storeName##subCategorySeparator##storeName2#"">">
				</CFLOOP>

				<H3>Category <CFOUTPUT><I>#Form.oldCategoryName#</I> updated to <I>#Form.categoryName#</I></CFOUTPUT> in <CFOUTPUT><I>#getSubcategoryNames.categoryName1#</I>.</CFOUTPUT>.</H3>
			<CFELSE>
				<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used in <CFOUTPUT><I>#getSubcategoryNames.categoryName1#</I> Please choose another name.</CFOUTPUT>.</H3>
				<CFINCLUDE TEMPLATE="../program/copyright.cfm">
				</BODY></HTML><CFABORT>
			</CFIF>
		</CFIF>
	<CFELSEIF ListGetAt(Form.catID,2) EQ 3><!--- AND IsDefined("Form.categoryID") --->
		<!--- EDIT CATEGORY 3 --->
		<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
			UPDATE Category
			SET categoryDescription = <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
				categoryImage = <CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#',</CFIF>
				categoryLogo = <CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#',</CFIF>
				templateFile = '#Form.templateFile#',
				categoryType = #Form.categoryType#
			WHERE categoryID = #Form.categoryID#
		</CFQUERY>
		<H3>Category information updated.</H3>

		<CFIF Form.oldCategoryName NEQ Form.categoryName>
			<CFQUERY NAME="getSubcategoryNames" DATASOURCE="#EAdatasource#">
				SELECT categoryName1, categoryName2, categoryID1, categoryID2
				FROM Category
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryID <> #Form.categoryID#
					AND categoryName1 = '#getSubcategoryNames.categoryName1#'
					AND categoryName2 = '#getSubcategoryNames.categoryName2#'
					AND categoryName3 = '#Form.categoryName#'
			</CFQUERY>
			<CFIF checkNameUnique.RecordCount EQ 0>
				<CFSET catName1 = getSubcategoryNames.categoryName1>
				<CFSET storeName = "#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2##subCategorySeparator##Form.categoryName#">
				<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryName3 = '#Form.categoryName#'
					WHERE categoryID1 = #getSubcategoryNames.categoryID1#
						AND categoryID2 = #getSubcategoryNames.categoryID2#
						AND categoryID3 = #Form.categoryID#
				</CFQUERY>
				<CFQUERY NAME=updateCategoryName DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryName = '#storeName#',
						categoryNameX = '#Form.categoryName#'
					WHERE categoryID = #Form.categoryID#
				</CFQUERY>

				<CFQUERY NAME=getUpCat DATASOURCE="#EAdatasource#">
					SELECT categoryID, categoryName1, categoryName2, categoryName3, categoryName4,
						categoryID1, categoryID2, categoryID3, categoryID4
					FROM Category
					WHERE categoryName1 = '#getSubcategoryNames.categoryName1#'
						AND categoryName2 = '#getSubcategoryNames.categoryName2#'
						AND categoryName3 = '#Form.categoryName#'
						AND categoryID <> #Form.categoryID#
				</CFQUERY>
				<CFLOOP QUERY=getUpCat>
					<CFQUERY NAME=updateCategoryName DATASOURCE="#EAdatasource#">
						UPDATE Category
						SET categoryName = '#storeName##subCategorySeparator##getUpCat.categoryName4#'
						WHERE categoryID = #getUpCat.categoryID#
					</CFQUERY>
					<CFFILE ACTION=Append FILE="#systemPath#\category\#getUpCat.categoryID#CategoryInfo.cfm"
						OUTPUT="<CFSET categoryName3 = ""#Form.categoryName#"">
<CFSET categoryName = ""#storeName##subCategorySeparator##getUpCat.categoryName4#"">">
				</CFLOOP>

				<H3>Category <CFOUTPUT><I>#Form.oldCategoryName#</I> updated to <I>#Form.categoryName#</I></CFOUTPUT> in <CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator#
				 #getSubcategoryNames.categoryName2#</I></CFOUTPUT>.</H3>
			<CFELSE>
				<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used in <CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator#
				 #getSubcategoryNames.categoryName2#</I> Please choose another name.</CFOUTPUT>.</H3>
				<CFINCLUDE TEMPLATE="../program/copyright.cfm">
				</BODY></HTML>
				<CFABORT>
			</CFIF>
		</CFIF>
	<CFELSE><!--- #ListGetAt(Form.catID,2)# EQ 4  AND IsDefined("Form.oldCategoryName") --->
		<!--- EDIT CATEGORY 4 --->
		<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
			UPDATE Category
			SET categoryDescription = <CFIF Form.categoryDescription EQ "">NULL, <CFELSE>'#Form.categoryDescription#',</CFIF>
				categoryImage = <CFIF categoryImage EQ "">NULL, <CFELSE>'#categoryImage#',</CFIF>
				categoryLogo = <CFIF categoryLogo EQ "">NULL, <CFELSE>'#categoryLogo#',</CFIF>
				templateFile = '#Form.templateFile#',
				categoryType = #Form.categoryType#
			WHERE categoryID = #Form.categoryID#
		</CFQUERY>
		<H3>Category information updated.</H3>

		<CFIF Form.oldCategoryName NEQ Form.categoryName>
			<CFQUERY NAME="getSubcategoryNames" DATASOURCE="#EAdatasource#">
				SELECT categoryName1, categoryName2, categoryName3
				FROM Category
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME="checkNameUnique" DATASOURCE="#EAdatasource#">
				SELECT categoryID
				FROM Category
				WHERE categoryID <> #Form.categoryID#
					AND categoryName1 = '#getSubcategoryNames.categoryName1#'
					AND categoryName2 = '#getSubcategoryNames.categoryName2#'
					AND categoryName3 = '#getSubcategoryNames.categoryName3#'
					AND categoryName4 = '#Form.categoryName#'
			</CFQUERY>
			<CFIF #checkNameUnique.RecordCount# EQ 0>
				<CFSET catName1 = getSubcategoryNames.categoryName1>
				<CFSET storeName = "#getSubcategoryNames.categoryName1##subCategorySeparator##getSubcategoryNames.categoryName2##subCategorySeparator##getSubcategoryNames.categoryName3##subCategorySeparator##Form.categoryName#">
				<CFQUERY NAME=updateCategory DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryName4 = '#Form.categoryName#',
						categoryName = '#storeName#',
						categoryNameX = '#Form.categoryName#'
					WHERE categoryID = #Form.categoryID#
				</CFQUERY>
				<H3>Category <CFOUTPUT><I>#Form.oldCategoryName#</I> updated to <I>#Form.categoryName#</I></CFOUTPUT> in <CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator#
				 #getSubcategoryNames.categoryName2##subCategorySeparator##getSubcategoryNames.categoryName3#</I></CFOUTPUT>.</H3>
			<CFELSE>
				<H3>Category <CFOUTPUT><I>#Form.categoryName#</I></CFOUTPUT> is already being used in <CFOUTPUT><I>#getSubcategoryNames.categoryName1##subCategorySeparator#
				 #getSubcategoryNames.categoryName2##subCategorySeparator##getSubcategoryNames.categoryName3#</I> Please choose another name.</CFOUTPUT>.</H3>
				<CFINCLUDE TEMPLATE="../program/copyright.cfm">
				</BODY></HTML><CFABORT>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF NOT IsDefined("badCategoryName")>
		<CFQUERY NAME=getCategoryInfo DATASOURCE="#EAdatasource#">
			SELECT categoryName, categoryName1, categoryName2, categoryName3, categoryName4,
				categoryID, categoryID1, categoryID2, categoryID3, categoryID4,
				templateFile, categoryImage, categoryLogo, categoryNameX, categoryType
			FROM Category
			WHERE categoryID = #categoryID#
		</CFQUERY>

		<CFFILE ACTION=Write FILE="#systemPath#\category\#categoryID#CategoryInfo.cfm"
			OUTPUT="<CFSET categoryName1 = ""#getCategoryInfo.categoryName1#"">
<CFSET categoryName2 = ""#getCategoryInfo.categoryName2#"">
<CFSET categoryName3 = ""#getCategoryInfo.categoryName3#"">
<CFSET categoryName4 = ""#getCategoryInfo.categoryName4#"">
<CFSET categoryNameX = ""#getCategoryInfo.categoryNameX#"">
<CFSET categoryName = ""#getCategoryInfo.categoryName#"">
<CFSET categoryID1 = #getCategoryInfo.categoryID1#>
<CFSET categoryID2 = #getCategoryInfo.categoryID2#>
<CFSET categoryID3 = #getCategoryInfo.categoryID3#>
<CFSET categoryID4 = #getCategoryInfo.categoryID4#>
<CFSET templateFile = ""#getCategoryInfo.templateFile#"">
<CFSET categoryImage = ""#getCategoryInfo.categoryImage#"">
<CFSET categoryLogo = ""#getCategoryInfo.categoryLogo#"">
<CFSET categoryType = #getCategoryInfo.categoryType#>
<CFSET forumID = 0>">

		<CFIF #Form.categoryHeader# EQ "">
			<CFFILE ACTION=Write FILE="#systemPath#\category\#categoryID#CategoryHeader.cfm" OUTPUT=" ">
		<CFELSE>
			<CFSET categoryHeader = Replace(Form.categoryHeader, "
	", "", "ALL")>
			<CFFILE ACTION=Write FILE="#systemPath#\category\#categoryID#CategoryHeader.cfm" OUTPUT="#categoryHeader#">
		</CFIF>

		<CFIF #Form.categoryFooter# EQ "">
			<CFFILE ACTION=Write FILE="#systemPath#\category\#categoryID#CategoryFooter.cfm" OUTPUT=" ">
		<CFELSE>
			<CFSET categoryFooter = Replace(Form.categoryFooter, "
	", "", "ALL")>
			<CFFILE ACTION=Write FILE="#systemPath#\category\#categoryID#CategoryFooter.cfm" OUTPUT="#categoryFooter#">
		</CFIF>

		<CFIF #Form.categorySpecial# EQ "">
			<CFFILE ACTION=Write FILE="#systemPath#\category\#categoryID#CategorySpecial.cfm" OUTPUT=" ">
		<CFELSE>
			<CFSET categorySpecial = Replace(Form.categorySpecial, "
	", "", "ALL")>
			<CFFILE ACTION=Write FILE="#systemPath#\category\#categoryID#CategorySpecial.cfm" OUTPUT="#categorySpecial#">
		</CFIF>

		<HR NOSHADE ALIGN=left SIZE=3 WIDTH=400>
		<CFIF IsDefined("Form.categoryID")>
			<CFINCLUDE TEMPLATE="categoryHome.cfm">
			<CFABORT>
		<CFELSE>
			<CFSET newCategory = 1>
		</CFIF>
	</CFIF>
</CFIF>

<CFFORM ACTION=categoryCreate.cfm ENCTYPE="multipart/form-data" NAME=categoryCreate>
<INPUT TYPE=hidden NAME=first VALUE=0>

<CFIF NOT IsDefined("categoryID") OR IsDefined("newCategory")>
	<FONT COLOR=purple SIZE=6><B>New Category</B></FONT><P>
<CFELSE>
	<FONT COLOR=purple SIZE=6><B>Edit Category - <CFOUTPUT>#categoryID#</CFOUTPUT></B></FONT><P>

	<CFQUERY NAME=getCategory DATASOURCE="#EAdatasource#">
		SELECT categoryName1, categoryName2, categoryName3, categoryName4,
			categoryID1, categoryID2, categoryID3, categoryID4, categoryNameX,
			categoryDescription, templateFile, categoryImage, categoryLogo,
			categoryType
		FROM Category
		WHERE categoryID = #categoryID#
	</CFQUERY>

	<CFIF getCategory.categoryID2 EQ 0>
		<CFSET categoryName = getCategory.categoryName1>
	<CFELSEIF getCategory.categoryID3 EQ 0>
		<CFSET categoryName = getCategory.categoryName2>
	<CFELSEIF getCategory.categoryID4 EQ 0>
		<CFSET categoryName = getCategory.categoryName3>
	<CFELSE>
		<CFSET categoryName = getCategory.categoryName4>
	</CFIF>

	<CFOUTPUT>
		<INPUT TYPE=hidden NAME=categoryID VALUE=#categoryID#>
		<INPUT TYPE=hidden NAME=oldCategoryName VALUE="#getCategory.categoryNameX#">
	</CFOUTPUT>
</CFIF>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD ALIGN=right>Name: </TD><TD>
<CFIF IsDefined("getCategory") EQ "True"><CFSET categoryName = getCategory.categoryNameX>
<CFELSEIF NOT IsDefined("Form.categoryName") OR IsDefined("newCategory")><CFSET categoryName = ""></CFIF>
<CFINPUT TYPE=text NAME=categoryName SIZE=30 MAXLENGTH=50 VALUE="#categoryName#" REQUIRED="Yes" MESSAGE="Category name cannot be blank."></TD></TR>

<TR><TD ALIGN=right>Subcategory: </TD><TD>
<!--- <CFIF IsDefined("getCategory") OR (IsDefined("Form.catID") AND NOT IsDefined("newCategory"))> --->
<CFIF IsDefined("categoryID") AND NOT IsDefined("newCategory")>
	<CFIF NOT IsDefined("getCategory")>
		<CFQUERY NAME="getCategory" DATASOURCE="#EAdatasource#">
			SELECT categoryID, categoryName1, categoryName2, categoryName3,
				categoryID1, categoryID2, categoryID3
			FROM Category
			WHERE categoryID = #ListFirst(Form.catID)#
		</CFQUERY>
	</CFIF>

	<CFOUTPUT QUERY="getCategory">
		<CFIF categoryID2 EQ 0>(primary category)
			<INPUT TYPE=hidden NAME=catID VALUE="0,1">
		<CFELSEIF categoryID3 EQ 0>#categoryName1#
			<INPUT TYPE=hidden NAME=catID VALUE="0,2">
		<CFELSEIF categoryID4 EQ 0>#categoryName1##subCategorySeparator##categoryName2#
			<INPUT TYPE=hidden NAME=catID VALUE="0,3">
		<CFELSE>#categoryName1##subCategorySeparator##categoryName2##subCategorySeparator##categoryName3#
			<INPUT TYPE=hidden NAME=catID VALUE="0,4">
		</CFIF>
	</CFOUTPUT>
<CFELSE>
	<CFQUERY NAME="getCategories" DATASOURCE="#EAdatasource#">
		SELECT categoryID, categoryName1, categoryName2, categoryName3, categoryName4,
			categoryID2, categoryID3, categoryID4
		FROM Category
		ORDER BY categoryName1, categoryName2, categoryName3, categoryName4
	</CFQUERY>

	<SELECT NAME=catID SIZE=1>
	<CFIF IsDefined("Form.catID") AND NOT IsDefined("newCategory")>
		<OPTION VALUE="0,1"<CFIF ListFirst(Form.catID) EQ 0> SELECTED</CFIF>>NEW (SEPARATE) CATEGORY
		<CFOUTPUT QUERY="getCategories">
			<CFIF getCategories.categoryID2 EQ 0>
				<OPTION VALUE="#getCategories.categoryID#,2"<CFIF ListFirst(Form.catID) EQ #getCategories.categoryID#> SELECTED</CFIF>>#getCategories.categoryName1#
			<CFELSEIF getCategories.categoryID3 EQ 0>
				<OPTION VALUE="#getCategories.categoryID#,3"<CFIF ListFirst(Form.catID) EQ #getCategories.categoryID#> SELECTED</CFIF>>#getCategories.categoryName1##subCategorySeparator##getCategories.categoryName2#
			<CFELSEIF getCategories.categoryID4 EQ 0>
				<OPTION VALUE="#getCategories.categoryID#,4"<CFIF ListFirst(Form.catID) EQ #getCategories.categoryID#> SELECTED</CFIF>>#getCategories.categoryName1##subCategorySeparator##getCategories.categoryName2##subCategorySeparator##getCategories.categoryName3#
			</CFIF>
		</CFOUTPUT>
	<CFELSE>
		<OPTION VALUE="0,1">NEW (SEPARATE) CATEGORY
		<CFOUTPUT QUERY="getCategories">
			<CFIF getCategories.categoryID2 EQ 0>
				<OPTION VALUE="#getCategories.categoryID#,2">#getCategories.categoryName1#
			<CFELSEIF getCategories.categoryID3 EQ 0>
				<OPTION VALUE="#getCategories.categoryID#,3">#getCategories.categoryName1##subCategorySeparator##getCategories.categoryName2#
			<CFELSEIF getCategories.categoryID4 EQ 0>
				<OPTION VALUE="#getCategories.categoryID#,4">#getCategories.categoryName1##subCategorySeparator##getCategories.categoryName2##subCategorySeparator##getCategories.categoryName3#
			</CFIF>
		</CFOUTPUT>
	</CFIF>
</CFIF>
</SELECT></TD></TR>

<CFIF IsDefined("getCategory") AND NOT IsDefined("Form.categoryType")><CFSET categoryType = getCategory.categoryType>
<CFELSEIF NOT IsDefined("categoryType") OR IsDefined("newCategory")><CFSET categoryType = 2></CFIF>
<TR><TD ALIGN=right>Type: </TD><TD>
<!---
<INPUT TYPE=radio NAME=categoryType VALUE=1<CFIF categoryType EQ 1> CHECKED</CFIF>> Auction<BR>
<INPUT TYPE=radio NAME=categoryType VALUE="-1"<CFIF categoryType EQ -1> CHECKED</CFIF>> Procurement (reverse)<BR>
<INPUT TYPE=radio NAME=categoryType VALUE=0<CFIF categoryType EQ 0> CHECKED</CFIF>> Classified (market)<BR>
<INPUT TYPE=radio NAME=categoryType VALUE=2<CFIF categoryType EQ 2> CHECKED</CFIF>> All
<INPUT TYPE=radio NAME=categoryType VALUE=3<CFIF categoryType EQ 3> CHECKED</CFIF>> Auction / Procurement<BR>
<INPUT TYPE=radio NAME=categoryType VALUE=4<CFIF categoryType EQ 4> CHECKED</CFIF>> Auction / Classified<BR>
<INPUT TYPE=radio NAME=categoryType VALUE=5<CFIF categoryType EQ 5> CHECKED</CFIF>> Procurement / Classified<BR>
--->
<SELECT NAME=categoryType SIZE=1>
	<OPTION VALUE=1<CFIF categoryType EQ 1> SELECTED</CFIF>> Auction
	<OPTION VALUE="-1"<CFIF categoryType EQ -1> SELECTED</CFIF>> Procurement (reverse)
	<OPTION VALUE=0<CFIF categoryType EQ 0> SELECTED</CFIF>> Classified
	<OPTION VALUE=2<CFIF categoryType EQ 2> SELECTED</CFIF>> All
	<OPTION VALUE=3<CFIF categoryType EQ 3> SELECTED</CFIF>> Auction / Procurement
	<OPTION VALUE=4<CFIF categoryType EQ 4> SELECTED</CFIF>> Auction / Classified
	<OPTION VALUE=5<CFIF categoryType EQ 5> SELECTED</CFIF>> Procurement / Classified
</SELECT>
</TD></TR>

<CFIF IsDefined("getCategory") AND NOT IsDefined("Form.catID")><CFSET categoryImage = getCategory.categoryImage>
<CFELSEIF NOT IsDefined("categoryImage") OR IsDefined("newCategory")><CFSET categoryImage = ""></CFIF>
<TR><TD ALIGN=right VALIGN=top>Button Image: </TD><TD>&nbsp;<FONT SIZE=2 COLOR=blue>File: </FONT><INPUT TYPE=file NAME=categoryImageUpload SIZE=40><BR>
<FONT SIZE=2 COLOR=blue>URL: </FONT><CFINPUT TYPE=text NAME=categoryImageText SIZE=54 VALUE="#categoryImage#"></TD></TR>

<CFIF IsDefined("getCategory") AND NOT IsDefined("Form.catID")><CFSET categoryLogo = getCategory.categoryLogo>
<CFELSEIF NOT IsDefined("categoryLogo") OR IsDefined("newCategory")><CFSET categoryLogo = ""></CFIF>
<TR><TD ALIGN=right VALIGN=top>Page Logo: </TD><TD>&nbsp;<FONT SIZE=2 COLOR=blue>File: </FONT><INPUT TYPE=file NAME=categoryLogoUpload SIZE=40><BR>
<FONT SIZE=2 COLOR=blue>URL: </FONT><CFINPUT TYPE=text NAME=categoryLogoText SIZE=54 VALUE="#categoryLogo#"></TD></TR>

<CFQUERY NAME=getTemplates DATASOURCE="#EAdatasource#">
	SELECT templateName, templateFile
	FROM Template
	WHERE templateType = 'category'
	ORDER BY templateName
</CFQUERY>
<TR><TD ALIGN=right>Template: </TD>
<TD><SELECT NAME=templateFile SIZE=1>
<CFIF IsDefined("getCategory") AND NOT IsDefined("Form.catID")>
	<CFOUTPUT QUERY=getTemplates>
		<CFIF getCategory.templateFile EQ getTemplates.templateFile>
			<OPTION SELECTED VALUE="#getTemplates.templateFile#">#getTemplates.templateName#
		<CFELSE>
			<OPTION VALUE="#getTemplates.templateFile#">#getTemplates.templateName#
		</CFIF>
	</CFOUTPUT>
<CFELSE>
	<CFOUTPUT QUERY=getTemplates><OPTION VALUE=#templateFile#>#templateName#</CFOUTPUT>
</CFIF>
</SELECT></TD></TR>

<CFIF IsDefined("getCategory") AND NOT IsDefined("Form.catID")><CFSET categoryDescription = RTrim(getCategory.categoryDescription)>
<CFELSEIF NOT IsDefined("Form.categoryDescription") OR IsDefined("newCategory")><CFSET categoryDescription = ""></CFIF>
<TR><TD ALIGN=right VALIGN=top>Description: </TD>
<TD><TEXTAREA NAME=categoryDescription ROWS=2 COLS=55 WRAP=virtual><CFOUTPUT>#categoryDescription#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD ALIGN=right VALIGN=top>Header: </TD>
<CFIF IsDefined("categoryID") AND NOT IsDefined("newCategory")>
	<CFFILE ACTION=Read FILE="#systemPath#\category\#categoryID#CategoryHeader.cfm" VARIABLE="categoryHeader">
	<CFSET categoryHeader = RTrim(categoryHeader)>
	<TD><TEXTAREA NAME=categoryHeader ROWS=5 COLS=55 WRAP=virtual><CFOUTPUT>#categoryHeader#</CFOUTPUT></TEXTAREA></TD></TR>
<CFELSE>
	<TD><TEXTAREA NAME=categoryHeader ROWS=5 COLS=55 WRAP=virtual></TEXTAREA></TD></TR>
</CFIF>
<TR><TD ALIGN=right VALIGN=top>Footer: </TD>
<CFIF IsDefined("categoryID") AND NOT IsDefined("newCategory")>
	<CFFILE ACTION=Read FILE="#systemPath#\category\#categoryID#CategoryFooter.cfm" VARIABLE="categoryFooter">
	<CFSET categoryFooter = RTrim(categoryFooter)>
	<TD><TEXTAREA NAME=categoryFooter ROWS=5 COLS=55 WRAP=virtual><CFOUTPUT>#categoryFooter#</CFOUTPUT></TEXTAREA></TD></TR>
<CFELSE>
	<TD><TEXTAREA NAME=categoryFooter ROWS=5 COLS=55 WRAP=virtual></TEXTAREA></TD></TR>
</CFIF>
<TR><TD ALIGN=right VALIGN=top>Special: </TD>
<CFIF IsDefined("categoryID") AND NOT IsDefined("newCategory")>
	<CFFILE ACTION=Read FILE="#systemPath#\category\#categoryID#categorySpecial.cfm" VARIABLE="categorySpecial">
	<CFSET categorySpecial = RTrim(categorySpecial)>
	<TD><TEXTAREA NAME=categorySpecial ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#categorySpecial#</CFOUTPUT></TEXTAREA></TD></TR>
<CFELSE>
	<TD><TEXTAREA NAME=categorySpecial ROWS=3 COLS=55 WRAP=virtual></TEXTAREA></TD></TR>
</CFIF>
<TR><TD></TD><TD HEIGHT=40><INPUT TYPE=reset VALUE=Clear> 
<CFIF IsDefined("categoryID") AND NOT IsDefined("newCategory")><INPUT TYPE=submit VALUE="Edit Category">
<CFELSE><INPUT TYPE=submit VALUE="Create Category"></CFIF>
</TD></TR>
</TABLE>

</CFFORM>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>
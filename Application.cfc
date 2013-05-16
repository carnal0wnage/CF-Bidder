<cfcomponent output="false">
	<!--- application variables --->
	<cfset this.name = "CF-Bidder">
	<cfset this.applicationTimeout = createTimeSpan(1,0,0,0)>
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,9,0,0)>
	<cfset this.setClientCookies = true>
	<cfset this.mappings["/auction"] = getDirectoryFromPath(getCurrentTemplatePath())>
	<cfscript>
/**
* Determines the root path of the application without hard-coding.
*
* @return Returns a string.
* @author Billy Cravens (billy@architechx.com)
* @version 1, October 3, 2002
*/
function GetRootPath() {
    var cNested = listLen(getBaseTemplatePath(),"\") - listLen(getCurrentTemplatePath(),"\");
    var    appRootDir = cgi.script_name;
    var i = 0;
    
    for (i=0;i lte cNested;i=incrementValue(i)) {
        appRootDir = listDeleteAt(appRootDir,listLen(appRootDir, "/"),"/");
    }
    appRootDir = appRootDir & "/";
    return appRootDir;
}
</cfscript>
	

	<!--- methods --->
	<cffunction name="onApplicationStart" access="public" returntype="boolean" output="false">
		<!--- get application settings from settings.ini file --->
		<cfif findNoCase("admin",getCurrentTemplatePath())>
			<cfset iniFile = expandPath("../settings.ini")>
		<cfelse>
			<cfset iniFile = expandPath("./settings.ini")>
		</cfif>
		<cfset sections = getProfileSections(iniFile)>
		<cfset data = structNew()>
		<cfif structKeyExists(sections, "default")>
		  <cfloop index="key" list="#sections.default#">
		     <cfset data[key] = getProfileString(iniFile, "default", key)>
		  </cfloop>
		  <cfset application.settings = data>
		<cfelse>
		  <cfthrow message="Ini file has a missing default section!">
		</cfif>
		<!--- get status of auction --->
		<cfquery name="qryStatus" datasource="#application.settings.dsn#">
			select mst_status, mst_close_time, mst_open_time from Master
			where mst_no = 1
		</cfquery>
		<cfset application.status = qryStatus.mst_status>
		<cfset application.close_time = qryStatus.mst_close_time>
		<cfset application.open_time = qryStatus.mst_open_time>
		<!--- other application variables --->
		<cfset application.root = GetRootPath()>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction name="onSessionStart" access="public" returntype="void" output="false">
		<cfif listFirst(server.coldfusion.productversion) lt 8>
			<p>Simple Silent Auction requires ColdFusion version 8 or higher</p>
			<cfabort>
		</cfif>
		<cfset session.level = "user">
	</cffunction>
	
	
	<cffunction name="onRequestStart" access="public" returnType="boolean" output="false">
	    <cfargument type="String" name="targetPage" required="true">
		<cfif structKeyExists(url,"init")>
			<cfset onApplicationStart()>
			<cfset onSessionStart()>
		</cfif>
		
	    <cfreturn true>
	</cffunction>
	
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		<cfset var errorcontent = "">
	    <cfif Find("coldfusion.filter.FormValidationException", Arguments.Exception.StackTrace)>
	        <cfthrow object="#exception#">
	    <cfelse>
			<cfsavecontent variable="errorcontent">
			<cfoutput>
				An error has been encountered at http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br>
				Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#<br>
				<cfdump var="#arguments.exception#" label="Error">
				<cfdump var="#form#" label="Form">
				<cfdump var="#url#" label="URL">
			</cfoutput>
			</cfsavecontent>
			
			<cfmail to="#application.settings.email#" from="#application.settings.email#" subject="ERROR in Simple Silent Auction" type="html">
				#errorcontent#
			</cfmail>
		</cfif>
        
		<cflocation url="error.html" addToken="no">
	</cffunction>


</cfcomponent>

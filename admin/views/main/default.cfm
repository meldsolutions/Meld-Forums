<cfsilent>
	<!--- headers --->
	<cfoutput>
	</cfoutput>
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<br />
<div>
	<!-- CONTENT HERE -->
	<div class="row">
		<div class="span4">
			<cfinclude template="includes/dsp_dashboard_posts.cfm" />
		</div>
		<div class="span4">
			<cfinclude template="includes/dsp_dashboard_users.cfm" />
		</div>
		<div class="span4">
			<cfinclude template="includes/dsp_dashboard_counts.cfm" />
		</div>
	</div>
		<!--- 
		<div class="col wide-left">
			
		</div>
		<div class="col wide-right">
			
		</div>
		<div class="col full">
			
		</div>
			 --->
	</div>
</div>	
<!--- end content --->
</cfoutput> 
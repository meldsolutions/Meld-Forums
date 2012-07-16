<cfsilent>
	<!--- headers --->
	<cfoutput>
	</cfoutput>
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<br />
<div id="meld-body">
	<!-- CONTENT HERE -->
	<div class="mf-dashboard-columns clearfix">
		<div class="col left">
			<cfinclude template="includes/dsp_dashboard_posts.cfm" />
		</div>
		<div class="col mid">
			<cfinclude template="includes/dsp_dashboard_users.cfm" />
		</div>
		<div class="col right">
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
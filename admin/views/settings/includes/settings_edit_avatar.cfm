<cfimport prefix="ui" taglib="../../../ui" />
<cfparam name="form.settingsbean_resetavatar" default="0" />
<cfoutput>
	
	<div id="msTabs-Avatar-Tab" class="tab-pane">

		<div class="fieldset">

			<div class="control-group">
				<label class="control-label">
					<cfif request.context.mmRBF.keyExists('avatarResizeType','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('avatarResizeType','tip')#">#request.context.mmRBF.key('avatarResizeType')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('avatarResizeType')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('avatarResizeType','helptext')>
						<span class="help-inline">(request.context.mmRBF.key('avatarResizeType','helptext'))</span>	
					</cfif>
				</label>
				<div class="controls">
					<select name="settingsbean_avatarResizeType" id="settingsbean_avatarResizeType">
					<cfloop list="CROP,RESIZE,CROPRESIZE" index="iiX">
						<option value="#iiX#" <cfif form.settingsbean_avatarResizeType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarResizeType_#iiX#')#</option>
					</cfloop>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">
					<cfif request.context.mmRBF.keyExists('avatarQualityType','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('avatarQualityType','tip')#">#request.context.mmRBF.key('avatarQualityType')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('avatarQualityType')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('avatarQualityType','helptext')>
						<span class="help-inline">(request.context.mmRBF.key('avatarQualityType','helptext'))</span>	
					</cfif>
				</label>
				<div class="controls">
					<select name="settingsbean_avatarQualityType" id="settingsbean_avatarQualityType">
					<cfloop list="highestQuality,highQuality,highestPerformance" index="iiX">
						<option value="#iiX#" <cfif form.settingsbean_avatarQualityType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarQualityType_#iiX#')#</option>
					</cfloop>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">
					<cfif request.context.mmRBF.keyExists('avatarAspectType','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('avatarAspectType','tip')#">#request.context.mmRBF.key('avatarAspectType')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('avatarAspectType')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('avatarAspectType','helptext')>
						<span class="help-inline">(request.context.mmRBF.key('avatarAspectType','helptext'))</span>	
					</cfif>
				</label>
				<div class="controls">
					<select name="settingsbean_avatarAspectType" id="settingsbean_avatarAspectType">
					<cfloop list="AspectXY,AspectX,AspectY,MaxAspectXY,Resize" index="iiX">
						<option value="#iiX#" <cfif form.settingsbean_avatarAspectType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarAspectType_#iiX#')#</option>
					</cfloop>
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">
					<cfif request.context.mmRBF.keyExists('avatarCropType','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('avatarCropType','tip')#">#request.context.mmRBF.key('avatarCropType')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('avatarCropType')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('avatarCropType','helptext')>
						<span class="help-inline">(request.context.mmRBF.key('avatarCropType','helptext'))</span>	
					</cfif>
				</label>
				<div class="controls">
					<select name="settingsbean_avatarCropType" id="settingsbean_avatarCropType">
					<cfloop list="CenterXY,CenterX,CenterY,BestXY,Crop" index="iiX">
						<option value="#iiX#" <cfif form.settingsbean_avatarCropType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarCropType_#iiX#')#</option>
					</cfloop>
					</select>
				</div>
			</div>


			<ui:Checkbox 	key="resetAvatar"	name="settingsbean_resetavatar" value="1" />

		</div>


	</div>


</cfoutput>
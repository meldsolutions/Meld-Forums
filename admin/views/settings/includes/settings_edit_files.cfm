<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Files">
		<h3>#rc.mmRBF.key('files')#</h3>
		<ul class="form">
			<li class="first">
				<label for="settingsbean_filesizelimit">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('filesizelimit','tip')#</span>#rc.mmRBF.key('filesizelimit')#</a>
				</label>
				<input class="text tiny" type="text" name="settingsbean_filesizelimit" id="settingsbean_filesizelimit" value="#form.settingsbean_filesizelimit#" size="20" maxlength="8" data-required="true" data-validate="numeric" data-message="#rc.mmRBF.key('filesizelimit','validation')#" />
			</li>
			<li>
				<label for="settingsbean_allowedextensions">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('allowedextensions','tip')#</span>#rc.mmRBF.key('allowedextensions')#</a>
				</label>
				<input class="text" type="text" name="settingsbean_allowedextensions" id="settingsbean_allowedextensions" value="#form.settingsbean_allowedextensions#" size="100" maxlength="250" data-required="false" />
			</li>
			<li>
				<label for="settingsbean_basetempdir">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('basetempdir','tip')#</span>#rc.mmRBF.key('basetempdir')#</a>
				</label>
				<input class="text" type="text" name="settingsbean_basetempdir" id="settingsbean_basetempdir" value="#form.settingsbean_basetempdir#" size="100" maxlength="250" data-required="false" />
			</li>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="settingsbean_values_resettempdirectory" id="settingsbean_values_resettempdirectory" value="1" />
				<label for="settingsbean_values_resettempdirectory">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('resettempdirectory','tip')#</span>#rc.mmRBF.key('resettempdirectory')#</a>
				</label>
			</li>
			<li class="padded"></li>
		</ul>
		<ul class="form">
			<h4>#rc.mmRBF.key('images')#</h4>
			<li class="first">
				<label for="settingsbean_avatarResizeType">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('avatarResizeType','tip')#</span>#rc.mmRBF.key('avatarResizeType')#</a>
				</label>
				<select name="settingsbean_avatarResizeType" id="settingsbean_avatarResizeType">
				<cfloop list="CROP,RESIZE,CROPRESIZE" index="iiX">
					<option value="#iiX#" <cfif form.settingsbean_avatarResizeType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarResizeType_#iiX#')#</option>
				</cfloop>
				</select>
			</li>
			<li>
				<label for="settingsbean_avatarQualityType">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('avatarQualityType','tip')#</span>#rc.mmRBF.key('avatarQualityType')#</a>
				</label>
				<select name="settingsbean_avatarQualityType" id="settingsbean_avatarQualityType">
				<cfloop list="highestQuality,highQuality,highestPerformance" index="iiX">
					<option value="#iiX#" <cfif form.settingsbean_avatarQualityType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarQualityType_#iiX#')#</option>
				</cfloop>
				</select>
			</li>
			<li>
				<label for="settingsbean_avatarAspectType">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('avatarAspectType','tip')#</span>#rc.mmRBF.key('avatarAspectType')#</a>
				</label>
				<select name="settingsbean_avatarAspectType" id="settingsbean_avatarAspectType">
				<cfloop list="AspectXY,AspectX,AspectY,MaxAspectXY,Resize" index="iiX">
					<option value="#iiX#" <cfif form.settingsbean_avatarAspectType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarAspectType_#iiX#')#</option>
				</cfloop>
				</select>
			</li>
			<li>
				<label for="settingsbean_avatarCropType">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('avatarCropType','tip')#</span>#rc.mmRBF.key('avatarCropType')#</a>
				</label>
				<select name="settingsbean_avatarCropType" id="settingsbean_avatarCropType">
				<cfloop list="CenterXY,CenterX,CenterY,BestXY,Crop" index="iiX">
					<option value="#iiX#" <cfif form.settingsbean_avatarCropType eq iiX>selected</cfif>>#rc.mmRBF.key('avatarCropType_#iiX#')#</option>
				</cfloop>
				</select>
			</li>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="settingsbean_values_resetAvatar" id="settingsbean_values_resetAvatar" value="1" />
				<label for="settingsbean_values_resetAvatar">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('resetAvatar','tip')#</span>#rc.mmRBF.key('resetAvatar')#</a>
				</label>
			</li>
		</ul>
	</div>
</cfoutput>
<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.4-Hannover" labelsEnabled="1" styleCategories="Symbology|Labeling|Fields|MapTips|Temporal">
  <temporal durationUnit="min" endExpression="" startField="time" startExpression="" durationField="" enabled="1" endField="" accumulate="0" mode="1" fixedDuration="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 symbollevels="0" forceraster="0" type="singleSymbol" enableorderby="1">
    <symbols>
      <symbol alpha="1" clip_to_extent="1" type="marker" force_rhr="0" name="0">
        <layer locked="0" pass="0" enabled="1" class="SimpleMarker">
          <prop k="angle" v="0"/>
          <prop k="color" v="8,255,24,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="arrow"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,164,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="7"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="2"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" name="active" value="true"/>
                  <Option type="QString" name="field" value="dir"/>
                  <Option type="int" name="type" value="2"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option type="bool" name="active" value="true"/>
                  <Option type="QString" name="expression" value="type &lt;> 'slack'"/>
                  <Option type="int" name="type" value="3"/>
                </Option>
                <Option type="Map" name="fillColor">
                  <Option type="bool" name="active" value="true"/>
                  <Option type="QString" name="expression" value="array_get(array('black','#08FF18','red','gray'),max(0,array_find(array('slack','ebb','flood','current'),type)))"/>
                  <Option type="int" name="type" value="3"/>
                </Option>
                <Option type="Map" name="size">
                  <Option type="bool" name="active" value="true"/>
                  <Option type="QString" name="expression" value="velocity*5+2"/>
                  <Option type="int" name="type" value="3"/>
                </Option>
              </Option>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" pass="0" enabled="1" class="SimpleMarker">
          <prop k="angle" v="0"/>
          <prop k="color" v="163,75,245,0"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="triangle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="0,0,0,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option type="Map" name="properties">
                <Option type="Map" name="fillColor">
                  <Option type="bool" name="active" value="false"/>
                  <Option type="QString" name="expression" value="if(type='H','#a34bf5',lighter('#a34bf5',150))"/>
                  <Option type="int" name="type" value="3"/>
                </Option>
              </Option>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
    <orderby>
      <orderByClause nullsFirst="0" asc="1">"velocity"</orderByClause>
    </orderby>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style textColor="0,0,0,255" allowHtml="0" fontSizeUnit="Point" fontItalic="0" capitalization="0" isExpression="0" fontLetterSpacing="0" fontUnderline="0" useSubstitutions="0" fontKerning="1" textOrientation="horizontal" multilineHeight="1" namedStyle="Regular" fontFamily=".AppleSystemUIFont" fontWordSpacing="0" fieldName="id" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontSize="10" fontWeight="50" fontStrikeout="0" textOpacity="1" blendMode="0" previewBkgrdColor="255,255,255,255">
        <text-buffer bufferSize="1" bufferNoFill="1" bufferDraw="0" bufferOpacity="1" bufferSizeUnits="MM" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferBlendMode="0" bufferJoinStyle="128" bufferColor="255,255,255,255"/>
        <text-mask maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskOpacity="1" maskEnabled="0" maskJoinStyle="128" maskSize="1.5" maskSizeUnits="MM" maskedSymbolLayers="" maskType="0"/>
        <background shapeType="0" shapeBlendMode="0" shapeOffsetY="0" shapeOffsetUnit="MM" shapeSizeY="0" shapeSizeX="0" shapeBorderColor="128,128,128,255" shapeSVGFile="" shapeJoinStyle="64" shapeSizeUnit="MM" shapeRadiiY="0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeFillColor="255,255,255,255" shapeRadiiX="0" shapeRadiiUnit="MM" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeOpacity="1" shapeRotationType="0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeSizeType="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthUnit="MM" shapeOffsetX="0" shapeDraw="0" shapeBorderWidth="0" shapeRotation="0">
          <symbol alpha="1" clip_to_extent="1" type="marker" force_rhr="0" name="markerSymbol">
            <layer locked="0" pass="0" enabled="1" class="SimpleMarker">
              <prop k="angle" v="0"/>
              <prop k="color" v="229,182,54,255"/>
              <prop k="horizontal_anchor_point" v="1"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="name" v="circle"/>
              <prop k="offset" v="0,0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="outline_color" v="35,35,35,255"/>
              <prop k="outline_style" v="solid"/>
              <prop k="outline_width" v="0"/>
              <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="outline_width_unit" v="MM"/>
              <prop k="scale_method" v="diameter"/>
              <prop k="size" v="2"/>
              <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="size_unit" v="MM"/>
              <prop k="vertical_anchor_point" v="1"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option type="QString" name="name" value=""/>
                  <Option name="properties"/>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowUnder="0" shadowDraw="0" shadowScale="100" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetGlobal="1" shadowRadiusUnit="MM" shadowRadius="1.5" shadowOffsetDist="1" shadowOffsetAngle="135" shadowBlendMode="6" shadowOpacity="0.69999999999999996" shadowOffsetUnit="MM" shadowColor="0,0,0,255" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusAlphaOnly="0"/>
        <dd_properties>
          <Option type="Map">
            <Option type="QString" name="name" value=""/>
            <Option name="properties"/>
            <Option type="QString" name="type" value="collection"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format useMaxLineLengthForAutoWrap="1" addDirectionSymbol="0" reverseDirectionSymbol="0" multilineAlign="3" plussign="0" formatNumbers="0" placeDirectionSymbol="0" decimals="3" wrapChar="" autoWrapLength="0" leftDirectionSymbol="&lt;" rightDirectionSymbol=">"/>
      <placement repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceUnit="MM" placement="1" distMapUnitScale="3x:0,0,0,0,0,0" offsetType="0" centroidInside="0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" maxCurvedCharAngleIn="25" repeatDistance="0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" lineAnchorType="0" geometryGeneratorType="PointGeometry" yOffset="5" quadOffset="4" distUnits="MM" centroidWhole="0" rotationAngle="0" xOffset="0" dist="10" priority="5" lineAnchorPercent="0.5" placementFlags="10" offsetUnits="MM" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" geometryGeneratorEnabled="0" maxCurvedCharAngleOut="-25" geometryGenerator="" layerType="PointGeometry" fitInPolygonOnly="0" repeatDistanceUnits="MM" preserveRotation="1" polygonPlacementFlags="2" overrunDistance="0"/>
      <rendering obstacleType="1" limitNumLabels="0" displayAll="0" minFeatureSize="0" obstacleFactor="1" fontMaxPixelSize="10000" mergeLines="0" fontLimitPixelSize="0" scaleMin="0" drawLabels="1" obstacle="1" scaleMax="0" scaleVisibility="0" fontMinPixelSize="3" labelPerPart="0" maxNumLabels="2000" zIndex="0" upsidedownLabels="0"/>
      <dd_properties>
        <Option type="Map">
          <Option type="QString" name="name" value=""/>
          <Option type="Map" name="properties">
            <Option type="Map" name="Show">
              <Option type="bool" name="active" value="true"/>
              <Option type="QString" name="expression" value="is_selected()"/>
              <Option type="int" name="type" value="3"/>
            </Option>
          </Option>
          <Option type="QString" name="type" value="collection"/>
        </Option>
      </dd_properties>
      <callout type="simple">
        <Option type="Map">
          <Option type="QString" name="anchorPoint" value="pole_of_inaccessibility"/>
          <Option type="Map" name="ddProperties">
            <Option type="QString" name="name" value=""/>
            <Option name="properties"/>
            <Option type="QString" name="type" value="collection"/>
          </Option>
          <Option type="bool" name="drawToAllParts" value="false"/>
          <Option type="QString" name="enabled" value="0"/>
          <Option type="QString" name="labelAnchorPoint" value="point_on_exterior"/>
          <Option type="QString" name="lineSymbol" value="&lt;symbol alpha=&quot;1&quot; clip_to_extent=&quot;1&quot; type=&quot;line&quot; force_rhr=&quot;0&quot; name=&quot;symbol&quot;>&lt;layer locked=&quot;0&quot; pass=&quot;0&quot; enabled=&quot;1&quot; class=&quot;SimpleLine&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; name=&quot;name&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option type=&quot;QString&quot; name=&quot;type&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>"/>
          <Option type="double" name="minLength" value="0"/>
          <Option type="QString" name="minLengthMapUnitScale" value="3x:0,0,0,0,0,0"/>
          <Option type="QString" name="minLengthUnit" value="MM"/>
          <Option type="double" name="offsetFromAnchor" value="0"/>
          <Option type="QString" name="offsetFromAnchorMapUnitScale" value="3x:0,0,0,0,0,0"/>
          <Option type="QString" name="offsetFromAnchorUnit" value="MM"/>
          <Option type="double" name="offsetFromLabel" value="0"/>
          <Option type="QString" name="offsetFromLabelMapUnitScale" value="3x:0,0,0,0,0,0"/>
          <Option type="QString" name="offsetFromLabelUnit" value="MM"/>
        </Option>
      </callout>
    </settings>
  </labeling>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field configurationFlags="None" name="fid"/>
    <field configurationFlags="None" name="id"/>
    <field configurationFlags="None" name="depth"/>
    <field configurationFlags="None" name="time"/>
    <field configurationFlags="None" name="velocity"/>
    <field configurationFlags="None" name="dir"/>
    <field configurationFlags="None" name="type"/>
    <field configurationFlags="None" name="label"/>
    <field configurationFlags="None" name="date_break"/>
    <field configurationFlags="None" name="station_name"/>
    <field configurationFlags="None" name="display_time"/>
    <field configurationFlags="None" name="station_bin"/>
    <field configurationFlags="None" name="display_velocity"/>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="fid" name=""/>
    <alias index="1" field="id" name=""/>
    <alias index="2" field="depth" name=""/>
    <alias index="3" field="time" name=""/>
    <alias index="4" field="velocity" name=""/>
    <alias index="5" field="dir" name=""/>
    <alias index="6" field="type" name=""/>
    <alias index="7" field="label" name=""/>
    <alias index="8" field="date_break" name=""/>
    <alias index="9" field="station_name" name=""/>
    <alias index="10" field="display_time" name=""/>
    <alias index="11" field="station_bin" name=""/>
    <alias index="12" field="display_velocity" name=""/>
  </aliases>
  <defaults>
    <default expression="" field="fid" applyOnUpdate="0"/>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="depth" applyOnUpdate="0"/>
    <default expression="" field="time" applyOnUpdate="0"/>
    <default expression="" field="velocity" applyOnUpdate="0"/>
    <default expression="" field="dir" applyOnUpdate="0"/>
    <default expression="" field="type" applyOnUpdate="0"/>
    <default expression="" field="label" applyOnUpdate="0"/>
    <default expression="" field="date_break" applyOnUpdate="0"/>
    <default expression="" field="station_name" applyOnUpdate="0"/>
    <default expression="" field="display_time" applyOnUpdate="0"/>
    <default expression="" field="station_bin" applyOnUpdate="0"/>
    <default expression="" field="display_velocity" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" unique_strength="1" exp_strength="0" field="fid" constraints="3"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="id" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="depth" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="time" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="velocity" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="dir" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="type" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="label" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="date_break" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="station_name" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="display_time" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="station_bin" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="display_velocity" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"/>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="depth"/>
    <constraint desc="" exp="" field="time"/>
    <constraint desc="" exp="" field="velocity"/>
    <constraint desc="" exp="" field="dir"/>
    <constraint desc="" exp="" field="type"/>
    <constraint desc="" exp="" field="label"/>
    <constraint desc="" exp="" field="date_break"/>
    <constraint desc="" exp="" field="station_name"/>
    <constraint desc="" exp="" field="display_time"/>
    <constraint desc="" exp="" field="station_bin"/>
    <constraint desc="" exp="" field="display_velocity"/>
  </constraintExpressions>
  <expressionfields>
    <field typeName="string" precision="0" subType="0" expression="attribute(get_feature(@noaa_current_stations_layer,'id',id),'name')" length="0" type="10" comment="" name="station_name"/>
    <field typeName="string" precision="0" subType="0" expression="format_date(time,'MM/dd hh:mm')" length="0" type="10" comment="" name="display_time"/>
    <field typeName="string" precision="0" subType="0" expression="attribute(get_feature(@noaa_current_stations_layer,'id',id),'bin')" length="0" type="10" comment="" name="station_bin"/>
    <field typeName="string" precision="0" subType="0" expression="if(type='ebb',-velocity,if(type='slack','',velocity))" length="0" type="10" comment="" name="display_velocity"/>
  </expressionfields>
  <mapTip>&lt;!-- archived tip display for non-aggregatable current records -->
&lt;!--
&lt;style>
div {
	font-size: 10px;
}
&lt;/style>
&lt;div>[% format_date(time,'MM/dd hh:mm') %]
&lt;br/>
[% type %]: [% velocity %] @ [% dir %]ºT&lt;/div>
-->
&lt;style>
.tip {
	width: 200px;
	max-height: 200px;
	overflow-y: auto;
	font-size: 10px;
}
.name {
	font-weight: bold;
}
.predict {
    padding-top: 5px;
}
table {
    border-collapse:collapse;
}
td {
    font-size: 10px;
	padding: 0px 10px 0px 10px;
}
td.date {
	padding-right: 0px;
}
tr.flood{
	background-color: #FDD
}
tr.ebb{
	background-color: #DFD
}
tr.date_break {
	border-top: 1px solid #999;
}
td.velocity {
	text-align: right;
}
&lt;/style>
&lt;div class="tip">
	&lt;span class="name">[% station_name %]&lt;/span>
	&lt;br/>
	&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% id %]_[% station_bin %]">Station [% id %]&lt;/a>
	&lt;div class="predict">
		&lt;table>
		&lt;tbody>
		[%
			with_variable('station_id',id,
				concatenate(format('
				  &lt;tr class="%3 %5">
				    &lt;td class="date %5">%1&lt;/td>
					&lt;td class="time">%2&lt;/td>
					&lt;td class="type">%3&lt;/td>
					&lt;td class="velocity">%4&lt;/td>
				  &lt;/tr>',
					   format_date(time,'MM/dd'),
					   format_date(time,'hh:mm'),
					   type,
					   display_velocity,
					   if(date_break,'date_break','')),
				filter:= id = @station_id
			             and (@map_start_time is null
							  or (time >= @map_start_time and time &lt; @map_end_time))
		))
		%]
		&lt;/tbody>
		&lt;/table>
	&lt;/div>
&lt;/div></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>

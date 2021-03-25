<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.4-Hannover" readOnly="0" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips" labelsEnabled="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 symbollevels="0" enableorderby="1" forceraster="0" type="singleSymbol">
    <symbols>
      <symbol name="0" clip_to_extent="1" alpha="1" force_rhr="0" type="marker">
        <layer pass="0" locked="0" enabled="1" class="VectorField">
          <prop k="angle_orientation" v="0"/>
          <prop k="angle_units" v="0"/>
          <prop k="distance_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="distance_unit" v="MM"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="scale" v="10"/>
          <prop k="size" v="2"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vector_field_type" v="1"/>
          <prop k="x_attribute" v="vector_display_length"/>
          <prop k="y_attribute" v="dir"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties"/>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol name="@0@0" clip_to_extent="1" alpha="1" force_rhr="0" type="line">
            <layer pass="0" locked="0" enabled="1" class="ArrowLine">
              <prop k="arrow_start_width" v="3"/>
              <prop k="arrow_start_width_unit" v="MM"/>
              <prop k="arrow_start_width_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="arrow_type" v="0"/>
              <prop k="arrow_width" v="3"/>
              <prop k="arrow_width_unit" v="MM"/>
              <prop k="arrow_width_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="head_length" v="3"/>
              <prop k="head_length_unit" v="MM"/>
              <prop k="head_length_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="head_thickness" v="3"/>
              <prop k="head_thickness_unit" v="MM"/>
              <prop k="head_thickness_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="head_type" v="0"/>
              <prop k="is_curved" v="1"/>
              <prop k="is_repeated" v="1"/>
              <prop k="offset" v="0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="offset_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="ring_filter" v="0"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties" type="Map">
                    <Option name="arrowHeadLength" type="Map">
                      <Option name="active" value="true" type="bool"/>
                      <Option name="field" value="vector_display_width" type="QString"/>
                      <Option name="type" value="2" type="int"/>
                    </Option>
                    <Option name="arrowHeadThickness" type="Map">
                      <Option name="active" value="true" type="bool"/>
                      <Option name="field" value="vector_display_width" type="QString"/>
                      <Option name="type" value="2" type="int"/>
                    </Option>
                    <Option name="arrowStartWidth" type="Map">
                      <Option name="active" value="true" type="bool"/>
                      <Option name="field" value="vector_display_width" type="QString"/>
                      <Option name="type" value="2" type="int"/>
                    </Option>
                    <Option name="arrowWidth" type="Map">
                      <Option name="active" value="true" type="bool"/>
                      <Option name="field" value="vector_display_width" type="QString"/>
                      <Option name="type" value="2" type="int"/>
                    </Option>
                  </Option>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol name="@@0@0@0" clip_to_extent="1" alpha="1" force_rhr="0" type="fill">
                <layer pass="0" locked="0" enabled="1" class="SimpleFill">
                  <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="0,0,255,255"/>
                  <prop k="joinstyle" v="bevel"/>
                  <prop k="offset" v="0,0"/>
                  <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="outline_color" v="35,35,35,255"/>
                  <prop k="outline_style" v="solid"/>
                  <prop k="outline_width" v="0.26"/>
                  <prop k="outline_width_unit" v="MM"/>
                  <prop k="style" v="solid"/>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option name="name" value="" type="QString"/>
                      <Option name="properties" type="Map">
                        <Option name="fillColor" type="Map">
                          <Option name="active" value="true" type="bool"/>
                          <Option name="expression" value="array_get(array('black','#08FF18','red','gray'),max(0,array_find(array('slack','ebb','flood','current'),type)))" type="QString"/>
                          <Option name="type" value="3" type="int"/>
                        </Option>
                      </Option>
                      <Option name="type" value="collection" type="QString"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
          </symbol>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
    <orderby>
      <orderByClause asc="1" nullsFirst="0">"velocity"</orderByClause>
    </orderby>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontKerning="1" blendMode="0" isExpression="0" textOpacity="1" fontLetterSpacing="0" fieldName="id" fontFamily=".AppleSystemUIFont" previewBkgrdColor="255,255,255,255" textColor="0,0,0,255" fontStrikeout="0" fontUnderline="0" multilineHeight="1" allowHtml="0" useSubstitutions="0" fontSizeUnit="Point" namedStyle="Regular" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontItalic="0" fontSize="10" fontWeight="50" textOrientation="horizontal" capitalization="0" fontWordSpacing="0">
        <text-buffer bufferColor="255,255,255,255" bufferJoinStyle="128" bufferNoFill="1" bufferSize="1" bufferSizeUnits="MM" bufferDraw="0" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferBlendMode="0" bufferOpacity="1"/>
        <text-mask maskSize="1.5" maskedSymbolLayers="" maskType="0" maskJoinStyle="128" maskEnabled="0" maskSizeUnits="MM" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskOpacity="1"/>
        <background shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeRotation="0" shapeType="0" shapeBorderWidthUnit="MM" shapeFillColor="255,255,255,255" shapeSizeY="0" shapeOpacity="1" shapeJoinStyle="64" shapeDraw="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetUnit="MM" shapeRadiiY="0" shapeSVGFile="" shapeOffsetX="0" shapeSizeX="0" shapeSizeType="0" shapeBlendMode="0" shapeOffsetY="0" shapeRotationType="0" shapeRadiiUnit="MM" shapeBorderWidth="0" shapeRadiiX="0" shapeBorderColor="128,128,128,255" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeSizeUnit="MM" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0">
          <symbol name="markerSymbol" clip_to_extent="1" alpha="1" force_rhr="0" type="marker">
            <layer pass="0" locked="0" enabled="1" class="SimpleMarker">
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
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowDraw="0" shadowRadiusUnit="MM" shadowColor="0,0,0,255" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowRadius="1.5" shadowOffsetAngle="135" shadowScale="100" shadowOffsetUnit="MM" shadowOffsetGlobal="1" shadowOffsetDist="1" shadowOpacity="0.69999999999999996" shadowBlendMode="6" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusAlphaOnly="0" shadowUnder="0"/>
        <dd_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format wrapChar="" useMaxLineLengthForAutoWrap="1" reverseDirectionSymbol="0" formatNumbers="0" placeDirectionSymbol="0" plussign="0" autoWrapLength="0" multilineAlign="3" addDirectionSymbol="0" leftDirectionSymbol="&lt;" rightDirectionSymbol=">" decimals="3"/>
      <placement distMapUnitScale="3x:0,0,0,0,0,0" dist="10" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" fitInPolygonOnly="0" overrunDistance="0" geometryGenerator="" geometryGeneratorType="PointGeometry" yOffset="5" rotationAngle="0" repeatDistance="0" placementFlags="10" overrunDistanceUnit="MM" lineAnchorPercent="0.5" preserveRotation="1" maxCurvedCharAngleIn="25" priority="5" repeatDistanceUnits="MM" placement="1" offsetUnits="MM" offsetType="0" xOffset="0" maxCurvedCharAngleOut="-25" quadOffset="4" distUnits="MM" polygonPlacementFlags="2" layerType="PointGeometry" centroidWhole="0" lineAnchorType="0" geometryGeneratorEnabled="0" centroidInside="0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0"/>
      <rendering labelPerPart="0" mergeLines="0" upsidedownLabels="0" fontMinPixelSize="3" minFeatureSize="0" scaleMax="0" maxNumLabels="2000" drawLabels="1" limitNumLabels="0" scaleMin="0" displayAll="0" scaleVisibility="0" obstacle="1" obstacleFactor="1" obstacleType="1" zIndex="0" fontMaxPixelSize="10000" fontLimitPixelSize="0"/>
      <dd_properties>
        <Option type="Map">
          <Option name="name" value="" type="QString"/>
          <Option name="properties" type="Map">
            <Option name="Show" type="Map">
              <Option name="active" value="true" type="bool"/>
              <Option name="expression" value="is_selected()" type="QString"/>
              <Option name="type" value="3" type="int"/>
            </Option>
          </Option>
          <Option name="type" value="collection" type="QString"/>
        </Option>
      </dd_properties>
      <callout type="simple">
        <Option type="Map">
          <Option name="anchorPoint" value="pole_of_inaccessibility" type="QString"/>
          <Option name="ddProperties" type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
          <Option name="drawToAllParts" value="false" type="bool"/>
          <Option name="enabled" value="0" type="QString"/>
          <Option name="labelAnchorPoint" value="point_on_exterior" type="QString"/>
          <Option name="lineSymbol" value="&lt;symbol name=&quot;symbol&quot; clip_to_extent=&quot;1&quot; alpha=&quot;1&quot; force_rhr=&quot;0&quot; type=&quot;line&quot;>&lt;layer pass=&quot;0&quot; locked=&quot;0&quot; enabled=&quot;1&quot; class=&quot;SimpleLine&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; value=&quot;&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; value=&quot;collection&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString"/>
          <Option name="minLength" value="0" type="double"/>
          <Option name="minLengthMapUnitScale" value="3x:0,0,0,0,0,0" type="QString"/>
          <Option name="minLengthUnit" value="MM" type="QString"/>
          <Option name="offsetFromAnchor" value="0" type="double"/>
          <Option name="offsetFromAnchorMapUnitScale" value="3x:0,0,0,0,0,0" type="QString"/>
          <Option name="offsetFromAnchorUnit" value="MM" type="QString"/>
          <Option name="offsetFromLabel" value="0" type="double"/>
          <Option name="offsetFromLabelMapUnitScale" value="3x:0,0,0,0,0,0" type="QString"/>
          <Option name="offsetFromLabelUnit" value="MM" type="QString"/>
        </Option>
      </callout>
    </settings>
  </labeling>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field name="id" configurationFlags="None"/>
    <field name="depth" configurationFlags="None"/>
    <field name="time" configurationFlags="None"/>
    <field name="date_break" configurationFlags="None"/>
    <field name="velocity" configurationFlags="None"/>
    <field name="dir" configurationFlags="None"/>
    <field name="type" configurationFlags="None"/>
    <field name="station_name" configurationFlags="None"/>
    <field name="display_time" configurationFlags="None"/>
    <field name="station_bin" configurationFlags="None"/>
    <field name="display_velocity" configurationFlags="None"/>
    <field name="vector_display_length" configurationFlags="None"/>
    <field name="vector_display_width" configurationFlags="None"/>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="depth" name="" index="1"/>
    <alias field="time" name="" index="2"/>
    <alias field="date_break" name="" index="3"/>
    <alias field="velocity" name="" index="4"/>
    <alias field="dir" name="" index="5"/>
    <alias field="type" name="" index="6"/>
    <alias field="station_name" name="" index="7"/>
    <alias field="display_time" name="" index="8"/>
    <alias field="station_bin" name="" index="9"/>
    <alias field="display_velocity" name="" index="10"/>
    <alias field="vector_display_length" name="" index="11"/>
    <alias field="vector_display_width" name="" index="12"/>
  </aliases>
  <defaults>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="depth" expression="" applyOnUpdate="0"/>
    <default field="time" expression="" applyOnUpdate="0"/>
    <default field="date_break" expression="" applyOnUpdate="0"/>
    <default field="velocity" expression="" applyOnUpdate="0"/>
    <default field="dir" expression="" applyOnUpdate="0"/>
    <default field="type" expression="" applyOnUpdate="0"/>
    <default field="station_name" expression="" applyOnUpdate="0"/>
    <default field="display_time" expression="" applyOnUpdate="0"/>
    <default field="station_bin" expression="" applyOnUpdate="0"/>
    <default field="display_velocity" expression="" applyOnUpdate="0"/>
    <default field="vector_display_length" expression="" applyOnUpdate="0"/>
    <default field="vector_display_width" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="depth" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="time" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="date_break" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="velocity" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="dir" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="type" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="station_name" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="display_time" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="station_bin" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="display_velocity" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="vector_display_length" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
    <constraint field="vector_display_width" exp_strength="0" notnull_strength="0" constraints="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id" desc="" exp=""/>
    <constraint field="depth" desc="" exp=""/>
    <constraint field="time" desc="" exp=""/>
    <constraint field="date_break" desc="" exp=""/>
    <constraint field="velocity" desc="" exp=""/>
    <constraint field="dir" desc="" exp=""/>
    <constraint field="type" desc="" exp=""/>
    <constraint field="station_name" desc="" exp=""/>
    <constraint field="display_time" desc="" exp=""/>
    <constraint field="station_bin" desc="" exp=""/>
    <constraint field="display_velocity" desc="" exp=""/>
    <constraint field="vector_display_length" desc="" exp=""/>
    <constraint field="vector_display_width" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields>
    <field typeName="string" name="station_name" subType="0" length="0" expression="attribute(get_feature(@noaa_current_stations_layer,'id',id),'name')" comment="" precision="0" type="10"/>
    <field typeName="string" name="display_time" subType="0" length="0" expression="format_date(time,'MM/dd hh:mm')" comment="" precision="0" type="10"/>
    <field typeName="string" name="station_bin" subType="0" length="0" expression="attribute(get_feature(@noaa_current_stations_layer,'id',id),'bin')" comment="" precision="0" type="10"/>
    <field typeName="string" name="display_velocity" subType="0" length="0" expression="if(type='ebb',-velocity,if(type='slack','',velocity))" comment="" precision="0" type="10"/>
    <field typeName="integer" name="vector_display_length" subType="0" length="10" expression="1&#x9;" comment="" precision="0" type="2"/>
    <field typeName="double precision" name="vector_display_width" subType="0" length="-1" expression="(max(1,5*log(5,velocity)))" comment="" precision="0" type="6"/>
  </expressionfields>
  <previewExpression>"station_name"</previewExpression>
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

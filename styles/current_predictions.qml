<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.5-Hannover" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal" readOnly="0" labelsEnabled="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal durationField="" accumulate="0" fixedDuration="0" startField="time" mode="1" endExpression="" durationUnit="min" startExpression="" endField="" enabled="1">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="1" symbollevels="0" type="singleSymbol" forceraster="0">
    <symbols>
      <symbol alpha="0.97" clip_to_extent="1" name="0" force_rhr="0" type="marker">
        <layer class="VectorField" locked="0" pass="0" enabled="1">
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
          <prop k="x_attribute" v="magnitude"/>
          <prop k="y_attribute" v="dir"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties"/>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" clip_to_extent="1" name="@0@0" force_rhr="0" type="line">
            <layer class="SimpleLine" locked="0" pass="0" enabled="1">
              <prop k="align_dash_pattern" v="0"/>
              <prop k="capstyle" v="square"/>
              <prop k="customdash" v="5;2"/>
              <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="customdash_unit" v="MM"/>
              <prop k="dash_pattern_offset" v="0"/>
              <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="dash_pattern_offset_unit" v="MM"/>
              <prop k="draw_inside_polygon" v="0"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="line_color" v="35,35,35,255"/>
              <prop k="line_style" v="solid"/>
              <prop k="line_width" v="1"/>
              <prop k="line_width_unit" v="MM"/>
              <prop k="offset" v="0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="ring_filter" v="0"/>
              <prop k="tweak_dash_pattern_on_corners" v="0"/>
              <prop k="use_custom_dash" v="0"/>
              <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
            <layer class="HashLine" locked="0" pass="0" enabled="1">
              <prop k="average_angle_length" v="4"/>
              <prop k="average_angle_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="average_angle_unit" v="MM"/>
              <prop k="hash_angle" v="0"/>
              <prop k="hash_length" v="1"/>
              <prop k="hash_length_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="hash_length_unit" v="MM"/>
              <prop k="interval" v="10"/>
              <prop k="interval_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="interval_unit" v="MM"/>
              <prop k="offset" v="0"/>
              <prop k="offset_along_line" v="5.55112e-17"/>
              <prop k="offset_along_line_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_along_line_unit" v="MM"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="placement" v="interval"/>
              <prop k="ring_filter" v="0"/>
              <prop k="rotate" v="1"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol alpha="1" clip_to_extent="1" name="@@0@0@1" force_rhr="0" type="line">
                <layer class="SimpleLine" locked="0" pass="0" enabled="1">
                  <prop k="align_dash_pattern" v="0"/>
                  <prop k="capstyle" v="square"/>
                  <prop k="customdash" v="5;2"/>
                  <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="customdash_unit" v="MM"/>
                  <prop k="dash_pattern_offset" v="0"/>
                  <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="dash_pattern_offset_unit" v="MM"/>
                  <prop k="draw_inside_polygon" v="0"/>
                  <prop k="joinstyle" v="bevel"/>
                  <prop k="line_color" v="255,255,255,255"/>
                  <prop k="line_style" v="solid"/>
                  <prop k="line_width" v="1"/>
                  <prop k="line_width_unit" v="MM"/>
                  <prop k="offset" v="0"/>
                  <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="ring_filter" v="0"/>
                  <prop k="tweak_dash_pattern_on_corners" v="0"/>
                  <prop k="use_custom_dash" v="0"/>
                  <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option name="name" value="" type="QString"/>
                      <Option name="properties"/>
                      <Option name="type" value="collection" type="QString"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
            <layer class="HashLine" locked="0" pass="0" enabled="1">
              <prop k="average_angle_length" v="4"/>
              <prop k="average_angle_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="average_angle_unit" v="MM"/>
              <prop k="hash_angle" v="0"/>
              <prop k="hash_length" v="1"/>
              <prop k="hash_length_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="hash_length_unit" v="MM"/>
              <prop k="interval" v="5"/>
              <prop k="interval_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="interval_unit" v="MM"/>
              <prop k="offset" v="0"/>
              <prop k="offset_along_line" v="5.55112e-17"/>
              <prop k="offset_along_line_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_along_line_unit" v="MM"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="placement" v="interval"/>
              <prop k="ring_filter" v="0"/>
              <prop k="rotate" v="1"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol alpha="1" clip_to_extent="1" name="@@0@0@2" force_rhr="0" type="line">
                <layer class="SimpleLine" locked="0" pass="0" enabled="1">
                  <prop k="align_dash_pattern" v="0"/>
                  <prop k="capstyle" v="square"/>
                  <prop k="customdash" v="5;2"/>
                  <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="customdash_unit" v="MM"/>
                  <prop k="dash_pattern_offset" v="0"/>
                  <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="dash_pattern_offset_unit" v="MM"/>
                  <prop k="draw_inside_polygon" v="0"/>
                  <prop k="joinstyle" v="bevel"/>
                  <prop k="line_color" v="255,255,255,255"/>
                  <prop k="line_style" v="solid"/>
                  <prop k="line_width" v="0.5"/>
                  <prop k="line_width_unit" v="MM"/>
                  <prop k="offset" v="0"/>
                  <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="ring_filter" v="0"/>
                  <prop k="tweak_dash_pattern_on_corners" v="0"/>
                  <prop k="use_custom_dash" v="0"/>
                  <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option name="name" value="" type="QString"/>
                      <Option name="properties"/>
                      <Option name="type" value="collection" type="QString"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
            <layer class="MarkerLine" locked="0" pass="0" enabled="1">
              <prop k="average_angle_length" v="4"/>
              <prop k="average_angle_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="average_angle_unit" v="MM"/>
              <prop k="interval" v="3"/>
              <prop k="interval_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="interval_unit" v="MM"/>
              <prop k="offset" v="5.55112e-17"/>
              <prop k="offset_along_line" v="0"/>
              <prop k="offset_along_line_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_along_line_unit" v="MM"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="placement" v="lastvertex"/>
              <prop k="ring_filter" v="0"/>
              <prop k="rotate" v="1"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties" type="Map">
                    <Option name="enabled" type="Map">
                      <Option name="active" value="true" type="bool"/>
                      <Option name="expression" value="type &lt;> 'slack'" type="QString"/>
                      <Option name="type" value="3" type="int"/>
                    </Option>
                  </Option>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol alpha="1" clip_to_extent="1" name="@@0@0@3" force_rhr="0" type="marker">
                <layer class="SimpleMarker" locked="0" pass="0" enabled="1">
                  <prop k="angle" v="0"/>
                  <prop k="color" v="255,0,0,255"/>
                  <prop k="horizontal_anchor_point" v="1"/>
                  <prop k="joinstyle" v="miter"/>
                  <prop k="name" v="arrowhead"/>
                  <prop k="offset" v="1,0"/>
                  <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="outline_color" v="35,35,35,255"/>
                  <prop k="outline_style" v="solid"/>
                  <prop k="outline_width" v="1"/>
                  <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="outline_width_unit" v="MM"/>
                  <prop k="scale_method" v="diameter"/>
                  <prop k="size" v="5"/>
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
            </layer>
          </symbol>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
    <orderby>
      <orderByClause nullsFirst="0" asc="1">"magnitude"</orderByClause>
    </orderby>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontSize="10" textColor="0,0,0,255" textOrientation="horizontal" blendMode="0" namedStyle="Regular" fontItalic="0" fontStrikeout="0" fontUnderline="0" fontSizeUnit="Point" fontFamily=".AppleSystemUIFont" fontSizeMapUnitScale="3x:0,0,0,0,0,0" allowHtml="0" fontWeight="50" previewBkgrdColor="255,255,255,255" useSubstitutions="0" fontKerning="1" isExpression="1" multilineHeight="1" capitalization="0" fieldName="format('%1;%2kt',format_date(local_time,'hh:mm'),format_number(magnitude,1))" textOpacity="1" fontWordSpacing="0" fontLetterSpacing="0">
        <text-buffer bufferDraw="1" bufferBlendMode="0" bufferSize="1" bufferOpacity="1" bufferJoinStyle="128" bufferColor="255,255,255,255" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferSizeUnits="MM" bufferNoFill="1"/>
        <text-mask maskEnabled="0" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskJoinStyle="128" maskedSymbolLayers="" maskSize="1.5" maskSizeUnits="MM" maskOpacity="1" maskType="0"/>
        <background shapeSizeY="0" shapeType="0" shapeRadiiY="0" shapeSizeType="0" shapeOffsetUnit="MM" shapeOffsetY="0" shapeSVGFile="" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeRotationType="0" shapeBorderColor="128,128,128,255" shapeRadiiX="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeRotation="0" shapeOffsetX="0" shapeRadiiUnit="MM" shapeBorderWidthUnit="MM" shapeBlendMode="0" shapeFillColor="255,255,255,255" shapeDraw="0" shapeOpacity="1" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeSizeUnit="MM" shapeSizeX="0" shapeBorderWidth="0" shapeJoinStyle="64">
          <symbol alpha="1" clip_to_extent="1" name="markerSymbol" force_rhr="0" type="marker">
            <layer class="SimpleMarker" locked="0" pass="0" enabled="1">
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
        <shadow shadowRadiusUnit="MM" shadowBlendMode="6" shadowOffsetAngle="135" shadowRadiusAlphaOnly="0" shadowOpacity="0.69999999999999996" shadowColor="0,0,0,255" shadowDraw="0" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowScale="100" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowRadius="1.5" shadowOffsetDist="1" shadowOffsetUnit="MM" shadowOffsetGlobal="1" shadowUnder="0"/>
        <dd_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format useMaxLineLengthForAutoWrap="1" decimals="3" wrapChar=";" autoWrapLength="0" addDirectionSymbol="0" rightDirectionSymbol=">" leftDirectionSymbol="&lt;" plussign="0" multilineAlign="3" placeDirectionSymbol="0" reverseDirectionSymbol="0" formatNumbers="0"/>
      <placement overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" repeatDistance="0" preserveRotation="1" quadOffset="4" overrunDistanceUnit="MM" lineAnchorPercent="0.5" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" geometryGeneratorType="PointGeometry" placementFlags="10" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" rotationAngle="0" distUnits="MM" distMapUnitScale="3x:0,0,0,0,0,0" geometryGenerator="" dist="10" fitInPolygonOnly="0" maxCurvedCharAngleIn="25" repeatDistanceUnits="MM" centroidWhole="0" placement="0" geometryGeneratorEnabled="0" polygonPlacementFlags="2" maxCurvedCharAngleOut="-25" lineAnchorType="0" layerType="PointGeometry" xOffset="0" offsetType="0" priority="5" overrunDistance="0" offsetUnits="MM" centroidInside="0" yOffset="0"/>
      <rendering minFeatureSize="0" scaleVisibility="0" upsidedownLabels="0" fontLimitPixelSize="0" obstacleFactor="1" scaleMax="0" fontMinPixelSize="3" zIndex="0" obstacleType="1" obstacle="1" drawLabels="1" displayAll="0" fontMaxPixelSize="10000" maxNumLabels="2000" mergeLines="0" limitNumLabels="0" scaleMin="0" labelPerPart="0"/>
      <dd_properties>
        <Option type="Map">
          <Option name="name" value="" type="QString"/>
          <Option name="properties" type="Map">
            <Option name="OffsetXY" type="Map">
              <Option name="active" value="false" type="bool"/>
              <Option name="type" value="1" type="int"/>
              <Option name="val" value="" type="QString"/>
            </Option>
            <Option name="Show" type="Map">
              <Option name="active" value="true" type="bool"/>
              <Option name="expression" value="(@map_start_time is not null)" type="QString"/>
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
          <Option name="lineSymbol" value="&lt;symbol alpha=&quot;1&quot; clip_to_extent=&quot;1&quot; name=&quot;symbol&quot; force_rhr=&quot;0&quot; type=&quot;line&quot;>&lt;layer class=&quot;SimpleLine&quot; locked=&quot;0&quot; pass=&quot;0&quot; enabled=&quot;1&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; value=&quot;&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; value=&quot;collection&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString"/>
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
    <field configurationFlags="None" name="station"/>
    <field configurationFlags="None" name="depth"/>
    <field configurationFlags="None" name="time"/>
    <field configurationFlags="None" name="value"/>
    <field configurationFlags="None" name="type"/>
    <field configurationFlags="None" name="dir"/>
    <field configurationFlags="None" name="magnitude"/>
    <field configurationFlags="None" name="station_name"/>
    <field configurationFlags="None" name="station_timeZoneId"/>
    <field configurationFlags="None" name="station_timeZoneUTC"/>
    <field configurationFlags="None" name="local_time"/>
    <field configurationFlags="None" name="local_date_str"/>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="station" name=""/>
    <alias index="1" field="depth" name=""/>
    <alias index="2" field="time" name=""/>
    <alias index="3" field="value" name=""/>
    <alias index="4" field="type" name=""/>
    <alias index="5" field="dir" name=""/>
    <alias index="6" field="magnitude" name=""/>
    <alias index="7" field="station_name" name=""/>
    <alias index="8" field="station_timeZoneId" name=""/>
    <alias index="9" field="station_timeZoneUTC" name=""/>
    <alias index="10" field="local_time" name=""/>
    <alias index="11" field="local_date_str" name=""/>
  </aliases>
  <defaults>
    <default field="station" expression="" applyOnUpdate="0"/>
    <default field="depth" expression="" applyOnUpdate="0"/>
    <default field="time" expression="" applyOnUpdate="0"/>
    <default field="value" expression="" applyOnUpdate="0"/>
    <default field="type" expression="" applyOnUpdate="0"/>
    <default field="dir" expression="" applyOnUpdate="0"/>
    <default field="magnitude" expression="" applyOnUpdate="0"/>
    <default field="station_name" expression="" applyOnUpdate="0"/>
    <default field="station_timeZoneId" expression="" applyOnUpdate="0"/>
    <default field="station_timeZoneUTC" expression="" applyOnUpdate="0"/>
    <default field="local_time" expression="" applyOnUpdate="0"/>
    <default field="local_date_str" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint unique_strength="0" constraints="0" field="station" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="depth" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="time" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="value" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="type" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="dir" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="magnitude" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="station_name" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="station_timeZoneId" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="station_timeZoneUTC" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="local_time" exp_strength="0" notnull_strength="0"/>
    <constraint unique_strength="0" constraints="0" field="local_date_str" exp_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="station"/>
    <constraint desc="" exp="" field="depth"/>
    <constraint desc="" exp="" field="time"/>
    <constraint desc="" exp="" field="value"/>
    <constraint desc="" exp="" field="type"/>
    <constraint desc="" exp="" field="dir"/>
    <constraint desc="" exp="" field="magnitude"/>
    <constraint desc="" exp="" field="station_name"/>
    <constraint desc="" exp="" field="station_timeZoneId"/>
    <constraint desc="" exp="" field="station_timeZoneUTC"/>
    <constraint desc="" exp="" field="local_time"/>
    <constraint desc="" exp="" field="local_date_str"/>
  </constraintExpressions>
  <expressionfields>
    <field length="-1" subType="0" typeName="datetime" comment="" name="local_time" expression="convert_to_time_zone(time,station_timeZoneUTC,station_timeZoneId)" precision="0" type="16"/>
    <field length="0" subType="0" typeName="string" comment="" name="local_date_str" expression="format_date(local_time,'yyyyMMdd')" precision="0" type="10"/>
  </expressionfields>
  <previewExpression>station + ' ' + format_date(time,'yyyyMMdd hh:mm')</previewExpression>
  <mapTip>&lt;style>
.tip {
	width: 200px;
	max-height: 200px;
	overflow-y: auto;
	font-size: 12px;
  font-family: sans-serif;
}
.name {
	font-weight: bold;
}
.date {
	padding-top: 5px;
}
.predict {
    padding-top: 5px;
}
table {
    border-collapse:collapse;
}
td {
    font-size: 12px;
	padding: 1px 5px 1px 5px;
}
tr.flood{
	background-color: #A0D8FF
}
tr.ebb{
	background-color: #A0ffD8
}
tr.date_break {
  border-top: 2px solid #999;
}
td.vel {
	text-align: right;
}
tr.slack td.vel {
	visibility: hidden;
}
&lt;/style>
&lt;div class="tip">
	&lt;div class="name">[% station_name %] ([% format_time_zone(local_time,2) %])&lt;/div>
	&lt;div class="station">&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% station %]&amp;d=[% format_date(minimum(time), 'yyyy-MM-dd') %]">Station [% station %]&lt;/a>&lt;/div>
	&lt;div class="predict">
		&lt;table>
		&lt;tbody>
		[%
		  format('
		  &lt;tr class="%1">
			&lt;td class="day">%2&lt;/td>
			&lt;td class="time">%3&lt;/td>
			&lt;td class="type">%4&lt;/td>
			&lt;td class="vel">%5&lt;/td>
		  &lt;/tr>',
			   type,
			   format_date(local_time,'ddd dd'),
			   format_date(local_time,'hh:mm'),
			   if(type='current',dir||'º',type),
			   format_number(if(type='current',magnitude,value),1)
		   )
		%]
		&lt;/tbody>
		&lt;/table>
	&lt;/div>
&lt;/div></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>

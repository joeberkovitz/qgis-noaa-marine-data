<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.4-Hannover" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal" readOnly="0" labelsEnabled="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal endField="" mode="1" enabled="1" durationField="" startField="time" startExpression="" durationUnit="min" endExpression="" fixedDuration="0" accumulate="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 type="singleSymbol" forceraster="0" symbollevels="0" enableorderby="1">
    <symbols>
      <symbol alpha="0.97" type="marker" force_rhr="0" name="0" clip_to_extent="1">
        <layer class="VectorField" enabled="1" locked="0" pass="0">
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
          <prop k="x_attribute" v="velocity"/>
          <prop k="y_attribute" v="dir"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" type="line" force_rhr="0" name="@0@0" clip_to_extent="1">
            <layer class="SimpleLine" enabled="1" locked="0" pass="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option name="properties"/>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
            <layer class="HashLine" enabled="1" locked="0" pass="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option name="properties"/>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
              <symbol alpha="1" type="line" force_rhr="0" name="@@0@0@1" clip_to_extent="1">
                <layer class="SimpleLine" enabled="1" locked="0" pass="0">
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
                      <Option type="QString" name="name" value=""/>
                      <Option name="properties"/>
                      <Option type="QString" name="type" value="collection"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
            <layer class="HashLine" enabled="1" locked="0" pass="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option name="properties"/>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
              <symbol alpha="1" type="line" force_rhr="0" name="@@0@0@2" clip_to_extent="1">
                <layer class="SimpleLine" enabled="1" locked="0" pass="0">
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
                      <Option type="QString" name="name" value=""/>
                      <Option name="properties"/>
                      <Option type="QString" name="type" value="collection"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
            <layer class="MarkerLine" enabled="1" locked="0" pass="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="enabled">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="expression" value="type &lt;> 'slack'"/>
                      <Option type="int" name="type" value="3"/>
                    </Option>
                  </Option>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
              <symbol alpha="1" type="marker" force_rhr="0" name="@@0@0@3" clip_to_extent="1">
                <layer class="SimpleMarker" enabled="1" locked="0" pass="0">
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
                      <Option type="QString" name="name" value=""/>
                      <Option name="properties"/>
                      <Option type="QString" name="type" value="collection"/>
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
      <text-style textColor="0,0,0,255" fontWeight="50" fontWordSpacing="0" allowHtml="0" namedStyle="Regular" fontKerning="1" fontSizeUnit="Point" fontSize="10" textOrientation="horizontal" multilineHeight="1" useSubstitutions="0" fontStrikeout="0" fontItalic="0" previewBkgrdColor="255,255,255,255" isExpression="1" fieldName="format('%1;%2kt',format_date(local_time,'hh:mm'),format_number(velocity,1))" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontFamily=".AppleSystemUIFont" capitalization="0" blendMode="0" fontLetterSpacing="0" textOpacity="1" fontUnderline="0">
        <text-buffer bufferBlendMode="0" bufferOpacity="1" bufferNoFill="1" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferJoinStyle="128" bufferDraw="1" bufferSizeUnits="MM" bufferColor="255,255,255,255" bufferSize="1"/>
        <text-mask maskSize="1.5" maskType="0" maskOpacity="1" maskedSymbolLayers="" maskJoinStyle="128" maskSizeUnits="MM" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskEnabled="0"/>
        <background shapeBorderColor="128,128,128,255" shapeRadiiX="0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthUnit="MM" shapeSizeY="0" shapeFillColor="255,255,255,255" shapeRadiiY="0" shapeBorderWidth="0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeDraw="0" shapeRadiiUnit="MM" shapeRotation="0" shapeOffsetX="0" shapeOffsetUnit="MM" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeSizeUnit="MM" shapeRotationType="0" shapeSVGFile="" shapeJoinStyle="64" shapeSizeType="0" shapeType="0" shapeOffsetY="0" shapeSizeX="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeOpacity="1" shapeBlendMode="0">
          <symbol alpha="1" type="marker" force_rhr="0" name="markerSymbol" clip_to_extent="1">
            <layer class="SimpleMarker" enabled="1" locked="0" pass="0">
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
        <shadow shadowOffsetAngle="135" shadowOffsetUnit="MM" shadowRadiusAlphaOnly="0" shadowOffsetDist="1" shadowUnder="0" shadowRadius="1.5" shadowOpacity="0.69999999999999996" shadowBlendMode="6" shadowOffsetGlobal="1" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowColor="0,0,0,255" shadowDraw="0" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusUnit="MM" shadowScale="100"/>
        <dd_properties>
          <Option type="Map">
            <Option type="QString" name="name" value=""/>
            <Option name="properties"/>
            <Option type="QString" name="type" value="collection"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format multilineAlign="3" autoWrapLength="0" leftDirectionSymbol="&lt;" addDirectionSymbol="0" wrapChar=";" placeDirectionSymbol="0" useMaxLineLengthForAutoWrap="1" formatNumbers="0" plussign="0" rightDirectionSymbol=">" reverseDirectionSymbol="0" decimals="3"/>
      <placement preserveRotation="1" fitInPolygonOnly="0" placementFlags="10" offsetType="0" maxCurvedCharAngleOut="-25" rotationAngle="0" repeatDistance="0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistance="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" centroidWhole="0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceUnit="MM" polygonPlacementFlags="2" placement="1" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" dist="10" geometryGeneratorEnabled="0" centroidInside="0" layerType="PointGeometry" distUnits="MM" lineAnchorPercent="0.5" xOffset="0" maxCurvedCharAngleIn="25" priority="5" repeatDistanceUnits="MM" yOffset="0" quadOffset="4" geometryGenerator="" distMapUnitScale="3x:0,0,0,0,0,0" lineAnchorType="0" offsetUnits="MM" geometryGeneratorType="PointGeometry"/>
      <rendering mergeLines="0" displayAll="0" maxNumLabels="2000" fontMaxPixelSize="10000" scaleMin="0" fontMinPixelSize="3" obstacle="1" obstacleFactor="1" scaleMax="0" limitNumLabels="0" minFeatureSize="0" zIndex="0" drawLabels="1" obstacleType="1" fontLimitPixelSize="0" scaleVisibility="0" upsidedownLabels="0" labelPerPart="0"/>
      <dd_properties>
        <Option type="Map">
          <Option type="QString" name="name" value=""/>
          <Option type="Map" name="properties">
            <Option type="Map" name="OffsetXY">
              <Option type="bool" name="active" value="true"/>
              <Option type="QString" name="expression" value="format('%1,%2',(5+vector_display_length)*sin(radians(dir)),(5+vector_display_length)*-cos(radians(dir)))"/>
              <Option type="int" name="type" value="3"/>
            </Option>
            <Option type="Map" name="Show">
              <Option type="bool" name="active" value="true"/>
              <Option type="QString" name="expression" value="(@map_start_time is not null)"/>
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
          <Option type="QString" name="lineSymbol" value="&lt;symbol alpha=&quot;1&quot; type=&quot;line&quot; force_rhr=&quot;0&quot; name=&quot;symbol&quot; clip_to_extent=&quot;1&quot;>&lt;layer class=&quot;SimpleLine&quot; enabled=&quot;1&quot; locked=&quot;0&quot; pass=&quot;0&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; name=&quot;name&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option type=&quot;QString&quot; name=&quot;type&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>"/>
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
    <field name="fid" configurationFlags="None"/>
    <field name="id_bin" configurationFlags="None"/>
    <field name="id" configurationFlags="None"/>
    <field name="bin" configurationFlags="None"/>
    <field name="depth" configurationFlags="None"/>
    <field name="time" configurationFlags="None"/>
    <field name="date_break" configurationFlags="None"/>
    <field name="velocity" configurationFlags="None"/>
    <field name="velocity_major" configurationFlags="None"/>
    <field name="dir" configurationFlags="None"/>
    <field name="type" configurationFlags="None"/>
    <field name="station_name" configurationFlags="None"/>
    <field name="station_timeZoneId" configurationFlags="None"/>
    <field name="station_timeZoneUTC" configurationFlags="None"/>
    <field name="vector_display_length" configurationFlags="None"/>
    <field name="local_time" configurationFlags="None"/>
    <field name="local_date_str" configurationFlags="None"/>
    <field name="vector_saturation" configurationFlags="None"/>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="fid" index="0"/>
    <alias name="" field="id_bin" index="1"/>
    <alias name="" field="id" index="2"/>
    <alias name="" field="bin" index="3"/>
    <alias name="" field="depth" index="4"/>
    <alias name="" field="time" index="5"/>
    <alias name="" field="date_break" index="6"/>
    <alias name="" field="velocity" index="7"/>
    <alias name="" field="velocity_major" index="8"/>
    <alias name="" field="dir" index="9"/>
    <alias name="" field="type" index="10"/>
    <alias name="" field="station_name" index="11"/>
    <alias name="" field="station_timeZoneId" index="12"/>
    <alias name="" field="station_timeZoneUTC" index="13"/>
    <alias name="" field="vector_display_length" index="14"/>
    <alias name="" field="local_time" index="15"/>
    <alias name="" field="local_date_str" index="16"/>
    <alias name="" field="vector_saturation" index="17"/>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"/>
    <default applyOnUpdate="0" expression="" field="id_bin"/>
    <default applyOnUpdate="0" expression="" field="id"/>
    <default applyOnUpdate="0" expression="" field="bin"/>
    <default applyOnUpdate="0" expression="" field="depth"/>
    <default applyOnUpdate="0" expression="" field="time"/>
    <default applyOnUpdate="0" expression="" field="date_break"/>
    <default applyOnUpdate="0" expression="" field="velocity"/>
    <default applyOnUpdate="0" expression="" field="velocity_major"/>
    <default applyOnUpdate="0" expression="" field="dir"/>
    <default applyOnUpdate="0" expression="" field="type"/>
    <default applyOnUpdate="0" expression="" field="station_name"/>
    <default applyOnUpdate="0" expression="" field="station_timeZoneId"/>
    <default applyOnUpdate="0" expression="" field="station_timeZoneUTC"/>
    <default applyOnUpdate="0" expression="" field="vector_display_length"/>
    <default applyOnUpdate="0" expression="" field="local_time"/>
    <default applyOnUpdate="0" expression="" field="local_date_str"/>
    <default applyOnUpdate="0" expression="" field="vector_saturation"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="1" constraints="3" unique_strength="1" exp_strength="0" field="fid"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="id_bin"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="id"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="bin"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="depth"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="time"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="date_break"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="velocity"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="velocity_major"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="dir"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="type"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="station_name"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="station_timeZoneId"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="station_timeZoneUTC"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="vector_display_length"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="local_time"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="local_date_str"/>
    <constraint notnull_strength="0" constraints="0" unique_strength="0" exp_strength="0" field="vector_saturation"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="fid"/>
    <constraint exp="" desc="" field="id_bin"/>
    <constraint exp="" desc="" field="id"/>
    <constraint exp="" desc="" field="bin"/>
    <constraint exp="" desc="" field="depth"/>
    <constraint exp="" desc="" field="time"/>
    <constraint exp="" desc="" field="date_break"/>
    <constraint exp="" desc="" field="velocity"/>
    <constraint exp="" desc="" field="velocity_major"/>
    <constraint exp="" desc="" field="dir"/>
    <constraint exp="" desc="" field="type"/>
    <constraint exp="" desc="" field="station_name"/>
    <constraint exp="" desc="" field="station_timeZoneId"/>
    <constraint exp="" desc="" field="station_timeZoneUTC"/>
    <constraint exp="" desc="" field="vector_display_length"/>
    <constraint exp="" desc="" field="local_time"/>
    <constraint exp="" desc="" field="local_date_str"/>
    <constraint exp="" desc="" field="vector_saturation"/>
  </constraintExpressions>
  <expressionfields>
    <field comment="" length="10" type="2" name="vector_display_length" expression="10" typeName="integer" precision="0" subType="0"/>
    <field comment="" length="-1" type="16" name="local_time" expression="convert_to_time_zone(time,station_timeZoneUTC,station_timeZoneId)" typeName="datetime" precision="0" subType="0"/>
    <field comment="" length="0" type="10" name="local_date_str" expression="format_date(local_time,'yyyyMMdd')" typeName="string" precision="0" subType="0"/>
    <field comment="" length="10" type="2" name="vector_saturation" expression="100/(1+exp(-(velocity-1.5)))" typeName="integer" precision="0" subType="0"/>
  </expressionfields>
  <previewExpression>id_bin + ' ' + format_date(time,'yyyyMMdd hh:mm')</previewExpression>
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
td.velocity {
	text-align: right;
}
tr.slack td.velocity {
	visibility: hidden;
}
&lt;/style>
&lt;div class="tip">
	&lt;div class="name">[% station_name %] ([% format_time_zone(local_time,2) %])&lt;/div>
	&lt;div class="station">&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% id_bin %]&amp;d=[% format_date(minimum(time), 'yyyy-MM-dd') %]">Station [% id_bin %]&lt;/a>&lt;/div>
	&lt;div class="predict">
		&lt;table>
		&lt;tbody>
		[%
		  with_variable('station_id',id,
				concatenate(
				  format('
				  &lt;tr class="%1 %6">
					&lt;td class="day">%2&lt;/td>
					&lt;td class="time">%3&lt;/td>
					&lt;td class="type">%4&lt;/td>
					&lt;td class="velocity">%5&lt;/td>
				  &lt;/tr>',
					   type,
					   format_date(local_time,'ddd dd'),
					   format_date(local_time,'hh:mm'),
					   if(velocity_major is null,to_string(dir)+'º',type),
					   format_number(if(velocity_major is null,velocity,velocity_major),1),
             if(date_break,'date_break','')),
				filter:= id = @station_id
			             and is_time_visible(time),
				order_by:= time
		   ))
		%]
		&lt;/tbody>
		&lt;/table>
	&lt;/div>
&lt;/div></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>

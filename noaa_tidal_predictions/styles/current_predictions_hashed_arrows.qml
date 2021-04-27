<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal" version="3.16.4-Hannover" labelsEnabled="0" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal startField="time" enabled="1" startExpression="" endField="" durationField="" endExpression="" durationUnit="min" accumulate="0" fixedDuration="0" mode="1">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="1" forceraster="0" symbollevels="0" type="singleSymbol">
    <symbols>
      <symbol name="0" clip_to_extent="1" alpha="0.97" force_rhr="0" type="marker">
        <layer pass="0" enabled="1" locked="0" class="VectorField">
          <prop v="0" k="angle_orientation"/>
          <prop v="0" k="angle_units"/>
          <prop v="3x:0,0,0,0,0,0" k="distance_map_unit_scale"/>
          <prop v="MM" k="distance_unit"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="10" k="scale"/>
          <prop v="2" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vector_field_type"/>
          <prop v="velocity" k="x_attribute"/>
          <prop v="dir" k="y_attribute"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties"/>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol name="@0@0" clip_to_extent="1" alpha="1" force_rhr="0" type="line">
            <layer pass="0" enabled="1" locked="0" class="SimpleLine">
              <prop v="0" k="align_dash_pattern"/>
              <prop v="square" k="capstyle"/>
              <prop v="5;2" k="customdash"/>
              <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
              <prop v="MM" k="customdash_unit"/>
              <prop v="0" k="dash_pattern_offset"/>
              <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
              <prop v="MM" k="dash_pattern_offset_unit"/>
              <prop v="0" k="draw_inside_polygon"/>
              <prop v="bevel" k="joinstyle"/>
              <prop v="35,35,35,255" k="line_color"/>
              <prop v="solid" k="line_style"/>
              <prop v="1" k="line_width"/>
              <prop v="MM" k="line_width_unit"/>
              <prop v="0" k="offset"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="0" k="ring_filter"/>
              <prop v="0" k="tweak_dash_pattern_on_corners"/>
              <prop v="0" k="use_custom_dash"/>
              <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
            <layer pass="0" enabled="1" locked="0" class="HashLine">
              <prop v="4" k="average_angle_length"/>
              <prop v="3x:0,0,0,0,0,0" k="average_angle_map_unit_scale"/>
              <prop v="MM" k="average_angle_unit"/>
              <prop v="0" k="hash_angle"/>
              <prop v="1" k="hash_length"/>
              <prop v="3x:0,0,0,0,0,0" k="hash_length_map_unit_scale"/>
              <prop v="MM" k="hash_length_unit"/>
              <prop v="10" k="interval"/>
              <prop v="3x:0,0,0,0,0,0" k="interval_map_unit_scale"/>
              <prop v="MM" k="interval_unit"/>
              <prop v="0" k="offset"/>
              <prop v="5.55112e-17" k="offset_along_line"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_along_line_map_unit_scale"/>
              <prop v="MM" k="offset_along_line_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="interval" k="placement"/>
              <prop v="0" k="ring_filter"/>
              <prop v="1" k="rotate"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol name="@@0@0@1" clip_to_extent="1" alpha="1" force_rhr="0" type="line">
                <layer pass="0" enabled="1" locked="0" class="SimpleLine">
                  <prop v="0" k="align_dash_pattern"/>
                  <prop v="square" k="capstyle"/>
                  <prop v="5;2" k="customdash"/>
                  <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
                  <prop v="MM" k="customdash_unit"/>
                  <prop v="0" k="dash_pattern_offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
                  <prop v="MM" k="dash_pattern_offset_unit"/>
                  <prop v="0" k="draw_inside_polygon"/>
                  <prop v="bevel" k="joinstyle"/>
                  <prop v="255,255,255,255" k="line_color"/>
                  <prop v="solid" k="line_style"/>
                  <prop v="1" k="line_width"/>
                  <prop v="MM" k="line_width_unit"/>
                  <prop v="0" k="offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="0" k="ring_filter"/>
                  <prop v="0" k="tweak_dash_pattern_on_corners"/>
                  <prop v="0" k="use_custom_dash"/>
                  <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
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
            <layer pass="0" enabled="1" locked="0" class="HashLine">
              <prop v="4" k="average_angle_length"/>
              <prop v="3x:0,0,0,0,0,0" k="average_angle_map_unit_scale"/>
              <prop v="MM" k="average_angle_unit"/>
              <prop v="0" k="hash_angle"/>
              <prop v="1" k="hash_length"/>
              <prop v="3x:0,0,0,0,0,0" k="hash_length_map_unit_scale"/>
              <prop v="MM" k="hash_length_unit"/>
              <prop v="5" k="interval"/>
              <prop v="3x:0,0,0,0,0,0" k="interval_map_unit_scale"/>
              <prop v="MM" k="interval_unit"/>
              <prop v="0" k="offset"/>
              <prop v="5.55112e-17" k="offset_along_line"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_along_line_map_unit_scale"/>
              <prop v="MM" k="offset_along_line_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="interval" k="placement"/>
              <prop v="0" k="ring_filter"/>
              <prop v="1" k="rotate"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" value="" type="QString"/>
                  <Option name="properties"/>
                  <Option name="type" value="collection" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol name="@@0@0@2" clip_to_extent="1" alpha="1" force_rhr="0" type="line">
                <layer pass="0" enabled="1" locked="0" class="SimpleLine">
                  <prop v="0" k="align_dash_pattern"/>
                  <prop v="square" k="capstyle"/>
                  <prop v="5;2" k="customdash"/>
                  <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
                  <prop v="MM" k="customdash_unit"/>
                  <prop v="0" k="dash_pattern_offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
                  <prop v="MM" k="dash_pattern_offset_unit"/>
                  <prop v="0" k="draw_inside_polygon"/>
                  <prop v="bevel" k="joinstyle"/>
                  <prop v="255,255,255,255" k="line_color"/>
                  <prop v="solid" k="line_style"/>
                  <prop v="0.5" k="line_width"/>
                  <prop v="MM" k="line_width_unit"/>
                  <prop v="0" k="offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="0" k="ring_filter"/>
                  <prop v="0" k="tweak_dash_pattern_on_corners"/>
                  <prop v="0" k="use_custom_dash"/>
                  <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
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
            <layer pass="0" enabled="1" locked="0" class="MarkerLine">
              <prop v="4" k="average_angle_length"/>
              <prop v="3x:0,0,0,0,0,0" k="average_angle_map_unit_scale"/>
              <prop v="MM" k="average_angle_unit"/>
              <prop v="3" k="interval"/>
              <prop v="3x:0,0,0,0,0,0" k="interval_map_unit_scale"/>
              <prop v="MM" k="interval_unit"/>
              <prop v="5.55112e-17" k="offset"/>
              <prop v="0" k="offset_along_line"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_along_line_map_unit_scale"/>
              <prop v="MM" k="offset_along_line_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="lastvertex" k="placement"/>
              <prop v="0" k="ring_filter"/>
              <prop v="1" k="rotate"/>
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
              <symbol name="@@0@0@3" clip_to_extent="1" alpha="1" force_rhr="0" type="marker">
                <layer pass="0" enabled="1" locked="0" class="SimpleMarker">
                  <prop v="0" k="angle"/>
                  <prop v="255,0,0,255" k="color"/>
                  <prop v="1" k="horizontal_anchor_point"/>
                  <prop v="miter" k="joinstyle"/>
                  <prop v="arrowhead" k="name"/>
                  <prop v="1,0" k="offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="35,35,35,255" k="outline_color"/>
                  <prop v="solid" k="outline_style"/>
                  <prop v="1" k="outline_width"/>
                  <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
                  <prop v="MM" k="outline_width_unit"/>
                  <prop v="diameter" k="scale_method"/>
                  <prop v="5" k="size"/>
                  <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
                  <prop v="MM" k="size_unit"/>
                  <prop v="1" k="vertical_anchor_point"/>
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
      <orderByClause asc="1" nullsFirst="0">"velocity"</orderByClause>
    </orderby>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontKerning="1" useSubstitutions="0" allowHtml="0" blendMode="0" fontStrikeout="0" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontSizeUnit="Point" fontLetterSpacing="0" fontWeight="50" fieldName="format('%1;%2kt',format_date(local_time,'hh:mm'),format_number(velocity,1))" fontFamily=".AppleSystemUIFont" fontUnderline="0" capitalization="0" textOrientation="horizontal" textColor="0,0,0,255" fontWordSpacing="0" fontSize="10" fontItalic="0" previewBkgrdColor="255,255,255,255" namedStyle="Regular" isExpression="1" multilineHeight="1" textOpacity="1">
        <text-buffer bufferOpacity="1" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferJoinStyle="128" bufferSizeUnits="MM" bufferSize="1" bufferColor="255,255,255,255" bufferBlendMode="0" bufferDraw="1" bufferNoFill="1"/>
        <text-mask maskType="0" maskSizeUnits="MM" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskedSymbolLayers="" maskOpacity="1" maskJoinStyle="128" maskEnabled="0" maskSize="1.5"/>
        <background shapeDraw="0" shapeBorderWidth="0" shapeSizeY="0" shapeSizeType="0" shapeRadiiY="0" shapeSizeUnit="MM" shapeType="0" shapeRotationType="0" shapeOpacity="1" shapeBlendMode="0" shapeOffsetUnit="MM" shapeSVGFile="" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetY="0" shapeBorderWidthUnit="MM" shapeSizeX="0" shapeOffsetX="0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiUnit="MM" shapeRotation="0" shapeFillColor="255,255,255,255" shapeRadiiX="0" shapeBorderColor="128,128,128,255" shapeJoinStyle="64" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0">
          <symbol name="markerSymbol" clip_to_extent="1" alpha="1" force_rhr="0" type="marker">
            <layer pass="0" enabled="1" locked="0" class="SimpleMarker">
              <prop v="0" k="angle"/>
              <prop v="229,182,54,255" k="color"/>
              <prop v="1" k="horizontal_anchor_point"/>
              <prop v="bevel" k="joinstyle"/>
              <prop v="circle" k="name"/>
              <prop v="0,0" k="offset"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="35,35,35,255" k="outline_color"/>
              <prop v="solid" k="outline_style"/>
              <prop v="0" k="outline_width"/>
              <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
              <prop v="MM" k="outline_width_unit"/>
              <prop v="diameter" k="scale_method"/>
              <prop v="2" k="size"/>
              <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
              <prop v="MM" k="size_unit"/>
              <prop v="1" k="vertical_anchor_point"/>
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
        <shadow shadowColor="0,0,0,255" shadowRadiusUnit="MM" shadowOpacity="0.69999999999999996" shadowBlendMode="6" shadowOffsetDist="1" shadowOffsetGlobal="1" shadowDraw="0" shadowOffsetAngle="135" shadowRadiusAlphaOnly="0" shadowOffsetUnit="MM" shadowUnder="0" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowScale="100" shadowRadius="1.5"/>
        <dd_properties>
          <Option type="Map">
            <Option name="name" value="" type="QString"/>
            <Option name="properties"/>
            <Option name="type" value="collection" type="QString"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format useMaxLineLengthForAutoWrap="1" formatNumbers="0" wrapChar=";" rightDirectionSymbol=">" reverseDirectionSymbol="0" plussign="0" decimals="3" placeDirectionSymbol="0" multilineAlign="3" autoWrapLength="0" leftDirectionSymbol="&lt;" addDirectionSymbol="0"/>
      <placement layerType="PointGeometry" preserveRotation="1" fitInPolygonOnly="0" lineAnchorType="0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" maxCurvedCharAngleIn="25" lineAnchorPercent="0.5" offsetUnits="MM" geometryGeneratorEnabled="0" rotationAngle="0" distMapUnitScale="3x:0,0,0,0,0,0" centroidWhole="0" centroidInside="0" xOffset="0" repeatDistance="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" polygonPlacementFlags="2" distUnits="MM" repeatDistanceUnits="MM" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" placement="1" geometryGenerator="" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" maxCurvedCharAngleOut="-25" quadOffset="4" offsetType="0" yOffset="0" placementFlags="10" overrunDistanceUnit="MM" dist="10" overrunDistance="0" geometryGeneratorType="PointGeometry" priority="5"/>
      <rendering fontMaxPixelSize="10000" minFeatureSize="0" scaleMin="0" displayAll="0" limitNumLabels="0" scaleVisibility="0" upsidedownLabels="0" fontLimitPixelSize="0" mergeLines="0" labelPerPart="0" obstacleFactor="1" scaleMax="0" maxNumLabels="2000" obstacle="1" fontMinPixelSize="3" zIndex="0" obstacleType="1" drawLabels="1"/>
      <dd_properties>
        <Option type="Map">
          <Option name="name" value="" type="QString"/>
          <Option name="properties" type="Map">
            <Option name="OffsetXY" type="Map">
              <Option name="active" value="true" type="bool"/>
              <Option name="expression" value="format('%1,%2',(5+vector_display_length)*sin(radians(dir)),(5+vector_display_length)*-cos(radians(dir)))" type="QString"/>
              <Option name="type" value="3" type="int"/>
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
          <Option name="lineSymbol" value="&lt;symbol name=&quot;symbol&quot; clip_to_extent=&quot;1&quot; alpha=&quot;1&quot; force_rhr=&quot;0&quot; type=&quot;line&quot;>&lt;layer pass=&quot;0&quot; enabled=&quot;1&quot; locked=&quot;0&quot; class=&quot;SimpleLine&quot;>&lt;prop v=&quot;0&quot; k=&quot;align_dash_pattern&quot;/>&lt;prop v=&quot;square&quot; k=&quot;capstyle&quot;/>&lt;prop v=&quot;5;2&quot; k=&quot;customdash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;customdash_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;customdash_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;dash_pattern_offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;dash_pattern_offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;draw_inside_polygon&quot;/>&lt;prop v=&quot;bevel&quot; k=&quot;joinstyle&quot;/>&lt;prop v=&quot;60,60,60,255&quot; k=&quot;line_color&quot;/>&lt;prop v=&quot;solid&quot; k=&quot;line_style&quot;/>&lt;prop v=&quot;0.3&quot; k=&quot;line_width&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;line_width_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;ring_filter&quot;/>&lt;prop v=&quot;0&quot; k=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;prop v=&quot;0&quot; k=&quot;use_custom_dash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;width_map_unit_scale&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; value=&quot;&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; value=&quot;collection&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString"/>
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
    <alias name="" index="0" field="id_bin"/>
    <alias name="" index="1" field="id"/>
    <alias name="" index="2" field="bin"/>
    <alias name="" index="3" field="depth"/>
    <alias name="" index="4" field="time"/>
    <alias name="" index="5" field="date_break"/>
    <alias name="" index="6" field="velocity"/>
    <alias name="" index="7" field="velocity_major"/>
    <alias name="" index="8" field="dir"/>
    <alias name="" index="9" field="type"/>
    <alias name="" index="10" field="station_name"/>
    <alias name="" index="11" field="station_timeZoneId"/>
    <alias name="" index="12" field="station_timeZoneUTC"/>
    <alias name="" index="13" field="vector_display_length"/>
    <alias name="" index="14" field="local_time"/>
    <alias name="" index="15" field="local_date_str"/>
    <alias name="" index="16" field="vector_saturation"/>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" field="id_bin" expression=""/>
    <default applyOnUpdate="0" field="id" expression=""/>
    <default applyOnUpdate="0" field="bin" expression=""/>
    <default applyOnUpdate="0" field="depth" expression=""/>
    <default applyOnUpdate="0" field="time" expression=""/>
    <default applyOnUpdate="0" field="date_break" expression=""/>
    <default applyOnUpdate="0" field="velocity" expression=""/>
    <default applyOnUpdate="0" field="velocity_major" expression=""/>
    <default applyOnUpdate="0" field="dir" expression=""/>
    <default applyOnUpdate="0" field="type" expression=""/>
    <default applyOnUpdate="0" field="station_name" expression=""/>
    <default applyOnUpdate="0" field="station_timeZoneId" expression=""/>
    <default applyOnUpdate="0" field="station_timeZoneUTC" expression=""/>
    <default applyOnUpdate="0" field="vector_display_length" expression=""/>
    <default applyOnUpdate="0" field="local_time" expression=""/>
    <default applyOnUpdate="0" field="local_date_str" expression=""/>
    <default applyOnUpdate="0" field="vector_saturation" expression=""/>
  </defaults>
  <constraints>
    <constraint notnull_strength="0" field="id_bin" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="id" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="bin" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="depth" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="time" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="date_break" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="velocity" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="velocity_major" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="dir" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="type" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="station_name" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="station_timeZoneId" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="station_timeZoneUTC" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="vector_display_length" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="local_time" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="local_date_str" exp_strength="0" constraints="0" unique_strength="0"/>
    <constraint notnull_strength="0" field="vector_saturation" exp_strength="0" constraints="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="id_bin" exp=""/>
    <constraint desc="" field="id" exp=""/>
    <constraint desc="" field="bin" exp=""/>
    <constraint desc="" field="depth" exp=""/>
    <constraint desc="" field="time" exp=""/>
    <constraint desc="" field="date_break" exp=""/>
    <constraint desc="" field="velocity" exp=""/>
    <constraint desc="" field="velocity_major" exp=""/>
    <constraint desc="" field="dir" exp=""/>
    <constraint desc="" field="type" exp=""/>
    <constraint desc="" field="station_name" exp=""/>
    <constraint desc="" field="station_timeZoneId" exp=""/>
    <constraint desc="" field="station_timeZoneUTC" exp=""/>
    <constraint desc="" field="vector_display_length" exp=""/>
    <constraint desc="" field="local_time" exp=""/>
    <constraint desc="" field="local_date_str" exp=""/>
    <constraint desc="" field="vector_saturation" exp=""/>
  </constraintExpressions>
  <expressionfields>
    <field name="vector_display_length" precision="0" typeName="integer" length="10" comment="" expression="10" type="2" subType="0"/>
    <field name="local_time" precision="0" typeName="datetime" length="-1" comment="" expression="convert_to_time_zone(time,station_timeZoneUTC,station_timeZoneId)" type="16" subType="0"/>
    <field name="local_date_str" precision="0" typeName="string" length="0" comment="" expression="format_date(local_time,'yyyyMMdd')" type="10" subType="0"/>
    <field name="vector_saturation" precision="0" typeName="integer" length="10" comment="" expression="100/(1+exp(-(velocity-1.5)))" type="2" subType="0"/>
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

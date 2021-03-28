<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="1" version="3.16.4-Hannover" readOnly="0" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal mode="1" durationField="" endExpression="" startField="time" endField="" durationUnit="min" accumulate="0" fixedDuration="0" startExpression="" enabled="1">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="1" forceraster="0" type="RuleRenderer" symbollevels="0">
    <rules key="{f82f9c0a-11c0-4463-a530-1848d9ec9562}">
      <rule symbol="0" filter="velocity_major > 0 or type='current'" key="{880197ea-b2a5-4567-aeea-b1d0267480b1}" label="flood"/>
      <rule symbol="1" filter="velocity_major &lt; 0" key="{baa31596-80f6-4974-a7ca-bee6dc792d6b}" label="ebb"/>
      <rule symbol="2" filter="type='slack'" key="{1fe9825b-adb2-48d1-b3a6-f1fd379546c4}" label="slack"/>
    </rules>
    <symbols>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="0.97" name="0">
        <layer class="VectorField" locked="0" pass="0" enabled="1">
          <prop v="0" k="angle_orientation"/>
          <prop v="0" k="angle_units"/>
          <prop v="3x:0,0,0,0,0,0" k="distance_map_unit_scale"/>
          <prop v="MM" k="distance_unit"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="1" k="scale"/>
          <prop v="2" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vector_field_type"/>
          <prop v="vector_display_length" k="x_attribute"/>
          <prop v="dir" k="y_attribute"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" alpha="1" name="@0@0">
            <layer class="ArrowLine" locked="0" pass="0" enabled="1">
              <prop v="3" k="arrow_start_width"/>
              <prop v="MM" k="arrow_start_width_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="arrow_start_width_unit_scale"/>
              <prop v="0" k="arrow_type"/>
              <prop v="3" k="arrow_width"/>
              <prop v="MM" k="arrow_width_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="arrow_width_unit_scale"/>
              <prop v="3" k="head_length"/>
              <prop v="MM" k="head_length_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="head_length_unit_scale"/>
              <prop v="3" k="head_thickness"/>
              <prop v="MM" k="head_thickness_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="head_thickness_unit_scale"/>
              <prop v="0" k="head_type"/>
              <prop v="1" k="is_curved"/>
              <prop v="1" k="is_repeated"/>
              <prop v="0" k="offset"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_unit_scale"/>
              <prop v="0" k="ring_filter"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" type="QString" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="arrowHeadLength">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="arrowHeadThickness">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="arrowStartWidth">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="arrowWidth">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                  </Option>
                  <Option value="collection" type="QString" name="type"/>
                </Option>
              </data_defined_properties>
              <symbol force_rhr="0" clip_to_extent="1" type="fill" alpha="1" name="@@0@0@0">
                <layer class="SimpleFill" locked="0" pass="0" enabled="1">
                  <prop v="3x:0,0,0,0,0,0" k="border_width_map_unit_scale"/>
                  <prop v="55,98,255,255" k="color"/>
                  <prop v="bevel" k="joinstyle"/>
                  <prop v="0,0" k="offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="35,35,35,255" k="outline_color"/>
                  <prop v="solid" k="outline_style"/>
                  <prop v="0.26" k="outline_width"/>
                  <prop v="MM" k="outline_width_unit"/>
                  <prop v="solid" k="style"/>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option value="" type="QString" name="name"/>
                      <Option type="Map" name="properties">
                        <Option type="Map" name="enabled">
                          <Option value="false" type="bool" name="active"/>
                          <Option value="" type="QString" name="expression"/>
                          <Option value="3" type="int" name="type"/>
                        </Option>
                        <Option type="Map" name="fillColor">
                          <Option value="false" type="bool" name="active"/>
                          <Option value="" type="QString" name="expression"/>
                          <Option value="3" type="int" name="type"/>
                        </Option>
                      </Option>
                      <Option value="collection" type="QString" name="type"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="0.97" name="1">
        <layer class="VectorField" locked="0" pass="0" enabled="1">
          <prop v="0" k="angle_orientation"/>
          <prop v="0" k="angle_units"/>
          <prop v="3x:0,0,0,0,0,0" k="distance_map_unit_scale"/>
          <prop v="MM" k="distance_unit"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="1" k="scale"/>
          <prop v="2" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vector_field_type"/>
          <prop v="vector_display_length" k="x_attribute"/>
          <prop v="dir" k="y_attribute"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" alpha="1" name="@1@0">
            <layer class="ArrowLine" locked="0" pass="0" enabled="1">
              <prop v="3" k="arrow_start_width"/>
              <prop v="MM" k="arrow_start_width_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="arrow_start_width_unit_scale"/>
              <prop v="0" k="arrow_type"/>
              <prop v="3" k="arrow_width"/>
              <prop v="MM" k="arrow_width_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="arrow_width_unit_scale"/>
              <prop v="3" k="head_length"/>
              <prop v="MM" k="head_length_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="head_length_unit_scale"/>
              <prop v="3" k="head_thickness"/>
              <prop v="MM" k="head_thickness_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="head_thickness_unit_scale"/>
              <prop v="0" k="head_type"/>
              <prop v="1" k="is_curved"/>
              <prop v="1" k="is_repeated"/>
              <prop v="0" k="offset"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_unit_scale"/>
              <prop v="0" k="ring_filter"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" type="QString" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="arrowHeadLength">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="arrowHeadThickness">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="arrowStartWidth">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="arrowWidth">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="vector_display_width" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                  </Option>
                  <Option value="collection" type="QString" name="type"/>
                </Option>
              </data_defined_properties>
              <symbol force_rhr="0" clip_to_extent="1" type="fill" alpha="1" name="@@1@0@0">
                <layer class="SimpleFill" locked="0" pass="0" enabled="1">
                  <prop v="3x:0,0,0,0,0,0" k="border_width_map_unit_scale"/>
                  <prop v="56,255,176,255" k="color"/>
                  <prop v="bevel" k="joinstyle"/>
                  <prop v="0,0" k="offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="35,35,35,255" k="outline_color"/>
                  <prop v="solid" k="outline_style"/>
                  <prop v="0.26" k="outline_width"/>
                  <prop v="MM" k="outline_width_unit"/>
                  <prop v="solid" k="style"/>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option value="" type="QString" name="name"/>
                      <Option type="Map" name="properties">
                        <Option type="Map" name="enabled">
                          <Option value="false" type="bool" name="active"/>
                          <Option value="" type="QString" name="expression"/>
                          <Option value="3" type="int" name="type"/>
                        </Option>
                        <Option type="Map" name="fillColor">
                          <Option value="false" type="bool" name="active"/>
                          <Option value="" type="QString" name="expression"/>
                          <Option value="3" type="int" name="type"/>
                        </Option>
                      </Option>
                      <Option value="collection" type="QString" name="type"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="1" name="2">
        <layer class="SimpleMarker" locked="0" pass="0" enabled="1">
          <prop v="0" k="angle"/>
          <prop v="0,0,0,255" k="color"/>
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
          <prop v="4" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <orderby>
      <orderByClause nullsFirst="0" asc="1">"velocity"</orderByClause>
    </orderby>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style isExpression="0" previewBkgrdColor="255,255,255,255" fontSizeUnit="Point" fontKerning="1" allowHtml="0" fontStrikeout="0" fontLetterSpacing="0" textOrientation="horizontal" fontUnderline="0" fontWordSpacing="0" fontWeight="50" fontSize="10" textOpacity="1" namedStyle="Regular" textColor="0,0,0,255" useSubstitutions="0" fontFamily=".AppleSystemUIFont" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fieldName="id" fontItalic="0" capitalization="0" blendMode="0" multilineHeight="1">
        <text-buffer bufferNoFill="1" bufferBlendMode="0" bufferSize="1" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferSizeUnits="MM" bufferJoinStyle="128" bufferDraw="1" bufferOpacity="1" bufferColor="255,255,255,255"/>
        <text-mask maskSize="1.5" maskSizeUnits="MM" maskedSymbolLayers="" maskOpacity="1" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskJoinStyle="128" maskEnabled="0" maskType="0"/>
        <background shapeOffsetY="0" shapeBorderColor="128,128,128,255" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeSizeY="0" shapeBorderWidthUnit="MM" shapeRadiiUnit="MM" shapeRotationType="0" shapeRadiiX="0" shapeJoinStyle="64" shapeFillColor="255,255,255,255" shapeOffsetX="0" shapeBlendMode="0" shapeDraw="0" shapeRadiiY="0" shapeBorderWidth="0" shapeOffsetUnit="MM" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeSizeType="0" shapeOpacity="1" shapeRotation="0" shapeSVGFile="" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeSizeX="0" shapeType="0" shapeSizeUnit="MM">
          <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="1" name="markerSymbol">
            <layer class="SimpleMarker" locked="0" pass="0" enabled="1">
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
                  <Option value="" type="QString" name="name"/>
                  <Option name="properties"/>
                  <Option value="collection" type="QString" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowOpacity="0.69999999999999996" shadowScale="100" shadowRadiusAlphaOnly="0" shadowOffsetAngle="135" shadowRadius="1.5" shadowDraw="0" shadowOffsetUnit="MM" shadowOffsetGlobal="1" shadowColor="0,0,0,255" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusUnit="MM" shadowUnder="0" shadowOffsetDist="1" shadowBlendMode="6"/>
        <dd_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format rightDirectionSymbol=">" reverseDirectionSymbol="0" useMaxLineLengthForAutoWrap="1" formatNumbers="0" decimals="3" leftDirectionSymbol="&lt;" plussign="0" multilineAlign="3" autoWrapLength="0" wrapChar="" addDirectionSymbol="0" placeDirectionSymbol="0"/>
      <placement xOffset="0" repeatDistanceUnits="MM" yOffset="5" lineAnchorType="0" maxCurvedCharAngleOut="-25" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" lineAnchorPercent="0.5" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" geometryGenerator="" distUnits="MM" offsetType="0" geometryGeneratorType="PointGeometry" offsetUnits="MM" placementFlags="10" repeatDistance="0" geometryGeneratorEnabled="0" distMapUnitScale="3x:0,0,0,0,0,0" polygonPlacementFlags="2" priority="5" rotationAngle="0" overrunDistanceUnit="MM" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" quadOffset="4" placement="1" dist="10" centroidInside="0" maxCurvedCharAngleIn="25" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" layerType="PointGeometry" fitInPolygonOnly="0" overrunDistance="0" preserveRotation="1" centroidWhole="0"/>
      <rendering mergeLines="0" fontMaxPixelSize="10000" limitNumLabels="0" zIndex="0" fontMinPixelSize="3" scaleMax="0" upsidedownLabels="0" obstacleType="1" minFeatureSize="0" displayAll="0" obstacle="1" scaleMin="0" labelPerPart="0" obstacleFactor="1" drawLabels="1" maxNumLabels="2000" fontLimitPixelSize="0" scaleVisibility="0"/>
      <dd_properties>
        <Option type="Map">
          <Option value="" type="QString" name="name"/>
          <Option type="Map" name="properties">
            <Option type="Map" name="Show">
              <Option value="true" type="bool" name="active"/>
              <Option value="is_selected()" type="QString" name="expression"/>
              <Option value="3" type="int" name="type"/>
            </Option>
          </Option>
          <Option value="collection" type="QString" name="type"/>
        </Option>
      </dd_properties>
      <callout type="simple">
        <Option type="Map">
          <Option value="pole_of_inaccessibility" type="QString" name="anchorPoint"/>
          <Option type="Map" name="ddProperties">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
          <Option value="false" type="bool" name="drawToAllParts"/>
          <Option value="0" type="QString" name="enabled"/>
          <Option value="point_on_exterior" type="QString" name="labelAnchorPoint"/>
          <Option value="&lt;symbol force_rhr=&quot;0&quot; clip_to_extent=&quot;1&quot; type=&quot;line&quot; alpha=&quot;1&quot; name=&quot;symbol&quot;>&lt;layer class=&quot;SimpleLine&quot; locked=&quot;0&quot; pass=&quot;0&quot; enabled=&quot;1&quot;>&lt;prop v=&quot;0&quot; k=&quot;align_dash_pattern&quot;/>&lt;prop v=&quot;square&quot; k=&quot;capstyle&quot;/>&lt;prop v=&quot;5;2&quot; k=&quot;customdash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;customdash_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;customdash_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;dash_pattern_offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;dash_pattern_offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;draw_inside_polygon&quot;/>&lt;prop v=&quot;bevel&quot; k=&quot;joinstyle&quot;/>&lt;prop v=&quot;60,60,60,255&quot; k=&quot;line_color&quot;/>&lt;prop v=&quot;solid&quot; k=&quot;line_style&quot;/>&lt;prop v=&quot;0.3&quot; k=&quot;line_width&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;line_width_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;ring_filter&quot;/>&lt;prop v=&quot;0&quot; k=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;prop v=&quot;0&quot; k=&quot;use_custom_dash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;width_map_unit_scale&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; type=&quot;QString&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; type=&quot;QString&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString" name="lineSymbol"/>
          <Option value="0" type="double" name="minLength"/>
          <Option value="3x:0,0,0,0,0,0" type="QString" name="minLengthMapUnitScale"/>
          <Option value="MM" type="QString" name="minLengthUnit"/>
          <Option value="0" type="double" name="offsetFromAnchor"/>
          <Option value="3x:0,0,0,0,0,0" type="QString" name="offsetFromAnchorMapUnitScale"/>
          <Option value="MM" type="QString" name="offsetFromAnchorUnit"/>
          <Option value="0" type="double" name="offsetFromLabel"/>
          <Option value="3x:0,0,0,0,0,0" type="QString" name="offsetFromLabelMapUnitScale"/>
          <Option value="MM" type="QString" name="offsetFromLabelUnit"/>
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
    <field name="vector_display_length" configurationFlags="None"/>
    <field name="vector_display_width" configurationFlags="None"/>
    <field name="display_time" configurationFlags="None"/>
  </fieldConfiguration>
  <aliases>
    <alias field="id_bin" index="0" name=""/>
    <alias field="id" index="1" name=""/>
    <alias field="bin" index="2" name=""/>
    <alias field="depth" index="3" name=""/>
    <alias field="time" index="4" name=""/>
    <alias field="date_break" index="5" name=""/>
    <alias field="velocity" index="6" name=""/>
    <alias field="velocity_major" index="7" name=""/>
    <alias field="dir" index="8" name=""/>
    <alias field="type" index="9" name=""/>
    <alias field="vector_display_length" index="10" name=""/>
    <alias field="vector_display_width" index="11" name=""/>
    <alias field="display_time" index="12" name=""/>
  </aliases>
  <defaults>
    <default field="id_bin" expression="" applyOnUpdate="0"/>
    <default field="id" expression="" applyOnUpdate="0"/>
    <default field="bin" expression="" applyOnUpdate="0"/>
    <default field="depth" expression="" applyOnUpdate="0"/>
    <default field="time" expression="" applyOnUpdate="0"/>
    <default field="date_break" expression="" applyOnUpdate="0"/>
    <default field="velocity" expression="" applyOnUpdate="0"/>
    <default field="velocity_major" expression="" applyOnUpdate="0"/>
    <default field="dir" expression="" applyOnUpdate="0"/>
    <default field="type" expression="" applyOnUpdate="0"/>
    <default field="vector_display_length" expression="" applyOnUpdate="0"/>
    <default field="vector_display_width" expression="" applyOnUpdate="0"/>
    <default field="display_time" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="0" constraints="0" field="id_bin" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="id" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="bin" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="depth" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="time" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="date_break" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="velocity" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="velocity_major" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="dir" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="type" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="vector_display_length" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="vector_display_width" unique_strength="0" exp_strength="0"/>
    <constraint notnull_strength="0" constraints="0" field="display_time" unique_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="id_bin" desc=""/>
    <constraint exp="" field="id" desc=""/>
    <constraint exp="" field="bin" desc=""/>
    <constraint exp="" field="depth" desc=""/>
    <constraint exp="" field="time" desc=""/>
    <constraint exp="" field="date_break" desc=""/>
    <constraint exp="" field="velocity" desc=""/>
    <constraint exp="" field="velocity_major" desc=""/>
    <constraint exp="" field="dir" desc=""/>
    <constraint exp="" field="type" desc=""/>
    <constraint exp="" field="vector_display_length" desc=""/>
    <constraint exp="" field="vector_display_width" desc=""/>
    <constraint exp="" field="display_time" desc=""/>
  </constraintExpressions>
  <expressionfields>
    <field length="10" expression="10" type="2" typeName="integer" comment="" name="vector_display_length" precision="0" subType="0"/>
    <field length="-1" expression="min(8,max(0.5,4*log(2,velocity + 1)))" type="6" typeName="double precision" comment="" name="vector_display_width" precision="0" subType="0"/>
    <field length="0" expression="format_date(time,'MM/yy mm:dd')" type="10" typeName="string" comment="" name="display_time" precision="0" subType="0"/>
  </expressionfields>
  <previewExpression>"id_bin"</previewExpression>
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
	background-color: #A0D8FF
}
tr.ebb{
	background-color: #A0ffD8
}
tr.date_break {
	border-top: 1px solid #999;
}
td.velocity {
	text-align: right;
}
tr.slack td.velocity {
	visibility: hidden;
}
&lt;/style>
&lt;div class="tip">
	&lt;span class="name">[% attribute(get_feature(@noaa_current_stations_layer,'id',id),'name') %]&lt;/span>
	&lt;br/>
	&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% id_bin %]">Station [% id_bin %]&lt;/a>
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
					   velocity_major,
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

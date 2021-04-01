<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal" labelsEnabled="1" version="3.16.4-Hannover">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal durationField="" startExpression="" startField="time" durationUnit="min" endExpression="" enabled="1" endField="" mode="1" fixedDuration="0" accumulate="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 type="RuleRenderer" enableorderby="1" symbollevels="0" forceraster="0">
    <rules key="{f82f9c0a-11c0-4463-a530-1848d9ec9562}">
      <rule label="slack" key="{db1cb4ea-3e7e-45d5-ae99-18be4af351b9}" symbol="0" filter="type='slack'"/>
      <rule label="current" key="{c3f9e513-78d6-4d83-88b6-8fcf3a2be92f}" symbol="1" filter="velocity_major is null"/>
      <rule label="flood" key="{880197ea-b2a5-4567-aeea-b1d0267480b1}" symbol="2" filter="velocity_major > 0"/>
      <rule label="ebb" key="{baa31596-80f6-4974-a7ca-bee6dc792d6b}" symbol="3" filter="velocity_major &lt; 0"/>
    </rules>
    <symbols>
      <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="marker" name="0">
        <layer class="SimpleMarker" locked="0" enabled="1" pass="0">
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
      <symbol force_rhr="0" alpha="0.97" clip_to_extent="1" type="marker" name="1">
        <layer class="VectorField" locked="0" enabled="1" pass="0">
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
          <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="line" name="@1@0">
            <layer class="ArrowLine" locked="0" enabled="1" pass="0">
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
              <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="fill" name="@@1@0@0">
                <layer class="SimpleFill" locked="0" enabled="1" pass="0">
                  <prop v="3x:0,0,0,0,0,0" k="border_width_map_unit_scale"/>
                  <prop v="55,160,201,255" k="color"/>
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
      <symbol force_rhr="0" alpha="0.97" clip_to_extent="1" type="marker" name="2">
        <layer class="VectorField" locked="0" enabled="1" pass="0">
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
          <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="line" name="@2@0">
            <layer class="ArrowLine" locked="0" enabled="1" pass="0">
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
              <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="fill" name="@@2@0@0">
                <layer class="SimpleFill" locked="0" enabled="1" pass="0">
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
      <symbol force_rhr="0" alpha="0.97" clip_to_extent="1" type="marker" name="3">
        <layer class="VectorField" locked="0" enabled="1" pass="0">
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
          <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="line" name="@3@0">
            <layer class="ArrowLine" locked="0" enabled="1" pass="0">
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
              <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="fill" name="@@3@0@0">
                <layer class="SimpleFill" locked="0" enabled="1" pass="0">
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
    </symbols>
    <orderby>
      <orderByClause nullsFirst="0" asc="1">"velocity"</orderByClause>
    </orderby>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontLetterSpacing="0" fontKerning="1" isExpression="1" fontWeight="50" fontFamily=".AppleSystemUIFont" fontSize="10" fontSizeUnit="Point" textColor="0,0,0,255" fontUnderline="0" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontItalic="0" allowHtml="0" fontWordSpacing="0" multilineHeight="1" capitalization="0" fieldName="format('%1;%2kt',format_date(time,'hh:mm'),format_number(velocity,1))" textOpacity="1" fontStrikeout="0" useSubstitutions="0" previewBkgrdColor="255,255,255,255" textOrientation="horizontal" namedStyle="Regular" blendMode="0">
        <text-buffer bufferColor="255,255,255,255" bufferNoFill="1" bufferSizeUnits="MM" bufferBlendMode="0" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferOpacity="1" bufferDraw="1" bufferJoinStyle="128" bufferSize="1"/>
        <text-mask maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskOpacity="1" maskType="0" maskJoinStyle="128" maskSizeUnits="MM" maskedSymbolLayers="" maskEnabled="0" maskSize="1.5"/>
        <background shapeRadiiX="0" shapeRotation="0" shapeJoinStyle="64" shapeFillColor="255,255,255,255" shapeDraw="0" shapeRadiiY="0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeSizeType="0" shapeBlendMode="0" shapeRotationType="0" shapeRadiiUnit="MM" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidth="0" shapeBorderWidthUnit="MM" shapeSVGFile="" shapeSizeUnit="MM" shapeType="0" shapeBorderColor="128,128,128,255" shapeOffsetX="0" shapeSizeY="0" shapeOpacity="1" shapeSizeX="0" shapeOffsetY="0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetUnit="MM">
          <symbol force_rhr="0" alpha="1" clip_to_extent="1" type="marker" name="markerSymbol">
            <layer class="SimpleMarker" locked="0" enabled="1" pass="0">
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
        <shadow shadowUnder="0" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowColor="0,0,0,255" shadowRadius="1.5" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetAngle="135" shadowOffsetGlobal="1" shadowRadiusAlphaOnly="0" shadowDraw="0" shadowBlendMode="6" shadowScale="100" shadowOpacity="0.69999999999999996" shadowRadiusUnit="MM" shadowOffsetDist="1" shadowOffsetUnit="MM"/>
        <dd_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format rightDirectionSymbol=">" reverseDirectionSymbol="0" decimals="3" wrapChar=";" useMaxLineLengthForAutoWrap="1" leftDirectionSymbol="&lt;" autoWrapLength="0" multilineAlign="3" formatNumbers="0" addDirectionSymbol="0" placeDirectionSymbol="0" plussign="0"/>
      <placement centroidInside="0" geometryGenerator="" polygonPlacementFlags="2" maxCurvedCharAngleIn="25" geometryGeneratorType="PointGeometry" xOffset="0" repeatDistance="0" lineAnchorType="0" placementFlags="10" priority="5" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" repeatDistanceUnits="MM" yOffset="0" offsetType="0" preserveRotation="1" rotationAngle="0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" offsetUnits="MM" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceUnit="MM" lineAnchorPercent="0.5" overrunDistance="0" layerType="PointGeometry" centroidWhole="0" quadOffset="4" distUnits="MM" maxCurvedCharAngleOut="-25" placement="1" fitInPolygonOnly="0" geometryGeneratorEnabled="0" distMapUnitScale="3x:0,0,0,0,0,0" dist="10"/>
      <rendering displayAll="0" fontMinPixelSize="3" fontLimitPixelSize="0" obstacleFactor="1" obstacleType="1" zIndex="0" maxNumLabels="2000" obstacle="1" mergeLines="0" fontMaxPixelSize="10000" scaleMax="0" scaleMin="0" limitNumLabels="0" upsidedownLabels="0" labelPerPart="0" scaleVisibility="0" minFeatureSize="0" drawLabels="1"/>
      <dd_properties>
        <Option type="Map">
          <Option value="" type="QString" name="name"/>
          <Option type="Map" name="properties">
            <Option type="Map" name="OffsetXY">
              <Option value="true" type="bool" name="active"/>
              <Option value="format('%1,%2',(5+vector_display_length)*sin(radians(dir)),(5+vector_display_length)*-cos(radians(dir)))" type="QString" name="expression"/>
              <Option value="3" type="int" name="type"/>
            </Option>
            <Option type="Map" name="Show">
              <Option value="true" type="bool" name="active"/>
              <Option value="(@map_start_time is not null) and (type = 'ebb' or type = 'flood')" type="QString" name="expression"/>
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
          <Option value="&lt;symbol force_rhr=&quot;0&quot; alpha=&quot;1&quot; clip_to_extent=&quot;1&quot; type=&quot;line&quot; name=&quot;symbol&quot;>&lt;layer class=&quot;SimpleLine&quot; locked=&quot;0&quot; enabled=&quot;1&quot; pass=&quot;0&quot;>&lt;prop v=&quot;0&quot; k=&quot;align_dash_pattern&quot;/>&lt;prop v=&quot;square&quot; k=&quot;capstyle&quot;/>&lt;prop v=&quot;5;2&quot; k=&quot;customdash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;customdash_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;customdash_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;dash_pattern_offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;dash_pattern_offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;draw_inside_polygon&quot;/>&lt;prop v=&quot;bevel&quot; k=&quot;joinstyle&quot;/>&lt;prop v=&quot;60,60,60,255&quot; k=&quot;line_color&quot;/>&lt;prop v=&quot;solid&quot; k=&quot;line_style&quot;/>&lt;prop v=&quot;0.3&quot; k=&quot;line_width&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;line_width_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;ring_filter&quot;/>&lt;prop v=&quot;0&quot; k=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;prop v=&quot;0&quot; k=&quot;use_custom_dash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;width_map_unit_scale&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; type=&quot;QString&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; type=&quot;QString&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString" name="lineSymbol"/>
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
    <field configurationFlags="None" name="id_bin"/>
    <field configurationFlags="None" name="id"/>
    <field configurationFlags="None" name="bin"/>
    <field configurationFlags="None" name="depth"/>
    <field configurationFlags="None" name="time"/>
    <field configurationFlags="None" name="date_break"/>
    <field configurationFlags="None" name="velocity"/>
    <field configurationFlags="None" name="velocity_major"/>
    <field configurationFlags="None" name="dir"/>
    <field configurationFlags="None" name="type"/>
    <field configurationFlags="None" name="station_name"/>
    <field configurationFlags="None" name="vector_display_length"/>
    <field configurationFlags="None" name="vector_display_width"/>
    <field configurationFlags="None" name="display_time"/>
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
    <alias field="station_name" index="10" name=""/>
    <alias field="vector_display_length" index="11" name=""/>
    <alias field="vector_display_width" index="12" name=""/>
    <alias field="display_time" index="13" name=""/>
  </aliases>
  <defaults>
    <default field="id_bin" applyOnUpdate="0" expression=""/>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="bin" applyOnUpdate="0" expression=""/>
    <default field="depth" applyOnUpdate="0" expression=""/>
    <default field="time" applyOnUpdate="0" expression=""/>
    <default field="date_break" applyOnUpdate="0" expression=""/>
    <default field="velocity" applyOnUpdate="0" expression=""/>
    <default field="velocity_major" applyOnUpdate="0" expression=""/>
    <default field="dir" applyOnUpdate="0" expression=""/>
    <default field="type" applyOnUpdate="0" expression=""/>
    <default field="station_name" applyOnUpdate="0" expression=""/>
    <default field="vector_display_length" applyOnUpdate="0" expression=""/>
    <default field="vector_display_width" applyOnUpdate="0" expression=""/>
    <default field="display_time" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="id_bin" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="id" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="bin" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="depth" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="time" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="date_break" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="velocity" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="velocity_major" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="dir" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="type" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="station_name" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="vector_display_length" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="vector_display_width" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="display_time" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="id_bin" desc="" exp=""/>
    <constraint field="id" desc="" exp=""/>
    <constraint field="bin" desc="" exp=""/>
    <constraint field="depth" desc="" exp=""/>
    <constraint field="time" desc="" exp=""/>
    <constraint field="date_break" desc="" exp=""/>
    <constraint field="velocity" desc="" exp=""/>
    <constraint field="velocity_major" desc="" exp=""/>
    <constraint field="dir" desc="" exp=""/>
    <constraint field="type" desc="" exp=""/>
    <constraint field="station_name" desc="" exp=""/>
    <constraint field="vector_display_length" desc="" exp=""/>
    <constraint field="vector_display_width" desc="" exp=""/>
    <constraint field="display_time" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields>
    <field typeName="integer" length="10" type="2" comment="" precision="0" subType="0" expression="10" name="vector_display_length"/>
    <field typeName="double precision" length="-1" type="6" comment="" precision="0" subType="0" expression="min(8,max(0.5,4*log(2,velocity + 1)))" name="vector_display_width"/>
    <field typeName="string" length="0" type="10" comment="" precision="0" subType="0" expression="format_date(time,'MM/yy mm:dd')" name="display_time"/>
  </expressionfields>
  <previewExpression>id_bin + ' ' + format_date(time,'yyyyMMdd hh:mm')</previewExpression>
  <mapTip>&lt;style>
.tip {
	width: 160px;
	max-height: 200px;
	overflow-y: auto;
	font-size: 12px;
  font-family: sans-serif;
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
    font-size: 12px;
	padding: 1px 5px 1px 15px;
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
tr.date_break td {
	font-weight: bold;
	padding-left: 0px;
}
td.velocity {
	text-align: right;
}
tr.slack td.velocity {
	visibility: hidden;
}
&lt;/style>
&lt;div class="tip">
	&lt;span class="name">[% station_name %]&lt;/span>
	&lt;br/>
	&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% id_bin %]&amp;d=[% format_date(minimum(time), 'yyyy-MM-dd') %]">Station [% id_bin %]&lt;/a>
	&lt;div class="predict">
		&lt;table>
		&lt;tbody>
		[%
			with_variable('station_id',id,
				concatenate(
				  if(date_break,
				     '&lt;tr class="date_break">&lt;td colspan="3">'+
					   format_date(time,'MM/dd/yyyy')+
					   '&lt;/td>&lt;/tr>','')+
				  format('
				  &lt;tr class="%1">
					&lt;td class="time">%2&lt;/td>
					&lt;td class="type">%3&lt;/td>
					&lt;td class="velocity">%4&lt;/td>
				  &lt;/tr>',
					   type,
					   format_date(time,'hh:mm'),
					   if(velocity_major is null,to_string(dir)+'º',type),
					   if(velocity_major is null,velocity,velocity_major),
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

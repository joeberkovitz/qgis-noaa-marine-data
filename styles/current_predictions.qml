<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.4-Hannover" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal" readOnly="0" labelsEnabled="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal enabled="1" endField="" mode="1" startExpression="" fixedDuration="0" startField="time" endExpression="" durationUnit="min" accumulate="0" durationField="">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 type="RuleRenderer" symbollevels="0" forceraster="0" enableorderby="1">
    <rules key="{f82f9c0a-11c0-4463-a530-1848d9ec9562}">
      <rule symbol="0" filter="type='slack'" key="{db1cb4ea-3e7e-45d5-ae99-18be4af351b9}" label="slack"/>
      <rule symbol="1" filter="velocity_major is null" key="{c3f9e513-78d6-4d83-88b6-8fcf3a2be92f}" label="current"/>
      <rule symbol="2" filter="type='flood'" key="{880197ea-b2a5-4567-aeea-b1d0267480b1}" label="flood"/>
      <rule symbol="3" filter="type='ebb'" key="{baa31596-80f6-4974-a7ca-bee6dc792d6b}" label="ebb"/>
    </rules>
    <symbols>
      <symbol type="marker" clip_to_extent="1" force_rhr="0" alpha="1" name="0">
        <layer enabled="1" pass="0" class="SimpleMarker" locked="0">
          <prop k="angle" v="0"/>
          <prop k="color" v="0,0,0,0"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="miter"/>
          <prop k="name" v="triangle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.4"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" clip_to_extent="1" force_rhr="0" alpha="0.97" name="1">
        <layer enabled="1" pass="0" class="VectorField" locked="0">
          <prop k="angle_orientation" v="0"/>
          <prop k="angle_units" v="0"/>
          <prop k="distance_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="distance_unit" v="MM"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="scale" v="1"/>
          <prop k="size" v="2"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vector_field_type" v="1"/>
          <prop k="x_attribute" v="vector_display_length"/>
          <prop k="y_attribute" v="dir"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol type="line" clip_to_extent="1" force_rhr="0" alpha="1" name="@1@0">
            <layer enabled="1" pass="0" class="ArrowLine" locked="0">
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
              <symbol type="fill" clip_to_extent="1" force_rhr="0" alpha="1" name="@@1@0@0">
                <layer enabled="1" pass="0" class="SimpleFill" locked="0">
                  <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="55,160,201,255"/>
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
      <symbol type="marker" clip_to_extent="1" force_rhr="0" alpha="0.97" name="2">
        <layer enabled="1" pass="0" class="VectorField" locked="0">
          <prop k="angle_orientation" v="0"/>
          <prop k="angle_units" v="0"/>
          <prop k="distance_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="distance_unit" v="MM"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="scale" v="1"/>
          <prop k="size" v="2"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vector_field_type" v="1"/>
          <prop k="x_attribute" v="vector_display_length"/>
          <prop k="y_attribute" v="dir"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol type="line" clip_to_extent="1" force_rhr="0" alpha="1" name="@2@0">
            <layer enabled="1" pass="0" class="ArrowLine" locked="0">
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
              <symbol type="fill" clip_to_extent="1" force_rhr="0" alpha="1" name="@@2@0@0">
                <layer enabled="1" pass="0" class="SimpleFill" locked="0">
                  <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="55,98,255,255"/>
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
      <symbol type="marker" clip_to_extent="1" force_rhr="0" alpha="0.97" name="3">
        <layer enabled="1" pass="0" class="VectorField" locked="0">
          <prop k="angle_orientation" v="0"/>
          <prop k="angle_units" v="0"/>
          <prop k="distance_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="distance_unit" v="MM"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="scale" v="1"/>
          <prop k="size" v="2"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vector_field_type" v="1"/>
          <prop k="x_attribute" v="vector_display_length"/>
          <prop k="y_attribute" v="dir"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol type="line" clip_to_extent="1" force_rhr="0" alpha="1" name="@3@0">
            <layer enabled="1" pass="0" class="ArrowLine" locked="0">
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
              <symbol type="fill" clip_to_extent="1" force_rhr="0" alpha="1" name="@@3@0@0">
                <layer enabled="1" pass="0" class="SimpleFill" locked="0">
                  <prop k="border_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="56,255,176,255"/>
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
      <text-style fontUnderline="0" fontWeight="50" namedStyle="Regular" previewBkgrdColor="255,255,255,255" fontItalic="0" textColor="0,0,0,255" fontKerning="1" blendMode="0" textOpacity="1" fontLetterSpacing="0" fieldName="format('%1;%2kt',format_date(local_time,'hh:mm'),format_number(velocity,1))" textOrientation="horizontal" fontSize="10" fontWordSpacing="0" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontSizeUnit="Point" useSubstitutions="0" isExpression="1" fontStrikeout="0" multilineHeight="1" allowHtml="0" capitalization="0" fontFamily=".AppleSystemUIFont">
        <text-buffer bufferDraw="1" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferSizeUnits="MM" bufferJoinStyle="128" bufferBlendMode="0" bufferSize="1" bufferNoFill="1" bufferColor="255,255,255,255" bufferOpacity="1"/>
        <text-mask maskJoinStyle="128" maskEnabled="0" maskType="0" maskSizeUnits="MM" maskOpacity="1" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskedSymbolLayers="" maskSize="1.5"/>
        <background shapeJoinStyle="64" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeSizeType="0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeRotation="0" shapeBorderColor="128,128,128,255" shapeRadiiUnit="MM" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeOffsetY="0" shapeBlendMode="0" shapeBorderWidthUnit="MM" shapeRotationType="0" shapeOpacity="1" shapeSizeX="0" shapeRadiiX="0" shapeType="0" shapeSizeY="0" shapeDraw="0" shapeOffsetX="0" shapeBorderWidth="0" shapeSizeUnit="MM" shapeOffsetUnit="MM" shapeRadiiY="0" shapeSVGFile="" shapeFillColor="255,255,255,255">
          <symbol type="marker" clip_to_extent="1" force_rhr="0" alpha="1" name="markerSymbol">
            <layer enabled="1" pass="0" class="SimpleMarker" locked="0">
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
                  <Option value="" type="QString" name="name"/>
                  <Option name="properties"/>
                  <Option value="collection" type="QString" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowOpacity="0.69999999999999996" shadowOffsetUnit="MM" shadowOffsetDist="1" shadowColor="0,0,0,255" shadowRadius="1.5" shadowScale="100" shadowRadiusUnit="MM" shadowDraw="0" shadowUnder="0" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusAlphaOnly="0" shadowOffsetAngle="135" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetGlobal="1" shadowBlendMode="6"/>
        <dd_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format placeDirectionSymbol="0" multilineAlign="3" plussign="0" formatNumbers="0" addDirectionSymbol="0" wrapChar=";" useMaxLineLengthForAutoWrap="1" autoWrapLength="0" leftDirectionSymbol="&lt;" rightDirectionSymbol=">" reverseDirectionSymbol="0" decimals="3"/>
      <placement distUnits="MM" geometryGeneratorType="PointGeometry" distMapUnitScale="3x:0,0,0,0,0,0" overrunDistance="0" preserveRotation="1" repeatDistanceUnits="MM" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" repeatDistance="0" geometryGeneratorEnabled="0" lineAnchorPercent="0.5" offsetUnits="MM" priority="5" layerType="PointGeometry" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" xOffset="0" yOffset="0" lineAnchorType="0" placement="1" overrunDistanceUnit="MM" rotationAngle="0" centroidWhole="0" dist="10" polygonPlacementFlags="2" placementFlags="10" maxCurvedCharAngleOut="-25" centroidInside="0" fitInPolygonOnly="0" maxCurvedCharAngleIn="25" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" offsetType="0" geometryGenerator="" quadOffset="4" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0"/>
      <rendering fontMaxPixelSize="10000" scaleVisibility="0" upsidedownLabels="0" drawLabels="1" scaleMax="0" fontLimitPixelSize="0" fontMinPixelSize="3" displayAll="0" obstacleType="1" minFeatureSize="0" obstacle="1" mergeLines="0" maxNumLabels="2000" zIndex="0" limitNumLabels="0" obstacleFactor="1" scaleMin="0" labelPerPart="0"/>
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
          <Option value="&lt;symbol type=&quot;line&quot; clip_to_extent=&quot;1&quot; force_rhr=&quot;0&quot; alpha=&quot;1&quot; name=&quot;symbol&quot;>&lt;layer enabled=&quot;1&quot; pass=&quot;0&quot; class=&quot;SimpleLine&quot; locked=&quot;0&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; type=&quot;QString&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; type=&quot;QString&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString" name="lineSymbol"/>
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
    <field configurationFlags="None" name="station_timeZoneId"/>
    <field configurationFlags="None" name="station_timeZoneUTC"/>
    <field configurationFlags="None" name="vector_display_length"/>
    <field configurationFlags="None" name="vector_display_width"/>
    <field configurationFlags="None" name="local_time"/>
    <field configurationFlags="None" name="local_date_str"/>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="id_bin" name=""/>
    <alias index="1" field="id" name=""/>
    <alias index="2" field="bin" name=""/>
    <alias index="3" field="depth" name=""/>
    <alias index="4" field="time" name=""/>
    <alias index="5" field="date_break" name=""/>
    <alias index="6" field="velocity" name=""/>
    <alias index="7" field="velocity_major" name=""/>
    <alias index="8" field="dir" name=""/>
    <alias index="9" field="type" name=""/>
    <alias index="10" field="station_name" name=""/>
    <alias index="11" field="station_timeZoneId" name=""/>
    <alias index="12" field="station_timeZoneUTC" name=""/>
    <alias index="13" field="vector_display_length" name=""/>
    <alias index="14" field="vector_display_width" name=""/>
    <alias index="15" field="local_time" name=""/>
    <alias index="16" field="local_date_str" name=""/>
  </aliases>
  <defaults>
    <default expression="" field="id_bin" applyOnUpdate="0"/>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="bin" applyOnUpdate="0"/>
    <default expression="" field="depth" applyOnUpdate="0"/>
    <default expression="" field="time" applyOnUpdate="0"/>
    <default expression="" field="date_break" applyOnUpdate="0"/>
    <default expression="" field="velocity" applyOnUpdate="0"/>
    <default expression="" field="velocity_major" applyOnUpdate="0"/>
    <default expression="" field="dir" applyOnUpdate="0"/>
    <default expression="" field="type" applyOnUpdate="0"/>
    <default expression="" field="station_name" applyOnUpdate="0"/>
    <default expression="" field="station_timeZoneId" applyOnUpdate="0"/>
    <default expression="" field="station_timeZoneUTC" applyOnUpdate="0"/>
    <default expression="" field="vector_display_length" applyOnUpdate="0"/>
    <default expression="" field="vector_display_width" applyOnUpdate="0"/>
    <default expression="" field="local_time" applyOnUpdate="0"/>
    <default expression="" field="local_date_str" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint unique_strength="0" exp_strength="0" field="id_bin" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="id" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="bin" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="depth" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="time" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="date_break" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="velocity" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="velocity_major" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="dir" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="type" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="station_name" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="station_timeZoneId" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="station_timeZoneUTC" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="vector_display_length" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="vector_display_width" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="local_time" notnull_strength="0" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" field="local_date_str" notnull_strength="0" constraints="0"/>
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
    <constraint exp="" field="station_name" desc=""/>
    <constraint exp="" field="station_timeZoneId" desc=""/>
    <constraint exp="" field="station_timeZoneUTC" desc=""/>
    <constraint exp="" field="vector_display_length" desc=""/>
    <constraint exp="" field="vector_display_width" desc=""/>
    <constraint exp="" field="local_time" desc=""/>
    <constraint exp="" field="local_date_str" desc=""/>
  </constraintExpressions>
  <expressionfields>
    <field expression="10" type="2" length="10" subType="0" precision="0" typeName="integer" comment="" name="vector_display_length"/>
    <field expression="min(8,max(0.5,4*log(2,velocity + 1)))" type="6" length="-1" subType="0" precision="0" typeName="double precision" comment="" name="vector_display_width"/>
    <field expression="convert_to_time_zone(time,station_timeZoneUTC,station_timeZoneId)" type="16" length="-1" subType="0" precision="0" typeName="datetime" comment="" name="local_time"/>
    <field expression="format_date(local_time,'yyyyMMdd')" type="10" length="0" subType="0" precision="0" typeName="string" comment="" name="local_date_str"/>
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

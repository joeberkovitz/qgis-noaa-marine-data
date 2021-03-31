<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="1" version="3.16.4-Hannover" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal enabled="1" mode="1" durationField="" durationUnit="min" endField="" endExpression="" fixedDuration="0" accumulate="0" startField="time" startExpression="">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="1" forceraster="0" type="RuleRenderer" symbollevels="0">
    <rules key="{f82f9c0a-11c0-4463-a530-1848d9ec9562}">
      <rule symbol="0" key="{db1cb4ea-3e7e-45d5-ae99-18be4af351b9}" label="slack" filter="type='slack'"/>
      <rule symbol="1" key="{c3f9e513-78d6-4d83-88b6-8fcf3a2be92f}" label="current" filter="velocity_major is null"/>
      <rule symbol="2" key="{880197ea-b2a5-4567-aeea-b1d0267480b1}" label="flood" filter="velocity_major > 0"/>
      <rule symbol="3" key="{baa31596-80f6-4974-a7ca-bee6dc792d6b}" label="ebb" filter="velocity_major &lt; 0"/>
    </rules>
    <symbols>
      <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="0" type="marker">
        <layer enabled="1" class="SimpleMarker" locked="0" pass="0">
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
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" alpha="0.97" name="1" type="marker">
        <layer enabled="1" class="VectorField" locked="0" pass="0">
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
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="@1@0" type="line">
            <layer enabled="1" class="ArrowLine" locked="0" pass="0">
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
                  <Option value="" name="name" type="QString"/>
                  <Option name="properties" type="Map">
                    <Option name="arrowHeadLength" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowHeadThickness" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowStartWidth" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowWidth" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                  </Option>
                  <Option value="collection" name="type" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="@@1@0@0" type="fill">
                <layer enabled="1" class="SimpleFill" locked="0" pass="0">
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
                      <Option value="" name="name" type="QString"/>
                      <Option name="properties" type="Map">
                        <Option name="enabled" type="Map">
                          <Option value="false" name="active" type="bool"/>
                          <Option value="" name="expression" type="QString"/>
                          <Option value="3" name="type" type="int"/>
                        </Option>
                        <Option name="fillColor" type="Map">
                          <Option value="false" name="active" type="bool"/>
                          <Option value="" name="expression" type="QString"/>
                          <Option value="3" name="type" type="int"/>
                        </Option>
                      </Option>
                      <Option value="collection" name="type" type="QString"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" alpha="0.97" name="2" type="marker">
        <layer enabled="1" class="VectorField" locked="0" pass="0">
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
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="@2@0" type="line">
            <layer enabled="1" class="ArrowLine" locked="0" pass="0">
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
                  <Option value="" name="name" type="QString"/>
                  <Option name="properties" type="Map">
                    <Option name="arrowHeadLength" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowHeadThickness" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowStartWidth" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowWidth" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                  </Option>
                  <Option value="collection" name="type" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="@@2@0@0" type="fill">
                <layer enabled="1" class="SimpleFill" locked="0" pass="0">
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
                      <Option value="" name="name" type="QString"/>
                      <Option name="properties" type="Map">
                        <Option name="enabled" type="Map">
                          <Option value="false" name="active" type="bool"/>
                          <Option value="" name="expression" type="QString"/>
                          <Option value="3" name="type" type="int"/>
                        </Option>
                        <Option name="fillColor" type="Map">
                          <Option value="false" name="active" type="bool"/>
                          <Option value="" name="expression" type="QString"/>
                          <Option value="3" name="type" type="int"/>
                        </Option>
                      </Option>
                      <Option value="collection" name="type" type="QString"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" force_rhr="0" alpha="0.97" name="3" type="marker">
        <layer enabled="1" class="VectorField" locked="0" pass="0">
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
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="@3@0" type="line">
            <layer enabled="1" class="ArrowLine" locked="0" pass="0">
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
                  <Option value="" name="name" type="QString"/>
                  <Option name="properties" type="Map">
                    <Option name="arrowHeadLength" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowHeadThickness" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowStartWidth" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="arrowWidth" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="vector_display_width" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                  </Option>
                  <Option value="collection" name="type" type="QString"/>
                </Option>
              </data_defined_properties>
              <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="@@3@0@0" type="fill">
                <layer enabled="1" class="SimpleFill" locked="0" pass="0">
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
                      <Option value="" name="name" type="QString"/>
                      <Option name="properties" type="Map">
                        <Option name="enabled" type="Map">
                          <Option value="false" name="active" type="bool"/>
                          <Option value="" name="expression" type="QString"/>
                          <Option value="3" name="type" type="int"/>
                        </Option>
                        <Option name="fillColor" type="Map">
                          <Option value="false" name="active" type="bool"/>
                          <Option value="" name="expression" type="QString"/>
                          <Option value="3" name="type" type="int"/>
                        </Option>
                      </Option>
                      <Option value="collection" name="type" type="QString"/>
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
      <text-style fontItalic="0" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontKerning="1" fontSize="10" useSubstitutions="0" fieldName="format('%1;%2kt',format_date(time,'hh:mm'),format_number(velocity,1))" namedStyle="Regular" fontStrikeout="0" fontUnderline="0" multilineHeight="1" capitalization="0" fontWordSpacing="0" blendMode="0" isExpression="1" textOrientation="horizontal" allowHtml="0" previewBkgrdColor="255,255,255,255" fontSizeUnit="Point" fontFamily=".AppleSystemUIFont" textOpacity="1" textColor="0,0,0,255" fontWeight="50" fontLetterSpacing="0">
        <text-buffer bufferJoinStyle="128" bufferNoFill="1" bufferSizeUnits="MM" bufferBlendMode="0" bufferDraw="1" bufferSize="1" bufferOpacity="1" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferColor="255,255,255,255"/>
        <text-mask maskSizeUnits="MM" maskJoinStyle="128" maskOpacity="1" maskEnabled="0" maskSize="1.5" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskType="0" maskedSymbolLayers=""/>
        <background shapeBorderColor="128,128,128,255" shapeBorderWidth="0" shapeRotationType="0" shapeRadiiUnit="MM" shapeType="0" shapeDraw="0" shapeOpacity="1" shapeRadiiY="0" shapeOffsetUnit="MM" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiX="0" shapeOffsetY="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeSizeY="0" shapeSVGFile="" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeSizeUnit="MM" shapeJoinStyle="64" shapeBlendMode="0" shapeFillColor="255,255,255,255" shapeOffsetX="0" shapeRotation="0" shapeBorderWidthUnit="MM" shapeSizeX="0" shapeSizeType="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0">
          <symbol clip_to_extent="1" force_rhr="0" alpha="1" name="markerSymbol" type="marker">
            <layer enabled="1" class="SimpleMarker" locked="0" pass="0">
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
                  <Option value="" name="name" type="QString"/>
                  <Option name="properties"/>
                  <Option value="collection" name="type" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowOffsetAngle="135" shadowScale="100" shadowBlendMode="6" shadowOffsetUnit="MM" shadowDraw="0" shadowOpacity="0.69999999999999996" shadowOffsetGlobal="1" shadowColor="0,0,0,255" shadowRadiusAlphaOnly="0" shadowRadius="1.5" shadowUnder="0" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetDist="1" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusUnit="MM"/>
        <dd_properties>
          <Option type="Map">
            <Option value="" name="name" type="QString"/>
            <Option name="properties"/>
            <Option value="collection" name="type" type="QString"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format placeDirectionSymbol="0" wrapChar=";" autoWrapLength="0" addDirectionSymbol="0" decimals="3" reverseDirectionSymbol="0" rightDirectionSymbol=">" multilineAlign="3" useMaxLineLengthForAutoWrap="1" leftDirectionSymbol="&lt;" formatNumbers="0" plussign="0"/>
      <placement dist="10" repeatDistanceUnits="MM" geometryGenerator="" geometryGeneratorEnabled="0" offsetType="0" priority="5" overrunDistanceUnit="MM" geometryGeneratorType="PointGeometry" centroidInside="0" lineAnchorType="0" maxCurvedCharAngleOut="-25" offsetUnits="MM" distMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" placement="1" maxCurvedCharAngleIn="25" fitInPolygonOnly="0" polygonPlacementFlags="2" repeatDistance="0" quadOffset="4" distUnits="MM" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" lineAnchorPercent="0.5" layerType="PointGeometry" xOffset="0" yOffset="0" rotationAngle="0" centroidWhole="0" preserveRotation="1" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistance="0" placementFlags="10"/>
      <rendering mergeLines="0" scaleVisibility="0" fontMaxPixelSize="10000" fontLimitPixelSize="0" obstacleFactor="1" fontMinPixelSize="3" drawLabels="1" maxNumLabels="2000" obstacle="1" obstacleType="1" scaleMin="0" labelPerPart="0" upsidedownLabels="0" zIndex="0" minFeatureSize="0" limitNumLabels="0" scaleMax="0" displayAll="0"/>
      <dd_properties>
        <Option type="Map">
          <Option value="" name="name" type="QString"/>
          <Option name="properties" type="Map">
            <Option name="OffsetXY" type="Map">
              <Option value="true" name="active" type="bool"/>
              <Option value="format('%1,%2',(5+vector_display_length)*sin(radians(dir)),(5+vector_display_length)*-cos(radians(dir)))" name="expression" type="QString"/>
              <Option value="3" name="type" type="int"/>
            </Option>
            <Option name="Show" type="Map">
              <Option value="true" name="active" type="bool"/>
              <Option value="(@map_start_time is not null) and (type = 'ebb' or type = 'flood')" name="expression" type="QString"/>
              <Option value="3" name="type" type="int"/>
            </Option>
          </Option>
          <Option value="collection" name="type" type="QString"/>
        </Option>
      </dd_properties>
      <callout type="simple">
        <Option type="Map">
          <Option value="pole_of_inaccessibility" name="anchorPoint" type="QString"/>
          <Option name="ddProperties" type="Map">
            <Option value="" name="name" type="QString"/>
            <Option name="properties"/>
            <Option value="collection" name="type" type="QString"/>
          </Option>
          <Option value="false" name="drawToAllParts" type="bool"/>
          <Option value="0" name="enabled" type="QString"/>
          <Option value="point_on_exterior" name="labelAnchorPoint" type="QString"/>
          <Option value="&lt;symbol clip_to_extent=&quot;1&quot; force_rhr=&quot;0&quot; alpha=&quot;1&quot; name=&quot;symbol&quot; type=&quot;line&quot;>&lt;layer enabled=&quot;1&quot; class=&quot;SimpleLine&quot; locked=&quot;0&quot; pass=&quot;0&quot;>&lt;prop v=&quot;0&quot; k=&quot;align_dash_pattern&quot;/>&lt;prop v=&quot;square&quot; k=&quot;capstyle&quot;/>&lt;prop v=&quot;5;2&quot; k=&quot;customdash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;customdash_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;customdash_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;dash_pattern_offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;dash_pattern_offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;draw_inside_polygon&quot;/>&lt;prop v=&quot;bevel&quot; k=&quot;joinstyle&quot;/>&lt;prop v=&quot;60,60,60,255&quot; k=&quot;line_color&quot;/>&lt;prop v=&quot;solid&quot; k=&quot;line_style&quot;/>&lt;prop v=&quot;0.3&quot; k=&quot;line_width&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;line_width_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;ring_filter&quot;/>&lt;prop v=&quot;0&quot; k=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;prop v=&quot;0&quot; k=&quot;use_custom_dash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;width_map_unit_scale&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; name=&quot;name&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; name=&quot;type&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" name="lineSymbol" type="QString"/>
          <Option value="0" name="minLength" type="double"/>
          <Option value="3x:0,0,0,0,0,0" name="minLengthMapUnitScale" type="QString"/>
          <Option value="MM" name="minLengthUnit" type="QString"/>
          <Option value="0" name="offsetFromAnchor" type="double"/>
          <Option value="3x:0,0,0,0,0,0" name="offsetFromAnchorMapUnitScale" type="QString"/>
          <Option value="MM" name="offsetFromAnchorUnit" type="QString"/>
          <Option value="0" name="offsetFromLabel" type="double"/>
          <Option value="3x:0,0,0,0,0,0" name="offsetFromLabelMapUnitScale" type="QString"/>
          <Option value="MM" name="offsetFromLabelUnit" type="QString"/>
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
    <alias field="station_name" index="10" name=""/>
    <alias field="vector_display_length" index="11" name=""/>
    <alias field="vector_display_width" index="12" name=""/>
    <alias field="display_time" index="13" name=""/>
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
    <default applyOnUpdate="0" field="vector_display_length" expression=""/>
    <default applyOnUpdate="0" field="vector_display_width" expression=""/>
    <default applyOnUpdate="0" field="display_time" expression=""/>
  </defaults>
  <constraints>
    <constraint unique_strength="0" field="id_bin" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="id" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="bin" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="depth" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="time" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="date_break" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="velocity" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="velocity_major" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="dir" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="type" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="station_name" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="vector_display_length" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="vector_display_width" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint unique_strength="0" field="display_time" notnull_strength="0" exp_strength="0" constraints="0"/>
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
    <field length="10" typeName="integer" subType="0" comment="" name="vector_display_length" type="2" expression="10" precision="0"/>
    <field length="-1" typeName="double precision" subType="0" comment="" name="vector_display_width" type="6" expression="min(8,max(0.5,4*log(2,velocity + 1)))" precision="0"/>
    <field length="0" typeName="string" subType="0" comment="" name="display_time" type="10" expression="format_date(time,'MM/yy mm:dd')" precision="0"/>
  </expressionfields>
  <previewExpression>id_bin + ' ' + format_date(time,'yyyyMMdd hh:mm')</previewExpression>
  <mapTip>&lt;style>
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
	&lt;span class="name">[% station_name %]&lt;/span>
	&lt;br/>
	&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% id_bin %]">Station [% id_bin %]&lt;/a>
	&lt;div class="predict">
		&lt;table>
		&lt;tbody>
		[%
			with_variable('station_id',id,
				concatenate(format('
				  &lt;tr class="%1 %6">
				    &lt;td class="date %6">%2&lt;/td>
					&lt;td class="time">%3&lt;/td>
					&lt;td class="type">%4&lt;/td>
					&lt;td class="velocity">%5&lt;/td>
				  &lt;/tr>',
					   type,
					   format_date(time,'MM/dd'),
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

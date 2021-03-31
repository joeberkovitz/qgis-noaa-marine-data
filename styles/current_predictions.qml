<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" version="3.16.4-Hannover" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|MapTips|Temporal" labelsEnabled="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal startField="time" enabled="1" durationField="" durationUnit="min" mode="1" endExpression="" fixedDuration="0" accumulate="0" endField="" startExpression="">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 symbollevels="0" forceraster="0" type="RuleRenderer" enableorderby="1">
    <rules key="{f82f9c0a-11c0-4463-a530-1848d9ec9562}">
      <rule key="{db1cb4ea-3e7e-45d5-ae99-18be4af351b9}" filter="type='slack'" label="slack" symbol="0"/>
      <rule key="{c3f9e513-78d6-4d83-88b6-8fcf3a2be92f}" filter="velocity_major is null" label="current" symbol="1"/>
      <rule key="{880197ea-b2a5-4567-aeea-b1d0267480b1}" filter="velocity_major > 0" label="flood" symbol="2"/>
      <rule key="{baa31596-80f6-4974-a7ca-bee6dc792d6b}" filter="velocity_major &lt; 0" label="ebb" symbol="3"/>
    </rules>
    <symbols>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" name="0" alpha="1">
        <layer pass="0" enabled="1" class="SimpleMarker" locked="0">
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
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" name="1" alpha="0.97">
        <layer pass="0" enabled="1" class="VectorField" locked="0">
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
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" name="@1@0" alpha="1">
            <layer pass="0" enabled="1" class="ArrowLine" locked="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="arrowHeadLength">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowHeadThickness">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowStartWidth">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowWidth">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                  </Option>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
              <symbol force_rhr="0" clip_to_extent="1" type="fill" name="@@1@0@0" alpha="1">
                <layer pass="0" enabled="1" class="SimpleFill" locked="0">
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
                      <Option type="QString" name="name" value=""/>
                      <Option type="Map" name="properties">
                        <Option type="Map" name="enabled">
                          <Option type="bool" name="active" value="false"/>
                          <Option type="QString" name="expression" value=""/>
                          <Option type="int" name="type" value="3"/>
                        </Option>
                        <Option type="Map" name="fillColor">
                          <Option type="bool" name="active" value="false"/>
                          <Option type="QString" name="expression" value=""/>
                          <Option type="int" name="type" value="3"/>
                        </Option>
                      </Option>
                      <Option type="QString" name="type" value="collection"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" name="2" alpha="0.97">
        <layer pass="0" enabled="1" class="VectorField" locked="0">
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
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" name="@2@0" alpha="1">
            <layer pass="0" enabled="1" class="ArrowLine" locked="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="arrowHeadLength">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowHeadThickness">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowStartWidth">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowWidth">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                  </Option>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
              <symbol force_rhr="0" clip_to_extent="1" type="fill" name="@@2@0@0" alpha="1">
                <layer pass="0" enabled="1" class="SimpleFill" locked="0">
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
                      <Option type="QString" name="name" value=""/>
                      <Option type="Map" name="properties">
                        <Option type="Map" name="enabled">
                          <Option type="bool" name="active" value="false"/>
                          <Option type="QString" name="expression" value=""/>
                          <Option type="int" name="type" value="3"/>
                        </Option>
                        <Option type="Map" name="fillColor">
                          <Option type="bool" name="active" value="false"/>
                          <Option type="QString" name="expression" value=""/>
                          <Option type="int" name="type" value="3"/>
                        </Option>
                      </Option>
                      <Option type="QString" name="type" value="collection"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" name="3" alpha="0.97">
        <layer pass="0" enabled="1" class="VectorField" locked="0">
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
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" name="@3@0" alpha="1">
            <layer pass="0" enabled="1" class="ArrowLine" locked="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="arrowHeadLength">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowHeadThickness">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowStartWidth">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                    <Option type="Map" name="arrowWidth">
                      <Option type="bool" name="active" value="true"/>
                      <Option type="QString" name="field" value="vector_display_width"/>
                      <Option type="int" name="type" value="2"/>
                    </Option>
                  </Option>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
              <symbol force_rhr="0" clip_to_extent="1" type="fill" name="@@3@0@0" alpha="1">
                <layer pass="0" enabled="1" class="SimpleFill" locked="0">
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
                      <Option type="QString" name="name" value=""/>
                      <Option type="Map" name="properties">
                        <Option type="Map" name="enabled">
                          <Option type="bool" name="active" value="false"/>
                          <Option type="QString" name="expression" value=""/>
                          <Option type="int" name="type" value="3"/>
                        </Option>
                        <Option type="Map" name="fillColor">
                          <Option type="bool" name="active" value="false"/>
                          <Option type="QString" name="expression" value=""/>
                          <Option type="int" name="type" value="3"/>
                        </Option>
                      </Option>
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
    <orderby>
      <orderByClause asc="1" nullsFirst="0">"velocity"</orderByClause>
    </orderby>
  </renderer-v2>
  <labeling type="simple">
    <settings calloutType="simple">
      <text-style fontSize="10" allowHtml="0" blendMode="0" fontSizeUnit="Point" capitalization="0" fontLetterSpacing="0" fontWeight="50" isExpression="1" useSubstitutions="0" fontFamily=".AppleSystemUIFont" fontUnderline="0" textOpacity="1" fontItalic="0" multilineHeight="1" textColor="0,0,0,255" fontStrikeout="0" namedStyle="Regular" fontKerning="1" fieldName="format('%1;%2kt',format_date(time,'hh:mm'),format_number(velocity,1))" textOrientation="horizontal" fontSizeMapUnitScale="3x:0,0,0,0,0,0" previewBkgrdColor="255,255,255,255" fontWordSpacing="0">
        <text-buffer bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferColor="255,255,255,255" bufferDraw="1" bufferJoinStyle="128" bufferSizeUnits="MM" bufferBlendMode="0" bufferSize="1" bufferOpacity="1" bufferNoFill="1"/>
        <text-mask maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskType="0" maskSize="1.5" maskEnabled="0" maskSizeUnits="MM" maskedSymbolLayers="" maskJoinStyle="128" maskOpacity="1"/>
        <background shapeSizeType="0" shapeBorderColor="128,128,128,255" shapeRadiiUnit="MM" shapeSizeUnit="MM" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeRotationType="0" shapeOffsetX="0" shapeFillColor="255,255,255,255" shapeRadiiY="0" shapeType="0" shapeBlendMode="0" shapeRotation="0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeSizeY="0" shapeDraw="0" shapeOpacity="1" shapeOffsetUnit="MM" shapeRadiiX="0" shapeOffsetY="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidth="0" shapeSVGFile="" shapeJoinStyle="64" shapeSizeX="0" shapeBorderWidthUnit="MM" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0">
          <symbol force_rhr="0" clip_to_extent="1" type="marker" name="markerSymbol" alpha="1">
            <layer pass="0" enabled="1" class="SimpleMarker" locked="0">
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
                  <Option type="QString" name="name" value=""/>
                  <Option name="properties"/>
                  <Option type="QString" name="type" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </background>
        <shadow shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowDraw="0" shadowUnder="0" shadowOffsetAngle="135" shadowRadiusAlphaOnly="0" shadowOffsetGlobal="1" shadowRadiusUnit="MM" shadowBlendMode="6" shadowOffsetDist="1" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowRadius="1.5" shadowOpacity="0.69999999999999996" shadowScale="100" shadowOffsetUnit="MM" shadowColor="0,0,0,255"/>
        <dd_properties>
          <Option type="Map">
            <Option type="QString" name="name" value=""/>
            <Option name="properties"/>
            <Option type="QString" name="type" value="collection"/>
          </Option>
        </dd_properties>
        <substitutions/>
      </text-style>
      <text-format autoWrapLength="0" leftDirectionSymbol="&lt;" addDirectionSymbol="0" formatNumbers="0" rightDirectionSymbol=">" useMaxLineLengthForAutoWrap="1" placeDirectionSymbol="0" multilineAlign="3" decimals="3" wrapChar=";" reverseDirectionSymbol="0" plussign="0"/>
      <placement repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" maxCurvedCharAngleOut="-25" overrunDistance="0" lineAnchorPercent="0.5" xOffset="0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" layerType="PointGeometry" yOffset="0" geometryGenerator="" lineAnchorType="0" placement="1" offsetType="0" rotationAngle="0" priority="5" repeatDistanceUnits="MM" fitInPolygonOnly="0" distMapUnitScale="3x:0,0,0,0,0,0" centroidWhole="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" preserveRotation="1" offsetUnits="MM" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" polygonPlacementFlags="2" repeatDistance="0" dist="10" geometryGeneratorEnabled="0" placementFlags="10" centroidInside="0" maxCurvedCharAngleIn="25" quadOffset="4" distUnits="MM" overrunDistanceUnit="MM" geometryGeneratorType="PointGeometry"/>
      <rendering scaleMin="0" scaleMax="0" fontMaxPixelSize="10000" maxNumLabels="2000" obstacleType="1" fontMinPixelSize="3" displayAll="0" minFeatureSize="0" limitNumLabels="0" zIndex="0" scaleVisibility="0" upsidedownLabels="0" obstacle="1" obstacleFactor="1" drawLabels="1" labelPerPart="0" fontLimitPixelSize="0" mergeLines="0"/>
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
              <Option type="QString" name="expression" value="(@map_start_time is not null) and (type = 'ebb' or type = 'flood')"/>
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
          <Option type="QString" name="lineSymbol" value="&lt;symbol force_rhr=&quot;0&quot; clip_to_extent=&quot;1&quot; type=&quot;line&quot; name=&quot;symbol&quot; alpha=&quot;1&quot;>&lt;layer pass=&quot;0&quot; enabled=&quot;1&quot; class=&quot;SimpleLine&quot; locked=&quot;0&quot;>&lt;prop v=&quot;0&quot; k=&quot;align_dash_pattern&quot;/>&lt;prop v=&quot;square&quot; k=&quot;capstyle&quot;/>&lt;prop v=&quot;5;2&quot; k=&quot;customdash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;customdash_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;customdash_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;dash_pattern_offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;dash_pattern_offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;draw_inside_polygon&quot;/>&lt;prop v=&quot;bevel&quot; k=&quot;joinstyle&quot;/>&lt;prop v=&quot;60,60,60,255&quot; k=&quot;line_color&quot;/>&lt;prop v=&quot;solid&quot; k=&quot;line_style&quot;/>&lt;prop v=&quot;0.3&quot; k=&quot;line_width&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;line_width_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;ring_filter&quot;/>&lt;prop v=&quot;0&quot; k=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;prop v=&quot;0&quot; k=&quot;use_custom_dash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;width_map_unit_scale&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; name=&quot;name&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option type=&quot;QString&quot; name=&quot;type&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>"/>
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
    <alias field="id_bin" name="" index="0"/>
    <alias field="id" name="" index="1"/>
    <alias field="bin" name="" index="2"/>
    <alias field="depth" name="" index="3"/>
    <alias field="time" name="" index="4"/>
    <alias field="date_break" name="" index="5"/>
    <alias field="velocity" name="" index="6"/>
    <alias field="velocity_major" name="" index="7"/>
    <alias field="dir" name="" index="8"/>
    <alias field="type" name="" index="9"/>
    <alias field="station_name" name="" index="10"/>
    <alias field="vector_display_length" name="" index="11"/>
    <alias field="vector_display_width" name="" index="12"/>
    <alias field="display_time" name="" index="13"/>
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
    <default field="station_name" expression="" applyOnUpdate="0"/>
    <default field="vector_display_length" expression="" applyOnUpdate="0"/>
    <default field="vector_display_width" expression="" applyOnUpdate="0"/>
    <default field="display_time" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="id_bin" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="id" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="bin" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="depth" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="time" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="date_break" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="velocity" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="velocity_major" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="dir" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="type" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="station_name" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="vector_display_length" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="vector_display_width" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
    <constraint field="display_time" constraints="0" unique_strength="0" exp_strength="0" notnull_strength="0"/>
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
    <field precision="0" typeName="integer" name="vector_display_length" type="2" comment="" expression="10" length="10" subType="0"/>
    <field precision="0" typeName="double precision" name="vector_display_width" type="6" comment="" expression="min(8,max(0.5,4*log(2,velocity + 1)))" length="-1" subType="0"/>
    <field precision="0" typeName="string" name="display_time" type="10" comment="" expression="format_date(time,'MM/yy mm:dd')" length="0" subType="0"/>
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

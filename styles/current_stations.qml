<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.16.4-Hannover" labelsEnabled="0" styleCategories="Symbology|Labeling|Fields|MapTips|Temporal">
  <temporal durationUnit="min" endExpression="" startField="" startExpression="" durationField="" enabled="0" endField="" accumulate="0" mode="0" fixedDuration="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 toleranceUnit="MM" toleranceUnitScale="3x:0,0,0,0,0,0" forceraster="0" type="pointCluster" tolerance="6" enableorderby="0">
    <renderer-v2 symbollevels="0" forceraster="0" type="singleSymbol" enableorderby="0">
      <symbols>
        <symbol alpha="1" clip_to_extent="1" type="marker" force_rhr="0" name="0">
          <layer locked="0" pass="0" enabled="0" class="SimpleMarker">
            <prop k="angle" v="0"/>
            <prop k="color" v="255,0,0,255"/>
            <prop k="horizontal_anchor_point" v="1"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="name" v="arrow"/>
            <prop k="offset" v="0,0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="outline_color" v="187,35,35,255"/>
            <prop k="outline_style" v="solid"/>
            <prop k="outline_width" v="0.4"/>
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
                    <Option type="QString" name="field" value="meanFloodDir"/>
                    <Option type="int" name="type" value="2"/>
                  </Option>
                  <Option type="Map" name="enabled">
                    <Option type="bool" name="active" value="true"/>
                    <Option type="QString" name="expression" value="max_flood IS NOT NULL"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="fillColor">
                    <Option type="bool" name="active" value="true"/>
                    <Option type="QString" name="expression" value="if(max_flood is not null,'#ff0000','#ffffff')"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="size">
                    <Option type="bool" name="active" value="true"/>
                    <Option type="QString" name="expression" value="if(max_flood,max_flood*5 + 2,7)"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                </Option>
                <Option type="QString" name="type" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
          <layer locked="0" pass="0" enabled="0" class="SimpleMarker">
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
            <prop k="outline_width" v="0.4"/>
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
                    <Option type="QString" name="field" value="meanEbbDir"/>
                    <Option type="int" name="type" value="2"/>
                  </Option>
                  <Option type="Map" name="enabled">
                    <Option type="bool" name="active" value="true"/>
                    <Option type="QString" name="expression" value="max_ebb IS NOT NULL"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="fillColor">
                    <Option type="bool" name="active" value="false"/>
                    <Option type="QString" name="expression" value="if(max_flood IS NULL,'#FFFFFF','#00FF00')"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="size">
                    <Option type="bool" name="active" value="true"/>
                    <Option type="QString" name="expression" value="if(max_ebb,-max_ebb*5 + 2,7)"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                </Option>
                <Option type="QString" name="type" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
          <layer locked="0" pass="0" enabled="0" class="SimpleMarker">
            <prop k="angle" v="0"/>
            <prop k="color" v="255,255,255,255"/>
            <prop k="horizontal_anchor_point" v="1"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="name" v="arrow"/>
            <prop k="offset" v="0,0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="outline_color" v="164,4,23,255"/>
            <prop k="outline_style" v="solid"/>
            <prop k="outline_width" v="0.4"/>
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
                    <Option type="QString" name="expression" value="&quot;meanFloodDir&quot;"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="enabled">
                    <Option type="bool" name="active" value="true"/>
                    <Option type="QString" name="expression" value="max_flood IS NULL"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="fillColor">
                    <Option type="bool" name="active" value="false"/>
                    <Option type="QString" name="expression" value="if(max_flood IS NULL,'#FFFFFF','#00FF00')"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="size">
                    <Option type="bool" name="active" value="false"/>
                    <Option type="QString" name="expression" value="if(max_ebb,-max_ebb*5 + 2,7)"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                </Option>
                <Option type="QString" name="type" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
          <layer locked="0" pass="0" enabled="0" class="SimpleMarker">
            <prop k="angle" v="0"/>
            <prop k="color" v="255,255,255,255"/>
            <prop k="horizontal_anchor_point" v="1"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="name" v="arrow"/>
            <prop k="offset" v="0,0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="outline_color" v="35,164,35,255"/>
            <prop k="outline_style" v="solid"/>
            <prop k="outline_width" v="0.4"/>
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
                    <Option type="QString" name="field" value="meanEbbDir"/>
                    <Option type="int" name="type" value="2"/>
                  </Option>
                  <Option type="Map" name="enabled">
                    <Option type="bool" name="active" value="true"/>
                    <Option type="QString" name="expression" value="max_ebb IS NULL"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="fillColor">
                    <Option type="bool" name="active" value="false"/>
                    <Option type="QString" name="expression" value="if(max_flood IS NULL,'#FFFFFF','#00FF00')"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                  <Option type="Map" name="size">
                    <Option type="bool" name="active" value="false"/>
                    <Option type="QString" name="expression" value="if(max_ebb,-max_ebb*5 + 2,7)"/>
                    <Option type="int" name="type" value="3"/>
                  </Option>
                </Option>
                <Option type="QString" name="type" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
          <layer locked="0" pass="0" enabled="1" class="SimpleMarker">
            <prop k="angle" v="0"/>
            <prop k="color" v="163,75,245,255"/>
            <prop k="horizontal_anchor_point" v="1"/>
            <prop k="joinstyle" v="bevel"/>
            <prop k="name" v="triangle"/>
            <prop k="offset" v="0,0"/>
            <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
            <prop k="offset_unit" v="MM"/>
            <prop k="outline_color" v="50,87,128,255"/>
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
                <Option type="QString" name="name" value=""/>
                <Option type="Map" name="properties">
                  <Option type="Map" name="fillColor">
                    <Option type="bool" name="active" value="true"/>
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
    </renderer-v2>
    <symbol alpha="1" clip_to_extent="1" type="marker" force_rhr="0" name="centerSymbol">
      <layer locked="0" pass="0" enabled="1" class="SimpleMarker">
        <prop k="angle" v="0"/>
        <prop k="color" v="163,75,245,255"/>
        <prop k="horizontal_anchor_point" v="1"/>
        <prop k="joinstyle" v="bevel"/>
        <prop k="name" v="triangle"/>
        <prop k="offset" v="0,0"/>
        <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="offset_unit" v="MM"/>
        <prop k="outline_color" v="35,35,35,255"/>
        <prop k="outline_style" v="solid"/>
        <prop k="outline_width" v="0"/>
        <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="outline_width_unit" v="MM"/>
        <prop k="scale_method" v="diameter"/>
        <prop k="size" v="6"/>
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
      <layer locked="0" pass="0" enabled="1" class="FontMarker">
        <prop k="angle" v="0"/>
        <prop k="chr" v="A"/>
        <prop k="color" v="255,255,255,255"/>
        <prop k="font" v=".AppleSystemUIFont"/>
        <prop k="font_style" v=""/>
        <prop k="horizontal_anchor_point" v="1"/>
        <prop k="joinstyle" v="miter"/>
        <prop k="offset" v="0,-0.47999999999999998"/>
        <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="offset_unit" v="MM"/>
        <prop k="outline_color" v="255,255,255,255"/>
        <prop k="outline_width" v="0"/>
        <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="outline_width_unit" v="MM"/>
        <prop k="size" v="3.84"/>
        <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
        <prop k="size_unit" v="MM"/>
        <prop k="vertical_anchor_point" v="1"/>
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" name="name" value=""/>
            <Option type="Map" name="properties">
              <Option type="Map" name="char">
                <Option type="bool" name="active" value="true"/>
                <Option type="QString" name="expression" value="@cluster_size"/>
                <Option type="int" name="type" value="3"/>
              </Option>
            </Option>
            <Option type="QString" name="type" value="collection"/>
          </Option>
        </data_defined_properties>
      </layer>
    </symbol>
  </renderer-v2>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field configurationFlags="None" name="field_1"/>
    <field configurationFlags="None" name="id"/>
    <field configurationFlags="None" name="name"/>
    <field configurationFlags="None" name="bin"/>
    <field configurationFlags="None" name="latitude"/>
    <field configurationFlags="None" name="longitude"/>
    <field configurationFlags="None" name="depth"/>
    <field configurationFlags="None" name="type"/>
    <field configurationFlags="None" name="meanFloodDir"/>
    <field configurationFlags="None" name="meanEbbDir"/>
    <field configurationFlags="None" name="id_bin"/>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="field_1" name=""/>
    <alias index="1" field="id" name=""/>
    <alias index="2" field="name" name=""/>
    <alias index="3" field="bin" name=""/>
    <alias index="4" field="latitude" name=""/>
    <alias index="5" field="longitude" name=""/>
    <alias index="6" field="depth" name=""/>
    <alias index="7" field="type" name=""/>
    <alias index="8" field="meanFloodDir" name=""/>
    <alias index="9" field="meanEbbDir" name=""/>
    <alias index="10" field="id_bin" name=""/>
  </aliases>
  <defaults>
    <default expression="" field="field_1" applyOnUpdate="0"/>
    <default expression="" field="id" applyOnUpdate="0"/>
    <default expression="" field="name" applyOnUpdate="0"/>
    <default expression="" field="bin" applyOnUpdate="0"/>
    <default expression="" field="latitude" applyOnUpdate="0"/>
    <default expression="" field="longitude" applyOnUpdate="0"/>
    <default expression="" field="depth" applyOnUpdate="0"/>
    <default expression="" field="type" applyOnUpdate="0"/>
    <default expression="" field="meanFloodDir" applyOnUpdate="0"/>
    <default expression="" field="meanEbbDir" applyOnUpdate="0"/>
    <default expression="" field="id_bin" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="field_1" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="id" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="name" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="bin" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="latitude" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="longitude" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="depth" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="type" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="meanFloodDir" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="meanEbbDir" constraints="0"/>
    <constraint notnull_strength="0" unique_strength="0" exp_strength="0" field="id_bin" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="field_1"/>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="name"/>
    <constraint desc="" exp="" field="bin"/>
    <constraint desc="" exp="" field="latitude"/>
    <constraint desc="" exp="" field="longitude"/>
    <constraint desc="" exp="" field="depth"/>
    <constraint desc="" exp="" field="type"/>
    <constraint desc="" exp="" field="meanFloodDir"/>
    <constraint desc="" exp="" field="meanEbbDir"/>
    <constraint desc="" exp="" field="id_bin"/>
  </constraintExpressions>
  <expressionfields>
    <field typeName="string" precision="0" subType="0" expression="id || '_' || bin" length="0" type="10" comment="" name="id_bin"/>
  </expressionfields>
  <mapTip>&lt;style>
.tip {
	width: 180px;
	font-size: 10px;
}
.name {
	font-weight: bold;
}
.predict {
    padding-top: 5px;
}
&lt;/style>
&lt;div class="tip">
	&lt;span class="name">[% name %]&lt;/span>
	&lt;br/>
	&lt;a href="https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id=[% id %]_[% bin %]">Station [% id %]&lt;/a>
	&lt;div class="predict">
	&lt;!--
		&lt;table>
		&lt;tbody>
		[%
		with_variable('station_id',id,
			aggregate(@noaa_predictions_layer_id,'concatenate',
				format('&lt;tr class="%2">&lt;td>%1&lt;/td>&lt;td>%2&lt;/td>&lt;td class="velocity">%3&lt;/td>&lt;/tr>',
					   format_date(time,'MM/dd hh:mm'),
					   type,
					   if(type = 'slack','',
						   if(type = 'ebb',-velocity,velocity))),
				id = @station_id
		))
		%]
		&lt;/tbody>
		&lt;/table>
	-->
	&lt;/div>
&lt;/div></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>

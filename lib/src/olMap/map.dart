// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:brick_bootstrap5_plus/brick_bootstrap5_plus.dart';
import 'map_app.dart';
import 'map_web.dart';
// import 'dart:developer' as console;
import 'package:get/get.dart';

class OlMap extends StatefulWidget {
  const OlMap({super.key});

  @override
  State<OlMap> createState() => OlMapState();
}

class OlMapState extends State<OlMap> {
  GlobalKey<MapWebState> webMapKey = GlobalKey<MapWebState>();
  GlobalKey<MapAppState> appMapKey = GlobalKey<MapAppState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  postMessage(MapMessage data) {
    GetPlatform.isWeb
        ? webMapKey.currentState?.postMessage(data)
        : appMapKey.currentState?.postMessage(data);
  }

  @override
  Widget build(BuildContext context) {
    return BRow(children: [
      BCol(
          classNames: 'col-24',
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  var MapInfo =
                      '{"geoserverURL":"http://Toppineszserver:8082/geoserver","geoserverURL_Remote":"http://toppineszserver:8082/geoserver","mapWorkspace":"EM12HY2019","defaultBounds":{"left":825500,"right":844500,"top":830500,"bottom":810500},"DefaultCenter":{"x":835500,"y":818800},"DefaultLayerGroup":"Default","InitZoom":10,"MaxZoom":20,"MinZoom":10,"LayersAlias":"HP Carriageway,HP Footway,HP SideLaneorBack,HP CycleTrack,HP Other,Structure,Slope,Tunnel,Lamp Post","LayersName":"HPCarriageway,HPFootway,HPSideLaneorBack,HPCycleTrack,HPOther,INV_STP,INV_HRS,CHT_seg_poly,Lamppost_EMMS2014","mapKey":"db06a2a70f604702948a4ff5331e2803","mapPath":"\\\\Toppineszserver\\Map\\data\\12HY2019","Districts_Shp":"DISTRICTS","MapbaseExtendLayer":""}';
                  postMessage(
                      MapMessage(fn: MapMessageFN.MapInfo, data: MapInfo));
                },
                child: Text('1 InitMap'),
              ),
              ElevatedButton(
                onPressed: () {
                  var defects =
                      '[{"WorkType":"VG","InspectionNo":"12HY2019-R1-VG-LCK0-202406060900","InspectionDateFrom":"2024-06-06T00:00:00","InspectionDateTo":"2024-06-06T00:00:00","District":"Lai Chi Kok","DistrictValue":"Lai Chi Kok","StreetID":null,"Street":"","RoadType":"VT3","RoadTypeValue":"VT3","RoadSurface":null,"Inspectedby":"admin","EnglishName":"adminShowName11","DCode":"M4","DCodeShow":"M4-Weeding","ExtentSeverity":"","Priority":"","RepairDueDate":"2024-06-06T23:59:59","RepairOnDate":null,"GEOX":"","GEOY":"","DefectStatus":"Overdue","DefectStatusValue":4,"CreateOn":null,"UpdateOn":null,"DefectID":"32b3dc2d-05c1-467f-a269-aff978abe120","DefectIDShow":"VG-LCK-A00032","LocationLevel":"","BeforePhoto":null,"AfterPhoto":null,"Receiver":"","Collect":0,"IsCollect":false,"RepairOrderNo":"","NMCreateTime":"2024-06-06T14:04:13.097","DefectIdentifiedDateFrom":"2024-06-06T00:00:00","DefectIdentifiedDateTo":null,"DefectRectifiedDate":null,"KIVOtherDate":null,"SurfaceType":"","DefectExtentSeverity":"","KIVOther":"","PTReinstate":null,"PTReinstateDate":null,"CheckedTime":null,"RepairTime":"","TotalCount":113,"Checked":false,"PhotoConfirm":false,"RejectCount":0,"RejectReason":"","StructureType":null,"IOW":"","DefectType":"","CreateBy":"admin","SubDistrict":"LCK0","FeatureType":"","DefectNo":1,"RepairMethod":"","DuetoTrafficAccident":"","LampPN":"","Bound":"","Chainage":"","Quantity":"","DefectRating":"","Score":0,"OEDefect":"","SegmentNo":"","TSDefectCode":"","DefectDescription":"","PhotoConfirmTime":null},{"WorkType":"RRI","InspectionNo":"12HY2019-LCK0-RI-202405220900","InspectionDateFrom":"2024-05-22T00:00:00","InspectionDateTo":"2024-05-22T00:00:00","District":"Lai Chi Kok","DistrictValue":"Lai Chi Kok","StreetID":"f05c759c-ef85-4fc4-1101-ab1de7af214d","Street":"ACCESS  ROAD TO SOUTH OF SHAM WONG ROAD","RoadType":"Carriageway","RoadTypeValue":"1","RoadSurface":"Dry","Inspectedby":"admin","EnglishName":"adminShowName11","DCode":"D.G","DCodeShow":"D-Drainage,D.G-Gully grating damaged, missing, blocked or sunken,D-Damaged,1","ExtentSeverity":"","Priority":"Cat (i)","RepairDueDate":"2024-05-01T23:59:59","RepairOnDate":null,"GEOX":"835424.8","GEOY":"818569.1","DefectStatus":"Overdue","DefectStatusValue":4,"CreateOn":null,"UpdateOn":null,"DefectID":"8b2842ef-f6fc-40c7-8d8e-367609130d96","DefectIDShow":"RI-LCK-A00049","LocationLevel":"","BeforePhoto":null,"AfterPhoto":null,"Receiver":"","Collect":0,"IsCollect":false,"RepairOrderNo":"","NMCreateTime":"2024-05-22T15:25:10.763","DefectIdentifiedDateFrom":"2024-05-22T00:00:00","DefectIdentifiedDateTo":null,"DefectRectifiedDate":null,"KIVOtherDate":null,"SurfaceType":"","DefectExtentSeverity":"","KIVOther":"","PTReinstate":null,"PTReinstateDate":null,"CheckedTime":null,"RepairTime":"","TotalCount":113,"Checked":false,"PhotoConfirm":false,"RejectCount":0,"RejectReason":"","StructureType":"","IOW":"","DefectType":"","CreateBy":"admin","SubDistrict":"LCK0","FeatureType":"","DefectNo":1,"RepairMethod":"Repair","DuetoTrafficAccident":"No","LampPN":"","Bound":"","Chainage":"","Quantity":"","DefectRating":"","Score":0,"OEDefect":"","SegmentNo":"","TSDefectCode":"","DefectDescription":"1","PhotoConfirmTime":null},{"WorkType":"GSPI","InspectionNo":"PI-KW1-K124-20240425","InspectionDateFrom":"2024-04-25T00:00:00","InspectionDateTo":"2024-04-27T00:00:00","District":"Sham Shui Po","DistrictValue":"Sham Shui Po","StreetID":"f0f66c1a-6073-4a54-a0c5-2e8d9af3c821","Street":"K124","RoadType":"Carriageway","RoadTypeValue":"1","RoadSurface":"Dry","Inspectedby":"admin","EnglishName":"adminShowName11","DCode":"FO","DCodeShow":"01 - Foundations","ExtentSeverity":"1","Priority":"N/A","RepairDueDate":"2024-04-25T23:59:59","RepairOnDate":"2024-04-25T00:00:00","GEOX":"","GEOY":"","DefectStatus":"Overdue","DefectStatusValue":4,"CreateOn":null,"UpdateOn":null,"DefectID":"37f3df82-8593-4936-9321-9578ae2fd30c","DefectIDShow":"PI-SSP-A00001","LocationLevel":"","BeforePhoto":"Business\\Inspection\\2024\\2024-04\\GSSPI\\PI-KW1-K124-20240425\\IP-0001.jpg","AfterPhoto":"Business\\Inspection\\2024\\2024-04\\GSSPI\\PI-KW1-K124-20240425\\CP-0002.jpg","Receiver":"","Collect":0,"IsCollect":false,"RepairOrderNo":"","NMCreateTime":"2024-04-25T15:59:27.943","DefectIdentifiedDateFrom":"2024-04-27T00:00:00","DefectIdentifiedDateTo":null,"DefectRectifiedDate":"2024-04-25T00:00:00","KIVOtherDate":null,"SurfaceType":"FD-1","DefectExtentSeverity":"","KIVOther":"","PTReinstate":null,"PTReinstateDate":null,"CheckedTime":null,"RepairTime":"","TotalCount":113,"Checked":false,"PhotoConfirm":false,"RejectCount":0,"RejectReason":"","StructureType":"Bridge","IOW":"KW1","DefectType":"Df-deformed/distort","CreateBy":"admin","SubDistrict":"KW1","FeatureType":"","DefectNo":1,"RepairMethod":"","DuetoTrafficAccident":"No","LampPN":"","Bound":"","Chainage":"","Quantity":"1","DefectRating":"","Score":0,"OEDefect":"","SegmentNo":"","TSDefectCode":"","DefectDescription":"","PhotoConfirmTime":null}]';
                  postMessage(MapMessage(
                      fn: MapMessageFN.UpdateDefects, data: defects));
                },
                child: Text('2 Defects'),
              ),
              ElevatedButton(
                onPressed: () {
                  var res =
                      '<?xml version="1.0" encoding="UTF-8"?><wfs:FeatureCollection xmlns="http://www.opengis.net/wfs" xmlns:wfs="http://www.opengis.net/wfs" xmlns:gml="http://www.opengis.net/gml" xmlns:EM12HY2019="EM12HY2019" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/wfs http://toppineszserver:8082/geoserver/schemas/wfs/1.0.0/WFS-basic.xsd EM12HY2019 http://toppineszserver:8082/geoserver/wfs?service=WFS&amp;version=1.0.0&amp;request=DescribeFeatureType&amp;typeName=EM12HY2019%3ARoad_polygon"><gml:boundedBy><gml:Box srsName="http://www.opengis.net/gml/srs/epsg.xml#2326"><gml:coordinates decimal="." cs="," ts=" ">833331.915897,821564.599 833358.385,821621.4</gml:coordinates></gml:Box></gml:boundedBy><gml:featureMember><EM12HY2019:Road_polygon fid="Road_polygon.702"><gml:boundedBy><gml:Box srsName="http://www.opengis.net/gml/srs/epsg.xml#2326"><gml:coordinates decimal="." cs="," ts=" ">833331.915897,821564.599 833358.385,821621.4</gml:coordinates></gml:Box></gml:boundedBy><EM12HY2019:the_geom><gml:MultiPolygon srsName="http://www.opengis.net/gml/srs/epsg.xml#2326"><gml:polygonMember><gml:Polygon><gml:outerBoundaryIs><gml:LinearRing><gml:coordinates decimal="." cs="," ts=" ">833348.938,821588.741 833353.12,821585.41 833356.386,821581.506 833357.987,821578.52 833358.385,821574.658 833357.316,821570.692 833354.865,821567.396 833351.345,821565.495 833347.175,821564.599 833343.325,821565.403 833339.999,821567.501 833336.88,821572.463 833333.833,821616.015 833331.915897,821620.493598 833345.3429,821621.4 833344.083,821616.024 833345.655,821594.54 833346.814,821591.368 833348.938,821588.741</gml:coordinates></gml:LinearRing></gml:outerBoundaryIs><gml:innerBoundaryIs><gml:LinearRing><gml:coordinates decimal="." cs="," ts=" ">833345.409,821572.561 833348.804,821572.744 833350.644,821575.793 833347.362,821583.247 833343.132,821587.957 833341.808,821588.242 833340.528,821586.765 833343.174,821575.123 833345.409,821572.561</gml:coordinates></gml:LinearRing></gml:innerBoundaryIs></gml:Polygon></gml:polygonMember></gml:MultiPolygon></EM12HY2019:the_geom><EM12HY2019:OBJECTID>167507</EM12HY2019:OBJECTID><EM12HY2019:AUDIT_CODE>966031C171493</EM12HY2019:AUDIT_CODE><EM12HY2019:ST_CODE>966031</EM12HY2019:ST_CODE><EM12HY2019:ROAD_NAME>ACCESS  ROAD TO SOUTH OF SHAM WONG ROAD</EM12HY2019:ROAD_NAME><EM12HY2019:FEAT_TYPE>1</EM12HY2019:FEAT_TYPE><EM12HY2019:LVL>0</EM12HY2019:LVL><EM12HY2019:CAP_DT>2014-03-16T16:00:00Z</EM12HY2019:CAP_DT><EM12HY2019:LST_UPD_DT>2014-03-16T16:00:00Z</EM12HY2019:LST_UPD_DT><EM12HY2019:CAP_USR>TOCK7</EM12HY2019:CAP_USR><EM12HY2019:LST_UPD_US>TOCK7</EM12HY2019:LST_UPD_US><EM12HY2019:AUDIT_ID>171493</EM12HY2019:AUDIT_ID><EM12HY2019:INV_GID>-947867</EM12HY2019:INV_GID><EM12HY2019:REVIEW_USR>STOCK3</EM12HY2019:REVIEW_USR><EM12HY2019:REVIEW_DT>2014-03-17T16:00:00Z</EM12HY2019:REVIEW_DT><EM12HY2019:REF_NO/><EM12HY2019:DATA_SOURC>6</EM12HY2019:DATA_SOURC><EM12HY2019:REGION/><EM12HY2019:IOW/><EM12HY2019:HMD>Lai Chi Kok</EM12HY2019:HMD><EM12HY2019:DB/><EM12HY2019:SHAPE_AREA>692.527197467</EM12HY2019:SHAPE_AREA><EM12HY2019:SHAPE_LEN>184.751536113</EM12HY2019:SHAPE_LEN><EM12HY2019:Road_Type>C</EM12HY2019:Road_Type></EM12HY2019:Road_polygon></gml:featureMember></wfs:FeatureCollection>';
                  postMessage(
                      MapMessage(fn: MapMessageFN.Locate, data: {'xml': res}));
                },
                child: Text('3 Locate Inventory'),
              ),
              ElevatedButton(
                onPressed: () {
                  postMessage(MapMessage(fn: MapMessageFN.Capture, data: {}));
                },
                child: Text('4 Capture'),
              ),
              ElevatedButton(
                onPressed: () {
                  postMessage(MapMessage(fn: MapMessageFN.ZoomIn, data: {}));
                },
                child: Text('5 ZoomIn'),
              ),
              ElevatedButton(
                onPressed: () {
                  postMessage(MapMessage(fn: MapMessageFN.ZoomOut, data: {}));
                },
                child: Text('6 ZoomOut'),
              ),
            ],
          )),
      BCol(
        classNames: 'col-24',
        child: Column(
          children: [
            GetPlatform.isWeb ? MapWeb(key: webMapKey) : MapApp(key: appMapKey),
          ],
        ),
      ),
    ]);
  }
}

enum MapMessageFN {
  MapInfo,
  UpdateDefects,
  Capture,
  ZoomIn,
  ZoomOut,
  Locate,
}

class MapMessage {
  final dynamic data;
  final MapMessageFN fn;
  MapMessage({
    required this.data,
    required this.fn,
  });
}

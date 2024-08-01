import { computed, defineComponent, onMounted, onUnmounted, ref } from "vue";
import { Control, ScaleLine, defaults as defaultControls, MousePosition } from 'ol/control';
//import { http } from "@/http";
import { Map as olMap, View } from 'ol'

import 'ol/ol.css'
import 'ol-layerswitcher/dist/ol-layerswitcher.css';

import { Image as ImageLayer } from 'ol/layer';
import Tile from 'ol/layer/Tile'
import TileWMS from 'ol/source/TileWMS'
import ImageWMS from 'ol/source/ImageWMS';

import LayerGroup from 'ol/layer/Group';
import LAYER_VECTOR from 'ol/layer/Vector';

import { Cluster, Vector as VectorSource } from 'ol/source';
import XYZ from 'ol/source/XYZ'
import SourceOSM from 'ol/source/OSM'
import SOURCE_VECTOR from 'ol/source/Vector';

import Projection from 'ol/proj/Projection';
import { transform } from 'ol/proj'
import proj4 from 'proj4';
import { register } from 'ol/proj/proj4';

import LayerSwitcher from 'ol-layerswitcher';

import type { BaseLayerOptions, GroupLayerOptions } from 'ol-layerswitcher';

import Overlay from 'ol/Overlay';

import Feature from 'ol/Feature';
import Point from 'ol/geom/Point';

import StyleStyle from 'ol/style/Style';
import STYLE_Fill from 'ol/style/Fill';
import STYLE_Text from 'ol/style/Text';
import STYLE_STROKE from 'ol/style/Stroke';

import { defaults as defaultInteractions } from 'ol/interaction';
import { Circle as CircleStyle, Fill, Stroke, Style, Text, Icon } from 'ol/style';
import Circle from 'ol/geom/Circle';
import {
    CoordinatesControl, myFilterControl, myOpenControl, myZoominControl, myZoomoutControl, getCoordinate, myExportPhotoControl, CurrViewDefectsControl
} from './controls.jsx';
import GML2 from 'ol/format/gml2';

export class MapManager {
    mapConfig: any;
    map: any;
    defectObjs: any = [];
    initZoom: number = 12;
    maxZoom: number = 20;
    minZoom: number = 12;
    defaultExtent: any = [805000, 820000, 838000, 843600];
    defaultCenter: any = [817600, 830980];
    p: any;
    isWeb: any;

    overlays: any;
    layerSwitcher: LayerSwitcher = new LayerSwitcher();

    inventoryHighLightLayer: any;
    defectLayer: any;
    defectHighLightLayer: any;

    clusterSource: any;

    constructor(_data: any, _p: any) {
        this.p = _p;
    }

    initMapConfig(_MapInfo: any) {
        this.mapConfig = _MapInfo;

        this.initZoom = this.mapConfig.InitZoom;

        this.minZoom = this.mapConfig.MinZoom;
        this.maxZoom = this.mapConfig.MaxZoom;
        this.defaultExtent = [this.mapConfig.defaultBounds.left, this.mapConfig.defaultBounds.bottom, this.mapConfig.defaultBounds.right, this.mapConfig.defaultBounds.top];
        this.defaultCenter = [this.mapConfig.DefaultCenter.x, this.mapConfig.DefaultCenter.y];
    }

    Init(_MapInfo: any) {
        if(this.map != undefined)
        {
            console.log('already initmap')
            return;
        }
        
        _MapInfo = _MapInfo.replace(/\\/g, '\\\\');

        this.initMapConfig(JSON.parse(_MapInfo));
        this.InitMap();
        this.AddbaseLayers();
        this.AddInventoryLayers();
        this.AddInventoryHighLightLayer();
        this.AddDefectLayer();
        this.AdddefectHighLightLayer();
        this.AddControls(null, 100);

        this.isWeb = computed(() => getPlatform() == 'Web');
        const getPlatform = () => {
            let platform = navigator.userAgent || navigator.platform;
            if (/iPad|iPhone|iPod/i.test(platform) && !(window as any).MSStream) {
                return 'iOS';
            } else if (/android/i.test(platform)) {
                return 'Android';
            } else if (/chrome|edg/i.test(platform)) {
                return 'Web';
            } else if (/Mac|iPod|iPad|iPhone/i.test(platform)) {
                return 'Mac'; // iOS 在 Safari 中会同时检测到 Mac 和 iOS，因此要先于 iOS 判断
            } else if (/linux/i.test(platform)) {
                return 'Linux';
            } else if (/nix/i.test(platform)) {
                return 'Unix';
            } else if (/win/i.test(platform)) {
                return 'Windows';
            }
        }

        this.calcScale(this.map.getView().getResolution());

        this.map.getView().on('change:resolution', (evt: any) => {
            this.calcScale(evt.target.get('resolution'));

            let zoom = this.map.getView().getZoom();
            if (zoom >= 19) {
                this.clusterSource.setDistance(1);
            }
            else if (zoom > 17) {
                this.clusterSource.setDistance(25);
            }
            else if (zoom > 16) {
                this.clusterSource.setDistance(35);
            }
            else
                this.clusterSource.setDistance(50);
        });

        this.map.on('click', (evt: any) => {
            this.layerSwitcher.hidePanel();


        });
    }

    getDefectStyle(DefectStatus: string, isBig: boolean) {
        //const iconUrls = import.meta.env.DEV ? ['/src/icon/mappin_green_completed_icon.png',
        //    '/src/icon/mappin_red_overdue_icon.png',
        //    '/src/icon/mappin_yellow_identified_icon.png',
        //    '/src/icon/mappin_blue_kiv_icon.png',
        //    '/src/icon/mappin_brown_identified_icon.png']
        //    :
        //    ['/Enhancement/src/icon/mappin_green_completed_icon.png',
        //        '/Enhancement/src/icon/mappin_red_overdue_icon.png',
        //        '/Enhancement/src/icon/mappin_yellow_identified_icon.png',
        //        '/Enhancement/src/icon/mappin_blue_kiv_icon.png',
        //        '/Enhancement/src/icon/mappin_brown_identified_icon.png'];

        const iconUrls = ['./icon/mappin_green_completed_icon.png',
            './icon/mappin_red_overdue_icon.png',
            './icon/mappin_yellow_identified_icon.png',
            './icon/mappin_blue_kiv_icon.png',
            './icon/mappin_brown_identified_icon.png'];

        let url = '';
        switch (DefectStatus) {
            case 'Completed':
                url = iconUrls[0];
                break;
            case 'Overdue':
                url = iconUrls[1];
                break;
            case 'Identified':
            case 'Completed - Draft':
                url = iconUrls[2];
                break;
            case 'KIV':
                url = iconUrls[3];
                break;
            case 'Reject':
                url = iconUrls[4];
                // console.log(iconUrls[4])
                break;
            default:
                url = iconUrls[0];
                break;
        }

        let scale = isBig ? 1.5 : 1.0;
        return new StyleStyle({
            image: new Icon({ anchor: [0.5, 0.92], src: url, scale: scale }),
        });
    }

    AddDefectLayer() {
        this.clusterSource = new Cluster({
            distance: 30,
            source: new VectorSource(),
        });

        this.defectLayer = new LAYER_VECTOR({// @ts-ignore
            name_: 'defect',
            crossOrigin: 'anonymous',
            source: this.clusterSource,
            style: (feature) => {
                const size = feature.get('features').length;
                if (size == 1) {
                    let DefectStatus = feature.getProperties().features[0].getProperties().DefectStatus;
                    DefectStatus = DefectStatus == null ? "" : DefectStatus;
                    return this.getDefectStyle(DefectStatus, false);
                } else {
                    if (this.map.getView().getZoom() >= 19.8) {
                        let DefectStatus = feature.getProperties().features[0].getProperties().DefectStatus;
                        DefectStatus = DefectStatus == null ? "" : DefectStatus;
                        return this.getDefectStyle(DefectStatus, false);
                    }
                    return new StyleStyle({
                        image: new CircleStyle({
                            radius: 15,
                            stroke: new Stroke({
                                color: 'white'
                            }),
                            fill: new Fill({
                                color: '#696969',
                            })
                        }),
                        text: new Text({
                            text: size.toString(),
                            fill: new Fill({
                                color: 'white'
                            })
                        })
                    });
                }
            },
        });
        this.map.addLayer(this.defectLayer);
    }

    AdddefectHighLightLayer() {
        this.defectHighLightLayer = new LAYER_VECTOR({// @ts-ignore
            name_: 'defectHighLight',
            crossOrigin: "Anonymous",
            source: new SOURCE_VECTOR({ wrapX: false }),
        });
        this.map.addLayer(this.defectHighLightLayer);
    }

    AddInventoryLayers() {
        let url = this.mapConfig.geoserverURL_Remote + '/wms';
        let workspace = this.mapConfig.mapWorkspace;
        let layers_name = this.mapConfig.LayersName.split(',');
        let layers_alias = this.mapConfig.LayersAlias.split(',');

        let arr = new Array();

        for (let i = 0; i < layers_alias.length; i++) {
            let alias = layers_alias[i];
            let alias2 = layers_alias[i];
            let bAdd = false;
            let name = layers_name[i];
            let visible = false;

            if (alias.indexOf('Carriageway') > 0) {
                alias = 'HP Carriageway';
                alias2 = 'HPCarriageway';
            }
            else if (alias.indexOf('Footway') > 0) {
                alias = 'HP Footway';
                alias2 = 'HPFootway';
            }
            else if (alias.indexOf('SideLaneorBack') > 0) {
                alias = 'HP SideLaneorBack';
                alias2 = 'HPSideLaneorBack';
            }
            else if (alias.indexOf('CycleTrack') > 0) {
                alias = 'HP CycleTrack';
                alias2 = 'HPCycleTrack';
            }
            else if (alias.indexOf('Other') > 0) {
                alias = 'HP Other';
                alias2 = 'HPOther';
            }

            let styles = workspace + ':' + name + '_2';

            let tiled = new ImageLayer({// @ts-ignore
                title: alias,
                visible: visible,
                source: new ImageWMS({
                    ratio: 1,
                    url: url,
                    crossOrigin: 'anonymous',
                    params: {
                        'FORMAT': 'image/png',
                        'VERSION': '1.1.1',
                        'STYLES': styles,
                        //tiled: true,
                        "LAYERS": workspace + ':' + name,
                    }
                })
            });
            arr.push(tiled);
        }

        this.overlays = new LayerGroup({
            title: 'Overlays',
            layers: arr
        } as GroupLayerOptions);

        this.map.addLayer(this.overlays);
    }

    postFlutterMessage = (data: any) => {
        if (this.isWeb) {
            window.parent.postMessage(JSON.stringify(data), window.location.origin);
        } else {
            try {
                (window as any).flutter_inappwebview
                    .callHandler('handlerMessage', JSON.stringify(data))
            } catch (error) {
                console.log('error： ' + error);
            }
        }
    }

    DefineProjection() {
        let projection = new Projection({
            code: 'EPSG:2326',
            units: 'm',
            axisOrientation: 'neu',
            global: false
        });

        proj4.defs(
            'EPSG:2326',
            '+proj=tmerc +lat_0=22.31213333333334 +lon_0=114.1785555555556 +k=1 +x_0=836694.05 +y_0=819069.8 +ellps=intl +towgs84=-162.619,-276.959,-161.764,0.067753,-2.24365,-1.15883,-1.09425 +units=m +no_defs'
        );

        register(proj4);
        return projection;
    }

    InitMap() {
        let projection = this.DefineProjection();
        this.map = new olMap({
            controls: defaultControls({
                attribution: true,
                rotate: false,
                zoom: false,
                attributionOptions: ({
                    collapsible: false
                })
            }).extend([]),
            interactions: defaultInteractions({ doubleClickZoom: false, pinchRotate: false }),
            target: "map",
            layers: [],
            view: new View({
                projection: projection,
                center: this.defaultCenter,
                zoom: this.initZoom,
                minZoom: this.minZoom,
                maxZoom: this.maxZoom,
                extent: this.defaultExtent,
            })
        });


    }

    AddInventoryHighLightLayer() {
        let style = new StyleStyle({
            fill: new STYLE_Fill({
                color: 'rgba(255, 255, 255, 0)'
            }),
            stroke: new STYLE_STROKE({
                color: '#FF0000',
                width: 2
            }),
            image: new CircleStyle({
                radius: 5,
                stroke: new STYLE_STROKE({
                    color: '#FF0000',
                    width: 2
                }),
            }),
            text: new STYLE_Text({
                font: '12px Calibri,sans-serif',
                fill: new STYLE_Fill({
                    color: '#000'
                }),
                stroke: new STYLE_STROKE({
                    color: '#fff',
                    width: 3
                })
            })
        });

        let stylePoint = new StyleStyle({
            text: new STYLE_Text({

                font: '10px bold arial',
                fill: new STYLE_Fill({
                    color: '#FF0000'
                }),

                offsetY: -6
            })
        });

        this.inventoryHighLightLayer = new LAYER_VECTOR({// @ts-ignore
            name_: 'defectHighLight',
            crossOrigin: "Anonymous",
            source: new SOURCE_VECTOR({ wrapX: false }),
            style: (feature) => {// @ts-ignore
                style.getText().setText(feature.get('name'));
                return style;
            }
        });
        this.map.addLayer(this.inventoryHighLightLayer);
    }

    AddbaseLayers() {
        let hkTileMap: any;
        let hkTileMapLabel: any;
        const apikey = 'db06a2a70f604702948a4ff5331e2803';
        let attributions = '';

        attributions = "<a href='https://api.portal.hkmapservice.gov.hk/signin?ReturnUrl=%2Fdisclaimer' target='_blank'>&copy; Map from Lands Department</a><div style='width:25px;height:25px;display:inline-flex;background:url(https://api.hkmapservice.gov.hk/mapapi/landsdlogo.jpg);background-size:25px;margin-left:4px'></div>";
        hkTileMap = new Tile({
            visible: true,
            source: new XYZ({
                crossOrigin: 'anonymous',
                //url: 'https://mapapi.geodata.gov.hk/gs/api/v1.0.0/xyz/basemap/wgs84/{z}/{x}/{y}.png'
                attributions: attributions,
                url: 'https://api.hkmapservice.gov.hk/osm/xyz/basemap/WGS84/tile/{z}/{x}/{y}.png?key=' + apikey
            })
        });

        let label_lang = "en";
        hkTileMapLabel = new Tile({
            // @ts-ignore
            visible: true,
            source: new XYZ({
                crossOrigin: 'anonymous',
                //url: 'https://mapapi.geodata.gov.hk/gs/api/v1.0.0/xyz/label/hk/en/wgs84/{z}/{x}/{y}.png'
                url: 'https://api.hkmapservice.gov.hk/osm/xyz/label-' + label_lang + '/WGS84/tile/{z}/{x}/{y}.png?key=' + apikey
            })
        });
        this.map.addLayer(hkTileMap);
        this.map.addLayer(hkTileMapLabel);
    }

    AddControls(emit: any, scaleMaxWidth: number) {
        this.map.addControl(new myZoominControl());
        this.map.addControl(new myZoomoutControl());
        let scaleLineControl = new ScaleLine({ maxWidth: scaleMaxWidth });
        this.map.addControl(scaleLineControl);
        this.map.addControl(new CoordinatesControl(this.map));

        this.layerSwitcher = new LayerSwitcher({
            reverse: false,
            groupSelectStyle: 'group',
            activationMode: 'click'
        });

        this.layerSwitcher.addEventListener('click', () => {
            this.layerSwitcher.showPanel();
        })
        this.map.addControl(this.layerSwitcher);
    }

    locateTest(xml: any) {
        let obj = xml;
        let gml2 = new GML2();
        let features = gml2.readFeatures(obj.xml);
        for (let i = 0; i < features.length; ++i) {
            let feature = features[i];
            let geometry = feature.getGeometry();

            let newFeature = new Feature({
                geometry: geometry,

            });

            this.inventoryHighLightLayer.getSource().addFeature(newFeature);
        }

        {
            let features = this.inventoryHighLightLayer.getSource().getFeatures();
            if (features.length > 0) {
                let extent = this.getFeaturesExtent_Polygon(features);
                if ((extent[2] - extent[0]) < 120 && (extent[2] - extent[0]) < 80) {
                    this.map.getView().setCenter([extent[0] + (extent[2] - extent[0]) / 2, extent[1] + (extent[3] - extent[1]) / 2]);
                    this.map.getView().setZoom(20);
                }
                else {
                    let size = this.map.getSize();
                    this.map.getView().fit(extent, size);
                }
            }
        }
    }

    getFeaturesExtent_Polygon(features: any) {
        let x1 = -1;
        let x2 = -1;
        let y1 = -1;
        let y2 = -1;
        for (let i = 0; i < features.length; i++) {
            let coordinates = features[i].values_.the_geom ? features[i].values_.the_geom.extent_ : features[i].values_.geometry.extent_;
            if (x1 == -1) {
                x1 = coordinates[0];
                y1 = coordinates[1];
                x2 = coordinates[2];
                y2 = coordinates[3];
            }
            else {
                x1 = x1 < coordinates[0] ? x1 : coordinates[0];
                y1 = y1 < coordinates[1] ? y1 : coordinates[1];
                x2 = x2 > coordinates[2] ? x2 : coordinates[2];
                y2 = y2 > coordinates[3] ? y2 : coordinates[3];
            }
        }

        //let fs = this.getDefectLayerSource().getFeatures();
        //for (let i = 0; i < fs.length; i++) {
        //    let coordinates = fs[i].getGeometry().flatCoordinates;

        //    x1 = x1 < coordinates[0] ? x1 : coordinates[0];
        //    y1 = y1 < coordinates[1] ? y1 : coordinates[1];
        //    x2 = x2 > coordinates[0] ? x2 : coordinates[0];
        //    y2 = y2 > coordinates[1] ? y2 : coordinates[1];
        //}

        if (x1 > 800000) {
            let w = x2 - x1;
            let h = y2 - y1;
            x1 -= w * 0.05;
            x2 += w * 0.05;
            y1 -= h * 0.05;
            y2 += h * 0.05;
        }
        return x1 > 800000 ? [x1, y1, x2, y2] : this.defaultExtent;
    }

    calcScale(resolution: number) {
        let dpi = 25.4 / 0.28;
        let mpu = this.map.getView().getProjection().getMetersPerUnit();
        let scale = resolution * mpu * 39.37 * dpi;
        //that.currScale = scale;
        let strScale = '';
        if (scale >= 9500 && scale <= 950000) {
            strScale = Math.round(scale / 1000) + "K";
        } else if (scale >= 950000) {
            strScale = Math.round(scale / 1000000) + "M";
        } else {
            strScale = Math.round(scale) + '';
        }

        let scaleText = "1 : " + strScale;
        const size = this.map.getSize();
        let curExtent = this.map.getView().calculateExtent(size);
        let strExtent = curExtent[0] + ',' + curExtent[1] + ',' + curExtent[2] + ',' + curExtent[3];
        let obj = { 'Message:': 'Scale', 'scale:': scaleText, 'mapExtent：': strExtent };

        //this.postFlutterMessage(obj);
    }

    getDefectLayerSource() {
        return this.defectLayer ? this.defectLayer.getSource().getSource() : null;
    }

    defectLayerClear() {
        if (this.defectLayer != undefined)
            this.getDefectLayerSource().clear();
    }

    defectHighLightLayerClear() {
        if (this.defectHighLightLayer != undefined)
            this.defectHighLightLayer.getSource().clear();
    }

    isInBound(x: number, y: number) {
        return (x >= this.mapConfig.defaultBounds.left && x <= this.mapConfig.defaultBounds.right && y >= this.mapConfig.defaultBounds.bottom && y <= this.mapConfig.defaultBounds.top);
    }

    UpdateDefects(cur: any) {
        cur = cur.replace(/\\/g, '\\\\');
        this.defectObjs = JSON.parse(cur)
        this.defectLayerClear();
        this.defectHighLightLayerClear();

        let _defects = this.defectObjs;

        let arr = [];
        for (let i = 0; i < _defects.length; i++) {
            let pntX = getCoordinate(_defects[i].GEOX);
            let pntY = getCoordinate(_defects[i].GEOY);

            if (!this.isInBound(pntX, pntY))
                continue;

            //const iconFeature = new Feature({ geometry: new Point([pntX, pntY]), });
            //iconFeature.setProperties(_defects[i]);
            //arr.push(iconFeature);

            arr.push(new Feature({
                geometry: new Point([pntX, pntY]),
                DefectID: _defects[i].hasOwnProperty('DefectID') ? _defects[i].DefectID : _defects[i].DefectId,
                GEOX: _defects[i].GEOX,
                GEOY: _defects[i].GEOY,
                DefectStatus: _defects[i].DefectStatus,
                DefectIDShow: _defects[i].DefectIDShow,
                InspectionNo: _defects[i].InspectionNo,
                Repair_due_date: _defects[i].Repair_due_date,
                Repair_on_date: _defects[i].Repair_on_date,
                Update_date: _defects[i].Update_date,
            }));
        }
        if (arr.length > 0)
            this.getDefectLayerSource().addFeatures(arr);

        console.log('UpdateDefects', arr.length);
        this.map.getView().setZoom(this.initZoom);
        this.map.getView().setCenter(this.defaultCenter);
    }

    getScaleControlInfo() {
        let scalelineinner = document.getElementsByClassName('ol-scale-line-inner');
        if (scalelineinner) {// @ts-ignore
            let scaleValue = scalelineinner[0].innerText;
            let scaleWidth = '75';
            for (let i = 0; i < scalelineinner[0].attributes.length; i++) {
                if (scalelineinner[0].attributes[i].name == 'style') {
                    let width = scalelineinner[0].attributes[i].nodeValue?.replace(/[^\d]/g, "");
                    if (width) scaleWidth = width;
                    break;
                }
            }
            return [scaleValue, scaleWidth];
        }

        return ['', ''];
    }

    Capture() {
        this.map.once('rendercomplete', () => {
            const mapCanvas = document.createElement('canvas');
            const size = this.map.getSize();
            mapCanvas.width = size[0];
            mapCanvas.height = size[1];
            const mapContext = mapCanvas.getContext('2d');

            let scaleInfos = this.getScaleControlInfo();
            Array.prototype.forEach.call(
                this.map.getViewport().querySelectorAll('.ol-layer canvas, canvas.ol-layer, canvas.ol-control'),
                function (canvas) {
                    if (canvas.width > 0) {
                        const opacity =
                            canvas.parentNode.style.opacity || canvas.style.opacity;
                        // @ts-ignore
                        mapContext.globalAlpha = opacity === '' ? 1 : Number(opacity);
                        let matrix;
                        const transform = canvas.style.transform;
                        if (transform) {
                            // Get the transform parameters from the style's transform matrix
                            matrix = transform
                                .match(/^matrix\(([^\(]*)\)$/)[1]
                                .split(',')
                                .map(Number);
                        } else {
                            matrix = [
                                parseFloat(canvas.style.width) / canvas.width,
                                0,
                                0,
                                parseFloat(canvas.style.height) / canvas.height,
                                0,
                                0,
                            ];
                        }
                        // Apply the transform to the export map context
                        CanvasRenderingContext2D.prototype.setTransform.apply(
                            mapContext,
                            matrix
                        );
                        const backgroundColor = canvas.parentNode.style.backgroundColor;
                        if (backgroundColor) {// @ts-ignore
                            mapContext.fillStyle = backgroundColor;// @ts-ignore
                            mapContext.fillRect(0, 0, canvas.width, canvas.height);
                        }// @ts-ignore
                        mapContext.drawImage(canvas, 0, 0);
                        if (scaleInfos[1] != "" && mapContext != null) {
                            const lineX = 200;
                            const lineY = 28;
                            const scaleHeight = 5;

                            mapContext.strokeStyle = "rgba(0,0,0,1)";
                            mapContext.fillStyle = "rgba(0,0,0,1)";
                            mapContext.lineWidth = 1;

                            mapContext.beginPath();

                            mapContext.moveTo(lineX + 1, size[1] - lineY);
                            mapContext.lineTo(lineX + 1, size[1] - lineY - scaleHeight);

                            mapContext.moveTo(lineX, size[1] - lineY);
                            mapContext.lineTo(lineX + parseFloat(scaleInfos[1]), size[1] - lineY);

                            mapContext.moveTo(lineX + parseFloat(scaleInfos[1]) - 1, size[1] - lineY);
                            mapContext.lineTo(lineX + parseFloat(scaleInfos[1]) - 1, size[1] - lineY - scaleHeight);

                            mapContext.stroke();
                            mapContext.font = "11px Arial";
                            mapContext.fillText(scaleInfos[0], 155, size[1] - 26);

                            mapContext.restore();
                            mapContext.closePath();
                        }
                    }
                }
            );// @ts-ignore
            mapContext.globalAlpha = 1;// @ts-ignore
            mapContext.setTransform(1, 0, 0, 1, 0, 0);

            const link = document.getElementById('image-download');// @ts-ignore
            link.href = mapCanvas.toDataURL();// @ts-ignore
            link.download = "Map-" + this.getCurrDateString() + ".png";// @ts-ignore
            link.click();
        });
        this.map.renderSync();
    }

    getCurrDateString() {
        const now = new Date();
        const year = now.getFullYear();// @ts-ignore
        const month = String(now.getMonth() + 1).padStart(2, '0');// @ts-ignore
        const day = String(now.getDate()).padStart(2, '0');
        return year + month + day;
    }

    zoomMap(zoomType: number) {
        // @ts-ignore
        const view = this.map.getView();
        const zoom = view.getZoom();

        if (zoomType == 0)
            // @ts-ignore
            view.setZoom(zoom + 0.5);
        else
            view.setZoom(zoom - 0.5);
    }
}